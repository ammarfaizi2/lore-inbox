Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbTAPGVS>; Thu, 16 Jan 2003 01:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbTAPGVS>; Thu, 16 Jan 2003 01:21:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:56762 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267038AbTAPGVR>;
	Thu, 16 Jan 2003 01:21:17 -0500
Date: Wed, 15 Jan 2003 22:31:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in
 2.5.53-mm1?
Message-Id: <20030115223109.52a860fe.akpm@digeo.com>
In-Reply-To: <20030116015023.GA5439@rushmore>
References: <20030116015023.GA5439@rushmore>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2003 06:30:06.0769 (UTC) FILETIME=[B5E30210:01C2BD28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> On a quad xeon running tiobench...
> The throughput and max latency for ext3 sequential writes
> looks very good when threads >= 2 on 2.5.51-mm1.
> 
> Did 2.5.51-mm1 mount ext3 as ext2?  I have ext2 logs for
> 2.5.51-mm1 and they look similar to the ext3 results.
> The other 2.5 kernels from around that time look more
> like 2.5.53-mm1.
> 

Dunno.  There have been about 7,000 different versions of the I/O scheduler
in that time and it seems a bit prone to butterfly effects.

Or maybe you accidentally ran the 2.5.51-mm1 tests on uniprocessor? 
Multithreaded tiobench on SMP brings out the worst behaviour in the ext2 and
ext3 block allocators.  Look:

<start tiobench>
<wait a while>
<kill it all off>

    quad:/mnt/sde5/tiobench> ls -ltr 
    ...
    -rw-------    1 akpm     akpm     860971008 Jan 15 22:02 _956_tiotest.0
    -rw-------    1 akpm     akpm     840470528 Jan 15 22:03 _956_tiotest.1

OK, 800 megs.

    quad:/mnt/sde5/tiobench> 0 bmap _956_tiotest.0|wc
     199224  597671 6751187

wtf?  It's taking 200,000 separate chunks of disk.

    quad:/mnt/sde5/tiobench> expr 860971008 / 199224
    4321

so the average chunk size is a little over 4k.

    quad:/mnt/sde5/tiobench> 0 bmap _956_tiotest.0 | tail -50000 | head -10
    149770-149770: 1845103-1845103 (1)
    149771-149771: 1845105-1845105 (1)
    149772-149772: 1845107-1845107 (1)
    149773-149773: 1845109-1845109 (1)
    149774-149774: 1845111-1845111 (1)
    149775-149775: 1845113-1845113 (1)
    149776-149776: 1845115-1845115 (1)
    149777-149777: 1845117-1845117 (1)
    149778-149778: 1845119-1845119 (1)
    149779-149779: 1845121-1845121 (1)

lovely.  These two files have perfectly intermingled blocks.  Writeback
bandwdith goes from 20 megabytes per second to about 0.5.

It doesn't happen on uniprocessor because each tiobench instance gets to run
for a timeslice, during which it is able to allocate a decent number of
contiguous blocks.

ext2 has block preallocation and will intermingle in 32k units, not 4k units.
So it's still crap, only not so smelly.

Does it matter much in practice?   Sometimes, not often.

It is crap? Yes.

Do I have time to do anything about it?   Probably not.


