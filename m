Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291321AbSBMDbJ>; Tue, 12 Feb 2002 22:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291323AbSBMDa7>; Tue, 12 Feb 2002 22:30:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27655 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291321AbSBMDaw>; Tue, 12 Feb 2002 22:30:52 -0500
Date: Tue, 12 Feb 2002 22:28:44 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <E16anHf-0003bt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020212220340.8017A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Alan Cox wrote:

> > > Whats wrong with sync not terminating when there is permenantly I/O left ?
> > > Its seems preferably to suprise data loss
> > 
> > Hard call.  What do we *want* sync to do?
> 
> I'd rather not change the 2.4 behaviour - just in case. For 2.5 I really
> have no opinion either way if SuS doesn't mind

Alan, I think you have this one wrong, although SuS seems to have it wrong
as well, and if Linux did what SuS said there would be no problem.

- What SuS seems to say is that all dirty buffers will queued for physical
  write. I think if we did that the livelock would disappear, but data
  integrity might suffer.
- sync() could be followed by write() at the very next dispatch, and it
  was never intended to be the last call after which no writes would be
  done. It is a point in time.
- the most common use of sync() is to flush data write to all files of the
  current process. If there was a better way to do it which was portable,
  sync() would be called less. I doubt there are processes which alluse
  that no write will be done after sync() returns.
- since sync() can't promise "no new writes" why try to make it do so? It
  should mean "write current sirty buffers" and that's far more than SuS
  requires.

I don't think benchmarks are generally important, but in this case the
benchmark reveals that we have been implementing a system call in a way
which not only does more than SuS requires, but more than the user
expects. To leave it trying to do even more than that seems to have no
benefit and a high (possible) cost.

I have seen shutdown hang many times, and I have to wonder if the shutdown
script is waiting for a process which is in some kind of write loop, while
the process ignores KILL signals. Don't know, don't claim I do, but I
see no reason for a sync() to handle more than current dirty blocks.

My opinion, but I hope yours. Fewer hangs and better performance is a
compromise I can accept.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

