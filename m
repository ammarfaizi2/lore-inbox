Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTIASgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTIASgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:36:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32423
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263364AbTIASfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:35:53 -0400
Date: Mon, 1 Sep 2003 20:36:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
Message-ID: <20030901183631.GN11503@dualathlon.random>
References: <20030830154137.GK24409@dualathlon.random> <Pine.LNX.4.44.0309011521490.6008-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309011521490.6008-100000@logos.cnet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 03:26:02PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Sat, 30 Aug 2003, Andrea Arcangeli wrote:
> 
> > On Sat, Aug 30, 2003 at 12:13:57PM -0300, Marcelo Tosatti wrote:
> > > 
> > > > You need to integrate with -aa on the VM.  It has been hard enough for
> > > > Andrea to get his stuff in, I doubt you will fair any better.
> > > 
> > > Thats because I never received separate patches which make sense one by
> > > one.  Most of Andreas changes are all grouped into few big patches that
> > > only he knows the mess. That is not the way to merge things.
> > > 
> > > I want to work out with him after I merge other stuff to address that.
> > 
> > that's true for only one patch, the others are pretty orthogonal after
> > Andrew helped splitting them:
> > 
> > 
> > 05_vm_03_vm_tunables-4
> > 05_vm_05_zone_accounting-2
> > 05_vm_06_swap_out-3
> > 05_vm_07_local_pages-4
> 
> Two things: I will leave this local pages change to be applied later. I
> want to see what it does by itself (apply swap_out() changes & friends now
> and on another -pre local pages).

fine thanks!

> 
> > 05_vm_08_try_to_free_pages_nozone-4
> 
> @@ -737,7 +737,6 @@ static void free_more_memory(void)
>         balance_dirty();
>         wakeup_bdflush();
>         try_to_free_pages(GFP_NOIO);
> -       run_task_queue(&tq_disk);
>         yield();
>  }
> 
> 
> Whats the reason behind this? 

the reason is that added or removed won't make any significant
difference. Sure, there may be a few dirty buffers queued, but we
already did balance_dirty() and wakeup_bdflush, so if there was
significant amount of dirty data to write, bdflush would trigger the
unplug by itself. And if there wasn't we can wait for more data to
become dirty.

In general, I don't like sparse tq_disk unplug, I like to have them only
where strictly needed, that looks cleaner, and it doesn't risk to
generate short commands.

Andrea

/*
 * If you also refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
