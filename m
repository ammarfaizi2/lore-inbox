Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVL2LTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVL2LTc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVL2LTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:19:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62543 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932557AbVL2LTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:19:31 -0500
Date: Thu, 29 Dec 2005 12:19:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Zhu Yi <yi.zhu@intel.com>, jketreno@linux.intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipw2200 stack reduction
Message-ID: <20051229111907.GJ2772@suse.de>
References: <20051228212934.GA2772@suse.de> <1135847228.9670.69.camel@debian.sh.intel.com> <20051229091940.GD2772@suse.de> <84144f020512290239t6192b344g63e4a71e44e8dfaa@mail.gmail.com> <20051229111414.GI2772@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229111414.GI2772@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29 2005, Jens Axboe wrote:
> Applied on top of the two other patches. Zhu, let me know if you just
> want 1 patch instead. It is just one change, so...

Here it is, with updated description.

---

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
transfer, and ipw_send_cmd_pdu() for commands with a data payload and
makes the payload a pointer to the buffer passed in from the caller.

As an added bonus, the diffstat looks like this:

 ipw2200.c |  260 +++++++++++++++++++++-----------------------------------------
 ipw2200.h |    2
 2 files changed, 92 insertions(+), 170 deletions(-)

and it shrinks the module a lot as well:

Before:

   text    data     bss     dec     hex filename
  75177    2472      44   77693   12f7d drivers/net/wireless/ipw2200.ko

After:

   text    data     bss     dec     hex filename
  61363    2488      44   63895    f997 drivers/net/wireless/ipw2200.ko

So about a ~18% reduction in module size.

Signed-off-by: Jens Axboe <axboe@suse.de>


diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index 5e7c7e9..596db7b 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -1870,7 +1870,8 @@ static char *get_cmd_string(u8 cmd)
 }
 
 #define HOST_COMPLETE_TIMEOUT HZ
-static int ipw_send_cmd(struct ipw_priv *priv, struct host_cmd *cmd)
+
+static int __ipw_send_cmd(struct ipw_priv *priv, struct host_cmd *cmd)
 {
 	int rc = 0;
 	unsigned long flags;
@@ -1899,7 +1900,7 @@ static int ipw_send_cmd(struct ipw_priv 
 		     priv->status);
 	printk_buf(IPW_DL_HOST_COMMAND, (u8 *) cmd->param, cmd->len);
 
-	rc = ipw_queue_tx_hcmd(priv, cmd->cmd, &cmd->param, cmd->len, 0);
+	rc = ipw_queue_tx_hcmd(priv, cmd->cmd, cmd->param, cmd->len, 0);
 	if (rc) {
 		priv->status &= ~STATUS_HCMD_ACTIVE;
 		IPW_ERROR("Failed to send %s: Reason %d\n",
@@ -1934,7 +1935,7 @@ static int ipw_send_cmd(struct ipw_priv 
 		goto exit;
 	}
 
-      exit:
+exit:
 	if (priv->cmdlog) {
 		priv->cmdlog[priv->cmdlog_pos++].retcode = rc;
 		priv->cmdlog_pos %= priv->cmdlog_len;
@@ -1942,61 +1943,62 @@ static int ipw_send_cmd(struct ipw_priv 
 	return rc;
 }
 
-static int ipw_send_host_complete(struct ipw_priv *priv)
+static int ipw_send_cmd_simple(struct ipw_priv *priv, u8 command)
+{
+	struct host_cmd cmd = {
+		.cmd = command,
+	};
+
+	return __ipw_send_cmd(priv, &cmd);
+}
+
+static int ipw_send_cmd_pdu(struct ipw_priv *priv, u8 command, u8 len,
+			    void *data)
 {
 	struct host_cmd cmd = {
-		.cmd = IPW_CMD_HOST_COMPLETE,
-		.len = 0
+		.cmd = command,
+		.len = len,
+		.param = data,
 	};
 
+	return __ipw_send_cmd(priv, &cmd);
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
@@ -2005,8 +2007,8 @@ static int ipw_send_adapter_address(stru
 	IPW_DEBUG_INFO("%s: Setting MAC to " MAC_FMT "\n",
 		       priv->net_dev->name, MAC_ARG(mac));
 
-	memcpy(cmd.param, mac, ETH_ALEN);
-	return ipw_send_cmd(priv, &cmd);
+	return ipw_send_cmd_pdu(priv, IPW_CMD_ADAPTER_ADDRESS, ETH_ALEN,
+					mac);
 }
 
 /*
@@ -2065,51 +2067,40 @@ static void ipw_bg_scan_check(void *data
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
@@ -2122,80 +2113,56 @@ static int ipw_send_associate(struct ipw
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
@@ -2247,18 +2214,14 @@ static int ipw_send_rts_threshold(struct
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
@@ -2266,27 +2229,19 @@ static int ipw_send_frag_threshold(struc
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
@@ -2297,17 +2252,18 @@ static int ipw_send_power_mode(struct ip
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
@@ -2316,18 +2272,14 @@ static int ipw_send_retry_limit(struct i
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
@@ -5672,54 +5624,44 @@ static void ipw_adhoc_create(struct ipw_
 
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
 
@@ -6216,15 +6158,10 @@ void ipw_wpa_assoc_frame(struct ipw_priv
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
@@ -7011,25 +6948,15 @@ static int ipw_handle_assoc_response(str
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
diff --git a/drivers/net/wireless/ipw2200.h b/drivers/net/wireless/ipw2200.h
index 1c98db0..dab1dcd 100644
--- a/drivers/net/wireless/ipw2200.h
+++ b/drivers/net/wireless/ipw2200.h
@@ -1860,7 +1860,7 @@ struct host_cmd {
 	u8 cmd;
 	u8 len;
 	u16 reserved;
-	u32 param[TFD_CMD_IMMEDIATE_PAYLOAD_LENGTH];
+	u32 *param;
 } __attribute__ ((packed));
 
 struct ipw_cmd_log {

-- 
Jens Axboe

