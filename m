Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbTLZUKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbTLZUKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:10:24 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:53193 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S265225AbTLZUKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:10:13 -0500
Date: Fri, 26 Dec 2003 20:10:11 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Rohit Seth <rohit.seth@intel.com>
Subject: Re: 2.6.0 Huge pages not working as expected
Message-ID: <20031226201011.GA32316@axis.demon.co.uk>
References: <20031226105433.GA25970@axis.demon.co.uk> <20031226115647.GH27687@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226115647.GH27687@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 03:56:47AM -0800, William Lee Irwin III wrote:
> On Fri, Dec 26, 2003 at 10:54:33AM +0000, Nick Craig-Wood wrote:
> > I wrote a little test program to show the benefits of huge pages by
> > reducing TLB thrashing - it fills up 16 MB with sequential numbers
> > then adds them with different strides - very much the sort of thing
> > FFTs do.  However huge pages show a performance decrease not increase
> > for large strides!  For smaller ones there is a small speedup.
> > I've been testing on
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 8
> > model name      : Pentium III (Coppermine)
> 
> P-III has something like 2 TLB entries usable for large pages.
> I recommend trying this again on a P-IV.

I tried again on a P4

  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 15
  model           : 1
  model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
  stepping        : 2
  cpu MHz         : 1717.286
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 2
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
  bogomips        : 3383.29

The results are just about the same - a slight slowdown for
hugepages...

Testing memory at 0x40157008
span =        1, time =     11.727 ms, total = -2097152
span =        2, time =     21.997 ms, total = -2097152
span =        4, time =     37.835 ms, total = -2097152
span =        8, time =     71.097 ms, total = -2097152
span =       16, time =    149.218 ms, total = -2097152
span =       32, time =    284.334 ms, total = -2097152
span =       64, time =    287.300 ms, total = -2097152
span =      128, time =    294.139 ms, total = -2097152
span =      256, time =    307.001 ms, total = -2097152
span =      512, time =    337.929 ms, total = -2097152
span =     1024, time =    427.346 ms, total = -2097152
span =     2048, time =    483.303 ms, total = -2097152
span =     4096, time =    482.394 ms, total = -2097152

Memory from hugetlbfs
Testing memory at 0x41400000
span =        1, time =     11.567 ms, total = -2097152
span =        2, time =     21.339 ms, total = -2097152
span =        4, time =     37.473 ms, total = -2097152
span =        8, time =     70.646 ms, total = -2097152
span =       16, time =    148.426 ms, total = -2097152
span =       32, time =    283.675 ms, total = -2097152
span =       64, time =    286.539 ms, total = -2097152
span =      128, time =    293.116 ms, total = -2097152
span =      256, time =    305.257 ms, total = -2097152
span =      512, time =    338.163 ms, total = -2097152
span =     1024, time =    426.377 ms, total = -2097152
span =     2048, time =    483.237 ms, total = -2097152
span =     4096, time =    489.516 ms, total = -2097152

I tried to test your theory by altering the test to run over just 1
4MB page - this produced similar results on the P3 and P4. These from
the P4

Memory from malloc()
Testing memory at 0x40157008
span =        1, time =      3.178 ms, total = -524288
span =        2, time =      5.548 ms, total = -524288
span =        4, time =      9.509 ms, total = -524288
span =        8, time =     17.877 ms, total = -524288
span =       16, time =     37.348 ms, total = -524288
span =       32, time =     71.231 ms, total = -524288
span =       64, time =     72.066 ms, total = -524288
span =      128, time =     73.971 ms, total = -524288
span =      256, time =     77.575 ms, total = -524288
span =      512, time =     86.041 ms, total = -524288
span =     1024, time =    108.016 ms, total = -524288
span =     2048, time =    117.772 ms, total = -524288
span =     4096, time =    115.696 ms, total = -524288

Memory from hugetlbfs
Testing memory at 0x40800000
span =        1, time =      3.061 ms, total = -524288
span =        2, time =      5.419 ms, total = -524288
span =        4, time =      9.406 ms, total = -524288
span =        8, time =     17.731 ms, total = -524288
span =       16, time =     37.213 ms, total = -524288
span =       32, time =     70.973 ms, total = -524288
span =       64, time =     71.695 ms, total = -524288
span =      128, time =     73.393 ms, total = -524288
span =      256, time =     76.395 ms, total = -524288
span =      512, time =     84.490 ms, total = -524288
span =     1024, time =    106.709 ms, total = -524288
span =     2048, time =    120.795 ms, total = -524288
span =     4096, time =    122.431 ms, total = -524288

Any other ideas?

(Interesting note - the 700 MHz P3 laptop is nearly twice as fast as
the 1.7 GHx P4 dekstop (261ms vs 489ms) at the span 4096 case, but the
P4 beats the P3 by a factor of 23 for the stride 1 (3ms vs 71 ms)!)

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
