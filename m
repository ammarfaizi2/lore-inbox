Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVFCPlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFCPlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVFCPlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:41:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35010 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261333AbVFCPlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:41:00 -0400
Date: Fri, 3 Jun 2005 17:40:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Ingo Oeser <ioe-lkml@axxeo.de>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: [patch] spinlock consolidation, v2
Message-ID: <20050603154029.GA2995@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the latest version of the spinlock consolidation patch can be found at:

  http://redhat.com/~mingo/spinlock-patches/consolidate-spinlocks.patch

the patch is now complete in the sense that it does everything i wanted 
it to do. If you have any other suggestions (or i have missed to 
incorporate an earlier suggestion of yours), please yell.

Changes:

 - all architectures have been converted to the new spinlock code.
   arm, i386, ia64, ppc, ppc64, s390/s390x, x64 was build-tested via
   crosscompilers. Alpha, m32r, mips, parisc, sh, sparc, sparc64 has
   not been tested yet, but should be mostly fine. x86 and x64 was
   boot-tested in all relevant .config variations. It all brought a nice 
   reduction in source code size:

     62 files changed, 1455 insertions(+), 3025 deletions(-)

   Al, would you be interested in checking this patch on your build 
   farm? It should build on all architectures, UP and SMP alike.

   (NOTE: i've switched sparc32, sparc64, alpha, ppc, parisc to use the 
    generic spinlock debugging code. I believe the generic debugging 
    code is now capable enough to be a replacement - but especially the 
    Sparc ones are pretty advanced; so if i've missed some important
    feature please let me know and i'll implement it in the generic 
    code.)

 - linux/spinlock_types.h: new, pure header file that can be used
   by other headers to define spinlock fields - without having to
   pull in all the other include files that are needed on the
   implementational side. (Roman Zippel)

 - lib/spinlock_debug.c: got rid of the __FILE__/__LINE__ debug output 
   (suggested by Ingo Oeser), and streamlined the debug output. 
   Implemented 'lockup detection' which is a must for architectures that 
   dont have the equivalent of an NMI watchdog. (but is useful on other 
   architectures as well.) Both spinlocks and rwlocks are now fully 
   debugged.

 - linux/spinlock.h: got rid of the ATOMIC_DEC_AND_LOCK cruft. This is 
   achieved by not doing the UP-nonpreempt-nondebug specific 
   optimization but letting it pick the generic _atomic_dec_and_lock 
   function. The assembly looks sane on x86 (no locked ops, etc.) so 
   there's no performance problem. Other architectures should work fine 
   too, those which implement _atomic_dec_and_lock unconditionally might 
   want to review whether they want to use the CONFIG_HAVE_DEC_LOCK 
   mechanism to get the optimized (generic) version of the function on 
   UP.

 - asm-generic/spinlock_types_up.h: further simplifications (suggested
   by Arjan van de Ven), typo fixed

 - linux/spinlock_up.h: since this an UP-nondebug branch now, the macros 
   were simplified and streamlined significantly.

 - asm-generic/spinlock_up.h: further cleanups, reordering of op
   definitions into 'natural' op order.

 - asm-i386/spinlock.h and asm-x86_64/spinlock.h: reordering of ops, 
   cleanups

 - include/linux/spinlock.h: more cleanups, reordering

 - linux/spinlock_smp.h: cleanups, reordering of prototypes

 - kernel/spinlock.c: fixed bug in generic_raw_read_trylock and renamed 
   it to generic__raw_read_trylock to ease conversion.

 - lib/kernel_lock.c: simplification

 - (lots of small details i forgot)

	Ingo
