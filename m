Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWKBLVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWKBLVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 06:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWKBLVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 06:21:36 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:60396 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751537AbWKBLVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 06:21:35 -0500
Date: Thu, 2 Nov 2006 11:21:32 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 0/11] Avoiding fragmentation with subzone groupings v26
In-Reply-To: <p734ptilcie.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.64.0611021025130.14806@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
 <p734ptilcie.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, Andi Kleen wrote:

> Mel Gorman <mel@csn.ul.ie> writes:
>>
>> Our tests show that about 60-70% of physical memory can be allocated on
>> a desktop after a few days uptime. In benchmarks and stress tests, we are
>> finding that 80% of memory is available as contiguous blocks at the end of
>> the test. To compare, a standard kernel was getting < 1% of memory as large
>> pages on a desktop and about 8-12% of memory as large pages at the end of
>> stress tests.
>
> If you don't have a fixed limit on the unreclaimable memory you could
> still get into a situation where all memory is fragmented and unreclaimable,
> right?
>

Right, it's just considerably harder so there will be adverse workloads 
that will break it (heavy IO on very large numbers of files under high 
load with reiserfs is one). I don't have a list of real workloads that 
break anti-frag yet so so I want to get anti-frag out there and see does 
it help people who really care about hugepages or not.

I've included a script below that tries to get as many hugepages as 
possible via the proc interface. What I usually do is run it after a 
series of stress tests or sometimes one a desktop after a few days to see 
how it gets on in comparison to the standard allocator. A test I ran there 
got 73% of memory as huge pages on a system with 19 days uptime. However, 
the machine wasn't heavily stressed during that time and I had configured 
min_free_kbytes to be 10% as suggested in the CONFIG help.

Generally anti-frag gets you way more hugepages, but not necessarily the 
whole systems worth. To get all free memory as huge pages, I'd need to be 
moving memory around and that would be very invasive. It gets better 
results with linear-reclaim or lumpy-reclaim patches applied.

For people to get 100% expected results, they still will need to size the 
hugepages pool at boot-time or set aside a zone of reclaimable pages at 
boot time. This patch is aimed at relaxing the restriction of sizing the 
pool up while the system is in use. For example, take a batch-scheduled 
machine running HPC jobs. I want it to be able to get more or less 
hugepages between jobs without requiring reboots. I'd like to hear from 
people who try resizing the pool what sort of success they have and what 
sort of workloads broke the strategy on them.

> It might be much harder to hit, but we have so many users that at least
> a few will eventually.
>

This is true. There are additional steps that could be taken that would 
make it even harder to break down but I'd like to get more data on what 
sort of workloads break this strategy before I complicate things more.

>> Performance tests are within 0.1% for kbuild on a number of test machines. aim9
>> is usually within 1%
>
> 1% is a lot.
>

Well, yes, but two things. First, aim9 is a microbenchmark. Small 
differences in aim9 seem to make very little difference to other 
benchmarks like kbuild. On some arches, aim9 results vary widely between 
subsequent runs making it very sensitive. I used aim9 initially because if 
it showed *large* regressions, something was usually up.

Second, I didn't say it was always a 1% regression, just that it generally 
within 1%. Here are the last aim9 result comparison on the x86_64

                  2.6.19-rc4-mm1-clean  2.6.19-rc4-mm1-list-based
  1 creat-clo                150666.67                  157083.33    6416.66  4.26% File Creations and Closes/second
  2 page_test                186915.00                  189065.16    2150.16  1.15% System Allocations & Pages/second
  3 brk_test                1863739.38                 1972521.25  108781.87  5.84% System Memory Allocations/second
  4 jmp_test               16388101.98                16381716.67   -6385.31 -0.04% Non-local gotos/second
  5 signal_test              464500.00                  501649.73   37149.73  8.00% Signal Traps/second
  6 exec_test                   165.17                     162.59      -2.58 -1.56% Program Loads/second
  7 fork_test                  4283.57                    4365.21      81.64  1.91% Task Creations/second
  8 link_test                 50129.19                   47658.31   -2470.88 -4.93% Link/Unlink Pairs/second

It's actally showing some performance improvements there according to aim9

Here are the aim9 results on a ppc64 LPAR

                  2.6.19-rc4-mm1-clean  2.6.19-rc4-mm1-list-based
  1 creat-clo                134460.92                  134816.67     355.75  0.26% File Creations and Closes/second
  2 page_test                307473.33                  304900.85   -2572.48 -0.84% System Allocations & Pages/second
  3 brk_test                1547025.50                 1565439.09   18413.59  1.19% System Memory Allocations/second
  4 jmp_test               10353816.67                10211531.41 -142285.26 -1.37% Non-local gotos/second
  5 signal_test              257007.17                  257066.67      59.50  0.02% Signal Traps/second
  6 exec_test                   108.61                     108.76       0.15  0.14% Program Loads/second
  7 fork_test                  3276.12                    3289.45      13.33  0.41% Task Creations/second
  8 link_test                 47225.33                   48289.50    1064.17  2.25% Link/Unlink Pairs/second

And here is the comparison on a numaq

                  2.6.19-rc4-mm1-clean  2.6.19-rc4-mm1-list-based
  1 creat-clo                 46660.00                   48609.03    1949.03  4.18% File Creations and Closes/second
  2 page_test                 47555.81                   47588.68      32.87  0.07% System Allocations & Pages/second
  3 brk_test                 247910.77                  254179.15    6268.38  2.53% System Memory Allocations/second
  4 jmp_test                2276287.29                 2275924.69    -362.60 -0.02% Non-local gotos/second
  5 signal_test               65561.48                   64778.41    -783.07 -1.19% Signal Traps/second
  6 exec_test                    21.32                      21.31      -0.01 -0.05% Program Loads/second
  7 fork_test                   880.79                     906.36      25.57  2.90% Task Creations/second
  8 link_test                 19058.50                   18726.81    -331.69 -1.74% Link/Unlink Pairs/second

These results tend to vary by a few percent in each run, even on 
subsequent runs so I consider the results to be very noisy and I haven't 
done the legwork yet to get an average over multiple runs. To give an idea 
of how mad the results can be, this is an older set of results on an 
x86_64. Look at the brk_test results even. Between 2.6.19-rc2-mm2-clean 
and 2.6.19-rc3-mm1, there is a 12% regression apparently, but it's 
unlikely to be reflected in "real" benchmarks.

                  2.6.19-rc2-mm2-clean  2.6.19-rc2-mm2-list-based
  1 creat-clo                142759.54                  170083.33   27323.79 19.14% File Creations and Closes/second
  2 page_test                187305.90                  179716.71   -7589.19 -4.05% System Allocations & Pages/second
  3 brk_test                2139943.34                 2377053.82  237110.48 11.08% System Memory Allocations/second
  4 jmp_test               16387850.00                16380453.26   -7396.74 -0.05% Non-local gotos/second
  5 signal_test              536933.33                  495550.74  -41382.59 -7.71% Signal Traps/second
  6 exec_test                   166.17                     162.39      -3.78 -2.27% Program Loads/second
  7 fork_test                  4201.23                    4261.91      60.68  1.44% Task Creations/second
  8 link_test                 48980.64                   58369.22    9388.58 19.17% Link/Unlink Pairs/second

Hence, I'd like to get a better idea of what sort of performance effect 
other people see on the benchmarks they care about.

Here is the script I use to grab hugepages;

#!/bin/bash
# This benchmark checks how many hugepages can be allocated in the hugepage
# pool

P=hugepages_get-bench
SLEEP_INTERVAL=3
FAIL_AFTER_NO_CHANGE_ATTEMPTS=20

# Args
while [ "$1" != "" ]; do
 	case "$1" in
 		-s)		export SLEEP_INTERVAL=$2; shift 2;;
 		-f)		export FAIL_AFTER_NO_CHANGE_ATTEMPTS=$2; shift 2;;
 	esac
done

# Check proc entry exists
if [ ! -e /proc/sys/vm/nr_hugepages ]; then
 	echo Attempting load of hugetlbfs module
 	modprobe hugetlbfs
 	if [ ! -e /proc/sys/vm/nr_hugepages ]; then
 		echo ERROR: /proc/sys/vm/nr_hugepages does not exist
 		exit $EXIT_TERMINATE
 	fi
fi

echo Allocating hugepages test
echo -------------------------

# Disable OOM killed
echo Disabling OOM Killer for current test process
echo -17 > /proc/self/oom_adj

# Record existing hugepage count
STARTING_COUNT=`cat /proc/sys/vm/nr_hugepages`
echo Starting page count: $STARTING_COUNT

# Ensure we have permission to write
echo $STARTING_COUNT > /proc/sys/vm/nr_hugepages || {
 	echo ERROR: Do not have permission to adjust nr_hugepages count
 	exit $EXIT_TERMINATE
}

# Start test
CURRENT_COUNT=$STARTING_COUNT
LAST_COUNT=$STARTING_COUNT
NOCHANGE_COUNT=0
ATTEMPT=0

while [ $NOCHANGE_COUNT -ne $FAIL_AFTER_NO_CHANGE_ATTEMPTS ]; do
 	ATTEMPT=$((ATTEMPT+1))
 	PAGES_COUNT=$(($CURRENT_COUNT+100))
 	echo $PAGES_COUNT > /proc/sys/vm/nr_hugepages

 	CURRENT_COUNT=`cat /proc/sys/vm/nr_hugepages`
 	PROGRESS=
 	if [ "$CURRENT_COUNT" = "$LAST_COUNT" ]; then
 		NOCHANGE_COUNT=$(($NOCHANGE_COUNT+1))
 	else
 		NOCHANGE_COUNT=0
 		PROGRESS="Progress made with $(($CURRENT_COUNT-$LAST_COUNT)) pages"
 	fi

 	echo Attempt $ATTEMPT: $CURRENT_COUNT pages $PROGRESS
 	LAST_COUNT=$CURRENT_COUNT
 	sleep $SLEEP_INTERVAL
done

echo Final page count: $CURRENT_COUNT
echo $STARTING_COUNT > /proc/sys/vm/nr_hugepages
exit $EXIT_SUCCESS


-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
