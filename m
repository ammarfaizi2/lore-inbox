Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUCVMmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUCVMmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:42:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53423
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261397AbUCVMmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:42:05 -0500
Date: Mon, 22 Mar 2004 13:42:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: do we want to kill VM_RESERVED or not? [was Re: 2.6.5-rc1-aa3]
Message-ID: <20040322124257.GT3649@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random> <200403212042.18092@WOLK> <20040322001023.GD3649@dualathlon.random> <200403221310.38481@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403221310.38481@WOLK>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 01:10:38PM +0100, Marc-Christian Petersen wrote:
> And VMware won't work at all. Booting a VMware Image triggers the 2 warnings 
> and the kernel BUG and the screen stays black in VMware.

I see, the below patch will avoid your oops (I also removed the stack
trace dump from memory.c since it's useless to get the stack trace from
there and this will reduce the noise).

--- x/mm/memory.c.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/mm/memory.c	2004-03-22 13:40:26.852849384 +0100
@@ -324,9 +324,11 @@ skip_copy_pte_range:
 					 * Device driver pages must not be
 					 * tracked by the VM for unmapping.
 					 */
-					BUG_ON(!page_mapped(page));
-					BUG_ON(!page->mapping);
-					page_add_rmap(page, vma, address, PageAnon(page));
+					if (likely(page_mapped(page) && page->mapping))
+						page_add_rmap(page, vma, address, PageAnon(page));
+					else
+						printk("Badness in %s at %s:%d\n",
+						       __FUNCTION__, __FILE__, __LINE__);
 				} else {
 					BUG_ON(page_mapped(page));
 					BUG_ON(page->mapping);
@@ -1429,7 +1431,9 @@ retry:
 	 * real anonymous pages, they're "device" reserved pages instead.
 	 */
 	reserved = !!(vma->vm_flags & VM_RESERVED);
-	WARN_ON(reserved == pageable);
+	if (unlikely(reserved == pageable))
+		printk("Badness in %s at %s:%d\n",
+		       __FUNCTION__, __FILE__, __LINE__);
 
 	/*
 	 * Should we do an early C-O-W break?

many thanks for the help!
