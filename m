Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVFZW7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVFZW7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVFZW7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:59:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52442 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261348AbVFZW7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:59:02 -0400
Date: Sun, 26 Jun 2005 14:23:34 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin LaHaise <bcrl@kvack.org>
Subject: increased translation cache footprint in v2.6
Message-ID: <20050626172334.GA5786@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sending this info because others also seem to be interested (and I assume there
are other small address translation cache machines where the following is is an issue).

We've noticed a slowdown while moving from v2.4 to v2.6 on a small PPC platform
(855T CPU running at 48Mhz, containing pair of separate I/D TLB caches with 
32 entries each), with a relatively recent kernel (v2.6.11).

Test in question is a "dd" copying 16MB from /dev/zero to RAMDISK. 

Pinning an 8Mbyte TLB entry at KERNELBASE brought performance back to v2.4 levels.

The following "itlb-content-before.txt" and "itlb-content-after.txt" files are the
contents of the virt. addresses cached in the I/TLB before and after a "sys_read" 
system call.


[marcelo@logos itlb]$ diff -u 24-itlb-content-before.txt 24-itlb-content-after.txt  | grep SPR | grep 816 | grep "+"
+SPR  816 : 0x0ffe800f    268337167
+SPR  816 : 0x0ffeb00f    268349455
+SPR  816 : 0xc009e01f  -1073094625
+SPR  816 : 0xc009d01f  -1073098721
+SPR  816 : 0xc000301f  -1073729505
+SPR  816 : 0xc009c01f  -1073102817

[marcelo@logos itlb]$ diff -u 24-itlb-content-before.txt 24-itlb-content-after.txt  | grep SPR | grep 818 | grep "+"  | wc -l
6

[marcelo@logos itlb]$ diff -u 26-itlb-before.txt 26-itlb-after.txt  | grep 816 | grep SPR | grep "+"
+SPR  816 : 0x0feda16f    267231599
+SPR  816 : 0xc004b17f  -1073434241
+SPR  816 : 0xc004a17f  -1073438337
+SPR  816 : 0x0ff7e16f    267903343
+SPR  816 : 0x1001016f    268501359
+SPR  816 : 0xc000217f  -1073733249
+SPR  816 : 0xc001617f  -1073651329
+SPR  816 : 0xc002e17f  -1073553025
+SPR  816 : 0xc010e17f  -1072635521
+SPR  816 : 0xc002d17f  -1073557121
+SPR  816 : 0xc010d17f  -1072639617
+SPR  816 : 0xc000c17f  -1073692289
+SPR  816 : 0xc000317f  -1073729153

[marcelo@logos itlb]$ diff -u 26-itlb-before.txt 26-itlb-after.txt  | grep 816 | grep SPR | grep "+" | wc -l
13

As can be seen the number of entries is more than twice (dominated by kernel addresses).

Sorry, I've got no list of functions for these addresses, but it was pretty obvious at the time 
looking at the sys_read() codepath and respective virtual addresses.

Manual reorganization of the functions sounded too messy, although BenL mentions something about
fget_light() can and should be optimized.

I suppose the compiler/linker should be doing optimization based function order knowledge about 
the on hottest paths (eg sys_read/sys_write). Why is it not doing this already and what are 
the implications?


Date: Fri, 22 Apr 2005 12:39:21 -0300
Subject: v2.6 performance slowdown on MPC8xx: Measuring TLB cache misses

Here goes more data about the v2.6 performance slowdown on MPC8xx.

Thanks Benjamin for the TLB miss counter idea! 

This are results of the following test script which zeroes the TLB counters,
copies 16MB of data from memory to memory using "dd", and reads the counters
again. 

-- 

#!/bin/bash
echo 0 > /proc/tlbmiss
time dd if=/dev/zero of=file bs=4k count=3840
cat /proc/tlbmiss

-- 

The results:

v2.6: 				v2.4: 				delta
[root@CAS root]# sh script     	[root@CAS root]# sh script     
real    0m4.241s                         real    0m3.440s
user    0m0.140s                         user    0m0.090s
sys     0m3.820s                         sys     0m3.330s

I-TLB userspace misses: 142369  I-TLB userspace misses: 2179    ITLB u: 139190
I-TLB kernel misses: 118288    	I-TLB kernel misses: 1369	ITLB k: 116319
D-TLB userspace misses: 222916 	D-TLB userspace misses: 180249	DTLB u: 38667
D-TLB kernel misses: 207773    	D-TLB kernel misses: 167236	DTLB k: 38273

The sum of all TLB miss counter delta's between v2.4 and v2.6 is: 

139190 + 116319 + 38667 + 38273  = 332449 

Multiplied by 23 cycles, which is the average wait time to read a 
page translation miss from memory:

332449 * 23 = 7646327 cycles.

Which is about 16% of 48000000, the total number of cycles this CPU 
performs on one second. Its very likely that there is a significant
indirect effect of this TLB miss increase, other than the wasted 
cycles to bring the page tables from memory: exception execution time 
and context switching.

Checking "time" output, we can see 1s of slowdown:  

[root@CAS root]# time dd if=/dev/zero of=file bs=4k count=3840 

v2.4:				v2.6:				diff
real    0m3.366s		real    0m4.360s		0.994s
user    0m0.080s		user    0m0.111s	        0.31s
sys     0m3.260s		sys     0m4.218s 		0.958s

Mostly caused by increased kernel execution time.

This proves that the slowdown is, in great part, due to increased 
translation cache trashing. 

Now, what is the best way to bring the performance back to v2.4 levels? 

For this "dd" test, which is dominated by "sys_read/sys_write", I thought 
of trying to bring the hotpath functions into the same pages, thus
decreasing the number of page translations required for such tasks.

Comments are appreciated.
