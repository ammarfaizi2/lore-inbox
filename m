Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUDNAqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUDNAqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:46:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50099 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263731AbUDNAp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:45:56 -0400
Subject: [PATCH 0/4] ext3 block reservation patch set
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20040402185007.7d41e1a2.akpm@osdl.org>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain> 
	<20040402185007.7d41e1a2.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Apr 2004 17:52:26 -0700
Message-Id: <1081903949.3548.6837.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a set of patches which implement the in-memory ext3 block
reservation (previously called reservation based ext3 preallocation). 

[patch 1]ext3_rsv_cleanup.patch: Cleans up the old ext3 preallocation
code carried from ext2 but turned off.

[patch 2]ext3_rsv_base.patch: Implements the base of in-memory block
reservation and block allocation from reservation window.

[patch 3]ext3_rsv_mount.patch: Adds features on top of the
ext3_rsv_base.patch: 
	- deal with earlier bogus -ENOSPC error
	- do block reservation only for regular file 
	- make the ext3 reservation feature as a mount option:
		new mount option added: reservation
	- A pair of file ioctl commands are added for application to 	control
the block reservation window size.

[patch 4]ext3_rsv_dw.patch: adjust the reservation window size
dynamically:
	Start from the deault reservation window size, if the hit ration 	of
the reservation window is more than 50%, we will double the 	reservation
window size next time up to a certain upper limit.

Here are some numbers collected on dbench on 8 way PIII 700Mhz:

      dbench average throughputs on 4 runs
==================================================
Threads ext3    ext3+rsv(8)             ext3+rsv+dw
1       103     104(0%)                 105(1%)
4       144     286(98%)                256(77%)
8       118     197(66%)                210(77%)
16      113     160(41%)                177(56%)
32      61      123(101%)               150(145%)
64      41      82(100%)                85(107%)

And some numbers on tiobench sequential write: 

            tiobench Sequential Writes throughputs(improvments)
=====================================================================
Threads ext2  ext3  ext3+rsv(8)(%)  ext3+rsv(128)(%)   ext3+rsv+dw(%)
1       26      23      25(8%)      26(13%)            26(13%)
4       17      4       14(250%)    24(500%)           25(525%)
8       15      7       13(85%)     23(228%)           24(242%)
16      16      13      12(-7%)     22(69%)            24(84%)
32      15      3       12(300%)    23(666%)           23(666%)
64      14      1       11(1000%)   22(2100%)          23(2200%)

Note each time we run the test on a fresh created ext3 filesystem.

We have also run fsx tests on a 8 way on 2.6.4 kernel with the patch set
for a whole weekend on fresh created ext3 filesystem, as well as on a 4
way with the root filesystem as ext3 plus all the changes. Other tests
include 8 threads dd tests and untar a kernel source tree. 

Besides look at the performance numbers and verify the functionality, we
also checked the block allocation layout for each file generated during
the test: the blocks for a file are more contiguous with the reservation
mount option on, especially when we dynamically increase the reservation
window size in the sequential write cases.

Andrew, is this something that you would consider for -mm tree?

Thanks again for Andrew, Ted and Badari's ideas and helps on this
project. I would really appreciate any comments and feedbacks.


Mingming


