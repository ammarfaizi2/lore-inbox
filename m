Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318318AbSHEJTm>; Mon, 5 Aug 2002 05:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318347AbSHEJTm>; Mon, 5 Aug 2002 05:19:42 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:34058 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318318AbSHEJTl>; Mon, 5 Aug 2002 05:19:41 -0400
Date: Mon, 5 Aug 2002 11:22:49 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
In-Reply-To: <20020805094429.A5897@namesys.com>
Message-ID: <Pine.LNX.4.44.0208051106420.31879-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, 5 Aug 2002, Oleg Drokin wrote:

> Hello!
> 
> On Sun, Aug 04, 2002 at 06:09:34PM +0200, Roland Kuhn wrote:
> 
> > The first call to getdents64 takes 4.7s! I captured the task status and 
> > got this:
> 
> It seems that your kernel performs writes slowly.
> 
That's true only in the case of a "filled write queue" (I don't know 
exactly how it's working). However, I verified that the average SCSI 
command takes less than two seconds to complete in this case (time between 
send to card and receive response interrupt).

BTW: was it directly clear for you for what the do_journal_begin_r() was 
waiting? I'm not so familiar with fs coding, especially the locking...

While we're at it: it looks like e.g. the 3ware driver is busy waiting in
tw_scsi_queue() until (by virtue of an interrupt?) a request_id becomes
free. Is this common practice? Or is there code somewhere checking for the
availability of these request slots before calling scsi_queue? I would
think that the CPU can do more useful things while waiting for an
interrupt...

> > this is to use a sync mount, and there I discovered something really 
> > strange: 2.4.19 gives me about 17MB/s while 2.4.18-3 (RedHat) was creeping 
> > slow with 10kB/s!
> 
> 2.4.18-3 is particularly bad know for this exact problem (slow write speed),
> you should consider upgrading to at least 2.4.18-5 kernel from redhat updates.
> 
> For me on plain 2.4.18 the problem is not visible that bad as for you.
> I.e. ls on a directory where I write this big file finishes in under
> half a second.
> 
Do you use IDE or SCSI? It seems like the SCSI drivers can have up to 
255*256 sectors pending on the controller. If that's the problem, how can 
I decrease this buffering?

> > If you have any thoughts on the cause of this behaviour and/or on how to 
> > fix it, I would be glad to hear them. If it's not too complicated I could 
> > even code something up myself, and I for sure can do any testing needed.
> 
> You said 2.4.19 writes stuff faster for you, how about testing ls on that
> kernel?
> 
The call trace was from 2.4.19, and the situation actually was much better 
than in the 2.4.18-3 case, where it took about 1 minute for ls to come 
back. 

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

