Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261420AbTCGHYq>; Fri, 7 Mar 2003 02:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbTCGHYq>; Fri, 7 Mar 2003 02:24:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:30085 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261420AbTCGHYo>;
	Fri, 7 Mar 2003 02:24:44 -0500
Date: Thu, 6 Mar 2003 23:35:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
Message-Id: <20030306233517.68c922f9.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
	<20030306222328.14b5929c.akpm@digeo.com>
	<Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 07:35:13.0031 (UTC) FILETIME=[16DAC970:01C2E47C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> On Thu, 6 Mar 2003, Andrew Morton wrote:
> 
> > Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> > >
> > > This just popped up on my screen, seems to have been triggered by sar/cron 
> > > (i'll probably have to reboot the box soon)
> > > 
> > > slab error in check_poison_obj(): cache `size-64': object was modified after freeing
> > > Call Trace:
> > >  [<c0142226>] check_poison_obj+0x66/0x70
> > >  [<c0143b92>] kmalloc+0xd2/0x180
> > >  [<c0166078>] pipe_new+0x28/0xd0
> > >  [<c0166153>] get_pipe_inode+0x23/0xb0
> > >  [<c0166212>] do_pipe+0x32/0x1e0
> > >  [<c0111ed3>] sys_pipe+0x13/0x60
> > >  [<c010ad9b>] syscall_call+0x7/0xb
> > 
> > Don't know.  If you're using anticipatory scheduler in 2.5.63-mmfoo this
> > will happen. 64-mm1 is OK.
> 
> Nope simply 2.5.64-unwashed. I don't know how to twiddle the advanced 
> knobs

OK.  -mm has a more sophisticated use-after-free detector.  It might be
worth dropping that in there, see if we can get more info.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm1/broken-out/use-after-free-check.patch

> > show_interrupts() is walking the per-irq action chain without locking it.
> > Any concurrent add/remove activity will explode.
> > 
> > Do you want to hunt down all the show_interrupts() instances and pop a
> > spin_lock_irq(desc->lock) around them?
> 
> Sure thing.

OK, thanks.

All the arch/*/kernel/irq.c implementations are distressingly similar. 
Andrey Panin did a bunch of work a while back to start consolidating the
common code but it didn't quite get finished off.  Guess we just have to grit
our teeth for now.
