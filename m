Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030570AbVKPXGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbVKPXGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030571AbVKPXGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:06:03 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:24463 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030570AbVKPXGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:06:00 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Greg KH <greg@kroah.com>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051116224728.GI12505@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com> <20051115233201.GA10143@elf.ucw.cz>
	 <1132115730.2499.37.camel@localhost> <20051116061459.GA31181@kroah.com>
	 <1132120845.25230.13.camel@localhost> <20051116165023.GB5630@kroah.com>
	 <1132171051.25230.53.camel@localhost> <20051116213517.GD12505@elf.ucw.cz>
	 <1132175248.25230.104.camel@localhost>  <20051116224728.GI12505@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1132177835.25230.129.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 17 Nov 2005 08:53:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-11-17 at 09:47, Pavel Machek wrote:
> Hi!
> 
> > > > I can agree with putting splash screens and userspace stuff in
> > > > userspace. Suspend2 has had that too, since March. But the guts of
> > > > the
> > > 
> > > Well, I'd say that having to resort to netlink is ... not quite
> > > nice. You get all the complexity of having userspace running during
> > > suspend, and get very little benefit.
> > 
> > Mmm, but less complexity than with trying to do the whole suspend from
> > userspace. (I don't need to export pageflags, bio routines etc or work
> > around it by using /dev/kmem).
> 
> Well, userland swsusp has pretty low impact on kernel code -- it adds
> something like 150 lines:
> 
>  drivers/char/mem.c      |   42 +
>  include/linux/suspend.h |   23
>  kernel/power/console.c  |    1
>  kernel/power/disk.c     |   19
>  kernel/power/swsusp.c   |   78 +
>  usr/swsusp-init         |    9
>  8 files changed, 2696 insertions(+), 4 deletions(-)
> 
> i don't think you can do much better than that...
> 
> > > ...at expense of complexity, and hooks all over the kernel. Yes, if
> > > you modify kernel a bit, nothing will use the page cache.
> > 
> > Could you back your "hooks all over the kernel" statement up? I do have
> > some BUG_ON()s aimed at double checking that nothing bad happens, but
> > they never get hit and obviously aren't required to stop processes using
> > the page cache. All that's really required is to freeze processes.
> 
> Are you willing to merge the code without BUG_ONs?

Yes.

> > > Anyway, I believe we have solution for that one. See Rafael's recent
> > > patches -- "only free as much memory as neccessary" should do the
> > > trick, without excessive complexity.
> > 
> > That's still imposing a 1/2 of memory limit, though.
> 
> Yes, hopefully users will not notice.

Users with more memory probably won't care so much, depending on what
apps they want to run and how responsive they want the system to be
post-resume.

> > > Well, I do not want the complexity of two page sets. I think Rafael's
> > > patches will provide almost equivalent functionality. Other than that,
> > > all your features should be doable. I'm not saying I'm going to write
> > > those patches myself, but I'll certainly not reject them just because
> > > they are too big.
> > 
> > I'm sorry for making you think that having two pagesets is a complex
> > issues. I know that when I first did it, I put tight restrictions on
> > memory usage while the first pageset was written and used a separate
> > memory pool. Since then, I've realised a far simpler way of handling
> > this, and the code has been greatly simplified. In essence, all you need
> > to do is make your I/O code generic enough that it can be passed a list
> > of pages to write and put page cache pages in a separate list when
> > figuring out what pages need to be saved. Then you save those pages
> > before doing your atomic copy of the other pages, and reload them after
> > restoring the atomic copy at resume time.
> 
> Okay, it may have gotten better. Anyway, this is the only part that
> really needs to be in-kernel. Saving 50% of memory is still going to
> produce *way* more responsive system than "save as little as
> possible", and I hope it will be good enough.

I agree about the 'way more responsive system'. Good enough will depend
on the user and which way the wind is blowing at the time. I guess if
that's the only option they have, it's still better than rebooting.

Regards,

Nigel

