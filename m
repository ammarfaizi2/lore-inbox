Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWAZCNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWAZCNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWAZCNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:13:18 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:54486 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750710AbWAZCNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:13:15 -0500
Date: Thu, 26 Jan 2006 11:13:18 +0900
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
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
Message-ID: <20060126021318.GB6648@miraclelinux.com>
References: <20060125113206.GD18584@miraclelinux.com> <24086.1138190083@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24086.1138190083@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 10:54:43PM +1100, Keith Owens wrote:
> Be very, very careful about using these generic *_bit() routines if the
> architecture supports non-maskable interrupts.
> 
> NMI events can occur at any time, including when interrupts have been
> disabled by *_irqsave().  So you can get NMI events occurring while a
> *_bit fucntion is holding a spin lock.  If the NMI handler also wants
> to do bit manipulation (and they do) then you can get a deadlock
> between the original caller of *_bit() and the NMI handler.
> 
> Doing any work that requires spinlocks in an NMI handler is just asking
> for deadlock problems.  The generic *_bit() routines add a hidden
> spinlock behind what was previously a safe operation.  I would even say
> that any arch that supports any type of NMI event _must_ define its own
> bit routines that do not rely on your _atomic_spin_lock_irqsave() and
> its hash of spinlocks.

At least cris and parisc are using similar *_bit function on SMP.
I will add your advise in comment.

--- ./include/asm-generic/bitops.h.orig	2006-01-26 10:56:00.000000000 +0900
+++ ./include/asm-generic/bitops.h	2006-01-26 11:01:28.000000000 +0900
@@ -50,6 +50,16 @@ extern raw_spinlock_t __atomic_hash[ATOM
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
 
+/*
+ * NMI events can occur at any time, including when interrupts have been
+ * disabled by *_irqsave().  So you can get NMI events occurring while a
+ * *_bit fucntion is holding a spin lock.  If the NMI handler also wants
+ * to do bit manipulation (and they do) then you can get a deadlock
+ * between the original caller of *_bit() and the NMI handler.
+ *
+ * by Keith Owens
+ */
+
 static __inline__ void set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BITOP_MASK(nr);
