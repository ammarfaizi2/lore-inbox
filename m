Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVL1V1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVL1V1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVL1V1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:27:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53073 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964923AbVL1V1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:27:53 -0500
Date: Wed, 28 Dec 2005 22:29:35 +0100
From: Jens Axboe <axboe@suse.de>
To: yi.zhu@intel.com, jketreno@linux.intel.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipw2200 stack reduction
Message-ID: <20051228212934.GA2772@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Checking the stack usage of my kernel, showed that ipw2200 had a few bad
offenders. This is on i386 32-bit:

0x00002876 ipw_send_associate:                          544
0x000028ee ipw_send_associate:                          544
0x000027dc ipw_send_scan_request_ext:                   520
0x00002864 ipw_set_sensitivity:                         520
0x00005eac ipw_set_rsn_capa:                            520

The reason is the host_cmd structure is large (500 bytes). All other
functions currently using ipw_send_cmd() suffer from the same problem.
This patch introduces ipw_send_cmd_simple() for commands with no data
transfer, and ipw_send_cmd_pdu() for commands with a data payload.

As an added bonus, the diffstat looks like this:

 ipw2200.c |  285 +++++++++++++++++++++++++-------------------------------------
 1 files changed, 115 insertions(+), 170 deletions(-)

and it shrinks the module a lot as well:

Before:

   text    data     bss     dec     hex filename
  75177    2472      44   77693   12f7d drivers/net/wireless/ipw2200.ko

After:

   text    data     bss     dec     hex filename
  65731    2472      44   68247   10a97 drivers/net/wireless/ipw2200.ko

(lsmod size is shrunk ~9kb, or about 11%).

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index 5e7c7e9..9ce659b 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -1870,7 +1870,7 @@ static char *get_cmd_string(u8 cmd)
 }
 
 #define HOST_COMPLETE_TIMEOUT HZ
-static int ipw_send_cmd(struct ipw_priv *priv, struct host_cmd *cmd)
+static int __ipw_send_cmd(struct ipw_priv *priv, struct host_cmd *cmd, int put)
 {
 	int rc = 0;
 	unsigned long flags;
@@ -1880,6 +1880,8 @@ static int ipw_send_cmd(struct ipw_priv 
 		IPW_ERROR("Failed to send %s: Already sending a command.\n",
 			  get_cmd_string(cmd->cmd));
 		spin_unlock_irqrestore(&priv->lock, flags);
+		if (put)
+			kfree(cmd);
 		return -EAGAIN;
 	}
 
@@ -1934,69 +1936,92 @@ static int ipw_send_cmd(struct ipw_priv 
 		goto exit;
 	}
 
-      exit:
+exit:
 	if (priv->cmdlog) {
 		priv->cmdlog[priv->cmdlog_pos++].retcode = rc;
 		priv->cmdlog_pos %= priv->cmdlog_len;
 	}
+	if (put)
+		kfree(cmd);
 	return rc;
 }
 
-static int ipw_send_host_complete(struct ipw_priv *priv)
+static struct host_cmd *ipw_host_cmd_get(u8 command, u8 len)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_HOST_COMPLETE,
-		.len = 0
-	};
+	struct host_cmd *cmd;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (cmd) {
+		cmd->cmd = command;
+		cmd->len = len;
+		return cmd;
+	}
+
+	return NULL;
+}
+
+static int ipw_send_cmd_simple(struct ipw_priv *priv, u8 command)
+{
+	struct host_cmd *cmd;
+
+	cmd = ipw_host_cmd_get(command, 0);
+	if (cmd)
+		return __ipw_send_cmd(priv, cmd, 1);
 
+	IPW_ERROR("Out of memory for cmd %x\n", command);
+	return -1;
+}
+
+static int ipw_send_cmd_pdu(struct ipw_priv *priv, u8 command, u8 len,
+			    void *data)
+{
+	struct host_cmd *cmd;
+
+	cmd = ipw_host_cmd_get(command, len);
+	if (cmd) {
+		memcpy(cmd->param, data, len);
+		return __ipw_send_cmd(priv, cmd, 1);
+	}
+
+	IPW_ERROR("Out of memory for cmd %x\n", command);
+	return -1;
+}
+
+static int ipw_send_host_complete(struct ipw_priv *priv)
+{
 	if (!priv) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_simple(priv, IPW_CMD_HOST_COMPLETE);
 }
 
 static int ipw_send_system_config(struct ipw_priv *priv,
 				  struct ipw_sys_config *config)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_SYSTEM_CONFIG,
-		.len = sizeof(*config)
-	};
-
 	if (!priv || !config) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	memcpy(cmd.param, config, sizeof(*config));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_SYSTEM_CONFIG, sizeof(*config),
+					config);
 }
 
 static int ipw_send_ssid(struct ipw_priv *priv, u8 * ssid, int len)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_SSID,
-		.len = min(len, IW_ESSID_MAX_SIZE)
-	};
-
 	if (!priv || !ssid) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	memcpy(cmd.param, ssid, cmd.len);
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_SSID, min(len, IW_ESSID_MAX_SIZE),
+					ssid);
 }
 
 static int ipw_send_adapter_address(struct ipw_priv *priv, u8 * mac)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_ADAPTER_ADDRESS,
-		.len = ETH_ALEN
-	};
-
 	if (!priv || !mac) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
@@ -2005,8 +2030,8 @@ static int ipw_send_adapter_address(stru
 	IPW_DEBUG_INFO("%s: Setting MAC to " MAC_FMT "\n",
 		       priv->net_dev->name, MAC_ARG(mac));
 
-	memcpy(cmd.param, mac, ETH_ALEN);
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_ADAPTER_ADDRESS, ETH_ALEN,
+					mac);
 }
 
 /*
@@ -2065,51 +2090,40 @@ static void ipw_bg_scan_check(void *data
 static int ipw_send_scan_request_ext(struct ipw_priv *priv,
 				     struct ipw_scan_request_ext *request)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_SCAN_REQUEST_EXT,
-		.len = sizeof(*request)
-	};
-
-	memcpy(cmd.param, request, sizeof(*request));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_SCAN_REQUEST_EXT,
+					sizeof(*request), request);
 }
 
 static int ipw_send_scan_abort(struct ipw_priv *priv)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_SCAN_ABORT,
-		.len = 0
-	};
-
 	if (!priv) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_simple(priv, IPW_CMD_SCAN_ABORT);
 }
 
 static int ipw_set_sensitivity(struct ipw_priv *priv, u16 sens)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_SENSITIVITY_CALIB,
-		.len = sizeof(struct ipw_sensitivity_calib)
+	struct ipw_sensitivity_calib calib = {
+		.beacon_rssi_raw = sens,
 	};
-	struct ipw_sensitivity_calib *calib = (struct ipw_sensitivity_calib *)
-	    &cmd.param;
-	calib->beacon_rssi_raw = sens;
-	return ipw_send_cmd(priv, &cmd);
+
+	return ipw_send_cmd_pdu(priv, IPW_CMD_SENSITIVITY_CALIB, sizeof(calib),
+					&calib);
 }
 
 static int ipw_send_associate(struct ipw_priv *priv,
 			      struct ipw_associate *associate)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_ASSOCIATE,
-		.len = sizeof(*associate)
-	};
-
 	struct ipw_associate tmp_associate;
+
+	if (!priv || !associate) {
+		IPW_ERROR("Invalid args\n");
+		return -1;
+	}
+
 	memcpy(&tmp_associate, associate, sizeof(*associate));
 	tmp_associate.policy_support =
 	    cpu_to_le16(tmp_associate.policy_support);
@@ -2122,80 +2136,56 @@ static int ipw_send_associate(struct ipw
 	    cpu_to_le16(tmp_associate.beacon_interval);
 	tmp_associate.atim_window = cpu_to_le16(tmp_associate.atim_window);
 
-	if (!priv || !associate) {
-		IPW_ERROR("Invalid args\n");
-		return -1;
-	}
-
-	memcpy(cmd.param, &tmp_associate, sizeof(*associate));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_ASSOCIATE, sizeof(tmp_associate),
+					&tmp_associate);
 }
 
 static int ipw_send_supported_rates(struct ipw_priv *priv,
 				    struct ipw_supported_rates *rates)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_SUPPORTED_RATES,
-		.len = sizeof(*rates)
-	};
-
 	if (!priv || !rates) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	memcpy(cmd.param, rates, sizeof(*rates));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_SUPPORTED_RATES, sizeof(*rates),
+					rates);
 }
 
 static int ipw_set_random_seed(struct ipw_priv *priv)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_SEED_NUMBER,
-		.len = sizeof(u32)
-	};
+	u32 val;
 
 	if (!priv) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	get_random_bytes(&cmd.param, sizeof(u32));
+	get_random_bytes(&val, sizeof(val));
 
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_SEED_NUMBER, sizeof(val), &val);
 }
 
 static int ipw_send_card_disable(struct ipw_priv *priv, u32 phy_off)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_CARD_DISABLE,
-		.len = sizeof(u32)
-	};
-
 	if (!priv) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	*((u32 *) & cmd.param) = phy_off;
-
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_CARD_DISABLE, sizeof(phy_off),
+					&phy_off);
 }
 
 static int ipw_send_tx_power(struct ipw_priv *priv, struct ipw_tx_power *power)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_TX_POWER,
-		.len = sizeof(*power)
-	};
-
 	if (!priv || !power) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	memcpy(cmd.param, power, sizeof(*power));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_TX_POWER, sizeof(*power),
+					power);
 }
 
 static int ipw_set_tx_power(struct ipw_priv *priv)
@@ -2247,18 +2237,14 @@ static int ipw_send_rts_threshold(struct
 	struct ipw_rts_threshold rts_threshold = {
 		.rts_threshold = rts,
 	};
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_RTS_THRESHOLD,
-		.len = sizeof(rts_threshold)
-	};
 
 	if (!priv) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	memcpy(cmd.param, &rts_threshold, sizeof(rts_threshold));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_RTS_THRESHOLD,
+				sizeof(rts_threshold), &rts_threshold);
 }
 
 static int ipw_send_frag_threshold(struct ipw_priv *priv, u16 frag)
@@ -2266,27 +2252,19 @@ static int ipw_send_frag_threshold(struc
 	struct ipw_frag_threshold frag_threshold = {
 		.frag_threshold = frag,
 	};
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_FRAG_THRESHOLD,
-		.len = sizeof(frag_threshold)
-	};
 
 	if (!priv) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	memcpy(cmd.param, &frag_threshold, sizeof(frag_threshold));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_FRAG_THRESHOLD,
+				sizeof(frag_threshold), &frag_threshold);
 }
 
 static int ipw_send_power_mode(struct ipw_priv *priv, u32 mode)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_POWER_MODE,
-		.len = sizeof(u32)
-	};
-	u32 *param = (u32 *) (&cmd.param);
+	u32 param;
 
 	if (!priv) {
 		IPW_ERROR("Invalid args\n");
@@ -2297,17 +2275,18 @@ static int ipw_send_power_mode(struct ip
 	 * level */
 	switch (mode) {
 	case IPW_POWER_BATTERY:
-		*param = IPW_POWER_INDEX_3;
+		param = IPW_POWER_INDEX_3;
 		break;
 	case IPW_POWER_AC:
-		*param = IPW_POWER_MODE_CAM;
+		param = IPW_POWER_MODE_CAM;
 		break;
 	default:
-		*param = mode;
+		param = mode;
 		break;
 	}
 
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_POWER_MODE, sizeof(param),
+					&param);
 }
 
 static int ipw_send_retry_limit(struct ipw_priv *priv, u8 slimit, u8 llimit)
@@ -2316,18 +2295,14 @@ static int ipw_send_retry_limit(struct i
 		.short_retry_limit = slimit,
 		.long_retry_limit = llimit
 	};
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_RETRY_LIMIT,
-		.len = sizeof(retry_limit)
-	};
 
 	if (!priv) {
 		IPW_ERROR("Invalid args\n");
 		return -1;
 	}
 
-	memcpy(cmd.param, &retry_limit, sizeof(retry_limit));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_RETRY_LIMIT, sizeof(retry_limit),
+					&retry_limit);
 }
 
 /*
@@ -5672,54 +5647,44 @@ static void ipw_adhoc_create(struct ipw_
 
 static void ipw_send_tgi_tx_key(struct ipw_priv *priv, int type, int index)
 {
-	struct ipw_tgi_tx_key *key;
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_TGI_TX_KEY,
-		.len = sizeof(*key)
-	};
+	struct ipw_tgi_tx_key key;
 
 	if (!(priv->ieee->sec.flags & (1 << index)))
 		return;
 
-	key = (struct ipw_tgi_tx_key *)&cmd.param;
-	key->key_id = index;
-	memcpy(key->key, priv->ieee->sec.keys[index], SCM_TEMPORAL_KEY_LENGTH);
-	key->security_type = type;
-	key->station_index = 0;	/* always 0 for BSS */
-	key->flags = 0;
+	key.key_id = index;
+	memcpy(key.key, priv->ieee->sec.keys[index], SCM_TEMPORAL_KEY_LENGTH);
+	key.security_type = type;
+	key.station_index = 0;	/* always 0 for BSS */
+	key.flags = 0;
 	/* 0 for new key; previous value of counter (after fatal error) */
-	key->tx_counter[0] = 0;
-	key->tx_counter[1] = 0;
+	key.tx_counter[0] = 0;
+	key.tx_counter[1] = 0;
 
-	ipw_send_cmd(priv, &cmd);
+	ipw_send_cmd_pdu(priv, IPW_CMD_TGI_TX_KEY, sizeof(key), &key);
 }
 
 static void ipw_send_wep_keys(struct ipw_priv *priv, int type)
 {
-	struct ipw_wep_key *key;
+	struct ipw_wep_key key;
 	int i;
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_WEP_KEY,
-		.len = sizeof(*key)
-	};
 
-	key = (struct ipw_wep_key *)&cmd.param;
-	key->cmd_id = DINO_CMD_WEP_KEY;
-	key->seq_num = 0;
+	key.cmd_id = DINO_CMD_WEP_KEY;
+	key.seq_num = 0;
 
 	/* Note: AES keys cannot be set for multiple times.
 	 * Only set it at the first time. */
 	for (i = 0; i < 4; i++) {
-		key->key_index = i | type;
+		key.key_index = i | type;
 		if (!(priv->ieee->sec.flags & (1 << i))) {
-			key->key_size = 0;
+			key.key_size = 0;
 			continue;
 		}
 
-		key->key_size = priv->ieee->sec.key_sizes[i];
-		memcpy(key->key, priv->ieee->sec.keys[i], key->key_size);
+		key.key_size = priv->ieee->sec.key_sizes[i];
+		memcpy(key.key, priv->ieee->sec.keys[i], key.key_size);
 
-		ipw_send_cmd(priv, &cmd);
+		ipw_send_cmd_pdu(priv, IPW_CMD_WEP_KEY, sizeof(key), &key);
 	}
 }
 
@@ -6216,15 +6181,10 @@ void ipw_wpa_assoc_frame(struct ipw_priv
 static int ipw_set_rsn_capa(struct ipw_priv *priv,
 			    char *capabilities, int length)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_RSN_CAPABILITIES,
-		.len = length,
-	};
-
 	IPW_DEBUG_HC("HOST_CMD_RSN_CAPABILITIES\n");
 
-	memcpy(cmd.param, capabilities, length);
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_RSN_CAPABILITIES, length,
+					capabilities);
 }
 
 /*
@@ -7011,25 +6971,15 @@ static int ipw_handle_assoc_response(str
 static int ipw_send_qos_params_command(struct ipw_priv *priv, struct ieee80211_qos_parameters
 				       *qos_param)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_QOS_PARAMETERS,
-		.len = (sizeof(struct ieee80211_qos_parameters) * 3)
-	};
-
-	memcpy(cmd.param, qos_param, sizeof(*qos_param) * 3);
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_QOS_PARAMETERS, qos_param,
+					sizeof(*qos_param) * 3);
 }
 
 static int ipw_send_qos_info_command(struct ipw_priv *priv, struct ieee80211_qos_information_element
 				     *qos_param)
 {
-	struct host_cmd cmd = {
-		.cmd = IPW_CMD_WME_INFO,
-		.len = sizeof(*qos_param)
-	};
-
-	memcpy(cmd.param, qos_param, sizeof(*qos_param));
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_WME_INFO, qos_param,
+					sizeof(*qos_param));
 }
 
 #endif				/* CONFIG_IPW_QOS */

-- 
Jens Axboe

