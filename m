Return-Path: <linux-kernel-owner+w=401wt.eu-S1422663AbXAESrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbXAESrl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbXAESrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:47:40 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:34867 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422663AbXAESrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:47:40 -0500
Message-Id: <200701051842.l05IgDCN004607@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/9] UML - network driver locking and code cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2007 13:42:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some missing locking to walks of the transports and opened lists.

Delete some dead code.

Comment the lack of some locking.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/net_kern.c |   42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2007-01-01 12:18:47.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2007-01-01 12:35:12.000000000 -0500
@@ -502,7 +502,7 @@ static DEFINE_SPINLOCK(transports_lock);
 static LIST_HEAD(transports);
 
 /* Filled in during early boot */
-struct list_head eth_cmd_line = LIST_HEAD_INIT(eth_cmd_line);
+static LIST_HEAD(eth_cmd_line);
 
 static int check_transport(struct transport *transport, char *eth, int n,
 			   void **init_out, char **mac_out)
@@ -563,7 +563,9 @@ static int eth_setup_common(char *str, i
 	struct transport *transport;
 	void *init;
 	char *mac = NULL;
+	int found = 0;
 
+	spin_lock(&transports_lock);
 	list_for_each(ele, &transports){
 		transport = list_entry(ele, struct transport, list);
 	        if(!check_transport(transport, str, index, &init, &mac))
@@ -572,9 +574,12 @@ static int eth_setup_common(char *str, i
 			eth_configure(index, init, mac, transport);
 			kfree(init);
 		}
-		return 1;
+		found = 1;
+		break;
 	}
-	return 0;
+
+	spin_unlock(&transports_lock);
+	return found;
 }
 
 static int eth_setup(char *str)
@@ -610,24 +615,6 @@ __uml_help(eth_setup,
 "    Configure a network device.\n\n"
 );
 
-#if 0
-static int eth_init(void)
-{
-	struct list_head *ele, *next;
-	struct eth_init *eth;
-
-	list_for_each_safe(ele, next, &eth_cmd_line){
-		eth = list_entry(ele, struct eth_init, list);
-
-		if(eth_setup_common(eth->init, eth->index))
-			list_del(&eth->list);
-	}
-
-	return(1);
-}
-__initcall(eth_init);
-#endif
-
 static int net_config(char *str, char **error_out)
 {
 	int n, err;
@@ -729,6 +716,7 @@ static int uml_inetaddr_event(struct not
 	return NOTIFY_DONE;
 }
 
+/* uml_net_init shouldn't be called twice on two CPUs at the same time */
 struct notifier_block uml_inetaddr_notifier = {
 	.notifier_call		= uml_inetaddr_event,
 };
@@ -747,18 +735,21 @@ static int uml_net_init(void)
 	 * didn't get a chance to run for them.  This fakes it so that
 	 * addresses which have already been set up get handled properly.
 	 */
+	spin_lock(&opened_lock);
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
 		ip = lp->dev->ip_ptr;
-		if(ip == NULL) continue;
+		if(ip == NULL)
+			continue;
 		in = ip->ifa_list;
 		while(in != NULL){
 			uml_inetaddr_event(NULL, NETDEV_UP, in);
 			in = in->ifa_next;
 		}
 	}
+	spin_unlock(&opened_lock);
 
-	return(0);
+	return 0;
 }
 
 __initcall(uml_net_init);
@@ -768,13 +759,16 @@ static void close_devices(void)
 	struct list_head *ele;
 	struct uml_net_private *lp;
 
+	spin_lock(&opened_lock);
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
 		free_irq(lp->dev->irq, lp->dev);
 		if((lp->close != NULL) && (lp->fd >= 0))
 			(*lp->close)(lp->fd, &lp->user);
-		if(lp->remove != NULL) (*lp->remove)(&lp->user);
+		if(lp->remove != NULL)
+			(*lp->remove)(&lp->user);
 	}
+	spin_unlock(&opened_lock);
 }
 
 __uml_exitcall(close_devices);

