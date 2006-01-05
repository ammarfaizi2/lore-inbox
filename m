Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWAEWjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWAEWjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWAEWjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:39:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51717 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750893AbWAEWjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:39:11 -0500
Date: Thu, 5 Jan 2006 23:39:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jkmaline@cc.hut.fi
Cc: hostap@shmoo.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/net/wireless/hostap/hostap_main.c shouldn't #include C files
Message-ID: <20060105223910.GJ12313@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains an attempt to properly build hostap.o without
#incude'ing C files.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Now that hostap_main.c renaming is in Linus' tree, this patch applies 
against Linus' tree.

 drivers/net/wireless/hostap/Makefile          |    3 
 drivers/net/wireless/hostap/hostap.h          |   37 +++++++++++
 drivers/net/wireless/hostap/hostap_80211.h    |    3 
 drivers/net/wireless/hostap/hostap_80211_rx.c |   11 +++
 drivers/net/wireless/hostap/hostap_80211_tx.c |   15 ++++
 drivers/net/wireless/hostap/hostap_ap.c       |   36 ++++++----
 drivers/net/wireless/hostap/hostap_ap.h       |    2 
 drivers/net/wireless/hostap/hostap_common.h   |    3 
 drivers/net/wireless/hostap/hostap_info.c     |    3 
 drivers/net/wireless/hostap/hostap_ioctl.c    |   12 ++-
 drivers/net/wireless/hostap/hostap_main.c     |   60 +-----------------
 drivers/net/wireless/hostap/hostap_proc.c     |    8 ++
 drivers/net/wireless/hostap/hostap_wlan.h     |    4 +
 include/net/ieee80211_crypt.h                 |    1 
 14 files changed, 120 insertions(+), 78 deletions(-)


--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/Makefile.old	2005-12-03 00:40:33.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/Makefile	2005-12-03 00:49:47.000000000 +0100
@@ -1,4 +1,5 @@
-hostap-y := hostap_main.o
+hostap-y := hostap_80211_rx.o hostap_80211_tx.o hostap_ap.o hostap_info.o \
+            hostap_ioctl.o hostap_main.o hostap_proc.o 
 obj-$(CONFIG_HOSTAP) += hostap.o
 
 obj-$(CONFIG_HOSTAP_CS) += hostap_cs.o
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap.h.old	2005-12-03 00:41:48.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap.h	2005-12-03 02:37:21.000000000 +0100
@@ -1,6 +1,15 @@
 #ifndef HOSTAP_H
 #define HOSTAP_H
 
+#include <linux/ethtool.h>
+
+#include "hostap_wlan.h"
+#include "hostap_ap.h"
+
+static const long freq_list[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
+				  2447, 2452, 2457, 2462, 2467, 2472, 2484 };
+#define FREQ_COUNT (sizeof(freq_list) / sizeof(freq_list[0]))
+
 /* hostap.c */
 
 extern struct proc_dir_entry *hostap_proc;
@@ -40,6 +49,26 @@
 int prism2_sta_send_mgmt(local_info_t *local, u8 *dst, u16 stype,
 			 u8 *body, size_t bodylen);
 int prism2_sta_deauth(local_info_t *local, u16 reason);
+int prism2_wds_add(local_info_t *local, u8 *remote_addr,
+		   int rtnl_locked);
+int prism2_wds_del(local_info_t *local, u8 *remote_addr,
+		   int rtnl_locked, int do_not_remove);
+
+
+/* hostap_ap.c */
+
+int ap_control_add_mac(struct mac_restrictions *mac_restrictions, u8 *mac);
+int ap_control_del_mac(struct mac_restrictions *mac_restrictions, u8 *mac);
+void ap_control_flush_macs(struct mac_restrictions *mac_restrictions);
+int ap_control_kick_mac(struct ap_data *ap, struct net_device *dev, u8 *mac);
+void ap_control_kickall(struct ap_data *ap);
+void * ap_crypt_get_ptrs(struct ap_data *ap, u8 *addr, int permanent,
+			 struct ieee80211_crypt_data ***crypt);
+int prism2_ap_get_sta_qual(local_info_t *local, struct sockaddr addr[],
+			   struct iw_quality qual[], int buf_size,
+			   int aplist);
+int prism2_ap_translate_scan(struct net_device *dev, char *buffer);
+int prism2_hostapd(struct ap_data *ap, struct prism2_hostapd_param *param);
 
 
 /* hostap_proc.c */
@@ -54,4 +83,12 @@
 void hostap_info_process(local_info_t *local, struct sk_buff *skb);
 
 
+/* hostap_ioctl.c */
+
+extern const struct iw_handler_def hostap_iw_handler_def;
+extern struct ethtool_ops prism2_ethtool_ops;
+
+int hostap_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
+
+
 #endif /* HOSTAP_H */
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_common.h.old	2005-12-03 01:19:43.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_common.h	2005-12-03 01:21:13.000000000 +0100
@@ -1,6 +1,9 @@
 #ifndef HOSTAP_COMMON_H
 #define HOSTAP_COMMON_H
 
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
 #define BIT(x) (1 << (x))
 
 #define MAC2STR(a) (a)[0], (a)[1], (a)[2], (a)[3], (a)[4], (a)[5]
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_wlan.h.old	2005-12-03 01:22:53.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_wlan.h	2005-12-03 01:26:43.000000000 +0100
@@ -1,6 +1,10 @@
 #ifndef HOSTAP_WLAN_H
 #define HOSTAP_WLAN_H
 
+#include <linux/wireless.h>
+#include <linux/netdevice.h>
+#include <net/iw_handler.h>
+
 #include "hostap_config.h"
 #include "hostap_common.h"
 
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_ap.h.old	2005-12-03 01:28:46.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_ap.h	2005-12-03 01:29:01.000000000 +0100
@@ -1,6 +1,8 @@
 #ifndef HOSTAP_AP_H
 #define HOSTAP_AP_H
 
+#include "hostap_80211.h"
+
 /* AP data structures for STAs */
 
 /* maximum number of frames to buffer per STA */
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_80211.h.old	2005-12-03 01:07:18.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_80211.h	2005-12-03 01:11:00.000000000 +0100
@@ -1,6 +1,9 @@
 #ifndef HOSTAP_80211_H
 #define HOSTAP_80211_H
 
+#include <linux/types.h>
+#include <net/ieee80211_crypt.h>
+
 struct hostap_ieee80211_mgmt {
 	u16 frame_control;
 	u16 duration;
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_main.c.old	2005-12-03 00:40:11.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_main.c	2005-12-03 02:24:34.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/kmod.h>
 #include <linux/rtnetlink.h>
 #include <linux/wireless.h>
+#include <linux/etherdevice.h>
 #include <net/iw_handler.h>
 #include <net/ieee80211.h>
 #include <net/ieee80211_crypt.h>
@@ -47,57 +48,6 @@
 #define PRISM2_MAX_MTU (PRISM2_MAX_FRAME_SIZE - (6 /* LLC */ + 8 /* WEP */))
 
 
-/* hostap.c */
-static int prism2_wds_add(local_info_t *local, u8 *remote_addr,
-			  int rtnl_locked);
-static int prism2_wds_del(local_info_t *local, u8 *remote_addr,
-			  int rtnl_locked, int do_not_remove);
-
-/* hostap_ap.c */
-static int prism2_ap_get_sta_qual(local_info_t *local, struct sockaddr addr[],
-				  struct iw_quality qual[], int buf_size,
-				  int aplist);
-static int prism2_ap_translate_scan(struct net_device *dev, char *buffer);
-static int prism2_hostapd(struct ap_data *ap,
-			  struct prism2_hostapd_param *param);
-static void * ap_crypt_get_ptrs(struct ap_data *ap, u8 *addr, int permanent,
-				struct ieee80211_crypt_data ***crypt);
-static void ap_control_kickall(struct ap_data *ap);
-#ifndef PRISM2_NO_KERNEL_IEEE80211_MGMT
-static int ap_control_add_mac(struct mac_restrictions *mac_restrictions,
-			      u8 *mac);
-static int ap_control_del_mac(struct mac_restrictions *mac_restrictions,
-			      u8 *mac);
-static void ap_control_flush_macs(struct mac_restrictions *mac_restrictions);
-static int ap_control_kick_mac(struct ap_data *ap, struct net_device *dev,
-			       u8 *mac);
-#endif /* !PRISM2_NO_KERNEL_IEEE80211_MGMT */
-
-
-static const long freq_list[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
-				  2447, 2452, 2457, 2462, 2467, 2472, 2484 };
-#define FREQ_COUNT (sizeof(freq_list) / sizeof(freq_list[0]))
-
-
-/* See IEEE 802.1H for LLC/SNAP encapsulation/decapsulation */
-/* Ethernet-II snap header (RFC1042 for most EtherTypes) */
-static unsigned char rfc1042_header[] =
-{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
-/* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
-static unsigned char bridge_tunnel_header[] =
-{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8 };
-/* No encapsulation header if EtherType < 0x600 (=length) */
-
-
-/* FIX: these could be compiled separately and linked together to hostap.o */
-#include "hostap_ap.c"
-#include "hostap_info.c"
-#include "hostap_ioctl.c"
-#include "hostap_proc.c"
-#include "hostap_80211_rx.c"
-#include "hostap_80211_tx.c"
-
-
 struct net_device * hostap_add_interface(struct local_info *local,
 					 int type, int rtnl_locked,
 					 const char *prefix,
@@ -196,8 +146,8 @@
 }
 
 
-static int prism2_wds_add(local_info_t *local, u8 *remote_addr,
-			  int rtnl_locked)
+int prism2_wds_add(local_info_t *local, u8 *remote_addr,
+		   int rtnl_locked)
 {
 	struct net_device *dev;
 	struct list_head *ptr;
@@ -258,8 +208,8 @@
 }
 
 
-static int prism2_wds_del(local_info_t *local, u8 *remote_addr,
-			  int rtnl_locked, int do_not_remove)
+int prism2_wds_del(local_info_t *local, u8 *remote_addr,
+		   int rtnl_locked, int do_not_remove)
 {
 	unsigned long flags;
 	struct list_head *ptr;
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_80211_rx.c.old	2005-12-03 00:53:21.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_80211_rx.c	2005-12-03 02:35:11.000000000 +0100
@@ -1,7 +1,18 @@
 #include <linux/etherdevice.h>
+#include <net/ieee80211_crypt.h>
 
 #include "hostap_80211.h"
 #include "hostap.h"
+#include "hostap_ap.h"
+
+/* See IEEE 802.1H for LLC/SNAP encapsulation/decapsulation */
+/* Ethernet-II snap header (RFC1042 for most EtherTypes) */
+static unsigned char rfc1042_header[] =
+{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
+/* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
+static unsigned char bridge_tunnel_header[] =
+{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8 };
+/* No encapsulation header if EtherType < 0x600 (=length) */
 
 void hostap_dump_rx_80211(const char *name, struct sk_buff *skb,
 			  struct hostap_80211_rx_status *rx_stats)
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_80211_tx.c.old	2005-12-03 01:05:49.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_80211_tx.c	2005-12-03 02:35:19.000000000 +0100
@@ -1,3 +1,18 @@
+#include "hostap_80211.h"
+#include "hostap_common.h"
+#include "hostap_wlan.h"
+#include "hostap.h"
+#include "hostap_ap.h"
+
+/* See IEEE 802.1H for LLC/SNAP encapsulation/decapsulation */
+/* Ethernet-II snap header (RFC1042 for most EtherTypes) */
+static unsigned char rfc1042_header[] =
+{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
+/* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
+static unsigned char bridge_tunnel_header[] =
+{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8 };
+/* No encapsulation header if EtherType < 0x600 (=length) */
+
 void hostap_dump_tx_80211(const char *name, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_4addr *hdr;
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_ap.c.old	2005-12-03 01:18:28.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_ap.c	2005-12-03 02:21:57.000000000 +0100
@@ -16,6 +16,14 @@
  *   (8802.11: 5.5)
  */
 
+#include <linux/proc_fs.h>
+#include <linux/delay.h>
+#include <linux/random.h>
+
+#include "hostap_wlan.h"
+#include "hostap.h"
+#include "hostap_ap.h"
+
 static int other_ap_policy[MAX_PARM_DEVICES] = { AP_OTHER_AP_SKIP_ALL,
 						 DEF_INTS };
 module_param_array(other_ap_policy, int, NULL, 0444);
@@ -360,8 +368,7 @@
 }
 
 
-static int ap_control_add_mac(struct mac_restrictions *mac_restrictions,
-			      u8 *mac)
+int ap_control_add_mac(struct mac_restrictions *mac_restrictions, u8 *mac)
 {
 	struct mac_entry *entry;
 
@@ -380,8 +387,7 @@
 }
 
 
-static int ap_control_del_mac(struct mac_restrictions *mac_restrictions,
-			      u8 *mac)
+int ap_control_del_mac(struct mac_restrictions *mac_restrictions, u8 *mac)
 {
 	struct list_head *ptr;
 	struct mac_entry *entry;
@@ -433,7 +439,7 @@
 }
 
 
-static void ap_control_flush_macs(struct mac_restrictions *mac_restrictions)
+void ap_control_flush_macs(struct mac_restrictions *mac_restrictions)
 {
 	struct list_head *ptr, *n;
 	struct mac_entry *entry;
@@ -454,8 +460,7 @@
 }
 
 
-static int ap_control_kick_mac(struct ap_data *ap, struct net_device *dev,
-			       u8 *mac)
+int ap_control_kick_mac(struct ap_data *ap, struct net_device *dev, u8 *mac)
 {
 	struct sta_info *sta;
 	u16 resp;
@@ -486,7 +491,7 @@
 #endif /* PRISM2_NO_KERNEL_IEEE80211_MGMT */
 
 
-static void ap_control_kickall(struct ap_data *ap)
+void ap_control_kickall(struct ap_data *ap)
 {
 	struct list_head *ptr, *n;
 	struct sta_info *sta;
@@ -2321,9 +2326,9 @@
 }
 
 
-static int prism2_ap_get_sta_qual(local_info_t *local, struct sockaddr addr[],
-				  struct iw_quality qual[], int buf_size,
-				  int aplist)
+int prism2_ap_get_sta_qual(local_info_t *local, struct sockaddr addr[],
+			   struct iw_quality qual[], int buf_size,
+			   int aplist)
 {
 	struct ap_data *ap = local->ap;
 	struct list_head *ptr;
@@ -2363,7 +2368,7 @@
 
 /* Translate our list of Access Points & Stations to a card independant
  * format that the Wireless Tools will understand - Jean II */
-static int prism2_ap_translate_scan(struct net_device *dev, char *buffer)
+int prism2_ap_translate_scan(struct net_device *dev, char *buffer)
 {
 	struct hostap_interface *iface;
 	local_info_t *local;
@@ -2608,8 +2613,7 @@
 }
 
 
-static int prism2_hostapd(struct ap_data *ap,
-			  struct prism2_hostapd_param *param)
+int prism2_hostapd(struct ap_data *ap, struct prism2_hostapd_param *param)
 {
 	switch (param->cmd) {
 	case PRISM2_HOSTAPD_FLUSH:
@@ -3207,8 +3211,8 @@
 }
 
 
-static void * ap_crypt_get_ptrs(struct ap_data *ap, u8 *addr, int permanent,
-				struct ieee80211_crypt_data ***crypt)
+void * ap_crypt_get_ptrs(struct ap_data *ap, u8 *addr, int permanent,
+			 struct ieee80211_crypt_data ***crypt)
 {
 	struct sta_info *sta;
 
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_info.c.old	2005-12-03 01:49:24.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_info.c	2005-12-03 01:51:43.000000000 +0100
@@ -1,5 +1,8 @@
 /* Host AP driver Info Frame processing (part of hostap.o module) */
 
+#include "hostap_wlan.h"
+#include "hostap.h"
+#include "hostap_ap.h"
 
 /* Called only as a tasklet (software IRQ) */
 static void prism2_info_commtallies16(local_info_t *local, unsigned char *buf,
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_ioctl.c.old	2005-12-03 01:52:34.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_ioctl.c	2005-12-03 02:27:09.000000000 +0100
@@ -1,11 +1,13 @@
 /* ioctl() (mostly Linux Wireless Extensions) routines for Host AP driver */
 
-#ifdef in_atomic
-/* Get kernel_locked() for in_atomic() */
+#include <linux/types.h>
 #include <linux/smp_lock.h>
-#endif
 #include <linux/ethtool.h>
+#include <net/ieee80211_crypt.h>
 
+#include "hostap_wlan.h"
+#include "hostap.h"
+#include "hostap_ap.h"
 
 static struct iw_statistics *hostap_get_wireless_stats(struct net_device *dev)
 {
@@ -3910,7 +3912,7 @@
 		 local->sta_fw_ver & 0xff);
 }
 
-static struct ethtool_ops prism2_ethtool_ops = {
+struct ethtool_ops prism2_ethtool_ops = {
 	.get_drvinfo = prism2_get_drvinfo
 };
 
@@ -3985,7 +3987,7 @@
 	(iw_handler) prism2_ioctl_priv_readmif,		/* 3 */
 };
 
-static const struct iw_handler_def hostap_iw_handler_def =
+const struct iw_handler_def hostap_iw_handler_def =
 {
 	.num_standard	= sizeof(prism2_handler) / sizeof(iw_handler),
 	.num_private	= sizeof(prism2_private_handler) / sizeof(iw_handler),
--- linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_proc.c.old	2005-12-03 02:29:08.000000000 +0100
+++ linux-2.6.15-rc3-mm1/drivers/net/wireless/hostap/hostap_proc.c	2005-12-03 02:32:00.000000000 +0100
@@ -1,5 +1,12 @@
 /* /proc routines for Host AP driver */
 
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <net/ieee80211_crypt.h>
+
+#include "hostap_wlan.h"
+#include "hostap.h"
+
 #define PROC_LIMIT (PAGE_SIZE - 80)
 
 

--- linux-2.6.15-mm1-full/include/net/ieee80211_crypt.h.old	2006-01-05 22:28:09.000000000 +0100
+++ linux-2.6.15-mm1-full/include/net/ieee80211_crypt.h	2006-01-05 22:28:26.000000000 +0100
@@ -25,6 +25,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <net/ieee80211.h>
 #include <asm/atomic.h>
 
 enum {

