Return-Path: <linux-kernel-owner+w=401wt.eu-S1753054AbWL2Xr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbWL2Xr4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbWL2Xra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:47:30 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:45701 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965226AbWL2XrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:47:04 -0500
Message-Id: <200612292341.kBTNfVIp005549@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/6] UML - Add locking to network transport registration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Dec 2006 18:41:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The registration of host network transports needed some locking.  The
transport list itself is locked, but calls to the registration
routines are not.  This is compensated for by checking that a
transport structure is not yet on any list.

I also took the opportunity to const all fields in the transport
structure except the list, which obviously can be modified.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/net_kern.c |    9 +++++----
 arch/um/include/net_kern.h |    8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-12-29 12:58:59.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-12-29 12:59:19.000000000 -0500
@@ -498,10 +498,8 @@ struct eth_init {
 	int index;
 };
 
-/* Filled in at boot time.  Will need locking if the transports become
- * modular.
- */
-struct list_head transports = LIST_HEAD_INIT(transports);
+static DEFINE_SPINLOCK(transports_lock);
+static LIST_HEAD(transports);
 
 /* Filled in during early boot */
 struct list_head eth_cmd_line = LIST_HEAD_INIT(eth_cmd_line);
@@ -540,7 +538,10 @@ void register_transport(struct transport
 	char *mac = NULL;
 	int match;
 
+	spin_lock(&transports_lock);
+	BUG_ON(!list_empty(&new->list));
 	list_add(&new->list, &transports);
+	spin_unlock(&transports_lock);
 
 	list_for_each_safe(ele, next, &eth_cmd_line){
 		eth = list_entry(ele, struct eth_init, list);
Index: linux-2.6.18-mm/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_kern.h	2006-12-29 12:23:02.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/net_kern.h	2006-12-29 12:59:19.000000000 -0500
@@ -52,12 +52,12 @@ struct net_kern_info {
 
 struct transport {
 	struct list_head list;
-	char *name;
-	int (*setup)(char *, char **, void *);
+	const char *name;
+	int (* const setup)(char *, char **, void *);
 	const struct net_user_info *user;
 	const struct net_kern_info *kern;
-	int private_size;
-	int setup_size;
+	const int private_size;
+	const int setup_size;
 };
 
 extern struct net_device *ether_init(int);

