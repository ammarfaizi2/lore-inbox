Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291329AbSBMDrT>; Tue, 12 Feb 2002 22:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291331AbSBMDrK>; Tue, 12 Feb 2002 22:47:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5134 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291329AbSBMDq5>;
	Tue, 12 Feb 2002 22:46:57 -0500
Message-ID: <3C69E1AE.B225A392@mandrakesoft.com>
Date: Tue, 12 Feb 2002 22:46:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <Pine.LNX.3.96.1020212220340.8017A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Wed, 13 Feb 2002, Alan Cox wrote:
> 
> > > > Whats wrong with sync not terminating when there is permenantly I/O left ?
> > > > Its seems preferably to suprise data loss
> > >
> > > Hard call.  What do we *want* sync to do?
> >
> > I'd rather not change the 2.4 behaviour - just in case. For 2.5 I really
> > have no opinion either way if SuS doesn't mind
> 
> Alan, I think you have this one wrong, although SuS seems to have it wrong
> as well, and if Linux did what SuS said there would be no problem.
> 
> - What SuS seems to say is that all dirty buffers will queued for physical
>   write. I think if we did that the livelock would disappear, but data
>   integrity might suffer.
> - sync() could be followed by write() at the very next dispatch, and it
>   was never intended to be the last call after which no writes would be
>   done. It is a point in time.
> - the most common use of sync() is to flush data write to all files of the
>   current process. If there was a better way to do it which was portable,
>   sync() would be called less. I doubt there are processes which alluse
>   that no write will be done after sync() returns.
> - since sync() can't promise "no new writes" why try to make it do so? It
>   should mean "write current sirty buffers" and that's far more than SuS
>   requires.
> 
> I don't think benchmarks are generally important, but in this case the
> benchmark reveals that we have been implementing a system call in a way
> which not only does more than SuS requires, but more than the user
> expects. To leave it trying to do even more than that seems to have no
> benefit and a high (possible) cost.

Yow, your message inspired me to re-read SuSv2 and indeed confirm,
sync(2) schedules I/O but can return before completion, while
fsync(2) schedules I/O and waits for completion.

So we need to implement system call checkpoint(2) ?  schedule I/O,
introduce an I/O barrier, then sleep until that I/O barrier and all I/O
scheduled before it occurs.

	Jeff




-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
