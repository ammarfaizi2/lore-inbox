Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWA3D3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWA3D3j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 22:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWA3D3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 22:29:39 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:3060 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750847AbWA3D3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 22:29:36 -0500
Date: Mon, 30 Jan 2006 12:29:33 +0900
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru,
       rmk@arm.linux.org.uk, spyro@f2s.com, dev-etrax@axis.com,
       dhowells@redhat.com, ysato@users.sourceforge.jp, torvalds@osdl.org,
       linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org,
       gerg@uclinux.org, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp, ak@suse.de,
       chris@zankel.net, akpm@osdl.org
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060130032933.GB6897@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060127.215147.670306403.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127.215147.670306403.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 09:51:47PM +0900, Hirokazu Takata wrote:
 
> Could you tell me more about the new generic {set,clear,test}_bit()
> routines?
> 
> Why do you copied these routines from parisc and employed them
>  as generic ones?
> I'm not sure whether these generic {set,clear,test}_bit() routines
> are really generic or not.

I think it is the most portable implementation.
And I'm trying not to write my own code in this patch set.

> 
> > +/* Can't use raw_spin_lock_irq because of #include problems, so
> > + * this is the substitute */
> > +#define _atomic_spin_lock_irqsave(l,f) do {	\
> > +	raw_spinlock_t *s = ATOMIC_HASH(l);	\
> > +	local_irq_save(f);			\
> > +	__raw_spin_lock(s);			\
> > +} while(0)
> > +
> > +#define _atomic_spin_unlock_irqrestore(l,f) do {	\
> > +	raw_spinlock_t *s = ATOMIC_HASH(l);		\
> > +	__raw_spin_unlock(s);				\
> > +	local_irq_restore(f);				\
> > +} while(0)
> 
> Is there a possibility that these routines affect for archs
> with no HAVE_ARCH_ATOMIC_BITOPS for SMP ?

Currently there is no architecture using this atomic *_bit() routines
on SMP. But it may be the benefit of those who are trying to port Linux.
(See the comment by Theodore Ts'o in include/asm-generic/bitops.h)

> I think __raw_spin_lock() is sufficient and local_irqsave() is 
> not necessary in general atomic routines.

If the interrupt handler also wants to do bit manipilation then
you can get a deadlock between the original caller of *_bit() and the
interrupt handler.

