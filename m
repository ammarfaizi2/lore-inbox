Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWAZQr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWAZQr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWAZQr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:47:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21257 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751290AbWAZQr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:47:56 -0500
Date: Thu, 26 Jan 2006 16:47:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 1/6] {set,clear,test}_bit() related cleanup
Message-ID: <20060126164744.GB27222@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>, Andi Kleen <ak@suse.de>,
	Chris Zankel <chris@zankel.net>
References: <20060125112625.GA18584@miraclelinux.com> <20060125112857.GB18584@miraclelinux.com> <20060126161426.GA1709@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126161426.GA1709@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 05:14:27PM +0100, Pavel Machek wrote:
> > Index: 2.6-git/include/asm-x86_64/mmu_context.h
> > ===================================================================
> > --- 2.6-git.orig/include/asm-x86_64/mmu_context.h	2006-01-25 19:07:15.000000000 +0900
> > +++ 2.6-git/include/asm-x86_64/mmu_context.h	2006-01-25 19:13:59.000000000 +0900
> > @@ -34,12 +34,12 @@
> >  	unsigned cpu = smp_processor_id();
> >  	if (likely(prev != next)) {
> >  		/* stop flush ipis for the previous mm */
> > -		clear_bit(cpu, &prev->cpu_vm_mask);
> > +		cpu_clear(cpu, prev->cpu_vm_mask);
> >  #ifdef CONFIG_SMP
> >  		write_pda(mmu_state, TLBSTATE_OK);
> >  		write_pda(active_mm, next);
> >  #endif
> > -		set_bit(cpu, &next->cpu_vm_mask);
> > +		cpu_set(cpu, next->cpu_vm_mask);
> >  		load_cr3(next->pgd);
> >  
> >  		if (unlikely(next->context.ldt != prev->context.ldt)) 
> 
> cpu_set sounds *very* ambiguous. We have thing called cpusets, for
> example. I'd not guess that is set_bit in cpu endianity (is it?).

That's a problem for the cpusets folk - cpu_set predates them by a
fair time - it's part of the cpumask API.  See include/linux/cpumask.h

Also, since cpu_vm_mask is a cpumask_t, the above change to me looks
like a bug fix in its own right.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
