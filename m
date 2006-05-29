Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWE2Pt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWE2Pt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 11:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWE2Pt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 11:49:29 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:37045 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751092AbWE2Pt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 11:49:28 -0400
Date: Mon, 29 May 2006 16:49:24 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd attempt)
Message-ID: <20060529154923.GA9025@skynet.ie>
References: <20060526151214.GA5190@skynet.ie> <20060526094924.10efc515.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060526094924.10efc515.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (26/05/06 09:49), Andrew Morton didst pronounce:
> mel@csn.ul.ie (Mel Gorman) wrote:
> >
> > (Resending with Andrew's email address correct this time)
> > 
> >  For the last few -mm releases, kernels built for an old RS6000 failed to
> >  compile with the message;
> > 
> >  arch/powerpc/kernel/built-in.o(.init.text+0x77b4): In function `vrsqrtefp':
> >  : undefined reference to `__udivdi3'
> >  arch/powerpc/kernel/built-in.o(.init.text+0x7800): In function `vrsqrtefp':
> >  : undefined reference to `__udivdi3'
> >  make: *** [.tmp_vmlinux1] Error 1
> 
> A function with a name like that doesn't _deserve_ to compile.
> 

heh

> But actually vrsqrtefp() doesn't call __udivdi3 - the error lies somewhere
> else in the kernel and the toolchain gets it wrong, so we don't know where.
> 

It explains why I couldn't find where vrsqrtefp() was.

> The way I usually hunt this problem down is to build the .s files (make
> arch/powerpc/kernel/foo.s) and then grep around, find the offending C
> function.
> 

That was a good idea, thanks. It showed that check_for_io_childs() in
arch/powerpc/kernel/pci_32.c was the real problem. A quick look showed
that is was doing divisions on resource_type_t which was 64 bits with my
.config. Selecting CONFIG_RESOURCES_32BIT made the problem go away. This
option is introduced by the kconfigurable-resources-* patches so I've cc'd
Vivek Goyal to comment on the potential fixes below.

> >  2.6.17-rc5 is not affected but I didn't search for the culprit patch in
> >  -mm. The following patch adds an implementation of __udivdi3 for plain old
> >  ppc32. This may not be the correct fix as Google tells me that __udivdi3
> >  has been replaced by calls to do_div() in a number of cases. There was no
> >  obvious way to do that for vrsqrtefp, hence this workaround. The patch should
> >  be acked, rejected or replaced by a ppc expert.
> 
> Yes, we've traditionally avoided adding the 64-bit divide library functions.

Understandable. The fixes are obvious in this case. Easiest is for users to
set CONFIG_RESOURCES_32BIT manually although the kernel build error is not
very obvious. A fairly easy bodge is to default CONFIG_RESOURCES_32BIT to Y
when building PPC32 but a determined user may still fail to build a kernel. A
slightly riskier option is this patch that replaces a potential 64 bit divide
with a do_div call. The patch has been successfully boot-tested on a RS6000.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc4-mm3-clean/arch/powerpc/kernel/pci_32.c linux-2.6.17-rc4-mm3-resources-32/arch/powerpc/kernel/pci_32.c
--- linux-2.6.17-rc4-mm3-clean/arch/powerpc/kernel/pci_32.c	2006-05-29 15:55:52.000000000 +0100
+++ linux-2.6.17-rc4-mm3-resources-32/arch/powerpc/kernel/pci_32.c	2006-05-29 15:53:43.000000000 +0100
@@ -1115,7 +1115,9 @@ check_for_io_childs(struct pci_bus *bus,
 	int	rc = 0;
 
 #define push_end(res, size) do { unsigned long __sz = (size) ; \
-	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
+	resource_size_t farEnd = (res->end + __sz); \
+	do_div(farEnd, (__sz + 1)); \
+	res->end = farEnd * (__sz + 1) + __sz; \
     } while (0)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
