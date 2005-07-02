Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVGBVsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVGBVsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 17:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVGBVsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 17:48:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1546 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261293AbVGBVqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:46:30 -0400
Date: Sat, 2 Jul 2005 23:46:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, ipw2100-admin@linux.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/ipw2100.c: possible cleanups
Message-ID: <20050702214629.GC5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the unused IPW_DEBUG_ENABLED

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/ipw2100.c |  136 ++++++++++++++++++++-------------
 drivers/net/wireless/ipw2100.h |   28 ------
 2 files changed, 86 insertions(+), 78 deletions(-)

--- linux-2.6.13-rc1-mm1-full/drivers/net/wireless/ipw2100.h.old	2005-07-02 22:11:53.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/net/wireless/ipw2100.h	2005-07-02 22:25:46.000000000 +0200
@@ -48,22 +48,6 @@
 struct ipw2100_tx_packet;
 struct ipw2100_rx_packet;
 
-#ifdef CONFIG_IPW_DEBUG
-enum { IPW_DEBUG_ENABLED = 1 };
-extern u32 ipw2100_debug_level;
-#define IPW_DEBUG(level, message...) \
-do { \
-	if (ipw2100_debug_level & (level)) { \
-		printk(KERN_DEBUG "ipw2100: %c %s ", \
-                       in_interrupt() ? 'I' : 'U',  __FUNCTION__); \
-		printk(message); \
-	} \
-} while (0)
-#else
-enum { IPW_DEBUG_ENABLED = 0 };
-#define IPW_DEBUG(level, message...) do {} while (0)
-#endif /* CONFIG_IPW_DEBUG */
-
 #define IPW_DL_UNINIT    0x80000000
 #define IPW_DL_NONE      0x00000000
 #define IPW_DL_ALL       0x7FFFFFFF
@@ -1144,10 +1128,6 @@
 #define WIRELESS_SPY		// enable iwspy support
 #endif
 
-extern struct iw_handler_def ipw2100_wx_handler_def;
-extern struct iw_statistics *ipw2100_wx_wireless_stats(struct net_device * dev);
-extern void ipw2100_wx_event_work(struct ipw2100_priv *priv);
-
 #define IPW_HOST_FW_SHARED_AREA0 	0x0002f200
 #define IPW_HOST_FW_SHARED_AREA0_END 	0x0002f510	// 0x310 bytes
 
@@ -1182,14 +1162,6 @@
 	const struct firmware *fw_entry;
 };
 
-int ipw2100_get_firmware(struct ipw2100_priv *priv, struct ipw2100_fw *fw);
-void ipw2100_release_firmware(struct ipw2100_priv *priv, struct ipw2100_fw *fw);
-int ipw2100_fw_download(struct ipw2100_priv *priv, struct ipw2100_fw *fw);
-int ipw2100_ucode_download(struct ipw2100_priv *priv, struct ipw2100_fw *fw);
-
 #define MAX_FW_VERSION_LEN 14
 
-int ipw2100_get_fwversion(struct ipw2100_priv *priv, char *buf, size_t max);
-int ipw2100_get_ucodeversion(struct ipw2100_priv *priv, char *buf, size_t max);
-
 #endif /* _IPW2100_H */
--- linux-2.6.13-rc1-mm1-full/drivers/net/wireless/ipw2100.c.old	2005-07-02 20:54:55.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/net/wireless/ipw2100.c	2005-07-02 22:31:21.000000000 +0200
@@ -207,7 +207,20 @@
 MODULE_PARM_DESC(associate, "auto associate when scanning (default on)");
 MODULE_PARM_DESC(disable, "manually disable the radio (default 0 [radio on])");
 
-u32 ipw2100_debug_level = IPW_DL_NONE;
+static u32 ipw2100_debug_level = IPW_DL_NONE;
+
+#ifdef CONFIG_IPW_DEBUG
+#define IPW_DEBUG(level, message...) \
+do { \
+	if (ipw2100_debug_level & (level)) { \
+		printk(KERN_DEBUG "ipw2100: %c %s ", \
+                       in_interrupt() ? 'I' : 'U',  __FUNCTION__); \
+		printk(message); \
+	} \
+} while (0)
+#else
+#define IPW_DEBUG(level, message...) do {} while (0)
+#endif /* CONFIG_IPW_DEBUG */
 
 #ifdef CONFIG_IPW_DEBUG
 static const char *command_types[] = {
@@ -295,6 +308,22 @@
 static void ipw2100_queues_free(struct ipw2100_priv *priv);
 static int ipw2100_queues_allocate(struct ipw2100_priv *priv);
 
+static int ipw2100_fw_download(struct ipw2100_priv *priv,
+			       struct ipw2100_fw *fw);
+static int ipw2100_get_firmware(struct ipw2100_priv *priv,
+				struct ipw2100_fw *fw);
+static int ipw2100_get_fwversion(struct ipw2100_priv *priv, char *buf,
+				 size_t max);
+static int ipw2100_get_ucodeversion(struct ipw2100_priv *priv, char *buf,
+				    size_t max);
+static void ipw2100_release_firmware(struct ipw2100_priv *priv,
+				     struct ipw2100_fw *fw);
+static int ipw2100_ucode_download(struct ipw2100_priv *priv,
+				  struct ipw2100_fw *fw);
+static void ipw2100_wx_event_work(struct ipw2100_priv *priv);
+static struct iw_statistics *ipw2100_wx_wireless_stats(struct net_device * dev);
+static struct iw_handler_def ipw2100_wx_handler_def;
+
 
 static inline void read_register(struct net_device *dev, u32 reg, u32 *val)
 {
@@ -473,8 +502,8 @@
 		 == IPW_DATA_DOA_DEBUG_VALUE));
 }
 
-int ipw2100_get_ordinal(struct ipw2100_priv *priv, u32 ord,
-			void *val, u32 *len)
+static int ipw2100_get_ordinal(struct ipw2100_priv *priv, u32 ord,
+			       void *val, u32 *len)
 {
 	struct ipw2100_ordinals *ordinals = &priv->ordinals;
 	u32 addr;
@@ -1574,7 +1603,7 @@
 	return err;
 }
 
-int ipw2100_set_scan_options(struct ipw2100_priv *priv)
+static int ipw2100_set_scan_options(struct ipw2100_priv *priv)
 {
 	struct host_command cmd = {
 		.host_command = SET_SCAN_OPTIONS,
@@ -1604,7 +1633,7 @@
 	return err;
 }
 
-int ipw2100_start_scan(struct ipw2100_priv *priv)
+static int ipw2100_start_scan(struct ipw2100_priv *priv)
 {
 	struct host_command cmd = {
 		.host_command = BROADCAST_SCAN,
@@ -1815,7 +1844,7 @@
 	netif_stop_queue(priv->net_dev);
 }
 
-void ipw2100_reset_adapter(struct ipw2100_priv *priv)
+static void ipw2100_reset_adapter(struct ipw2100_priv *priv)
 {
 	unsigned long flags;
 	union iwreq_data wrqu = {
@@ -1945,8 +1974,8 @@
 }
 
 
-int ipw2100_set_essid(struct ipw2100_priv *priv, char *essid,
-		      int length, int batch_mode)
+static int ipw2100_set_essid(struct ipw2100_priv *priv, char *essid,
+			     int length, int batch_mode)
 {
 	int ssid_len = min(length, IW_ESSID_MAX_SIZE);
 	struct host_command cmd = {
@@ -2077,7 +2106,7 @@
 	priv->status |= STATUS_SCANNING;
 }
 
-const struct ipw2100_status_indicator status_handlers[] = {
+static const struct ipw2100_status_indicator status_handlers[] = {
 	IPW2100_HANDLER(IPW_STATE_INITIALIZED, 0),
 	IPW2100_HANDLER(IPW_STATE_COUNTRY_FOUND, 0),
 	IPW2100_HANDLER(IPW_STATE_ASSOCIATED, isr_indicate_associated),
@@ -2145,7 +2174,7 @@
 }
 
 #ifdef CONFIG_IPW_DEBUG
-const char *frame_types[] = {
+static const char *frame_types[] = {
 	"COMMAND_STATUS_VAL",
 	"STATUS_CHANGE_VAL",
 	"P80211_DATA_VAL",
@@ -2265,7 +2294,7 @@
  *
  */
 #ifdef CONFIG_IPW2100_RX_DEBUG
-u8 packet_data[IPW_RX_NIC_BUFFER_LENGTH];
+static u8 packet_data[IPW_RX_NIC_BUFFER_LENGTH];
 #endif
 
 static inline void ipw2100_corruption_detected(struct ipw2100_priv *priv,
@@ -3407,7 +3436,7 @@
 
 
 #define IPW2100_REG(x) { IPW_ ##x, #x }
-const struct {
+static const struct {
 	u32 addr;
 	const char *name;
 } hw_data[] = {
@@ -3418,7 +3447,7 @@
 	IPW2100_REG(REG_RESET_REG),
 };
 #define IPW2100_NIC(x, s) { x, #x, s }
-const struct {
+static const struct {
 	u32 addr;
 	const char *name;
 	size_t size;
@@ -3428,7 +3457,7 @@
 	IPW2100_NIC(0x210000, 1),
 };
 #define IPW2100_ORD(x, d) { IPW_ORD_ ##x, #x, d }
-const struct {
+static const struct {
 	u8 index;
 	const char *name;
 	const char *desc;
@@ -3793,7 +3822,7 @@
 static DEVICE_ATTR(stats, S_IRUGO, show_stats, NULL);
 
 
-int ipw2100_switch_mode(struct ipw2100_priv *priv, u32 mode)
+static int ipw2100_switch_mode(struct ipw2100_priv *priv, u32 mode)
 {
 	int err;
 
@@ -4471,7 +4500,7 @@
  *
  ********************************************************************/
 
-int ipw2100_set_mac_address(struct ipw2100_priv *priv, int batch_mode)
+static int ipw2100_set_mac_address(struct ipw2100_priv *priv, int batch_mode)
 {
 	struct host_command cmd = {
 		.host_command = ADAPTER_ADDRESS,
@@ -4494,7 +4523,7 @@
 	return err;
 }
 
-int ipw2100_set_port_type(struct ipw2100_priv *priv, u32 port_type,
+static int ipw2100_set_port_type(struct ipw2100_priv *priv, u32 port_type,
 				 int batch_mode)
 {
 	struct host_command cmd = {
@@ -4535,7 +4564,8 @@
 }
 
 
-int ipw2100_set_channel(struct ipw2100_priv *priv, u32 channel, int batch_mode)
+static int ipw2100_set_channel(struct ipw2100_priv *priv, u32 channel,
+			       int batch_mode)
 {
 	struct host_command cmd = {
 		.host_command = CHANNEL,
@@ -4585,7 +4615,7 @@
 	return 0;
 }
 
-int ipw2100_system_config(struct ipw2100_priv *priv, int batch_mode)
+static int ipw2100_system_config(struct ipw2100_priv *priv, int batch_mode)
 {
 	struct host_command cmd = {
 		.host_command = SYSTEM_CONFIG,
@@ -4647,7 +4677,8 @@
 	return 0;
 }
 
-int ipw2100_set_tx_rates(struct ipw2100_priv *priv, u32 rate, int batch_mode)
+static int ipw2100_set_tx_rates(struct ipw2100_priv *priv, u32 rate,
+				int batch_mode)
 {
 	struct host_command cmd = {
 		.host_command = BASIC_TX_RATES,
@@ -4686,8 +4717,8 @@
 	return 0;
 }
 
-int ipw2100_set_power_mode(struct ipw2100_priv *priv,
-			   int power_level)
+static int ipw2100_set_power_mode(struct ipw2100_priv *priv,
+				  int power_level)
 {
 	struct host_command cmd = {
 		.host_command = POWER_MODE,
@@ -4724,7 +4755,7 @@
 }
 
 
-int ipw2100_set_rts_threshold(struct ipw2100_priv *priv, u32 threshold)
+static int ipw2100_set_rts_threshold(struct ipw2100_priv *priv, u32 threshold)
 {
 	struct host_command cmd = {
 		.host_command = RTS_THRESHOLD,
@@ -4788,7 +4819,7 @@
 }
 #endif
 
-int ipw2100_set_short_retry(struct ipw2100_priv *priv, u32 retry)
+static int ipw2100_set_short_retry(struct ipw2100_priv *priv, u32 retry)
 {
 	struct host_command cmd = {
 		.host_command = SHORT_RETRY_LIMIT,
@@ -4808,7 +4839,7 @@
 	return 0;
 }
 
-int ipw2100_set_long_retry(struct ipw2100_priv *priv, u32 retry)
+static int ipw2100_set_long_retry(struct ipw2100_priv *priv, u32 retry)
 {
 	struct host_command cmd = {
 		.host_command = LONG_RETRY_LIMIT,
@@ -4829,8 +4860,8 @@
 }
 
 
-int ipw2100_set_mandatory_bssid(struct ipw2100_priv *priv, u8 *bssid,
-				int batch_mode)
+static int ipw2100_set_mandatory_bssid(struct ipw2100_priv *priv, u8 *bssid,
+				       int batch_mode)
 {
 	struct host_command cmd = {
 		.host_command = MANDATORY_BSSID,
@@ -4963,11 +4994,11 @@
 	u8 unicast_using_group;
 } __attribute__ ((packed));
 
-int ipw2100_set_security_information(struct ipw2100_priv *priv,
-				     int auth_mode,
-				     int security_level,
-				     int unicast_using_group,
-				     int batch_mode)
+static int ipw2100_set_security_information(struct ipw2100_priv *priv,
+					    int auth_mode,
+					    int security_level,
+					    int unicast_using_group,
+					    int batch_mode)
 {
 	struct host_command cmd = {
 		.host_command = SET_SECURITY_INFORMATION,
@@ -5029,8 +5060,8 @@
 	return err;
 }
 
-int ipw2100_set_tx_power(struct ipw2100_priv *priv,
-			 u32 tx_power)
+static int ipw2100_set_tx_power(struct ipw2100_priv *priv,
+				u32 tx_power)
 {
 	struct host_command cmd = {
 		.host_command = TX_POWER_INDEX,
@@ -5049,8 +5080,8 @@
 	return 0;
 }
 
-int ipw2100_set_ibss_beacon_interval(struct ipw2100_priv *priv,
-				     u32 interval, int batch_mode)
+static int ipw2100_set_ibss_beacon_interval(struct ipw2100_priv *priv,
+					    u32 interval, int batch_mode)
 {
 	struct host_command cmd = {
 		.host_command = BEACON_INTERVAL,
@@ -6781,7 +6812,7 @@
 
 #define WEXT_USECHANNELS 1
 
-const long ipw2100_frequencies[] = {
+static const long ipw2100_frequencies[] = {
 	2412, 2417, 2422, 2427,
 	2432, 2437, 2442, 2447,
 	2452, 2457, 2462, 2467,
@@ -6791,7 +6822,7 @@
 #define FREQ_COUNT (sizeof(ipw2100_frequencies) / \
                     sizeof(ipw2100_frequencies[0]))
 
-const long ipw2100_rates_11b[] = {
+static const long ipw2100_rates_11b[] = {
 	1000000,
 	2000000,
 	5500000,
@@ -6950,7 +6981,7 @@
 #define POWER_MODES 5
 
 /* Values are in microsecond */
-const s32 timeout_duration[POWER_MODES] = {
+static const s32 timeout_duration[POWER_MODES] = {
 	350000,
 	250000,
 	75000,
@@ -6958,7 +6989,7 @@
 	25000,
 };
 
-const s32 period_duration[POWER_MODES] = {
+static const s32 period_duration[POWER_MODES] = {
 	400000,
 	700000,
 	1000000,
@@ -8023,7 +8054,7 @@
 	ipw2100_wx_get_preamble,
 };
 
-struct iw_handler_def ipw2100_wx_handler_def =
+static struct iw_handler_def ipw2100_wx_handler_def =
 {
 	.standard = ipw2100_wx_handlers,
 	.num_standard = sizeof(ipw2100_wx_handlers) / sizeof(iw_handler),
@@ -8039,7 +8070,7 @@
  * Called by /proc/net/wireless
  * Also called by SIOCGIWSTATS
  */
-struct iw_statistics *ipw2100_wx_wireless_stats(struct net_device * dev)
+static struct iw_statistics *ipw2100_wx_wireless_stats(struct net_device * dev)
 {
 	enum {
 		POOR = 30,
@@ -8175,7 +8206,7 @@
 	return (struct iw_statistics *) NULL;
 }
 
-void ipw2100_wx_event_work(struct ipw2100_priv *priv)
+static void ipw2100_wx_event_work(struct ipw2100_priv *priv)
 {
 	union iwreq_data wrqu;
 	int len = ETH_ALEN;
@@ -8288,7 +8319,8 @@
 }
 
 
-int ipw2100_get_firmware(struct ipw2100_priv *priv, struct ipw2100_fw *fw)
+static int ipw2100_get_firmware(struct ipw2100_priv *priv,
+				struct ipw2100_fw *fw)
 {
 	char *fw_name;
 	int rc;
@@ -8327,8 +8359,8 @@
 	return 0;
 }
 
-void ipw2100_release_firmware(struct ipw2100_priv *priv,
-			      struct ipw2100_fw *fw)
+static void ipw2100_release_firmware(struct ipw2100_priv *priv,
+				     struct ipw2100_fw *fw)
 {
 	fw->version = 0;
 	if (fw->fw_entry)
@@ -8337,7 +8369,8 @@
 }
 
 
-int ipw2100_get_fwversion(struct ipw2100_priv *priv, char *buf, size_t max)
+static int ipw2100_get_fwversion(struct ipw2100_priv *priv, char *buf,
+				 size_t max)
 {
 	char ver[MAX_FW_VERSION_LEN];
 	u32 len = MAX_FW_VERSION_LEN;
@@ -8356,7 +8389,8 @@
 	return tmp;
 }
 
-int ipw2100_get_ucodeversion(struct ipw2100_priv *priv, char *buf, size_t max)
+static int ipw2100_get_ucodeversion(struct ipw2100_priv *priv, char *buf,
+				    size_t max)
 {
 	u32 ver;
 	u32 len = sizeof(ver);
@@ -8370,7 +8404,8 @@
 /*
  * On exit, the firmware will have been freed from the fw list
  */
-int ipw2100_fw_download(struct ipw2100_priv *priv, struct ipw2100_fw *fw)
+static int ipw2100_fw_download(struct ipw2100_priv *priv,
+			       struct ipw2100_fw *fw)
 {
 	/* firmware is constructed of N contiguous entries, each entry is
 	 * structured as:
@@ -8427,7 +8462,8 @@
 	u8 ucode_valid;
 };
 
-int ipw2100_ucode_download(struct ipw2100_priv *priv, struct ipw2100_fw *fw)
+static int ipw2100_ucode_download(struct ipw2100_priv *priv,
+				  struct ipw2100_fw *fw)
 {
 	struct net_device *dev = priv->net_dev;
 	const unsigned char *microcode_data = fw->uc.data;
