Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVADR16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVADR16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVADR1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:27:48 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57839 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261847AbVADR0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:26:40 -0500
Date: Tue, 4 Jan 2005 18:26:14 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Nikita Danilov <nikita@clusterfs.com>, torvalds@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl
Subject: [PATCH] remove duplicated patch fragment
Message-ID: <20050104172614.GB12861@apps.cwi.nl>
References: <200501040611.j046BHoq005158@hera.kernel.org> <m14qhxmkw4.fsf@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14qhxmkw4.fsf@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 03:36:11PM +0300, Nikita Danilov wrote:

> 	/*
> 	 * Leave the last 3% for root
> 	 */
> 	if (!capable(CAP_SYS_ADMIN))
> 		allowed -= allowed / 32;
> 
> 	/* Leave the last 3% for root */
> 	if (current->euid)
> 		allowed -= allowed / 32;
> 
> in security/commoncaps.c (and similarly in security/dummy.c). Why
> "super-user" reservation is handled twice, and with that antiquated
> current->euid check instead of capabilities? Broken merge?

Yes - sorry. The first of these two semi-identical fragments
is from Alan and appeared in patch-2.6.9, two weeks after
the patch under discussion was made. So, the second half
can be dropped. Below a patch.

> On another account, shouldn't capable(CAP_SYS_ADMIN) checks in
> cap_vm_enough_memory() be replaced with capable(CAP_SYS_RESOURCE):
> (CAP_SYS_RESOURCE is used by file systems to control reserved disk
> blocks)?

The use of current->euid comes from the use of current->euid in dummy.c
a few lines higher up in the same routine.
The use of CAP_SYS_ADMIN comes from the use of CAP_SYS_ADMIN in
commoncap.c a few lines higher up in the same routine.

I have no strong opinion about what is best.

Andries

diff -uprN -X /linux/dontdiff a/security/commoncap.c b/security/commoncap.c
--- a/security/commoncap.c	2005-01-04 18:33:40.000000000 +0100
+++ b/security/commoncap.c	2005-01-04 18:35:49.000000000 +0100
@@ -386,10 +386,6 @@ int cap_vm_enough_memory(long pages)
 		allowed -= allowed / 32;
 	allowed += total_swap_pages;
 
-	/* Leave the last 3% for root */
-	if (current->euid)
-		allowed -= allowed / 32;
-
 	/* Don't let a single process grow too big:
 	   leave 3% of the size of this process for other processes */
 	allowed -= current->mm->total_vm / 32;


