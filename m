Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131509AbRAKRsU>; Thu, 11 Jan 2001 12:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbRAKRsJ>; Thu, 11 Jan 2001 12:48:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33038 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131509AbRAKRsB>; Thu, 11 Jan 2001 12:48:01 -0500
Date: Thu, 11 Jan 2001 18:46:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010111184645.B828@athlon.random>
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de> <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De> <200101110841.AAA01652@penguin.transmeta.com> <3A5D8583.F5F30BD2@Hell.WH8.TU-Dresden.De> <20010111111145.A19584@gruyere.muc.suse.de> <3A5D8B79.AD1E161D@Hell.WH8.TU-Dresden.De> <20010111183605.A828@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010111183605.A828@athlon.random>; from andrea@suse.de on Thu, Jan 11, 2001 at 06:36:05PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 06:36:05PM +0100, Andrea Arcangeli wrote:
> On Thu, Jan 11, 2001 at 11:31:21AM +0100, Udo A. Steinberg wrote:
> >  CONFIG_MK7=y
> 
> I'm looking into it.

The fxsr fixes from 2.4.1-pre1 allows athlon to correctly use FXSR too (when
nofxsr isn't passed to the kernel of course).

So then this 3dnow breaks here:

void *_mmx_memcpy(void *to, const void *from, size_t len)
{
	void *p=to;
	int i= len >> 6;	/* len/64 */

	if (!(current->flags & PF_USEDFPU))
		clts();
	else
	{
		__asm__ __volatile__ ( " fnsave %0; fwait\n"::"m"(current->thread.i387));
		current->flags &= ~PF_USEDFPU;
	}

The 3dnow is hardcoding the usage of old fnsave, whereas it should be using the
i387 operations in first place as all other parts of the kernel.

Then athlon will be able use both the faster fxsr and the 3dnow code
at the same time (whereas in 2.4.0 it wasn't wrongly using fxsr).

I also noticed this minor leftover:

--- ./arch/i386/kernel/i386_ksyms.c.~1~	Thu Dec 14 22:33:59 2000
+++ ./arch/i386/kernel/i386_ksyms.c	Thu Jan 11 17:15:21 2001
@@ -116,6 +116,7 @@
 EXPORT_SYMBOL(mmx_clear_page);
 EXPORT_SYMBOL(mmx_copy_page);
 #endif
+EXPORT_SYMBOL(mmu_cr4_features);
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);


Until I fix the 3dnow code to use the i387.c library please workaround
this way:

--- ./arch/i386/config.in.~1~	Thu Jan 11 17:52:05 2001
+++ ./arch/i386/config.in	Thu Jan 11 18:38:29 2001
@@ -109,7 +109,7 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_USE_3DNOW y
+#   define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi


FXSR on athlon works like a charm in the aa 2.2.x patchkit because in 2.2.x
there are no special string operations that uses 3dnow.

Sorry for having missed that.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
