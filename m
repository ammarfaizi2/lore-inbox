Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbULTB5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbULTB5H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbULTB4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:56:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30481 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261384AbULTBxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:53:37 -0500
Date: Mon, 20 Dec 2004 02:53:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Margit Schubert-While <margitsw@t-online.de>, prism54-private@prism54.org,
       netdev@oss.sgi.com, jgarzik@pobox.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] prism54: misc cleanups
Message-ID: <20041220015331.GP21288@stusta.de>
References: <20041030054534.GC4374@stusta.de> <20041031010143.GI7887@ruslug.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031010143.GI7887@ruslug.rutgers.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As a side effect it turned out that the mgt_unlatch_all function was 
> > completely unused, and I've therefore removed it.
> 
> mgt_unlatch_all is there as work in progress. We currently set ESSID to
> commit but we may need more work than that depending on the mode we're
> in. Even though we're not using it right now we may use it soon due to
> WPA. Please don't remove it.

Sorry for the late answer.

Below is a version of this patch that #if 0's mgt_unlatch_all instead.

> 	Luis

cu
Adrian


<--  snip  -->


The patch below makes some functions in prism54 that are only required 
locally static.

As a side effect it turned out that the mgt_unlatch_all function was 
completely unused, and it's therefore #if 0'ed.

I also considered moving display_buffer as static inline into 
islpci_mgt.h, but I wasn't 100% sure and therefore left it.


diffstat output:
 drivers/net/wireless/prism54/isl_ioctl.c  |   32 +++++++++++-------
 drivers/net/wireless/prism54/isl_ioctl.h  |    5 --
 drivers/net/wireless/prism54/islpci_dev.c |    5 +-
 drivers/net/wireless/prism54/islpci_dev.h |    2 -
 drivers/net/wireless/prism54/islpci_mgt.c |    2 +
 drivers/net/wireless/prism54/oid_mgt.c    |   38 +---------------------
 drivers/net/wireless/prism54/oid_mgt.h    |    4 --
 7 files changed, 28 insertions(+), 60 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/isl_ioctl.h.old	2004-10-30 06:52:18.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/isl_ioctl.h	2004-10-30 07:02:58.000000000 +0200
@@ -41,15 +41,10 @@
 
 void prism54_wpa_ie_init(islpci_private *priv);
 void prism54_wpa_ie_clean(islpci_private *priv);
-void prism54_wpa_ie_add(islpci_private *priv, u8 *bssid,
-			u8 *wpa_ie, size_t wpa_ie_len);
-size_t prism54_wpa_ie_get(islpci_private *priv, u8 *bssid, u8 *wpa_ie);
 
 int prism54_set_mac_address(struct net_device *, void *);
 
 int prism54_ioctl(struct net_device *, struct ifreq *, int);
-int prism54_set_wpa(struct net_device *, struct iw_request_info *, 
-			__u32 *, char *);
 
 extern const struct iw_handler_def prism54_handler_def;
 
--- linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/isl_ioctl.c.old	2004-10-30 06:43:10.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/isl_ioctl.c	2004-10-30 07:11:26.000000000 +0200
@@ -36,6 +36,14 @@
 
 #include <net/iw_handler.h>	/* New driver API */
 
+
+static void prism54_wpa_ie_add(islpci_private *priv, u8 *bssid,
+				u8 *wpa_ie, size_t wpa_ie_len);
+static size_t prism54_wpa_ie_get(islpci_private *priv, u8 *bssid, u8 *wpa_ie);
+static int prism54_set_wpa(struct net_device *, struct iw_request_info *, 
+				__u32 *, char *);
+
+
 /**
  * prism54_mib_mode_helper - MIB change mode helper function
  * @mib: the &struct islpci_mib object to modify
@@ -47,7 +55,7 @@
  *  Wireless API modes to Device firmware modes. It also checks for 
  *  correct valid Linux wireless modes. 
  */
-int
+static int
 prism54_mib_mode_helper(islpci_private *priv, u32 iw_mode)
 {
 	u32 config = INL_CONFIG_MANUALRUN;
@@ -647,7 +655,7 @@
 	return current_ev;
 }
 
-int
+static int
 prism54_get_scan(struct net_device *ndev, struct iw_request_info *info,
 		 struct iw_point *dwrq, char *extra)
 {
@@ -1582,7 +1590,7 @@
 #define MAC2STR(a) (a)[0], (a)[1], (a)[2], (a)[3], (a)[4], (a)[5]
 #define MACSTR "%02x:%02x:%02x:%02x:%02x:%02x"
 
-void
+static void
 prism54_wpa_ie_add(islpci_private *priv, u8 *bssid,
 		   u8 *wpa_ie, size_t wpa_ie_len)
 {
@@ -1649,7 +1657,7 @@
 	up(&priv->wpa_sem);
 }
 
-size_t
+static size_t
 prism54_wpa_ie_get(islpci_private *priv, u8 *bssid, u8 *wpa_ie)
 {
 	struct list_head *ptr;
@@ -1736,7 +1744,7 @@
 	}
 }
 
-int
+static int
 prism54_process_trap_helper(islpci_private *priv, enum oid_num_t oid,
 			    char *data)
 {
@@ -2314,7 +2322,7 @@
        return ret;
 }
 
-int
+static int
 prism54_set_wpa(struct net_device *ndev, struct iw_request_info *info,
 		__u32 * uwrq, char *extra)
 {
@@ -2358,7 +2366,7 @@
 	return 0;
 }
 
-int
+static int
 prism54_get_wpa(struct net_device *ndev, struct iw_request_info *info,
 		__u32 * uwrq, char *extra)
 {
@@ -2367,7 +2375,7 @@
 	return 0;
 }
 
-int
+static int
 prism54_set_prismhdr(struct net_device *ndev, struct iw_request_info *info,
 		     __u32 * uwrq, char *extra)
 {
@@ -2380,7 +2388,7 @@
 	return 0;
 }
 
-int
+static int
 prism54_get_prismhdr(struct net_device *ndev, struct iw_request_info *info,
 		     __u32 * uwrq, char *extra)
 {
@@ -2389,7 +2397,7 @@
 	return 0;
 }
 
-int
+static int
 prism54_debug_oid(struct net_device *ndev, struct iw_request_info *info,
 		  __u32 * uwrq, char *extra)
 {
@@ -2401,7 +2409,7 @@
 	return 0;
 }
 
-int
+static int
 prism54_debug_get_oid(struct net_device *ndev, struct iw_request_info *info,
 		      struct iw_point *data, char *extra)
 {
@@ -2437,7 +2445,7 @@
 	return ret;
 }
 
-int
+static int
 prism54_debug_set_oid(struct net_device *ndev, struct iw_request_info *info,
 		      struct iw_point *data, char *extra)
 {
--- linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/islpci_dev.h.old	2004-10-30 06:58:23.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/islpci_dev.h	2004-10-30 07:04:02.000000000 +0200
@@ -211,8 +211,6 @@
 			       priv->device_base);
 }
 
-struct net_device_stats *islpci_statistics(struct net_device *);
-
 int islpci_free_memory(islpci_private *);
 struct net_device *islpci_setup(struct pci_dev *);
 #endif				/* _ISLPCI_DEV_H */
--- linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/islpci_dev.c.old	2004-10-30 06:46:08.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/islpci_dev.c	2004-10-30 07:12:13.000000000 +0200
@@ -44,6 +44,7 @@
 
 static int prism54_bring_down(islpci_private *);
 static int islpci_alloc_memory(islpci_private *);
+static struct net_device_stats *islpci_statistics(struct net_device *);
 
 /* Temporary dummy MAC address to use until firmware is loaded.
  * The idea there is that some tools (such as nameif) may query
@@ -52,7 +53,7 @@
  * Of course, this is not the final/real MAC address. It doesn't
  * matter, as you are suppose to be able to change it anytime via
  * ndev->set_mac_address. Jean II */
-const unsigned char	dummy_mac[6] = { 0x00, 0x30, 0xB4, 0x00, 0x00, 0x00 };
+static const unsigned char	dummy_mac[6] = { 0x00, 0x30, 0xB4, 0x00, 0x00, 0x00 };
 
 static int
 isl_upload_firmware(islpci_private *priv)
@@ -607,7 +608,7 @@
 	return rc;
 }
 
-struct net_device_stats *
+static struct net_device_stats *
 islpci_statistics(struct net_device *ndev)
 {
 	islpci_private *priv = netdev_priv(ndev);
--- linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/islpci_mgt.c.old	2004-10-30 06:46:45.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/islpci_mgt.c	2004-10-30 07:15:39.000000000 +0200
@@ -44,6 +44,7 @@
 /******************************************************************************
     Driver general functions
 ******************************************************************************/
+#if VERBOSE > SHOW_ERROR_MESSAGES
 void
 display_buffer(char *buffer, int length)
 {
@@ -58,6 +59,7 @@
 
 	printk("\n");
 }
+#endif
 
 /*****************************************************************************
     Queue handling for management frames
--- linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/oid_mgt.h.old	2004-10-30 07:05:55.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/net/wireless/prism54/oid_mgt.h	2004-10-30 07:42:02.000000000 +0200
@@ -28,8 +28,7 @@
 
 void mgt_clean(islpci_private *);
 
-/* I don't know where to put these 3 */
-extern const int frequency_list_bg[];
+/* I don't know where to put these 2 */
 extern const int frequency_list_a[];
 int channel_of_freq(int);
 
@@ -49,7 +48,6 @@
 void mgt_get(islpci_private *, enum oid_num_t, void *);
 
 int mgt_commit(islpci_private *);
-void mgt_unlatch_all(islpci_private *);
 
 int mgt_mlme_answer(islpci_private *);
 
--- linux-2.6.10-rc3-mm1-full/drivers/net/wireless/prism54/oid_mgt.c.old	2004-12-20 01:03:44.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/net/wireless/prism54/oid_mgt.c	2004-12-20 01:05:31.000000000 +0100
@@ -24,8 +24,8 @@
 #include "isl_ioctl.h"
 
 /* to convert between channel and freq */
-const int frequency_list_bg[] = { 2412, 2417, 2422, 2427, 2432, 2437, 2442,
-	2447, 2452, 2457, 2462, 2467, 2472, 2484
+static const int frequency_list_bg[] = { 2412, 2417, 2422, 2427, 2432,
+	2437, 2442, 2447, 2452, 2457, 2462, 2467, 2472, 2484
 };
 
 int
@@ -730,6 +730,7 @@
  *
  * The way to do this is to set ESSID. Note though that they may get 
  * unlatch before though by setting another OID. */
+#if 0
 void
 mgt_unlatch_all(islpci_private *priv)
 {
@@ -756,6 +757,7 @@
 	if (rvalue)
 		printk(KERN_DEBUG "%s: Unlatching OIDs failed\n", priv->ndev->name);
 }
+#endif
 
 /* This will tell you if you are allowed to answer a mlme(ex) request .*/
 

