Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265092AbUD3HG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265092AbUD3HG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 03:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265096AbUD3HG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 03:06:57 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:9734 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265092AbUD3HFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 03:05:25 -0400
Date: Fri, 30 Apr 2004 17:05:19 +1000 (EST)
From: Tim Connors <tconnors+linuxkernel1083305837@astro.swin.edu.au>
X-X-Sender: tconnors@tellurium.ssi.swin.edu.au
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <4091F38C.3010400@yahoo.com.au>
Message-ID: <Pine.LNX.4.53.0404301646510.11320@tellurium.ssi.swin.edu.au>
References: <40904A84.2030307@yahoo.com.au> <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
 <slrn-0.9.7.4-14292-10175-200404301617-tc@hexane.ssi.swin.edu.au>
 <4091F38C.3010400@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Nick Piggin wrote:

> Tim Connors wrote:
> > Horst von Brand <vonbrand@inf.utfsm.cl> said on Thu, 29 Apr 2004 16:01:11 -0400:
> >
> >>Nick Piggin <nickpiggin@yahoo.com.au> said:
> >>
> >>[...]
> >>
> >>
> >>>I don't know. What if you have some huge application that only
> >>>runs once per day for 10 minutes? Do you want it to be consuming
> >>>100MB of your memory for the other 23 hours and 50 minutes for
> >>>no good reason?
> >>
> >>How on earth is the kernel supposed to know that for this one particular
> >>job you don't care if it takes 3 hours instead of 10 minutes, just because
> >>you don't want to spare enough preciousss RAM?
> >
> >
> > Note that we are not talking about having insufficient memory. In my
> > case (2.4 kernel - ie, 2.6 with swapiness 0%) there is more than
> > enough memory to contain all my working set - it's only because cache
> > is too eager to claim memory that is otherwise in use that
> > non-optimalities occur.
> >
>
> Well depends on what you mean by working set.
>
> In our memory manager, there is a point where often used
> "file cache" (ie. unmapped cache) is considered preferable
> to unused or little used "application memory" (mapped
> memory).

Sure - and indeed I have current swap usage (now that I am not doing
anything) of 300MB - that's good because I am not using whatever's in
there.

> I missed the description of your exact problem... was it in
> this thread somewhere? Testing 2.6 would be appreciated if
> possible too.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.3/1033.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.3/1394.html

In short: I have 512MB RAM. The files I am reading are read over NFS,
created remotely. I read them once, and then discard them (either delete
them, or keep them around, but don't read them again -- obviously, in the
latter case, they have an opportunity to pollute the cache for a long
time). If I do read them twice, it's only been a few times that I have
noticed any speedup the second time around, even for the smaller files (if
they're small enough not to cause a problem with swapping vital bits of
software out, then they are small enough that extra reads are hardly
noticable anyway - given the damn fast raid disks behind NFS we have)

For one of the file types, these can be several hundred megs, and are read
by an astronomical package - I have no idea how they are read, but because
it is fits, maybe it has to go back and read the header several times, but
I doubt the image data is read more than once. Come display time, memory
usage in this example is roughly the size of the FITS file - several
hundred megs. I don't recall how big X is, in such a situation, but the
sum of them both, plus recently used apps like mozilla, is below RAM size.
Watching top, I can see, during the read, mozilla rsize memory usage go
down rapidly - about as rapidly as cache usage going up.

Parts of X and the window manager also get swapped out, so when I move to
another virtual page, I get to watch fvwm redraw the screen - this is not
too painful though, because only a few megs need be swapped back in
(although the HD is seeking all over the place as things thrash about, so
it does still take non-negligible amount of time). Mozilla takes about 30
seconds to swap back in (~50-100MB - again, lots of thrashing from the
HD). I don't recall once mozilla is swapped back in, whether cache usage
has dropped again, or whether the visualisation software loses its pages
instead.

I'll try to test 2.6 here (half the battle is convincing the sysadmins
this is a worthwhile persuit) - I use that at home quite succesfully, but
I don't do big files or visualisation there.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
'It's amazing I won. I was running against peace, prosperity and incumbency.'
  -- George W. Bush. June 14, 2001, to Swedish PM Goran Perrson,
     unaware that a live television camera was still rolling.
