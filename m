Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVBICyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVBICyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVBICyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:54:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3080 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261762AbVBICxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:53:34 -0500
Date: Wed, 9 Feb 2005 03:53:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/i4l/: possible cleanups
Message-ID: <20050209025331.GC2978@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the following unused global function:
  - isdn_audio.c: isdn_audio_2adpcm_flush
- remove the following unused struct:
  - isdn_net.c: isdn_concap_demand_dial_dops

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/i4l/isdn_audio.c    |   10 --------
 drivers/isdn/i4l/isdn_audio.h    |    1 
 drivers/isdn/i4l/isdn_common.c   |    6 ++---
 drivers/isdn/i4l/isdn_common.h   |    1 
 drivers/isdn/i4l/isdn_concap.c   |   15 ++----------
 drivers/isdn/i4l/isdn_concap.h   |    1 
 drivers/isdn/i4l/isdn_net.c      |   10 ++++----
 drivers/isdn/i4l/isdn_tty.c      |    4 +--
 drivers/isdn/i4l/isdn_tty.h      |    1 
 drivers/isdn/i4l/isdn_ttyfax.c   |    6 ++---
 drivers/isdn/i4l/isdn_x25iface.c |   36 +++++++++++++++----------------
 11 files changed, 34 insertions(+), 57 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_audio.h.old	2005-02-09 03:17:36.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_audio.h	2005-02-09 03:17:43.000000000 +0100
@@ -35,7 +35,6 @@
 extern adpcm_state *isdn_audio_adpcm_init(adpcm_state *, int);
 extern int isdn_audio_adpcm2xlaw(adpcm_state *, int, unsigned char *, unsigned char *, int);
 extern int isdn_audio_xlaw2adpcm(adpcm_state *, int, unsigned char *, unsigned char *, int);
-extern int isdn_audio_2adpcm_flush(adpcm_state * s, unsigned char *out);
 extern void isdn_audio_calc_dtmf(modem_info *, unsigned char *, int, int);
 extern void isdn_audio_eval_dtmf(modem_info *);
 dtmf_state *isdn_audio_dtmf_init(dtmf_state *);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_audio.c.old	2005-02-09 03:17:52.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_audio.c	2005-02-09 03:18:02.000000000 +0100
@@ -392,16 +392,6 @@
 }
 
 int
-isdn_audio_2adpcm_flush(adpcm_state * s, unsigned char *out)
-{
-	int olen = 0;
-
-	if (s->nleft)
-		isdn_audio_put_bits(0, 8 - s->nleft, s, &out, &olen);
-	return olen;
-}
-
-int
 isdn_audio_xlaw2adpcm(adpcm_state * s, int fmt, unsigned char *in,
 		      unsigned char *out, int len)
 {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_common.h.old	2005-02-09 03:18:20.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_common.h	2005-02-09 03:18:26.000000000 +0100
@@ -41,7 +41,6 @@
 extern int  isdn_writebuf_skb_stub(int, int, int, struct sk_buff *);
 extern int  register_isdn(isdn_if * i);
 extern int  isdn_msncmp( const char *,  const char *);
-extern int  isdn_add_channels(isdn_driver_t *, int, int, int);
 #if defined(ISDN_DEBUG_NET_DUMP) || defined(ISDN_DEBUG_MODEM_DUMP)
 extern void isdn_dumppkt(char *, u_char *, int, int);
 #endif
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_common.c.old	2005-02-09 03:18:39.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_common.c	2005-02-09 03:19:12.000000000 +0100
@@ -67,7 +67,7 @@
 static int isdn_writebuf_stub(int, int, const u_char __user *, int);
 static void set_global_features(void);
 static int isdn_wildmat(char *s, char *p);
-
+static int isdn_add_channels(isdn_driver_t *d, int drvidx, int n, int adding);
 
 static inline void
 isdn_lock_driver(isdn_driver_t *drv)
@@ -388,7 +388,7 @@
  */
 #include <linux/isdn/capicmd.h>
 
-int
+static int
 isdn_capi_rec_hl_msg(capi_msg *cm) {
 	
 	int di;
@@ -1923,7 +1923,7 @@
 	return ret;
 }
 
-int
+static int
 isdn_add_channels(isdn_driver_t *d, int drvidx, int n, int adding)
 {
 	int j, k, m;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_concap.h.old	2005-02-09 03:19:25.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_concap.h	2005-02-09 03:19:47.000000000 +0100
@@ -8,7 +8,6 @@
  */
 
 extern struct concap_device_ops isdn_concap_reliable_dl_dops;
-extern struct concap_device_ops isdn_concap_demand_dial_dops;
 extern struct concap_proto * isdn_concap_new( int );
 
 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_concap.c.old	2005-02-09 03:19:55.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_concap.c	2005-02-09 03:21:08.000000000 +0100
@@ -39,7 +39,7 @@
    */
 
 
-int isdn_concap_dl_data_req(struct concap_proto *concap, struct sk_buff *skb)
+static int isdn_concap_dl_data_req(struct concap_proto *concap, struct sk_buff *skb)
 {
 	struct net_device *ndev = concap -> net_dev;
 	isdn_net_dev *nd = ((isdn_net_local *) ndev->priv)->netdev;
@@ -58,7 +58,7 @@
 }
 
 
-int isdn_concap_dl_connect_req(struct concap_proto *concap)
+static int isdn_concap_dl_connect_req(struct concap_proto *concap)
 {
 	struct net_device *ndev = concap -> net_dev;
 	isdn_net_local *lp = (isdn_net_local *) ndev->priv;
@@ -71,7 +71,7 @@
 	return ret;
 }
 
-int isdn_concap_dl_disconn_req(struct concap_proto *concap)
+static int isdn_concap_dl_disconn_req(struct concap_proto *concap)
 {
 	IX25DEBUG( "isdn_concap_dl_disconn_req: %s \n", concap -> net_dev -> name);
 
@@ -85,15 +85,6 @@
 	&isdn_concap_dl_disconn_req
 };
 
-struct concap_device_ops isdn_concap_demand_dial_dops = {
-	NULL, /* set this first entry to something like &isdn_net_start_xmit,
-		 but the entry part of the current isdn_net_start_xmit must be
-		 separated first. */
-	/* no connection control for demand dial semantics */
-	NULL,
-	NULL,
-};
-
 /* The following should better go into a dedicated source file such that
    this sourcefile does not need to include any protocol specific header
    files. For now:
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_net.c.old	2005-02-09 03:21:22.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_net.c	2005-02-09 03:22:19.000000000 +0100
@@ -176,7 +176,7 @@
 
 /* Prototypes */
 
-int isdn_net_force_dial_lp(isdn_net_local *);
+static int isdn_net_force_dial_lp(isdn_net_local *);
 static int isdn_net_start_xmit(struct sk_buff *, struct net_device *);
 
 static void isdn_net_ciscohdlck_connected(isdn_net_local *lp);
@@ -312,7 +312,7 @@
  * Since this function is called every second, simply reset the
  * byte-counter of the interface after copying it to the cps-variable.
  */
-unsigned long last_jiffies = -HZ;
+static unsigned long last_jiffies = -HZ;
 
 void
 isdn_net_autohup(void)
@@ -1131,7 +1131,7 @@
 }
 
 
-void isdn_net_tx_timeout(struct net_device * ndev)
+static void isdn_net_tx_timeout(struct net_device * ndev)
 {
 	isdn_net_local *lp = (isdn_net_local *) ndev->priv;
 
@@ -1424,7 +1424,7 @@
 }
 
 /* cisco hdlck device private ioctls */
-int
+static int
 isdn_ciscohdlck_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	isdn_net_local *lp = (isdn_net_local *) dev->priv;
@@ -2460,7 +2460,7 @@
  * This is called from the userlevel-routine below or
  * from isdn_net_start_xmit().
  */
-int
+static int
 isdn_net_force_dial_lp(isdn_net_local * lp)
 {
 	if ((!(lp->flags & ISDN_NET_CONNECTED)) && !lp->dialstate) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_tty.h.old	2005-02-09 03:23:16.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_tty.h	2005-02-09 03:23:20.000000000 +0100
@@ -109,7 +109,6 @@
 extern void isdn_tty_exit(void);
 extern void isdn_tty_readmodem(void);
 extern int  isdn_tty_find_icall(int, int, setup_parm *);
-extern void isdn_tty_cleanup_xmit(modem_info *);
 extern int  isdn_tty_stat_callback(int, isdn_ctrl *);
 extern int  isdn_tty_rcv_skb(int, int, int, struct sk_buff *);
 extern int  isdn_tty_capi_facility(capi_msg *cm); 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_tty.c.old	2005-02-09 03:22:34.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_tty.c	2005-02-09 03:22:54.000000000 +0100
@@ -273,7 +273,7 @@
 	return 1;
 }
 
-void
+static void
 isdn_tty_cleanup_xmit(modem_info * info)
 {
 	skb_queue_purge(&info->xmit_queue);
@@ -560,7 +560,7 @@
 /*
  * return the usage calculated by si and layer 2 protocol
  */
-int
+static int
 isdn_calc_usage(int si, int l2)
 {
 	int usg = ISDN_USAGE_MODEM;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_ttyfax.c.old	2005-02-09 03:23:42.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_ttyfax.c	2005-02-09 03:24:09.000000000 +0100
@@ -148,7 +148,7 @@
 	}
 }
 
-int
+static int
 isdn_tty_fax_command1(modem_info * info, isdn_ctrl * c)
 {
 	static char *msg[] =
@@ -316,7 +316,7 @@
  * Parse AT+F.. FAX class 1 commands
  */
 
-int
+static int
 isdn_tty_cmd_FCLASS1(char **p, modem_info * info)
 {
 	static char *cmd[] =
@@ -408,7 +408,7 @@
  * Parse AT+F.. FAX class 2 commands
  */
 
-int
+static int
 isdn_tty_cmd_FCLASS2(char **p, modem_info * info)
 {
 	atemu *m = &info->emu;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_x25iface.c.old	2005-02-09 03:24:24.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/i4l/isdn_x25iface.c	2005-02-09 03:26:33.000000000 +0100
@@ -40,15 +40,15 @@
 
 
 /* is now in header file (extern): struct concap_proto * isdn_x25iface_proto_new(void); */
-void isdn_x25iface_proto_del( struct concap_proto * );
-int isdn_x25iface_proto_close( struct concap_proto * );
-int isdn_x25iface_proto_restart( struct concap_proto *,
-				 struct net_device *,
-				 struct concap_device_ops *);
-int isdn_x25iface_xmit( struct concap_proto *, struct sk_buff * );
-int isdn_x25iface_receive( struct concap_proto *, struct sk_buff * );
-int isdn_x25iface_connect_ind( struct concap_proto * );
-int isdn_x25iface_disconn_ind( struct concap_proto * );
+static void isdn_x25iface_proto_del( struct concap_proto * );
+static int isdn_x25iface_proto_close( struct concap_proto * );
+static int isdn_x25iface_proto_restart( struct concap_proto *,
+					struct net_device *,
+					struct concap_device_ops *);
+static int isdn_x25iface_xmit( struct concap_proto *, struct sk_buff * );
+static int isdn_x25iface_receive( struct concap_proto *, struct sk_buff * );
+static int isdn_x25iface_connect_ind( struct concap_proto * );
+static int isdn_x25iface_disconn_ind( struct concap_proto * );
 
 
 static struct concap_proto_ops ix25_pops = {
@@ -102,7 +102,7 @@
 
 /* close the x25iface encapsulation protocol 
  */
-int isdn_x25iface_proto_close(struct concap_proto *cprot){
+static int isdn_x25iface_proto_close(struct concap_proto *cprot){
 
 	ix25_pdata_t *tmp;
         int ret = 0;
@@ -129,7 +129,7 @@
 
 /* Delete the x25iface encapsulation protocol instance
  */
-void isdn_x25iface_proto_del(struct concap_proto *cprot){
+static void isdn_x25iface_proto_del(struct concap_proto *cprot){
 
 	ix25_pdata_t * tmp;
  
@@ -158,9 +158,9 @@
 
 /* (re-)initialize the data structures for x25iface encapsulation
  */
-int isdn_x25iface_proto_restart(struct concap_proto *cprot,
-				struct net_device *ndev, 
-				struct concap_device_ops *dops)
+static int isdn_x25iface_proto_restart(struct concap_proto *cprot,
+					struct net_device *ndev, 
+					struct concap_device_ops *dops)
 {
 	ix25_pdata_t * pda = cprot -> proto_data ;
 	ulong flags;
@@ -187,7 +187,7 @@
 
 /* deliver a dl_data frame received from i4l HL driver to the network layer 
  */
-int isdn_x25iface_receive(struct concap_proto *cprot, struct sk_buff *skb)
+static int isdn_x25iface_receive(struct concap_proto *cprot, struct sk_buff *skb)
 {
   	IX25DEBUG( "isdn_x25iface_receive %s \n", MY_DEVNAME(cprot->net_dev) );
 	if ( ( (ix25_pdata_t*) (cprot->proto_data) ) 
@@ -206,7 +206,7 @@
 
 /* a connection set up is indicated by lower layer 
  */
-int isdn_x25iface_connect_ind(struct concap_proto *cprot)
+static int isdn_x25iface_connect_ind(struct concap_proto *cprot)
 {
 	struct sk_buff * skb = dev_alloc_skb(1);
 	enum wan_states *state_p 
@@ -235,7 +235,7 @@
 	
 /* a disconnect is indicated by lower layer 
  */
-int isdn_x25iface_disconn_ind(struct concap_proto *cprot)
+static int isdn_x25iface_disconn_ind(struct concap_proto *cprot)
 {
 	struct sk_buff *skb;
 	enum wan_states *state_p 
@@ -264,7 +264,7 @@
 /* process a frame handed over to us from linux network layer. First byte
    semantics as defined in Documentation/networking/x25-iface.txt
    */
-int isdn_x25iface_xmit(struct concap_proto *cprot, struct sk_buff *skb)
+static int isdn_x25iface_xmit(struct concap_proto *cprot, struct sk_buff *skb)
 {
 	unsigned char firstbyte = skb->data[0];
 	enum wan_states *state = &((ix25_pdata_t*)cprot->proto_data)->state;

