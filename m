Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314659AbSEPU2l>; Thu, 16 May 2002 16:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314670AbSEPU2k>; Thu, 16 May 2002 16:28:40 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:17925 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S314659AbSEPU2k>;
	Thu, 16 May 2002 16:28:40 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205162028.g4GKSbA23812@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <3CE40A77.22C74DC1@zip.com.au> from Andrew Morton at "May 16, 2002
 12:37:27 pm"
To: Andrew Morton <akpm@zip.com.au>
Date: Thu, 16 May 2002 22:28:37 +0200 (MET DST)
Cc: Steve Whitehouse <Steve@ChyGwyn.com>,
        linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Andrew Morton wrote:"
> Steven Whitehouse wrote:
> > It would be nice to have a per device "max dirty pages" limit. Also useful
> > would be a per queue priority so that if the max dirty pages limit is reached
> > for that device, then the driver gets higher priority on memory allocations
> > until the number of dirty pages has dropped below an acceptable level. I
> > don't know how easy or desireable it would be to implement such a scheme
> > generally though.

I think that is one possible mechanism, yes.  What we need is for the VM
system to "act more intelligently".  I've given up on trying to get VM
info and throttling the nbd device using it, because the lockup doesn't
involve nbd, and would be made worse by slowing it down.  The lockup is
purely a VM phenonemen - It tries to flush buffers aimed at nbd.  but
won't give the nbd process any tcp buffers to do the flushing with, and
thus blocks itself.

> I'd expect a lot of these problems would be lessened by tweaking
> the fractional settings in /proc/sys/vm/bdflush.  Get it to write
> data earlier.  nfract, ndirty, nfract_sync and nfract_stop_bdflush.

This is part of the standard setup in Enbd, at least - the client
daemons twiddle these settings to at least 15/85% on startup.  It
doesn't help the reported tcp/vm deadlock, though it makes the occasions
on which it happens more "abnormal" than "usual".  Unfortunately those
abnormal conditions are reached under memory pressure while nbd is
running - one simply has to get tcp competing for buffers with other
heavy i/o.  If the i/o is directed at nbd itself, you have a deadlock.

Setting PF_MEMALLOC on the networking process seems to help a lot.
Obviously it can't help if we are competing against "nothing" instead of
another process.  I.e.  when we are doing i/o exclusively to nbd.  (e.g.
swap over nbd).

> Also, test 2.4.18 and 2.4.19-pre8.  There were significant
> bdflush changes in -pre6.

I'm willing to look, but you don't make it sound intrinsically
likely.

And setting vm/bdflush affects everthing, and presumably unoptimizes
the settings for everthing else on the system. This is core
kernel hackers territory .. somebody must be able to do something
here!

Peter
