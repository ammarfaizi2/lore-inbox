Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVBIC4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVBIC4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVBIC4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:56:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7688 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261766AbVBICz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:55:26 -0500
Date: Wed, 9 Feb 2005 03:55:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/pcbit/: possible cleanups
Message-ID: <20050209025521.GD2978@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make some needlessly global functions static
- remove the following unused global functions:
  - callbacks.c: cb_out_3
  - capi.c: capi_decode_disc_conf

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/pcbit/callbacks.c |   17 -----------------
 drivers/isdn/pcbit/callbacks.h |    3 ---
 drivers/isdn/pcbit/capi.c      |   10 ----------
 drivers/isdn/pcbit/capi.h      |    1 -
 drivers/isdn/pcbit/drv.c       |   16 ++++++++--------
 5 files changed, 8 insertions(+), 39 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/callbacks.h.old	2005-02-09 03:27:18.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/callbacks.h	2005-02-09 03:27:24.000000000 +0100
@@ -19,9 +19,6 @@
 extern void cb_out_2(struct pcbit_dev * dev, struct pcbit_chan* chan, 
 		     struct callb_data *data);
 
-extern void cb_out_3(struct pcbit_dev * dev, struct pcbit_chan* chan, 
-		     struct callb_data *data);
-
 extern void cb_in_1(struct pcbit_dev * dev, struct pcbit_chan* chan, 
 		    struct callb_data *data);
 extern void cb_in_2(struct pcbit_dev * dev, struct pcbit_chan* chan, 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/callbacks.c.old	2005-02-09 03:27:32.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/callbacks.c	2005-02-09 03:27:49.000000000 +0100
@@ -125,23 +125,6 @@
 
 
 /*
- * Disconnect received (actually RELEASE COMPLETE) 
- * This means we were not able to establish connection with remote
- * Inform the big boss above
- */
-void cb_out_3(struct pcbit_dev * dev, struct pcbit_chan* chan,
-	      struct callb_data *data) 
-{
-        isdn_ctrl ictl;
-
-        ictl.command = ISDN_STAT_DHUP;
-        ictl.driver=dev->id;
-        ictl.arg=chan->id;
-        dev->dev_if->statcallb(&ictl);
-}
-
-
-/*
  * Incoming call received
  * inform user
  */
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/capi.h.old	2005-02-09 03:28:06.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/capi.h	2005-02-09 03:28:14.000000000 +0100
@@ -54,7 +54,6 @@
 
 /* Connection Termination */
 extern int capi_disc_req(ushort callref, struct sk_buff **skb, u_char cause);
-extern int capi_decode_disc_conf(struct pcbit_chan *chan, struct sk_buff *skb);
 
 extern int capi_decode_disc_ind(struct pcbit_chan *chan, struct sk_buff *skb);
 extern int capi_disc_resp(struct pcbit_chan *chan, struct sk_buff **skb);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/capi.c.old	2005-02-09 03:28:26.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/capi.c	2005-02-09 03:28:32.000000000 +0100
@@ -627,16 +627,6 @@
         return 0;
 }
 
-int capi_decode_disc_conf(struct pcbit_chan *chan, struct sk_buff *skb)
-{
-        ushort errcode;
-
-        errcode = *((ushort*) skb->data);
-        skb_pull(skb, 2);
-
-        return errcode;                
-}
-
 #ifdef DEBUG
 int capi_decode_debug_188(u_char *hdr, ushort hdrlen)
 {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/drv.c.old	2005-02-09 03:29:07.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/pcbit/drv.c	2005-02-09 03:30:10.000000000 +0100
@@ -56,10 +56,10 @@
  * prototypes
  */
 
-int pcbit_command(isdn_ctrl* ctl);
-int pcbit_stat(u_char __user * buf, int len, int, int);
-int pcbit_xmit(int driver, int chan, int ack, struct sk_buff *skb);
-int pcbit_writecmd(const u_char __user *, int, int, int);
+static int pcbit_command(isdn_ctrl* ctl);
+static int pcbit_stat(u_char __user * buf, int len, int, int);
+static int pcbit_xmit(int driver, int chan, int ack, struct sk_buff *skb);
+static int pcbit_writecmd(const u_char __user *, int, int, int);
 
 static int set_protocol_running(struct pcbit_dev * dev);
 
@@ -238,7 +238,7 @@
 }
 #endif
 
-int pcbit_command(isdn_ctrl* ctl)
+static int pcbit_command(isdn_ctrl* ctl)
 {
 	struct pcbit_dev  *dev;
 	struct pcbit_chan *chan;
@@ -330,7 +330,7 @@
 }
 #endif
 
-int pcbit_xmit(int driver, int chnum, int ack, struct sk_buff *skb)
+static int pcbit_xmit(int driver, int chnum, int ack, struct sk_buff *skb)
 {
 	ushort hdrlen;
 	int refnum, len;
@@ -389,7 +389,7 @@
 	return len;
 }
 
-int pcbit_writecmd(const u_char __user *buf, int len, int driver, int channel)
+static int pcbit_writecmd(const u_char __user *buf, int len, int driver, int channel)
 {
 	struct pcbit_dev * dev;
 	int i, j;
@@ -713,7 +713,7 @@
 static int stat_st = 0;
 static int stat_end = 0;
 
-int pcbit_stat(u_char __user *buf, int len, int driver, int channel)
+static int pcbit_stat(u_char __user *buf, int len, int driver, int channel)
 {
 	int stat_count;
 	stat_count = stat_end - stat_st;

