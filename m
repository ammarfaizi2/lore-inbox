Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265550AbSJXQqz>; Thu, 24 Oct 2002 12:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265551AbSJXQqz>; Thu, 24 Oct 2002 12:46:55 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.149]:37090 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S265550AbSJXQqu>; Thu, 24 Oct 2002 12:46:50 -0400
Date: Thu, 24 Oct 2002 18:52:29 +0200 (MEST)
From: Armin Schindler <mac@melware.de>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: module_init in interrupt context ?
In-Reply-To: <Pine.LNX.4.44.0210231111480.2739-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.31.0210241833520.19649-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Kai Germaschewski wrote:
> On Wed, 23 Oct 2002, Armin Schindler wrote:
>
> > With kernel 2.4.19 I noticed that calls from module_init()
> > may be done in interrupt context. I didn't have a problem here
> > before 2.4.17.
>
> Well, I am positive that this is not so.
>
> > E.g. in module_init() I use pci_module_init() for my driver
> > (I don't have HOTPLUG enabled), the when the .probe function is called
> > and the card is detected I create a proc entry for this new
> > found device, but most of the time create_proc_entry causes
> > BUG(), because it is called from interrupt context.
>
> I think you should provide the backtrace and the code in questions.
> Obviously, something is wrong, but it's virtually impossible that
> module_init() runs from irq context, so it has to be something else.

Yes, you are right, it is something else.
The problem is, that in_interrupt() is true if local_bh_count()
is != 0, which basically sounds correct, but if we are in
spin_lock_bh(), local_bh_count() is also != 0.

This means, in_interrupt() is always true when called inside
spin_[un]lock_bh() region.

So, it is not allowed to call create_proc_entry after
spin_lock_bh(), because sub-function proc_create()
calles kmalloc() with GFP_KERNEL and then in_interrupt()
is tested again, which gives the wrong status and
causes BUG() in kmem_cache_grow().

Was this done on purpose ?

Armin

