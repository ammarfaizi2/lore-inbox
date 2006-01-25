Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWAYLys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWAYLys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWAYLyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:54:47 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:48580 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751141AbWAYLyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:54:46 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: mita@miraclelinux.com (Akinobu Mita)
cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
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
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h 
In-reply-to: Your message of "Wed, 25 Jan 2006 20:32:06 +0900."
             <20060125113206.GD18584@miraclelinux.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 25 Jan 2006 22:54:43 +1100
Message-ID: <24086.1138190083@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita (on Wed, 25 Jan 2006 20:32:06 +0900) wrote:
>o generic {,test_and_}{set,clear,change}_bit() (atomic bitops)
...
>+static __inline__ void set_bit(int nr, volatile unsigned long *addr)
>+{
>+	unsigned long mask = BITOP_MASK(nr);
>+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
>+	unsigned long flags;
>+
>+	_atomic_spin_lock_irqsave(p, flags);
>+	*p  |= mask;
>+	_atomic_spin_unlock_irqrestore(p, flags);
>+}

Be very, very careful about using these generic *_bit() routines if the
architecture supports non-maskable interrupts.

NMI events can occur at any time, including when interrupts have been
disabled by *_irqsave().  So you can get NMI events occurring while a
*_bit fucntion is holding a spin lock.  If the NMI handler also wants
to do bit manipulation (and they do) then you can get a deadlock
between the original caller of *_bit() and the NMI handler.

Doing any work that requires spinlocks in an NMI handler is just asking
for deadlock problems.  The generic *_bit() routines add a hidden
spinlock behind what was previously a safe operation.  I would even say
that any arch that supports any type of NMI event _must_ define its own
bit routines that do not rely on your _atomic_spin_lock_irqsave() and
its hash of spinlocks.

