Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbTBUKai>; Fri, 21 Feb 2003 05:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTBUKai>; Fri, 21 Feb 2003 05:30:38 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:45189 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267344AbTBUKah>;
	Fri, 21 Feb 2003 05:30:37 -0500
Date: Fri, 21 Feb 2003 11:40:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iosched: impact of streaming read on read-many-files
Message-ID: <20030221104028.GO31480@x30.school.suse.de>
References: <20030220212304.4712fee9.akpm@digeo.com> <20030220212758.5064927f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220212758.5064927f.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 09:27:58PM -0800, Andrew Morton wrote:
> 
> Here we look at what affect a large streaming read has upon an operation
> which reads many small files from the same disk.
> 
> A single streaming read was set up with:
> 
> 	while true
> 	do
> 	        cat 512M-file > /dev/null
> 	done
> 
> and we measure how long it takes to read all the files from a 2.4.19 kernel
> tree off the same disk with
> 
> 	time (find kernel-tree -type f | xargs cat > /dev/null)
> 
> 
> 
> 2.4.21-pre4:	31 minutes 30 seconds
> 
> 2.5.61+hacks:	3 minutes 39 seconds
> 
> 2.5.61+CFQ:	5 minutes 7 seconds (*)
> 
> 2.5.61+AS:	17 seconds
> 
> 
> 
> 
> 
> * CFQ performed very strangely here.  Tremendous amount of seeking and a

strangely? this is the *feature*. Benchmarking CFQ in function of real
time is pointless, apparently you don't understand the whole point about
CFQ and you keep benchmarking like if CFQ was designed for a database
workload. the only thing you care if you run CFQ is the worst case
latency of read, never the throughput, 128k/sec is more than enough as
far as you never wait 2 seconds before you can get the next 128k.

take tiobench with 1 single thread in read mode and keep it running in
background and collect the worst case latency, only *then* you will have
a chance to see a benefit. CFQ is all but a generic purpose elevator.
You must never use CFQ if your object is throughput and you benchmark
the global workload and not the worst case latency of every single read
or write-sync syscall.

CFQ is made for multimedia desktop usage only, you want to be sure
mplayer or xmms will never skip frames, not for parallel cp reading
floods of data at max speed like a database with zillon of threads. For
multimedia not to skip frames 1M/sec is  more than enough bandwidth,
doesn't matter if the huge database in background runs much slower as
far as you never skip a frame.

If you don't mind to skip frames you shouldn't use CFQ and everything
will run faster, period.

Andrea
