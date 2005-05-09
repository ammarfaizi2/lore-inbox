Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVEIUHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVEIUHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVEIUHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:07:38 -0400
Received: from one.firstfloor.org ([213.235.205.2]:33258 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261499AbVEIUHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:07:30 -0400
To: rudi@asics.ws
Cc: "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel (64bit) 4GB memory support
References: <41BAC68D.6050303@pobox.com> <1102760002.10824.170.camel@cpu0>
	<41BB32A4.2090301@pobox.com> <1102824735.17081.187.camel@cpu0>
	<Pine.LNX.4.61.0412112141180.7847@montezuma.fsmlabs.com>
	<1102828235.17081.189.camel@cpu0>
	<Pine.LNX.4.61.0412120131570.7847@montezuma.fsmlabs.com>
	<1102842902.10322.200.camel@cpu0>
	<Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
	<1103027130.3650.73.camel@cpu0> <20041216074905.GA2417@c9x.org>
	<1103213359.31392.71.camel@cpu0>
	<Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
	<1103646195.3652.196.camel@cpu0>
	<Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com>
	<1103647158.3659.199.camel@cpu0>
	<Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com>
	<1115654185.3296.658.camel@cpu10>
From: Andi Kleen <ak@muc.de>
Date: Mon, 09 May 2005 22:07:27 +0200
In-Reply-To: <1115654185.3296.658.camel@cpu10> (Rudolf Usselmann's message
 of "Mon, 09 May 2005 22:56:25 +0700")
Message-ID: <m11x8gups0.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Usselmann <rudi@asics.ws> writes:
>
> Just curious, did anybody ever look in to this at all ? I keep
> on downloading new kernels and trying 4GB of memory - still no
> luck.
>
> I did file a bug report but didn't get any notifications at all.
> I don't subscribe to the linux-kernel list so not sure if anything
> ever came up or not.
>
> Is there a way to get this fixed ?

Does the following patch (against a 2.6.12rc3 kernel) fix your problems?

-Andi

Don't look up struct page * of physical address in iounmap

it could be in a memory hole not mapped in mem_map

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/mm/ioremap.c
===================================================================
--- linux.orig/arch/x86_64/mm/ioremap.c
+++ linux/arch/x86_64/mm/ioremap.c
@@ -272,7 +272,7 @@ void iounmap(volatile void __iomem *addr
 	if ((p->flags >> 20) &&
 		p->phys_addr + p->size - 1 < virt_to_phys(high_memory)) {
 		/* p->size includes the guard page, but cpa doesn't like that */
-		change_page_attr(virt_to_page(__va(p->phys_addr)),
+		change_page_attr_addr(p->phys_addr,
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL);
 		global_flush_tlb();
