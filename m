Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTDNRQA (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTDNRQA (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:16:00 -0400
Received: from users.ccur.com ([208.248.32.211]:52579 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S263574AbTDNRP4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 13:15:56 -0400
Date: Mon, 14 Apr 2003 13:27:31 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4 preemption bug in bh_kmap_irq
Message-ID: <20030414172730.GA17451@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [I submitted this bug to Alan some time ago, he agreed it was
   a problem but felt that it should be fixed in the 2.4 preemption
   patch.]

Hi Robert, Everyone,

The bh_kmap_irq/bh_kunmap_irq functions are broken in 2.4.21-pre5.
However no symptoms occur unless the preemption patch is applied.

The bug is that bh_map_irq *conditionally* calls kmap_atomic (which
disables preemption as one of its functions), while bh_unmap_irq
*unconditionally* calls kunmap_atomic (which enables it).  This
imbalance results in a occasional off-by-one preempt_count, which in
turn causes IDE PIO mode interrupt code (specifically, read_intr) to
erronously invoke preempt_schedule while at interrupt level.

The below patch compiles and boots ide=nodma on my preempt 2.4 kernel
on the one motherboard that had the problem.  Before this patch, the
kernel would not even boot for that motherboard.  I also applied and
test booted a pure 2.4.21-pre5 kernel with this patch.

The patch implements my preference for simplicity, so you may want to
take some other approach if maximal performance is what you want.

Joe




--- include/linux/highmem.h.orig	2003-03-12 05:01:56.000000000 -0500
+++ include/linux/highmem.h	2003-03-12 16:07:04.000000000 -0500
@@ -33,22 +33,10 @@
 {
 	unsigned long addr;
 
-	__save_flags(*flags);
-
-	/*
-	 * could be low
-	 */
-	if (!PageHighMem(bh->b_page))
-		return bh->b_data;
-
-	/*
-	 * it's a highmem page
-	 */
-	__cli();
+	local_irq_save(*flags);
 	addr = (unsigned long) kmap_atomic(bh->b_page, KM_BH_IRQ);
 
-	if (addr & ~PAGE_MASK)
-		BUG();
+	BUG_ON (addr & ~PAGE_MASK);
 
 	return (char *) addr + bh_offset(bh);
 }
@@ -58,7 +46,7 @@
 	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
 
 	kunmap_atomic((void *) ptr, KM_BH_IRQ);
-	__restore_flags(*flags);
+	local_irq_restore(*flags);
 }
 
 #else /* CONFIG_HIGHMEM */

>From alan@lxorguk.ukuu.org.uk  Wed Mar 12 22:19:43 2003
Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from exchange.ccur.com by rudolph.ccur.com (8.6.10/CCC-4.1)
	id WAA17543; Wed, 12 Mar 2003 22:19:43 GMT
Received: by exchange.ccur.com with Internet Mail Service (5.5.2653.19)
	id <1J8VJBZT>; Wed, 12 Mar 2003 17:19:43 -0500
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-4-cust86.swan.cable.ntl.com [213.105.254.86]) by exchange.ccur.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id 1J8VJBZS; Wed, 12 Mar 2003 17:19:38 -0500
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.7/8.12.7) with ESMTP id h2CNRVYf024118;
	Wed, 12 Mar 2003 23:27:32 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.7/8.12.7/Submit) id h2CNRTqm024116;
	Wed, 12 Mar 2003 23:27:29 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH] bug in 2.4 bh_kmap_irq() breaks IDE under preempt patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joe Korty <joe.korty@ccur.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303122213.WAA17415@rudolph.ccur.com>
References: <200303122213.WAA17415@rudolph.ccur.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1047511647.23902.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 23:27:28 +0000
Status: RO
Content-Length: 406
Lines: 9

On Wed, 2003-03-12 at 22:13, Joe Korty wrote:
> The bug is that bh_map_irq *conditionally* calls kmap_atomic (which
> disables preemption as one of its functions), while bh_unmap_irq
> *unconditionally* calls kunmap_atomic (which enables it).  This

Thats a pre-empt bug ont a bh_map_irq bug. I'm glad you've found it
however. It explains a few things and will be useful for people wanting
pre-empt 2.4 .
