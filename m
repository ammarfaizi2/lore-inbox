Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264165AbUD0P14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUD0P14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbUD0P14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:27:56 -0400
Received: from hera.kernel.org ([63.209.29.2]:14008 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264165AbUD0P1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:27:52 -0400
To: linux-kernel@vger.kernel.org
From: Mary Edie Meredith <maryedie@osdl.org>
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
Date: Tue, 27 Apr 2004 08:19:10 -0700
Organization: Open Source Development Labs
Message-ID: <408E79EE.2050507@osdl.org>
References: <200403190846.56955.pbadari@us.ibm.com>	<20040321015746.14b3c0dc.akpm@osdl.org>	<1080636930.3548.4549.camel@localhost.localdomain>	<20040330014523.6a368a69.akpm@osdl.org>	<1080956712.15980.6505.camel@localhost.localdomain>	<20040402175049.20b10864.akpm@osdl.org>	<1080959870.3548.6555.camel@localhost.localdomain> 	<20040402185007.7d41e1a2.akpm@osdl.org> <1081903949.3548.6837.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1083079613 31074 172.20.1.91 (27 Apr 2004 15:26:53 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 27 Apr 2004 15:26:53 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To test the benefit of Mingming's ext3 reservation
patchset, we ran tiobench on 2-way systems on STP
using 2.6.6-rc2-mm1 versus 2.6.6-rc2-mm1 patched to
force the ext3 file system to be built without
reservation.

The results show increased throughput for >1
threads not only for sequential write, but also
for random write, sequential read, and random read.
Latency is also decreased for all cases.

Raw data can be found:
-2 way 2.6.6-rc2-mm1
http://khack.osdl.org/stp/292223/results/tiobench-ext3.txt
-2 way 2.6.6-rc2-mm1  noreservation default
http://khack.osdl.org/stp/292225/results/tiobench-ext3.txt

Judith compared the two runs by plotting the
results at: http://developer.osdl.org/judith/tiobench/ext3-reserve/

Here are some interesting ones:
Thruput results:
-Random write thruput 128k
http://developer.osdl.org/judith/tiobench/ext3-reserve/through.ext3.2CPU.RW.128.png
-Random write thruput 4k
http://developer.osdl.org/judith/tiobench/ext3-reserve/through.ext3.2CPU.RW.4.png
-Sequential write thruput 4k
http://developer.osdl.org/judith/tiobench/ext3-reserve/through.ext3.2CPU.SW.4.png
-Sequential write thruput 128k
http://developer.osdl.org/judith/tiobench/ext3-reserve/through.ext3.2CPU.SW.128.png

Latency is reduced almost across the board.
-Example: Latency figures for Random write 4k:
http://developer.osdl.org/judith/tiobench/ext3-reserve/lat.ext3.2CPU.RW.4.png

Mary Edie Meredith
Open Source Development Labs
503-626-2455 x42
maryedie@hotmail.com

Mingming Cao wrote:
> Hello,
> 
> Here is a set of patches which implement the in-memory ext3 block
> reservation (previously called reservation based ext3 preallocation). 
> 
> [patch 1]ext3_rsv_cleanup.patch: Cleans up the old ext3 preallocation
> code carried from ext2 but turned off.
> 
> [patch 2]ext3_rsv_base.patch: Implements the base of in-memory block
> reservation and block allocation from reservation window.
> 
> [patch 3]ext3_rsv_mount.patch: Adds features on top of the
> ext3_rsv_base.patch: 
> 	- deal with earlier bogus -ENOSPC error
> 	- do block reservation only for regular file 
> 	- make the ext3 reservation feature as a mount option:
> 		new mount option added: reservation
> 	- A pair of file ioctl commands are added for application to 	control
> the block reservation window size.
> 
> [patch 4]ext3_rsv_dw.patch: adjust the reservation window size
> dynamically:
> 	Start from the deault reservation window size, if the hit ration 	of
> the reservation window is more than 50%, we will double the 	reservation
> window size next time up to a certain upper limit.
> 
> Here are some numbers collected on dbench on 8 way PIII 700Mhz:
> 
>       dbench average throughputs on 4 runs
> ==================================================
> Threads ext3    ext3+rsv(8)             ext3+rsv+dw
> 1       103     104(0%)                 105(1%)
> 4       144     286(98%)                256(77%)
> 8       118     197(66%)                210(77%)
> 16      113     160(41%)                177(56%)
> 32      61      123(101%)               150(145%)
> 64      41      82(100%)                85(107%)
> 
> And some numbers on tiobench sequential write: 
> 
>             tiobench Sequential Writes throughputs(improvments)
> =====================================================================
> Threads ext2  ext3  ext3+rsv(8)(%)  ext3+rsv(128)(%)   ext3+rsv+dw(%)
> 1       26      23      25(8%)      26(13%)            26(13%)
> 4       17      4       14(250%)    24(500%)           25(525%)
> 8       15      7       13(85%)     23(228%)           24(242%)
> 16      16      13      12(-7%)     22(69%)            24(84%)
> 32      15      3       12(300%)    23(666%)           23(666%)
> 64      14      1       11(1000%)   22(2100%)          23(2200%)
> 
> Note each time we run the test on a fresh created ext3 filesystem.
> 
> We have also run fsx tests on a 8 way on 2.6.4 kernel with the patch set
> for a whole weekend on fresh created ext3 filesystem, as well as on a 4
> way with the root filesystem as ext3 plus all the changes. Other tests
> include 8 threads dd tests and untar a kernel source tree. 
> 
> Besides look at the performance numbers and verify the functionality, we
> also checked the block allocation layout for each file generated during
> the test: the blocks for a file are more contiguous with the reservation
> mount option on, especially when we dynamically increase the reservation
> window size in the sequential write cases.
> 
> Andrew, is this something that you would consider for -mm tree?
> 
> Thanks again for Andrew, Ted and Badari's ideas and helps on this
> project. I would really appreciate any comments and feedbacks.
> 
> 
> Mingming
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
