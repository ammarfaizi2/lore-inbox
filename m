Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUDNWZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUDNWX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:23:56 -0400
Received: from palrel11.hp.com ([156.153.255.246]:36277 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261914AbUDNWTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:19:41 -0400
Date: Wed, 14 Apr 2004 15:19:40 -0700
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] irlan - irlan_common cleanup
Message-ID: <20040414221940.GG5434@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_irlan_common_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Minor type changes in irlan_common for clarity:
        - use const
        - init and exit can be static
        - use skb_queue_purge to flush queue
        - get rid of noisy old comment


diff -Nru a/net/irda/irlan/irlan_common.c b/net/irda/irlan/irlan_common.c
--- a/net/irda/irlan/irlan_common.c	Fri Mar 19 11:44:11 2004
+++ b/net/irda/irlan/irlan_common.c	Fri Mar 19 11:44:11 2004
@@ -75,14 +75,14 @@
 static int access = ACCESS_PEER; /* PEER, DIRECT or HOSTED */
 
 #ifdef CONFIG_PROC_FS
-static char *irlan_access[] = {
+static const char *irlan_access[] = {
 	"UNKNOWN",
 	"DIRECT",
 	"PEER",
 	"HOSTED"
 };
 
-static char *irlan_media[] = {
+static const char *irlan_media[] = {
 	"UNKNOWN",
 	"802.3",
 	"802.5"
@@ -115,7 +115,7 @@
  *    Initialize IrLAN layer
  *
  */
-int __init irlan_init(void)
+static int __init irlan_init(void)
 {
 	struct irlan_cb *new;
 	__u16 hints;
@@ -156,7 +156,7 @@
 	return 0;
 }
 
-void __exit irlan_cleanup(void) 
+static void __exit irlan_cleanup(void) 
 {
 	struct irlan_cb *self, *next;
 
@@ -242,8 +242,6 @@
  */
 static void __irlan_close(struct irlan_cb *self)
 {
-	struct sk_buff *skb;
-
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 	
 	ASSERT_RTNL();
@@ -260,8 +258,7 @@
 		iriap_close(self->client.iriap);
 
 	/* Remove frames queued on the control channel */
-	while ((skb = skb_dequeue(&self->client.txq)))
-		dev_kfree_skb(skb);
+	skb_queue_purge(&self->client.txq);
 
 	/* Unregister and free self via destructor */
 	unregister_netdevice(self->dev);
@@ -1177,19 +1174,6 @@
 MODULE_PARM(access, "i");
 MODULE_PARM_DESC(access, "Access type DIRECT=1, PEER=2, HOSTED=3");
 
-/*
- * Function init_module (void)
- *
- *    Initialize the IrLAN module, this function is called by the
- *    modprobe(1) program.
- */
 module_init(irlan_init);
-
-/*
- * Function cleanup_module (void)
- *
- *    Remove the IrLAN module, this function is called by the rmmod(1)
- *    program
- */
 module_exit(irlan_cleanup);
 
