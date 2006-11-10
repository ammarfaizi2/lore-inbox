Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946751AbWKJQSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946751AbWKJQSp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946753AbWKJQSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:18:45 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59014 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1946751AbWKJQSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:18:44 -0500
Date: Fri, 10 Nov 2006 11:18:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] EHCI: fix memory pool name allocation
Message-ID: <Pine.LNX.4.44L0.0611101112010.2314-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as802) changes the poolname allocation for the shadow
budget in ehci-mem.c.  The name needs to be allocated dynamically, not
on the stack, because the memory management system continues to use it
after registration.

Also included are a couple of minor whitespace fixups (tabs instead of
spaces).

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Andrew:

This patch has been submitted to Greg, but it's tied in with other changes 
to ehci-hcd and so it might not get accepted for a while.  However it does 
fix a real bug in the current -mm kernel; I think you should apply it.

Alan Stern


Index: usb-2.6/drivers/usb/host/ehci.h
===================================================================
--- usb-2.6.orig/drivers/usb/host/ehci.h
+++ usb-2.6/drivers/usb/host/ehci.h
@@ -71,8 +71,9 @@ struct ehci_hcd {			/* one per controlle
 	int			next_uframe;	/* scan periodic, start here */
 	unsigned		periodic_sched;	/* periodic activity count */
 
-        kmem_cache_t            *budget_pool;   /* Pool for shadow budget */
-        struct ehci_shadow_budget **budget;     /* pointer to the shadow budget
+	char			poolname[20];	/* Shadow budget pool name */
+	kmem_cache_t		*budget_pool;	/* Pool for shadow budget */
+	struct ehci_shadow_budget **budget;	/* pointer to the shadow budget
 						   of bandwidth placeholders */
 
 	struct ehci_fstn        *periodic_restore_fstn;
Index: usb-2.6/drivers/usb/host/ehci-mem.c
===================================================================
--- usb-2.6.orig/drivers/usb/host/ehci-mem.c
+++ usb-2.6/drivers/usb/host/ehci-mem.c
@@ -293,17 +293,11 @@ static int ehci_mem_init (struct ehci_hc
 	        goto fail;
 	}
 
-	{
-		char poolname[20];
-
-		snprintf(poolname,20,"ehci_budget_%d",
-			 ehci_to_hcd(ehci)->self.busnum);
-
-		ehci->budget_pool =
-			kmem_cache_create (poolname,
-					   sizeof(struct ehci_shadow_budget),
-					   0,0,NULL,NULL);
-	}
+	snprintf(ehci->poolname, sizeof(ehci->poolname), "ehci-budget-%d",
+			ehci_to_hcd(ehci)->self.busnum);
+	ehci->budget_pool = kmem_cache_create(ehci->poolname,
+			sizeof(struct ehci_shadow_budget),
+			0, 0, NULL, NULL);
 	if (!ehci->budget_pool)
 		goto fail;
 

