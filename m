Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbULOBTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbULOBTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbULOBSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:18:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53005 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261817AbULOBHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:07:53 -0500
Date: Wed, 15 Dec 2004 02:07:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jonathan Naylor <g4klx@g4klx.demon.co.uk>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/lapb/lapb_iface.c: remove unused code
Message-ID: <20041215010745.GB12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes the following unused code:
- EXPORT_SYMBOL'ed functions lapb_getparms and lapb_setparms
- struct lapb_parms_struct

Please review whether it's correct or conflicts with pending changes.


diffstat output:
 Documentation/networking/lapb-module.txt |   45 ---------------
 include/linux/lapb.h                     |   14 ----
 net/lapb/lapb_iface.c                    |   67 -----------------------
 3 files changed, 126 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/linux/lapb.h.old	2004-12-14 20:23:12.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/lapb.h	2004-12-14 20:24:38.000000000 +0100
@@ -32,22 +32,8 @@
 	void (*data_transmit)(struct net_device *dev, struct sk_buff *skb);
 };
 
-struct lapb_parms_struct {
-	unsigned int t1;
-	unsigned int t1timer;
-	unsigned int t2;
-	unsigned int t2timer;
-	unsigned int n2;
-	unsigned int n2count;
-	unsigned int window;
-	unsigned int state;
-	unsigned int mode;
-};
-
 extern int lapb_register(struct net_device *dev, struct lapb_register_struct *callbacks);
 extern int lapb_unregister(struct net_device *dev);
-extern int lapb_getparms(struct net_device *dev, struct lapb_parms_struct *parms);
-extern int lapb_setparms(struct net_device *dev, struct lapb_parms_struct *parms);
 extern int lapb_connect_request(struct net_device *dev);
 extern int lapb_disconnect_request(struct net_device *dev);
 extern int lapb_data_request(struct net_device *dev, struct sk_buff *skb);
--- linux-2.6.10-rc3-mm1-full/net/lapb/lapb_iface.c.old	2004-12-14 20:23:27.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/lapb/lapb_iface.c	2004-12-15 00:12:18.000000000 +0100
@@ -195,71 +195,6 @@
 	return rc;
 }
 
-int lapb_getparms(struct net_device *dev, struct lapb_parms_struct *parms)
-{
-	int rc = LAPB_BADTOKEN;
-	struct lapb_cb *lapb = lapb_devtostruct(dev);
-
-	if (!lapb)
-		goto out;
-
-	parms->t1      = lapb->t1 / HZ;
-	parms->t2      = lapb->t2 / HZ;
-	parms->n2      = lapb->n2;
-	parms->n2count = lapb->n2count;
-	parms->state   = lapb->state;
-	parms->window  = lapb->window;
-	parms->mode    = lapb->mode;
-
-	if (!timer_pending(&lapb->t1timer))
-		parms->t1timer = 0;
-	else
-		parms->t1timer = (lapb->t1timer.expires - jiffies) / HZ;
-
-	if (!timer_pending(&lapb->t2timer))
-		parms->t2timer = 0;
-	else
-		parms->t2timer = (lapb->t2timer.expires - jiffies) / HZ;
-
-	lapb_put(lapb);
-	rc = LAPB_OK;
-out:
-	return rc;
-}
-
-int lapb_setparms(struct net_device *dev, struct lapb_parms_struct *parms)
-{
-	int rc = LAPB_BADTOKEN;
-	struct lapb_cb *lapb = lapb_devtostruct(dev);
-
-	if (!lapb)
-		goto out;
-
-	rc = LAPB_INVALUE;
-	if (parms->t1 < 1 || parms->t2 < 1 || parms->n2 < 1)
-		goto out_put;
-
-	if (lapb->state == LAPB_STATE_0) {
-		if (((parms->mode & LAPB_EXTENDED) &&
-		     (parms->window < 1 || parms->window > 127)) ||
-		    (parms->window < 1 || parms->window > 7))
-			goto out_put;
-
-		lapb->mode    = parms->mode;
-		lapb->window  = parms->window;
-	}
-
-	lapb->t1    = parms->t1 * HZ;
-	lapb->t2    = parms->t2 * HZ;
-	lapb->n2    = parms->n2;
-
-	rc = LAPB_OK;
-out_put:
-	lapb_put(lapb);
-out:
-	return rc;
-}
-
 int lapb_connect_request(struct net_device *dev)
 {
 	struct lapb_cb *lapb = lapb_devtostruct(dev);
@@ -424,8 +359,6 @@
 
 EXPORT_SYMBOL(lapb_register);
 EXPORT_SYMBOL(lapb_unregister);
-EXPORT_SYMBOL(lapb_getparms);
-EXPORT_SYMBOL(lapb_setparms);
 EXPORT_SYMBOL(lapb_connect_request);
 EXPORT_SYMBOL(lapb_disconnect_request);
 EXPORT_SYMBOL(lapb_data_request);
--- linux-2.6.10-rc3-mm1-full/Documentation/networking/lapb-module.txt.old	2004-12-14 20:24:12.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/Documentation/networking/lapb-module.txt	2004-12-14 20:24:24.000000000 +0100
@@ -49,51 +49,6 @@
 may be substituted.
 
 
-LAPB Parameter Structure
-------------------------
-
-This structure is used with the lapb_getparms and lapb_setparms functions
-(see below). They are used to allow the device driver to get and set the
-operational parameters of the LAPB implementation for a given connection.
-
-struct lapb_parms_struct {
-	unsigned int t1;
-	unsigned int t1timer;
-	unsigned int t2;
-	unsigned int t2timer;
-	unsigned int n2;
-	unsigned int n2count;
-	unsigned int window;
-	unsigned int state;
-	unsigned int mode;
-};
-
-T1 and T2 are protocol timing parameters and are given in units of 100ms. N2
-is the maximum number of tries on the link before it is declared a failure.
-The window size is the maximum number of outstanding data packets allowed to
-be unacknowledged by the remote end, the value of the window is between 1
-and 7 for a standard LAPB link, and between 1 and 127 for an extended LAPB
-link.
-
-The mode variable is a bit field used for setting (at present) three values.
-The bit fields have the following meanings:
-
-Bit	Meaning
-0	LAPB operation (0=LAPB_STANDARD 1=LAPB_EXTENDED).
-1	[SM]LP operation (0=LAPB_SLP 1=LAPB=MLP).
-2	DTE/DCE operation (0=LAPB_DTE 1=LAPB_DCE)
-3-31	Reserved, must be 0.
-
-Extended LAPB operation indicates the use of extended sequence numbers and
-consequently larger window sizes, the default is standard LAPB operation.
-MLP operation is the same as SLP operation except that the addresses used by
-LAPB are different to indicate the mode of operation, the default is Single
-Link Procedure. The difference between DCE and DTE operation is (i) the
-addresses used for commands and responses, and (ii) when the DCE is not
-connected, it sends DM without polls set, every T1. The upper case constant
-names will be defined in the public LAPB header file.
-
-
 Functions
 ---------
 

