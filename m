Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317045AbSFWPjr>; Sun, 23 Jun 2002 11:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317047AbSFWPjq>; Sun, 23 Jun 2002 11:39:46 -0400
Received: from trained-monkey.org ([209.217.122.11]:16401 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S317045AbSFWPjp>; Sun, 23 Jun 2002 11:39:45 -0400
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: highmem pci dma mapping does not work, missing cast in asm-i386/pci.h
References: <20020610195644.C13225@redhat.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 23 Jun 2002 11:39:43 -0400
In-Reply-To: Benjamin LaHaise's message of "Mon, 10 Jun 2002 19:56:44 -0400"
Message-ID: <m37kkqngw0.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ben" == Benjamin LaHaise <bcrl@redhat.com> writes:

Ben> Hello all, There's a missing cast in pci_map_page that causes 64
Ben> bit capable drivers to access the wrong memory for highmem pages.
Ben> Please include the patch below to fix it.

Looking at this one, I believe we need to do the same for
page_to_phys() - either by using dma_addr_t as the type or explicitly
going u64 #ifdef CONFIG_HIGHMEM.

Patch using dma_addr_t included relative to 2.4.18.

Btw. I noticed that in 2.5.24/ia32 we use CONFIG_HIGHMEM to declare
dma_addr_t as 64 bit but CONFIG_HIGHMEM64G to handle page_to_phys. Is
this just an oversight or on purpose?

Comments?

Jes


--- include/asm-i386/io.h~	Sun Jun 23 11:29:26 2002
+++ include/asm-i386/io.h	Sun Jun 23 11:30:17 2002
@@ -2,6 +2,7 @@
 #define _ASM_IO_H
 
 #include <linux/config.h>
+#include <asm/types.h>
 
 /*
  * This file contains the definitions for the x86 IO instructions
@@ -76,7 +77,7 @@
 /*
  * Change "struct page" to physical address.
  */
-#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
+#define page_to_phys(page)	((dma_addr_t)(page - mem_map) << PAGE_SHIFT)
 
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
