Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318650AbSICDx2>; Mon, 2 Sep 2002 23:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318661AbSICDx2>; Mon, 2 Sep 2002 23:53:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13582 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318650AbSICDx0>; Mon, 2 Sep 2002 23:53:26 -0400
Date: Mon, 2 Sep 2002 21:06:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: aebr@win.tue.nl, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <Pine.LNX.4.44.0209022051540.1332-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209022100250.1047-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Sep 2002, Linus Torvalds wrote:
> 
> However, that has nothing to do with whether it is in user space or kernel 
> space. In many ways it is _easier_ to do on demand in kernel space: when 
> somebody opens /dev/sda1 and it isn't partitioned yet, you know it needs 
> to be. 

Note that this actually allows you to do your own user-space partitioning 
if you want to - simply by making sure that you do your partitioning 
_before_ somebody tries to open a partition on the device.

And if you look at how fs/block_dev.c looks right now, you'll notice that
we already handle the "main device" vs "sub-partition" cases differently,
so it should be fairly straightforward to eventually do the partitioning
on demand.

We're not there yet, no.  But doing it in the open() path of
fs/block_dev.c sure looks like it's the easiest way to maintain sanity wrt 
partitioning, _and_ maintain 100% backwards compatibility.

[ Well, the "100% backwards compatibility" is not strictly true. Doing
  partition handling on demand will mean that things like /proc/partitions
  will obviously also end up being populated on demand, which may break
  various sysadmin tools. But at least then it's fairly well localized, 
  and it's reasonably easy to grep for /proc/partitions in tools to see if 
  they may care ]

		Linus

