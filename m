Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271880AbRH1SqK>; Tue, 28 Aug 2001 14:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271881AbRH1Sp7>; Tue, 28 Aug 2001 14:45:59 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:6673 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271880AbRH1Spw>; Tue, 28 Aug 2001 14:45:52 -0400
Message-ID: <3B8BE6C9.ECDF30E@namesys.com>
Date: Tue, 28 Aug 2001 22:45:29 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Dieter =?koi8-r?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010828010850Z270025-760+6645@vger.kernel.org> <3B8BE08F.360C3481@zip.com.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Dieter Nützel wrote:
> >
> > ...
> > (dbench-1.1 32 clients)
> > ...
> > 640 MB PC100-2-2-2 SDRAM
> > ...
> > * readahead do not show dramatic differences
> > * killall -STOP kupdated DO
> 
> dbench is a poor tool for evaluating VM or filesystem performance.
> It deletes its own files.
> 
> If you want really good dbench numbers, you can simply install lots
> of RAM and tweak the bdflush parameters thusly:
> 
> 1: set nfract and nfract_sync really high, so you can use all your
>    RAM for buffering dirty data.
> 
> 2: Set the kupdate interval to 1000000000 to prevent kupdate from
>    kicking in.
> 
> And guess what?  You can perform an entire dbench run without
> touching the disk at all!  dbench deletes its own files, and
> they never hit disk.
> 
> It gets more complex - if you leave the bdflush parameters at
> default, and increase the number of dbench clients you'll reach
> a point where bdflush starts kicking in to reduce the amount
> of buffercache memory.  This slows the dbench clients down,
> so they have less opportunity to delete data before kupdate and
> bdflush write them out.  So the net effect is that the slower
> you go, the more I/O you end up doing - a *lot* more.  This slows
> you down further, which causes more I/O, etc.
> 
> dbench is not a benchmark.  It is really complex, it is really
> misleading.  It is a fine stress-tester though.
> 
> The original netbench test which dbench emulates has three phases:
> startup, run and cleanup.  Throughput numbers are only quoted for
> the "run" phase.  dbench is incomplete in that it reports on throughput
> for all three phases.  Apparently Tridge and friends are working on
> changing this, but it will still be the case that the entire test
> can be optimised away, and that it is subject to the regenerative
> feedback phenomenon described above.
> 
> For tuning and measuring fs and VM efficiency we need to user
> simpler, more specific tools.
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I would encourage you to check out the reiser_fract_tree program, which is at
the heart of mongo.pl.  It generates lots of files using a fractal algorithm for
size and number per directory, and I think it reflects real world statistics
decently.  You can specify mean file size, max file size, mean nr of files per
directory, max nr files per directory, check it out..... 
www.namesys.com/benchmarks.html

It just generates file sets, which is fine for write performance testing like
you are doing.  Mongo.pl can do reads and copies and stuff using those file
sets.

Hans
