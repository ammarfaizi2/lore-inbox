Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbTBUKpf>; Fri, 21 Feb 2003 05:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTBUKpf>; Fri, 21 Feb 2003 05:45:35 -0500
Received: from dial-ctb04109.webone.com.au ([210.9.244.109]:20228 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267374AbTBUKpd>;
	Fri, 21 Feb 2003 05:45:33 -0500
Message-ID: <3E560584.1040406@cyberone.com.au>
Date: Fri, 21 Feb 2003 21:55:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: iosched: impact of streaming read on read-many-files
References: <20030220212304.4712fee9.akpm@digeo.com> <20030220212758.5064927f.akpm@digeo.com> <20030221104028.GO31480@x30.school.suse.de>
In-Reply-To: <20030221104028.GO31480@x30.school.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Thu, Feb 20, 2003 at 09:27:58PM -0800, Andrew Morton wrote:
>
>>Here we look at what affect a large streaming read has upon an operation
>>which reads many small files from the same disk.
>>
>>A single streaming read was set up with:
>>
>>	while true
>>	do
>>	        cat 512M-file > /dev/null
>>	done
>>
>>and we measure how long it takes to read all the files from a 2.4.19 kernel
>>tree off the same disk with
>>
>>	time (find kernel-tree -type f | xargs cat > /dev/null)
>>
>>
>>
>>2.4.21-pre4:	31 minutes 30 seconds
>>
>>2.5.61+hacks:	3 minutes 39 seconds
>>
>>2.5.61+CFQ:	5 minutes 7 seconds (*)
>>
>>2.5.61+AS:	17 seconds
>>
>>
>>
>>
>>
>>* CFQ performed very strangely here.  Tremendous amount of seeking and a
>>
>
>strangely? this is the *feature*. Benchmarking CFQ in function of real
>time is pointless, apparently you don't understand the whole point about
>CFQ and you keep benchmarking like if CFQ was designed for a database
>workload. the only thing you care if you run CFQ is the worst case
>latency of read, never the throughput, 128k/sec is more than enough as
>far as you never wait 2 seconds before you can get the next 128k.
>
>take tiobench with 1 single thread in read mode and keep it running in
>background and collect the worst case latency, only *then* you will have
>a chance to see a benefit. CFQ is all but a generic purpose elevator.
>You must never use CFQ if your object is throughput and you benchmark
>the global workload and not the worst case latency of every single read
>or write-sync syscall.
>
>CFQ is made for multimedia desktop usage only, you want to be sure
>mplayer or xmms will never skip frames, not for parallel cp reading
>floods of data at max speed like a database with zillon of threads. For
>multimedia not to skip frames 1M/sec is  more than enough bandwidth,
>doesn't matter if the huge database in background runs much slower as
>far as you never skip a frame.
>
>If you don't mind to skip frames you shouldn't use CFQ and everything
>will run faster, period.
>
There is actually a point when you have a number of other IO streams
going on where your decreased throughput means *maximum* latency goes
up because robin doesn't go round fast enough. I guess desktop loads
won't often have a lot of different IO streams.

The anticipatory scheduler isn't so strict about fairness, however it
will make as good an attempt as CFQ at keeping maximum read latency
below read_expire (actually read_expire*2 in the current implementation).

