Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269229AbRH1SS4>; Tue, 28 Aug 2001 14:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271868AbRH1SSr>; Tue, 28 Aug 2001 14:18:47 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:20743 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269229AbRH1SSn>; Tue, 28 Aug 2001 14:18:43 -0400
Message-ID: <3B8BE08F.360C3481@zip.com.au>
Date: Tue, 28 Aug 2001 11:18:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010828010850Z270025-760+6645@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> ...
> (dbench-1.1 32 clients)
> ...
> 640 MB PC100-2-2-2 SDRAM
> ...
> * readahead do not show dramatic differences
> * killall -STOP kupdated DO

dbench is a poor tool for evaluating VM or filesystem performance.
It deletes its own files.

If you want really good dbench numbers, you can simply install lots
of RAM and tweak the bdflush parameters thusly:

1: set nfract and nfract_sync really high, so you can use all your
   RAM for buffering dirty data.

2: Set the kupdate interval to 1000000000 to prevent kupdate from
   kicking in.

And guess what?  You can perform an entire dbench run without
touching the disk at all!  dbench deletes its own files, and
they never hit disk.


It gets more complex - if you leave the bdflush parameters at
default, and increase the number of dbench clients you'll reach
a point where bdflush starts kicking in to reduce the amount
of buffercache memory.  This slows the dbench clients down,
so they have less opportunity to delete data before kupdate and
bdflush write them out.  So the net effect is that the slower
you go, the more I/O you end up doing - a *lot* more.  This slows
you down further, which causes more I/O, etc.

dbench is not a benchmark.  It is really complex, it is really
misleading.  It is a fine stress-tester though.

The original netbench test which dbench emulates has three phases:
startup, run and cleanup.  Throughput numbers are only quoted for
the "run" phase.  dbench is incomplete in that it reports on throughput
for all three phases.  Apparently Tridge and friends are working on
changing this, but it will still be the case that the entire test
can be optimised away, and that it is subject to the regenerative
feedback phenomenon described above.

For tuning and measuring fs and VM efficiency we need to user
simpler, more specific tools.

-
