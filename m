Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272429AbRH3UTc>; Thu, 30 Aug 2001 16:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272430AbRH3UTW>; Thu, 30 Aug 2001 16:19:22 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2750 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272429AbRH3UTF>;
	Thu, 30 Aug 2001 16:19:05 -0400
Subject: Re: 2.4.9-ac4: undefined reference pgtable_cache_init
From: Paul Larson <plars@austin.ibm.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Frank Davis <fdavis@si.rr.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010830172612.F1149@flint.arm.linux.org.uk>
In-Reply-To: <3B8E6467.1030204@si.rr.com> 
	<20010830172612.F1149@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 30 Aug 2001 15:17:36 +0000
Message-Id: <999184657.9362.32.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Aug 2001 17:26:12 +0100, Russell King wrote:
> On Thu, Aug 30, 2001 at 12:05:59PM -0400, Frank Davis wrote:
> > Hello,
> >    During make bzImage, I received the following:
> > 
> > init/main.o: In function 'start_kernel'
> > init/main.o(.text.init+0x842): undefined reference to 'pgtable_cache_init'
> 
> Which architecture are you building for?

I've seen this as well on i386.  It crops up when you are using HIGHMEM.
In include/asm-i386/pgtable.h you declare pgtable_cache_init if HIGHMEM
is on, or define it to the empty while loop if not.  It really needs to
be calling init_pae_pgd_cache instead though.  Try this patch against
2.4.9-ac4.  I don't know if changing the name of init_pae_pgd_cache was
the Right Thing (tm) to do, but it worked for me.  It's not getting
called anywhere else anyways.

-Paul Larson

diff -urN linux-2.4.9-ac4/arch/i386/mm/init.c linux-new/arch/i386/mm/init.c
--- linux-2.4.9-ac4/arch/i386/mm/init.c	Thu Aug 30 14:09:00 2001
+++ linux-new/arch/i386/mm/init.c	Thu Aug 30 15:01:12 2001
@@ -583,7 +583,7 @@
 
 struct kmem_cache_s *pae_pgd_cachep;
 
-void __init init_pae_pgd_cache(void)
+void __init pgtable_cache_init(void)
 {
 	/*
 	 * PAE pgds must be 16-byte aligned:

