Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVCOUb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVCOUb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVCOUbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:31:20 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56311 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261477AbVCOU2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:28:00 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH] InfiniBand: remove unsafe use of in_atomic()
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Tue, 15 Mar 2005 12:27:58 -0800
Message-ID: <52zmx4wt69.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Mar 2005 20:27:58.0377 (UTC) FILETIME=[7A066190:01C5299D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using in_atomic() to decide between GFP_KERNEL and GFP_ATOMIC is not
safe (it doesn't work if CONFIG_PREEMPT=n).  Change to just always
allocating with GFP_ATOMIC, since we don't know if we can sleep or not.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/mad.c	2005-03-15 12:23:32.640868259 -0800
+++ linux-export/drivers/infiniband/core/mad.c	2005-03-15 12:26:56.311553460 -0800
@@ -646,7 +646,7 @@
 				  struct ib_smp *smp,
 				  struct ib_send_wr *send_wr)
 {
-	int ret, alloc_flags, solicited;
+	int ret, solicited;
 	unsigned long flags;
 	struct ib_mad_local_private *local;
 	struct ib_mad_private *mad_priv;
@@ -666,11 +666,7 @@
 	if (!ret || !device->process_mad)
 		goto out;
 
-	if (in_atomic() || irqs_disabled())
-		alloc_flags = GFP_ATOMIC;
-	else
-		alloc_flags = GFP_KERNEL;
-	local = kmalloc(sizeof *local, alloc_flags);
+	local = kmalloc(sizeof *local, GFP_ATOMIC);
 	if (!local) {
 		ret = -ENOMEM;
 		printk(KERN_ERR PFX "No memory for ib_mad_local_private\n");
@@ -678,7 +674,7 @@
 	}
 	local->mad_priv = NULL;
 	local->recv_mad_agent = NULL;
-	mad_priv = kmem_cache_alloc(ib_mad_cache, alloc_flags);
+	mad_priv = kmem_cache_alloc(ib_mad_cache, GFP_ATOMIC);
 	if (!mad_priv) {
 		ret = -ENOMEM;
 		printk(KERN_ERR PFX "No memory for local response MAD\n");
@@ -860,9 +856,7 @@
 		}
 
 		/* Allocate MAD send WR tracking structure */
-		mad_send_wr = kmalloc(sizeof *mad_send_wr,
-				      (in_atomic() || irqs_disabled()) ?
-				      GFP_ATOMIC : GFP_KERNEL);
+		mad_send_wr = kmalloc(sizeof *mad_send_wr, GFP_ATOMIC);
 		if (!mad_send_wr) {
 			printk(KERN_ERR PFX "No memory for "
 			       "ib_mad_send_wr_private\n");
