Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVHBPX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVHBPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVHBPX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:23:56 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:19373 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261573AbVHBPVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:21:37 -0400
Date: Tue, 2 Aug 2005 17:21:31 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: linux-kernel@vger.kernel.org
Cc: Jean-Marc Saffroy <Jean-Marc.Saffroy@ext.bull.net>
Subject: bug in __vm_enough_memory()
Message-ID: <Pine.LNX.4.61.0508021656350.22220@openx3.frec.bull.fr>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/08/2005 17:33:44,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/08/2005 17:33:45,
	Serialize complete at 02/08/2005 17:33:45
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

We have found what seems to be a small bug in __vm_enough_memory()
when sysctl_overcommit_memory is set to OVERCOMMIT_NEVER.

When this bug occurs the systems fails to boot, with /sbin/init whining 
about fork() returning ENOMEM.

We hunted down the problem to this:

The deferred update mecanism used in vm_acct_memory(), on a SMP system, 
allows the vm_committed_space counter to have a negative value.

This should not be a problem since this counter is known to be inaccurate.

But in __vm_enough_memory() this counter is compared to the `allowed' 
variable, which is an unsigned long. This comparison is broken since it 
will consider the negative values of vm_committed_space to be huge 
positive values, resulting in a memory allocation failure.

A proposed fix is attached below.

Signed-off-by: Jean-Marc.Saffroy@ext.bull.net
Signed-off-by: Simon.Derr@bull.net


Index: linux-2.6.12/mm/mmap.c
===================================================================
--- linux-2.6.12.orig/mm/mmap.c	2005-08-02 15:45:30.000000000 +0200
+++ linux-2.6.12/mm/mmap.c	2005-08-02 16:28:48.289575957 +0200
@@ -144,7 +144,10 @@ int __vm_enough_memory(long pages, int c
 	   leave 3% of the size of this process for other processes */
 	allowed -= current->mm->total_vm / 32;
 
-	if (atomic_read(&vm_committed_space) < allowed)
+	/* cast `allowed' as a signed long because vm_committed_space 
+	 * sometimes has a negative value
+	 */
+	if (atomic_read(&vm_committed_space) < (long)allowed)
 		return 0;
 
 	vm_unacct_memory(pages);
Index: linux-2.6.12/mm/nommu.c
===================================================================
--- linux-2.6.12.orig/mm/nommu.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/mm/nommu.c	2005-08-02 16:28:46.384302543 +0200
@@ -1167,7 +1167,10 @@ int __vm_enough_memory(long pages, int c
 	   leave 3% of the size of this process for other processes */
 	allowed -= current->mm->total_vm / 32;
 
-	if (atomic_read(&vm_committed_space) < allowed)
+	/* cast `allowed' as a signed long because vm_committed_space 
+	 * sometimes has a negative value
+	 */
+	if (atomic_read(&vm_committed_space) < (long)allowed)
 		return 0;
 
 	vm_unacct_memory(pages);
