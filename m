Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265190AbUD3Nd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265190AbUD3Nd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 09:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUD3Nd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 09:33:28 -0400
Received: from pr-117-210.ains.net.au ([202.147.117.210]:22469 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S265190AbUD3Nc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 09:32:56 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1 
In-reply-to: Your message of "Fri, 30 Apr 2004 01:46:58 MST."
             <20040430014658.112a6181.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Apr 2004 23:32:48 +1000
Message-ID: <2015.1083331968@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004 01:46:58 -0700, 
Andrew Morton <akpm@osdl.org> wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc3/2.6.6-rc3-mm1/
>+allow-architectures-to-reenable-interrupts-on-contended-spinlocks.patch
>
> Rework the spinlock code so that architectures can reenable interrupts when
> spinning in spin_lock_irq() or spin_lcok_irqsave().  Only implemented for
> ia64 at this stage.

Only spin_lock_irqsave(), not spin_lock_irq().  The patch needs the old
flags to determine if interrupts were originally enabled, the flags are
not saved for spin_lock_irq().

In theory, spin_lock_irq() should never be called when interrupts are
already disabled, the corresponding spin_unlock_irq() will
unconditionally enable interrupts.  So it should be possible for
spin_lock_irq() to pass a constant flags value to
_raw_spin_lock_flags(), stating that interrupts were enabled before
spin_lock_irq().  Two problems with that :-

* The flags value for 'interrupts were enabled' is arch specific.

* I have seen buggy code that does spin_lock_irq() when interrupts
  are already disabled.  Unconditionally enabling interrupts while
  waiting for a contended spin_lock_irq() will perturb that code.

For now, the patch only improves the performance of spin_lock_irqsave().

