Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSIJRPA>; Tue, 10 Sep 2002 13:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSIJRPA>; Tue, 10 Sep 2002 13:15:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57258 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317359AbSIJRO6>;
	Tue, 10 Sep 2002 13:14:58 -0400
Date: Tue, 10 Sep 2002 13:19:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oleg Drokin <green@namesys.com>
cc: linux-kernel@vger.kernel.org, axboe@suse.de, andre@linux-ide.org
Subject: Re: 2.5.34 BUG at kernel/sched.c:944 (partitions code related?)
In-Reply-To: <20020910175639.A830@namesys.com>
Message-ID: <Pine.GSO.4.21.0209101313570.6397-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Sep 2002, Oleg Drokin wrote:

> Hello!
> 
>     Starting with yesterday I am seeing kernel BUG at sched.c:944 
>     on 2.5.3[34], I've seen similar report for 2.5.31 in the list with no
>     responces, however 2.5.31 was working fine for me.
> 
>     Stack trace for the BUG was entirely within idle task (default_idle,
>     rest_init, cpu_idle, ...)
> 
>     It explodes immediatelly after printing:
>  hda: hda1 hda2 hda3 hda4 < hda5
> 
>     Then panics trying to kill interrupt handler.
> 
>     On 2.4 this partition layout looks like this:
>  hda: [PTBL] [7476/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 >

Interesting.  At that point we are just reading sectors from disk
using normal IO path.  Had already done two reads and still have
at least one more to do.  Results of parsing are stored in temporary
array and partitioning information is yet to be changed - we hadn't
even started updating it (that would happen after parsing is over).

Basically, the shit hits the fan in the middle of work that is identical
in 2.5.34 and 2.5.33...

>    Box itself is Dual Athlon MP 1700+. IDE only, 1G RAM, highmem enabled.
> 
>    Other strange thing that caught my attention is this, if in 2.5.31 I had
>    this order or disk detection:
> <4>hda: IC35L060AVER07-0, ATA DISK drive
> <4>hdb: IC35L060AVER07-0, ATA DISK drive
> <4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> <4>hda: host protected area => 1
> <6>hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> <4>hdb: host protected area => 1
> <6>hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> <6> hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> <6> hdb: hdb1
> 
>    Now it does it in reverse like this:
> hdb: host protected area => 1
> hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> hdb: hdb1
> hda: host protected area => 1
> hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
> hda: hda1 hda2 hda3 hda4 < hda5PANIC

Detection happens in the same order.  Attaching to subdrivers doesn't,
but that's not a problem...

