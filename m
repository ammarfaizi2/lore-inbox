Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbTCYJUv>; Tue, 25 Mar 2003 04:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261833AbTCYJUv>; Tue, 25 Mar 2003 04:20:51 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.28]:34461 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261829AbTCYJUt>; Tue, 25 Mar 2003 04:20:49 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: eliminate ATM open/close races
Date: Tue, 25 Mar 2003 10:31:50 +0100
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303251031.50691.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The list of open vccs is modified by open/close, and traversed by the
receive tasklet.  This is the last race I know of in this driver.


speedtch.c |   20 ++++++++++++++++++--
1 files changed, 18 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Tue Mar 25 10:27:35 2003
+++ b/drivers/usb/misc/speedtch.c	Tue Mar 25 10:27:35 2003
@@ -933,11 +933,17 @@
 	if (vcc->qos.aal != ATM_AAL5)
 		return -EINVAL;
 
-	if (udsl_find_vcc (instance, vpi, vci))
+	down (&instance->serialize); /* vs self, udsl_atm_close */
+
+	if (udsl_find_vcc (instance, vpi, vci)) {
+		up (&instance->serialize);
 		return -EADDRINUSE;
+	}
 
-	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL)))
+	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL))) {
+		up (&instance->serialize);
 		return -ENOMEM;
+	}
 
 	memset (new, 0, sizeof (struct udsl_vcc_data));
 	new->vcc = vcc;
@@ -949,12 +955,16 @@
 	vcc->vpi = vpi;
 	vcc->vci = vci;
 
+	tasklet_disable (&instance->receive_tasklet);
 	list_add (&new->list, &instance->vcc_list);
+	tasklet_enable (&instance->receive_tasklet);
 
 	set_bit (ATM_VF_ADDR, &vcc->flags);
 	set_bit (ATM_VF_PARTIAL, &vcc->flags);
 	set_bit (ATM_VF_READY, &vcc->flags);
 
+	up (&instance->serialize);
+
 	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
 
 	MOD_INC_USE_COUNT;
@@ -983,7 +993,11 @@
 
 	udsl_cancel_send (instance, vcc);
 
+	down (&instance->serialize); /* vs self, udsl_atm_open */
+
+	tasklet_disable (&instance->receive_tasklet);
 	list_del (&vcc_data->list);
+	tasklet_enable (&instance->receive_tasklet);
 
 	if (vcc_data->reasBuffer)
 		kfree_skb (vcc_data->reasBuffer);
@@ -997,6 +1011,8 @@
 	clear_bit (ATM_VF_READY, &vcc->flags);
 	clear_bit (ATM_VF_PARTIAL, &vcc->flags);
 	clear_bit (ATM_VF_ADDR, &vcc->flags);
+
+	up (&instance->serialize);
 
 	MOD_DEC_USE_COUNT;
 

