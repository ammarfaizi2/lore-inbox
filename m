Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVFPUQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVFPUQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVFPUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:16:44 -0400
Received: from mail.dif.dk ([193.138.115.101]:43450 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261793AbVFPUQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:16:25 -0400
Date: Thu, 16 Jun 2005 22:21:50 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Walt Drummond <drummond@valinux.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [resend][PATCH] avoid signed vs unsigned comparison in efi_range_is_wc()
Message-ID: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I send in the patch below a while back but never recieved any response.
Now I'm resending it in the hope that it might be added to -mm.
The patch still applies cleanly to 2.6.12-rc6-mm1

-- 
Jesper Juhl


---------- Forwarded message ----------
Date: Fri, 18 Mar 2005 00:43:33 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Walt Drummond <drummond@valinux.com>,
    David Mosberger-Tang <davidm@hpl.hp.com>,
    Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] avoid signed vs unsigned comparison in efi_range_is_wc()


This little function in include/linux/efi.h :

static inline int efi_range_is_wc(unsigned long start, unsigned long len)
{
        int i;

        for (i = 0; i < len; i += (1UL << EFI_PAGE_SHIFT)) {
                unsigned long paddr = __pa(start + i);
                if (!(efi_mem_attributes(paddr) & EFI_MEMORY_WC))
                        return 0;
        }
        /* The range checked out */
        return 1;
}

generates this warning when building with gcc -W : 

include/linux/efi.h: In function `efi_range_is_wc':
include/linux/efi.h:320: warning: comparison between signed and unsigned

It looks to me like a significantly large 'len' passed in could cause the 
loop to never end. Isn't it safer to make 'i' an unsigned long as well? 
Like this little patch below (which of course also kills the warning) :


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm4-orig/include/linux/efi.h linux-2.6.11-mm4/include/linux/efi.h
--- linux-2.6.11-mm4-orig/include/linux/efi.h	2005-03-16 15:45:35.000000000 +0100
+++ linux-2.6.11-mm4/include/linux/efi.h	2005-03-18 00:34:36.000000000 +0100
@@ -315,7 +315,7 @@ extern struct efi_memory_map memmap;
  */
 static inline int efi_range_is_wc(unsigned long start, unsigned long len)
 {
-	int i;
+	unsigned long i;
 
 	for (i = 0; i < len; i += (1UL << EFI_PAGE_SHIFT)) {
 		unsigned long paddr = __pa(start + i);




