Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSIBFly>; Mon, 2 Sep 2002 01:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSIBFly>; Mon, 2 Sep 2002 01:41:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28933 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315419AbSIBFlx>;
	Mon, 2 Sep 2002 01:41:53 -0400
Message-ID: <3D72FDDA.470D0B84@zip.com.au>
Date: Sun, 01 Sep 2002 22:57:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul <set@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
References: <3D72C6F9.6000302@wmich.edu> <Pine.LNX.4.44L.0209012327360.1857-100000@imladris.surriel.com> <20020902052203.GC2925@squish.home.loc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> 
> ...
>         I just thought I would toss this in: For some classes
> of users, latency is extremely critical.

There are several types of latency: interrupt, scheduling, IO, probably
more.

The ones we're most interested in are scheduling latency and IO
latency.

These are two utterly, completely, wildly different things!  They differ
by two or three orders of magnitude and their underlying causes and
effects are quite different.

Let's please be careful in making the distinction between the two.

scheduling latency is pretty specialised.  You have to push the
system pretty hard to experience a scheduling stall which is longer
than a monitor refresh interval.  I don't believe that scheduling latency
is perceptible in desktop use.  Audio, yes.  Games, maybe.

IO latency is a much larger problem in Linux.  Once you start pushing the
system it pops up all over the place.  One simple test I use to quantify
this is:

- boot with mem=512m
- perform a continuous appending write to an ext2 file on a scratch
  disk.
- Now see how long it takes to build a kernel on a different disk.

This is not a completely silly scenario, and we have problems.  I have
one (dopey, hate it) patch which reduces that kernel build time by 30%.

The problem is that `gcc' is being forced to write back data to that
scratch disk within the page allocator.  It will take some algorithmic
rework in the VM to fix this properly.

Another prominent source of latency is at the disk request layer, where
heavy writers starve readers.  There's a hack^Wfix in Alan's kernels
for this, but nobody has discussed in in a while and I'm not sure how
useful it is being.
