Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286197AbRLTHoA>; Thu, 20 Dec 2001 02:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286195AbRLTHnu>; Thu, 20 Dec 2001 02:43:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:24339 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286198AbRLTHnd>; Thu, 20 Dec 2001 02:43:33 -0500
Message-ID: <3C21963B.AD97D4@zip.com.au>
Date: Wed, 19 Dec 2001 23:41:47 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <87bsgwi6zz.fsf@fadata.bg> <Pine.LNX.4.21.0112181757460.4821-100000@freak.distro.conectiva> <3C1FC254.525B9108@zip.com.au> <3C1FCB96.83E49ECB@zip.com.au> <3C204C4F.C989AD71@zip.com.au>,
		<3C204C4F.C989AD71@zip.com.au>; from akpm@zip.com.au on Wed, Dec 19, 2001 at 12:14:07AM -0800 <20011219144213.A1395@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> > The thing I don't like about the Andrea+Momchil approach is that it
> > exposes the risk of flooding the machine with dirty data.  A scheme
> 
> it doesn't, balance_dirty() has to work only  at the highlevel.
> sync_page_buffers also is no problem, we'll try again later in those
> GFP_NOIO allocations.

Not so.  The loop thread *copies* the data.  We must throttle it,
otherwise the loop thread gobbles all memory and the box dies.  This
is trivial to demonstrate.

> furthmore you don't even address the writepage from loop thread on the
> loop queue.

How can this deadlock?  The only path to those buffers is
via the page, and the page is locked.
 
> The final fix should be in rc2aa1 that I will release in a jiffy. It
> takes care now of both the VM and balance_dirty().
>
> this is the incremental fix against rc1aa1:
> 

No.  Your patch removes *all* loop thread throttling, it doesn't even start
IO (thus removing the throttling which request starving would provide)
and doesn't even wake up bdflush.

If you set nfract to 70%, nfract_sync to 80% and do a big write, the
machine falls into a VM coma within 15 seconds.  The same happens
with both my patches :-(

And it's not legitimate to say "don't do that".  If we can't survive
those settings, we don't have a solution. We need to throttle writes
*more*, not less.

I'll keep poking at it.   If you have any more suggestions/patches,
please toss them over...

-
