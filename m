Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265556AbSJXRIR>; Thu, 24 Oct 2002 13:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265557AbSJXRIR>; Thu, 24 Oct 2002 13:08:17 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:54714 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265556AbSJXRIQ>; Thu, 24 Oct 2002 13:08:16 -0400
Date: Thu, 24 Oct 2002 12:14:26 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Armin Schindler <mac@melware.de>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: module_init in interrupt context ?
In-Reply-To: <Pine.LNX.4.31.0210241833520.19649-100000@phoenix.one.melware.de>
Message-ID: <Pine.LNX.4.44.0210241208130.6574-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Armin Schindler wrote:

> Yes, you are right, it is something else.
> The problem is, that in_interrupt() is true if local_bh_count()
> is != 0, which basically sounds correct, but if we are in
> spin_lock_bh(), local_bh_count() is also != 0.
> 
> This means, in_interrupt() is always true when called inside
> spin_[un]lock_bh() region.
> 
> So, it is not allowed to call create_proc_entry after
> spin_lock_bh(), because sub-function proc_create()
> calles kmalloc() with GFP_KERNEL and then in_interrupt()
> is tested again, which gives the wrong status and
> causes BUG() in kmem_cache_grow().
> 
> Was this done on purpose ?

You are never allowed to sleep with a spinlock held, no matter if it's 
_bh, _irq or just a plain spin_lock(). Doing so creates the possibility of 
deadlock (assuming your lock actually is necessary and you're not 
serialized already), current 2.5 btw has debugging code which checks for 
this bug.

So this code was buggy in earlier 2.4 as well, you'll have to create your 
proc entry outside the protected region or use a semaphore instead of a 
spinlock.

--Kai


