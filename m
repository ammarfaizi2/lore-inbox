Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTARG7q>; Sat, 18 Jan 2003 01:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbTARG7q>; Sat, 18 Jan 2003 01:59:46 -0500
Received: from holomorphy.com ([66.224.33.161]:14209 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262821AbTARG7p>;
	Sat, 18 Jan 2003 01:59:45 -0500
Date: Fri, 17 Jan 2003 23:08:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@zip.com.au, davej@codemonkey.org.uk, ak@muc.de,
       Erich Focht <efocht@ess.nec.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <20030118070808.GA789@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, akpm@zip.com.au,
	davej@codemonkey.org.uk, ak@muc.de, Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <200301171535.21226.efocht@ess.nec.de> <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 04:11:59PM +0100, Ingo Molnar wrote:
> agreed, i've attached the -B0 patch that does this. The balancing rates
> are 1 msec, 2 msec, 200 and 400 msec (idle-local, idle-global, busy-local,
> busy-global).

I suspect some of these results may be off on NUMA-Q (or any PAE box)
if CONFIG_MTRR was enabled. Michael, Martin, please doublecheck
/proc/mtrr and whether CONFIG_MTRR=y. If you didn't enable it, or if
you compile times aren't on the order of 5-10 minutes, you're unaffected.

The severity of the MTRR regression in 2.5.59 is apparent from:
$ cat /proc/mtrr
reg00: base=0xc0000000 (3072MB), size=1024MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
$ time make -j bzImage > /dev/null
make -j bzImage > /dev/null  8338.52s user 245.73s system 1268% cpu 11:16.56 total

Fixing it up by hand (after dealing with various bits of pain) to:
$ cat /proc/mtrr
reg00: base=0xc0000000 (3072MB), size=1024MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
reg02: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
reg03: base=0x200000000 (8192MB), size=4096MB: write-back, count=1
reg04: base=0x300000000 (12288MB), size=4096MB: write-back, count=1
reg05: base=0x400000000 (16384MB), size=16384MB: write-back, count=1
reg06: base=0x800000000 (32768MB), size=16384MB: write-back, count=1
reg07: base=0xc00000000 (49152MB), size=16384MB: write-back, count=1

make -j bzImage > /dev/null  361.72s user 546.28s system 2208% cpu 41.109 total
make -j bzImage > /dev/null  364.00s user 575.73s system 2005% cpu 46.858 total
make -j bzImage > /dev/null  366.77s user 568.44s system 2239% cpu 41.765 total

I'll do some bisection search to figure out which patch broke the world.

-- wli
