Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965347AbWJ3RS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965347AbWJ3RS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965349AbWJ3RS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:18:57 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:25988 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S965347AbWJ3RS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:18:56 -0500
Reply-To: jm-lkml@forest.fc.hp.com
To: <linux-kernel@vger.kernel.org>
From: John Marvin <jm-lkml@forest.fc.hp.com>
Subject: Port of Shimizu superpages patch to ia64/x86-64
Message-Id: <20061030171237.BB6C23ECB@forest.fc.hp.com>
Date: Mon, 30 Oct 2006 10:12:37 -0700 (MST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been doing some research on superpages on Linux, with a particular
emphasis on the ia64 architecture (I work for HP). As part of that research
I've been experimenting with different tlb miss handler implementations
on ia64, comparing long format and short format vhpt miss handlers. I've
chosen to use a short format vhpt handler for this patch.

I've been using the "Shimizu Superpages" patch as a test bed for various
experiments, and have ported it forward to the 2.6.17.6 release of the
kernel. The Shimizu patch has been posted here in the past a few times,
and it has previously supported the Sparc, Alpha and i386 architectures.
I've dropped Sparc and Alpha, since I have no expertise with those
architectures, nor easy access to machines of those types to work with.
I have added support for ia64 and x86-64. I've also fixed a fair number
of bugs in the patch, however the basic structure of the patch has not
changed much (those who are interested in Sparc or Alpha may be able to
get an older version of the patch and port the machine dependent code
forward). The patch has been tested quite a bit on ia64. I've done
some testing on the other architectures, but I haven't tested a wide
variety of configurations.

One feature has been added that enables you to examine superpage
allocations at the vma level for a process (/proc/<pid>/superpages, based
on /proc/<pid>/maps). Some structural changes have been made to support
superpages that span more than one pmd (used on ia64).

The patch is a little over 100 Kb, so I haven't included it here. It
can be obtained from the following URL:

    http://www.themarvins.org/superpages.patch

I've followed previous discussions regarding superpages on this list, and
am quite aware of Linus's feelings regarding this feature. Certainly
this implementation has some significant limitations. The Shimizu patch
only supports superpages for anonymous memory. It only works in situations
where large chunks of memory are allocated at one time (as opposed to
lots of small allocations eventually adding up to a very large amount
of allocated memory). Once a superpage has been demoted, it will never
be promoted again. There is no support for aiding contiguity, simply
relying on the buddy allocator to keep things contiguous. For the i386
and x86-64 architectures pmd's, pud's and pgd's are order 1 allocations,
which also can lead to issues in low memory situations.

As some people who follow the various superpage implementations know,
Alan Cox (not "the" Alan Cox of Linux fame) of Rice University has an
implementation of superpages on FreeBSD that is considered by many to
be a far better solution. I am working with him to port his implementation
to Linux. I still don't hold out a lot of hope of getting that into the
mainstream kernel, given Linus's opinion, but I'll cross that bridge at
a later time. Regardless, there will always be people who want/need such
features, even if they have to patch their kernel to get them.

I've enclosed some benchmark results below for five different
configurations:

    1) i386 2 Level Pagetables
    2) i386 3 Level Pagetables (PAE)
    3) x86-64 (4 Level Pagetables)
    4) ia64 3 Level Pagetables
    5) ia64 4 Level Pagetables

the i386 and x86-64 tests were done on the same machine -- a 3 Ghz
Pentium 4 w/ emt (Prescott) with 1 Gb of memory. The ia64 tests were
done on a fairly old rx2600 (1Ghz Itanium 2 w/3Mb cache). The benchmarks
are from three different sources, 1) NAS Parallel Benchmarks v. 3.1,
2) HPCC Random Access (GUPS), and 3) Asci Sweep3D. On i386 and x86-64
only the Asci Sweep3D benchmark does not appear to benefit from super
pages. On ia64 super pages appears to be detrimental to one class
of the NAS LU benchmark. All other benchmarks appear to benefit to
some extent from superpages. Random Access (GUPS) and the NAS CG
benchmarks appear to benefit the most.

John Marvin

Appendix : Benchmark Results

i386 2 Level Page Tables

		 Avg. Time     Avg. Time
		Super Pages   Super Pages    Percent
     Benchmark    Disabled       Enabled   Improvement
--------------------------------------------------------
NAS  BT Class A     194.44         190.30       2.13
NAS  BT Class B     819.32         803.88       1.89
NAS  BT Class C    3362.47        3279.22       2.48
NAS  CG Class A       2.75           2.70       2.00
NAS  CG Class B     278.01          97.16      65.05
NAS  CG Class C    1202.17         479.77      60.09
NAS  IS Class B      10.41          10.30       1.01
NAS  LU Class A     175.77         172.85       1.66
NAS  LU Class B     743.58         721.27       3.00
NAS  LU Class C    3009.48        2910.89       3.28
NAS  SP Class B     543.08         522.21       3.84
HPCC GUPS 2^25       10.27           8.96      12.76
HPCC GUPS 2^26       22.14          18.40      16.89
ASCI Sweep3D 150    171.56         171.88      -0.19

i386 3 Level Page Tables (PAE)

		  Avg. Time     Avg. Time
		 Super Pages   Super Pages    Percent
     Benchmark     Disabled       Enabled   Improvement
-------------------------------------------------------
NAS  BT Class A     194.14         190.91       1.67
NAS  BT Class B     821.30         805.30       1.95
NAS  BT Class C    3336.53        3283.19       1.60
NAS  CG Class A       2.72           2.71       0.18
NAS  CG Class B     281.58          97.19      65.48
NAS  CG Class C    1205.68         321.62      73.33
NAS  IS Class B      10.47          10.30       1.58
NAS  LU Class A     176.46         172.35       2.33
NAS  LU Class B     744.14         721.18       3.09
NAS  LU Class C    3025.46        2923.02       3.39
NAS  SP Class B     550.55         522.13       5.16
HPCC GUPS 2^25       11.91           9.24      22.42
HPCC GUPS 2^26       26.26          18.73      28.66
ASCI Sweep3D 150    172.25         172.14       0.06

x86-64  4 Level Page Tables

		  Avg. Time     Avg. Time
		 Super Pages   Super Pages    Percent
     Benchmark     Disabled       Enabled   Improvement
-------------------------------------------------------
NAS  BT Class A     154.72         151.66       1.97
NAS  BT Class B     670.27         657.33       1.93
NAS  BT Class C    2731.36        2668.22       2.31
NAS  CG Class A       3.05           3.00       1.64
NAS  CG Class B     310.33         168.02      45.86
NAS  CG Class C    1290.74         347.74      73.06
NAS  IS Class B      10.43          10.28       1.49
NAS  LU Class A     124.62         117.41       5.78
NAS  LU Class B     545.41         519.11       4.82
NAS  LU Class C    2227.86        2116.18       5.01
NAS  SP Class B     461.87         439.78       4.78
HPCC GUPS 2^25        7.65           6.61      13.61
HPCC GUPS 2^26       17.63          13.01      26.22
ASCI Sweep3D 150    560.57         560.42       0.03

ia64 3 Level Page Tables

		  Avg. Time     Avg. Time
		 Super Pages   Super Pages    Percent
     Benchmark     Disabled       Enabled   Improvement
-------------------------------------------------------
NAS  BT Class A     895.09         891.29       0.43
NAS  BT Class B    3743.07        3724.30       0.50
NAS  BT Class C   15481.65       15367.76       0.74
NAS  CG Class A      18.19          18.13       0.30
NAS  CG Class B     821.60         782.08       4.81
NAS  CG Class C    6158.51        2150.11      65.09
NAS  IS Class B      33.64          30.31       9.91
NAS  IS Class C     251.43         228.00       9.32
NAS  LU Class A     422.25         416.61       1.34
NAS  LU Class B    1900.03        1930.40      -1.60
NAS  LU Class C    7945.01        7839.01       1.33
NAS  SP Class B    2403.06        2372.96       1.25
HPCC GUPS 2^25       28.06          27.41       2.30
HPCC GUPS 2^26       56.28          55.20       1.94
HPCC GUPS 2^27      117.78         110.77       5.95
ASCI Sweep3D 150    944.35         943.76       0.06

ia64 4 Level Page Tables

		  Avg. Time     Avg. Time
		 Super Pages   Super Pages    Percent
     Benchmark     Disabled       Enabled   Improvement
-------------------------------------------------------
NAS  BT Class A     895.02         891.27       0.42
NAS  BT Class B    3742.71        3723.06       0.52
NAS  BT Class C   15483.59       15367.18       0.75
NAS  CG Class A      18.18          18.13       0.28
NAS  CG Class B     821.82         782.02       4.84
NAS  CG Class C    6163.17        2150.10      65.11
NAS  IS Class B      33.67          30.33       9.93
NAS  IS Class C     251.46         228.05       9.31
NAS  LU Class A     421.45         416.38       1.20
NAS  LU Class B    1898.35        1930.42      -1.69
NAS  LU Class C    7943.45        7839.33       1.31
NAS  SP Class B    2403.51        2372.71       1.28
HPCC GUPS 2^25       28.05          27.41       2.27
HPCC GUPS 2^26       56.31          55.19       1.98
HPCC GUPS 2^27      117.84         110.77       6.00
ASCI Sweep3D 15     943.53         943.86      -0.04
