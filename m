Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272873AbRI0Npw>; Thu, 27 Sep 2001 09:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272912AbRI0Npn>; Thu, 27 Sep 2001 09:45:43 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:41607
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S272873AbRI0Npb>; Thu, 27 Sep 2001 09:45:31 -0400
Date: Thu, 27 Sep 2001 09:45:53 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] ppp causes memory corruption
Message-ID: <143140000.1001598353@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

Short version: Any use of ppp can lead to memory corruption.  Patch below.

We've been trying to track an odd memory corruption problem for a while,
and someone recently managed to narrow it down to PPPoE.  I kinda drew the
short straw, as my laptop was then able to relaibly reproduce.

Anyway, the bug is that ppp_generic.c has two places that kfree the ppp
struct, and not enough locking to make sure they don't both free it if
ppp_destroy_interface schedules while unregistering the device.

This patch also has a few hunks for pppoe.c, setting a few variables to 0
to make sure they don't get freed twice.

A larger problem is that ppp_generic.c has numerous schedules inside
spinlocks (including the one that caused the double free ;-).  Kurt Garloff
supplied some hunks to swtich GFP_KERNEL to GFP_ATOMIC, but I'm hoping
someone who knows the code is interested in fixing the rest of the spin
lock abuses.  Otherwise I might try to tackle it next week.

Patch below, against 2.4.10.  Please apply.

--- 3.1/drivers/net/pppoe.c Sun, 23 Sep 2001 16:21:54 -0400 
+++ 3.1(w)/drivers/net/pppoe.c Wed, 26 Sep 2001 18:01:28 -0400 
@@ -541,11 +541,15 @@
 	sk->state = PPPOX_DEAD;
 
 	po = sk->protinfo.pppox;
-	if (po->pppoe_pa.sid)
+	if (po->pppoe_pa.sid) {
 		delete_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
+		po->pppoe_pa.sid = 0 ;
+	}
 
 	if (po->pppoe_dev)
 	    dev_put(po->pppoe_dev);
+
+	po->pppoe_dev = NULL ;
 
 	sock_orphan(sk);
 	sock->sk = NULL;
--- 3.1/drivers/net/ppp_generic.c Sun, 23 Sep 2001 20:11:16 -0400 
+++ 3.1(w)/drivers/net/ppp_generic.c Thu, 27 Sep 2001 09:28:51 -0400 
@@ -2105,13 +2108,12 @@
 {
 	struct compressor_entry *ce;
 	int ret;
-
 	spin_lock(&compressor_list_lock);
 	ret = -EEXIST;
 	if (find_comp_entry(cp->compress_proto) != 0)
 		goto out;
 	ret = -ENOMEM;
-	ce = kmalloc(sizeof(struct compressor_entry), GFP_KERNEL);
+	ce = kmalloc(sizeof(struct compressor_entry), GFP_ATOMIC);
 	if (ce == 0)
 		goto out;
 	ret = 0;
@@ -2216,11 +2218,11 @@
 
 	/* Create a new ppp structure and link it before `list'. */
 	ret = -ENOMEM;
-	ppp = kmalloc(sizeof(struct ppp), GFP_KERNEL);
+	ppp = kmalloc(sizeof(struct ppp), GFP_ATOMIC);
 	if (ppp == 0)
 		goto out;
 	memset(ppp, 0, sizeof(struct ppp));
-	dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
+	dev = kmalloc(sizeof(struct net_device), GFP_ATOMIC);
 	if (dev == 0) {
 		kfree(ppp);
 		goto out;
@@ -2285,6 +2287,7 @@
 static void ppp_destroy_interface(struct ppp *ppp)
 {
 	struct net_device *dev;
+	int n_channels ;
 
 	spin_lock(&all_ppp_lock);
 	list_del(&ppp->file.list);
@@ -2314,6 +2317,7 @@
 #endif /* CONFIG_PPP_FILTER */
 	dev = ppp->dev;
 	ppp->dev = 0;
+	n_channels = ppp->n_channels ;
 	ppp_unlock(ppp);
 
 	if (dev) {
@@ -2329,7 +2333,7 @@
 	 * ppp structure.  Otherwise we leave it around until the
 	 * last channel disconnects from it.
 	 */
-	if (ppp->n_channels == 0)
+	if (n_channels == 0) 
 		kfree(ppp);
 
 	spin_unlock(&all_ppp_lock);

