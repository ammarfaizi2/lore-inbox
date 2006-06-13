Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWFMQtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWFMQtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWFMQtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:49:08 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:6354 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S932178AbWFMQtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:49:07 -0400
Date: Tue, 13 Jun 2006 17:49:04 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
       vgoyal@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd attempt)
Message-ID: <20060613164904.GA15240@skynet.ie>
References: <20060526151214.GA5190@skynet.ie> <20060526094924.10efc515.akpm@osdl.org> <20060529154923.GA9025@skynet.ie> <2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org> <Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie> <c6414fc4b2c627791a49085bf8eea7e8@kernel.crashing.org> <20060529190515.GA17608@skynet.ie> <17545.16696.195276.334774@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <17545.16696.195276.334774@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/06/06 19:36), Paul Mackerras didst pronounce:
> Mel Gorman writes:
> 
> > +	res->end = -(-res->end & ~(unsigned long)mask); \
> > +	res->end += mask; \
> 
> I think this is equivalent to
> 
> 	res->end = (res->end + mask) | mask;
> 
> and I have to say the latter seems more understandable to me (and
> doesn't need a cast) ...
> 

Makes sense. The patch on top of the latest -mm is below if you want to push
it. It has not been boot tested as building with the latest -mm is broken
at the moment for older powerpcs because of the git-powerpc.patch patch .
That patch assumes that mm_context_t is a struct with a vdso_base which is
not always the case (it's an unsigned long in include/asm-ppc/mmu.h).

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc6-mm2-clean/arch/powerpc/kernel/pci_32.c linux-2.6.17-rc6-mm2-resources/arch/powerpc/kernel/pci_32.c
--- linux-2.6.17-rc6-mm2-clean/arch/powerpc/kernel/pci_32.c	2006-06-13 17:25:39.000000000 +0100
+++ linux-2.6.17-rc6-mm2-resources/arch/powerpc/kernel/pci_32.c	2006-06-13 17:30:20.000000000 +0100
@@ -1121,9 +1121,8 @@ check_for_io_childs(struct pci_bus *bus,
 	 * e.g. res->end of 0x1fff moves to 0x2fff
 	 */
 #define push_end(res, mask) do {				\
-	BUG_ON(((mask+1) & mask) != 0);			\
-	res->end = -(-res->end & ~(unsigned long)mask);		\
-	res->end += mask;					\
+	BUG_ON(((mask+1) & mask) != 0);				\
+	res->end = (res->end + mask) | mask;			\
     } while (0)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
