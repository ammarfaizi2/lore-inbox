Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbSI1ISa>; Sat, 28 Sep 2002 04:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262743AbSI1ISa>; Sat, 28 Sep 2002 04:18:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:8085 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262742AbSI1IS3>;
	Sat, 28 Sep 2002 04:18:29 -0400
Message-ID: <3D95670C.3239A357@digeo.com>
Date: Sat, 28 Sep 2002 01:23:40 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.5.39 with contest 0.41
References: <1033196310.3d955316425bd@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 08:23:43.0886 (UTC) FILETIME=[5BC402E0:01C266C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> Here follow the latest benchmarks with contest (http://contest.kolivas.net)
> 
> noload:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  67.71           98%             1.00*
> 2.5.38                  72.38           94%             1.07
> 2.5.38-mm3              73.00           93%             1.08
> 2.5.39                  73.17           93%             1.08
> 
> process_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  110.75          57%             1.64*
> 2.5.38                  85.71           79%             1.27
> 2.5.38-mm3              96.32           72%             1.42*
> 2.5.39                  88.18           77%             1.30

well that's funny.

> io_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  216.05          33%             3.19
> 2.5.38                  887.76          8%              13.11*
> 2.5.38-mm3              105.17          70%             1.55*
> 2.5.39                  216.81          37%             3.20

-mm3 has fifo_batch=16.  2.5.39 has fifo_batch=32.
 
> mem_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  105.40          70%             1.56
> 2.5.38                  107.89          73%             1.59
> 2.5.38-mm3              117.09          63%             1.73*
> 2.5.39                  103.72          72%             1.53

2.5's swapout is still fairly synchronously sucky.  So low-latency
writeout could be advantageous there.  This difference is probably
also the fifo_batch thing.  Or maybe statistical?


I did some testing with your latest.  4xPIII, mem=512m, SCSI,
tag depth = 0, 2.5.39-mm1 candidate:

fifo_batch=32:

	noload          2:34.53         291%
	cpuload         2:36.20         286%
	memload         2:19.44         333%
	ioloadhalf      2:34.81         303%
	ioloadfull      3:15.47         238%

(err.  memload sped it up!)

fifo_batch=16:

	noload          2:00.03         380%
	cpuload         2:27.62         304%
	memload         2:22.59         326%
	ioloadhalf      2:33.75         306%
	ioloadfull      2:59.18         259%

- Something went horridly wrong in the first `noload' test.
- fifo_batch=16 is better than 32.
- you see a 4x hit from io_load.  I see a 1.5x hit.

This is all pretty wild.   I'll go profile process_load a bit.



BTW, please change all the

	#define dprintf(...) printf(__VA_ARGS__)

to

	#define dprintf(x...) printf(x)

so people who use crufty old compilers can build it.
