Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTANKrH>; Tue, 14 Jan 2003 05:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbTANKrH>; Tue, 14 Jan 2003 05:47:07 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:63733 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262201AbTANKrE> convert rfc822-to-8bit; Tue, 14 Jan 2003 05:47:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: NUMA scheduler 2nd approach
Date: Tue, 14 Jan 2003 11:56:17 +0100
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301130055.28005.efocht@ess.nec.de> <1042507438.24867.153.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1042507438.24867.153.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301141156.17603.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

thanks for the many experiments, they help giving some more
insight. It's quite clear that we'll have to tune the knobs a bit to
make this fit well.

At first a comment on the "target" of the tuning:

>  26     0.0    0.0  100.0    0.0 |    2     2    |  56.28
>  27    15.3    0.0    0.0   84.7 |    3     3    |  57.12
>  28   100.0    0.0    0.0    0.0 |    0     0    |  53.85
>  29    32.7   67.2    0.0    0.0 |    0     1   *|  62.66
>  30   100.0    0.0    0.0    0.0 |    0     0    |  53.86
>  31   100.0    0.0    0.0    0.0 |    0     0    |  53.94
>  32   100.0    0.0    0.0    0.0 |    0     0    |  55.36
> AverageUserTime 56.38 seconds
> ElapsedTime     124.09
> TotalUserTime   1804.67
> TotalSysTime    7.71
>
> Ideally, there would be nothing but 100.0 in all non-zero entries.
> I'll try adding in the 05 patch, and if that does not help, will
> try a few other adjustments.

The numa_test is written such that you MUST get numbers below 100%
with this kind of scheduler! There is a "disturbing" process started 3
seconds after the parallel tasks are up and running which has the aim
to "shake" the system a bit and the scheduler ends up with  some of
the parallel tasks moved away from their homenode. This is a
reallistic situation for long running parallel background jobs. In the
min-sched case this cannot happen, therefore you see the 100% all
over!

Increasing more and more the barrier for moving a task apart from it's
node won't necessarilly help the scheduler as we end up with the
min-sched limitations. The aim will be to introduce node affinity for
processes such that they can return to their homenode when the
exceptional load situation is gone. We should not try to reach the
min-sched numbers without having node-affine tasks.


> * Make the check in find_busiest_node into a macro that is defined
>   in the arch specific topology header file.  Then different NUMA
>   architectures can tune this appropriately.

I still think that the load balancing condition should be clear
and the same for every architecture. But tunable. I understand that
the constant added helps but I don't have a clear motivation for it.
We could keep the imbalance ratio as a condition for searching the
maximum:
> +  if (load > maxload && (4*load > ((5*4*this_load)/4))) {
(with tunable barrier height: say replace 5/4 by 11/8 or similar, i.e.
  (8*load > ((11*8*this_load)/8))
)
and rule out any special unwanted cases after the loop. These would be
cases where it is obvious that we don't have to steal anything, like:
load of remote node is <= number of cpus in remote node.

For making this tunable I suggest something like:
#define CROSS_NODE_BAL 125
   (100*load > ((CROSS_NODE_BAL*100*this_load)/100))
and let platforms define their own value. Using 100 makes it easy to
understand.

> * In find_busiest_queue change:
>
> 	cpumask |= __node_to_cpu_mask(node);
>   to:
> 	cpumask = __node_to_cpu_mask(node) | (1UL << (this_cpu));
>
>
>   There is no reason to iterate over the runqueues on the current
>   node, which is what the code currently does.

Here I thought I'd give the load balancer the chance to balance
internally just in case the own node's load jumped up in the mean
time. But this should ideally be caught by find_busiest_node(),
therefore I agree with your change.


> Some numbers for anyone interested:Kernbench:
>
> All numbers are based on a 2.5.55 kernel with the cputime stats patch:
>   * stock55 = no additional patches
>   * mini+rebal-44 = patches 01, 02, and 03
>   * rebal+4+fix = patches 01, 02, 03, and the cpumask change described
>     above, and a +4 constant added to the check in find_busiest_node
>   * rebal+4+fix+04 = above with the 04 patch added
>
>                         Elapsed       User     System        CPU
>    rebal+4+fix+04-55    29.302s   285.136s    82.106s      1253%
>       rebal+4+fix-55    30.498s   286.586s    88.176s    1228.6%
>        mini+rebal-55    30.756s   287.646s    85.512s    1212.8%
>              stock55    31.018s   303.084s    86.626s    1256.2%

The first line is VERY good!

The results below (for Schedbench) are not really meaningful without
statistics... But the combination rebal+4+fix+04-55 is the clear
winner for me. Still, I'd be curious to know the rebal+fix+04-55
numbers ;-)

> Schedbench 4:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>    rebal+4+fix+04-55      27.34      40.49     109.39       0.88
>       rebal+4+fix-55      24.73      38.50      98.94       0.84
>        mini+rebal-55      25.18      43.23     100.76       0.68
>              stock55      31.38      41.55     125.54       1.24
>
> Schedbench 8:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>    rebal+4+fix+04-55      30.05      44.15     240.48       2.50
>       rebal+4+fix-55      34.33      46.40     274.73       2.31
>        mini+rebal-55      32.99      52.42     264.00       2.08
>              stock55      44.63      61.28     357.11       2.22
>
> Schedbench 16:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>    rebal+4+fix+04-55      52.13      57.68     834.23       3.55
>       rebal+4+fix-55      52.72      65.16     843.70       4.55
>        mini+rebal-55      57.29      71.51     916.84       5.10
>              stock55      66.91      85.08    1070.72       6.05
>
> Schedbench 32:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>    rebal+4+fix+04-55      56.38     124.09    1804.67       7.71
>       rebal+4+fix-55      55.13     115.18    1764.46       8.86
>        mini+rebal-55      57.83     125.80    1850.84      10.19
>              stock55      80.38     181.80    2572.70      13.22
>
> Schedbench 64:
>                         AvgUser    Elapsed  TotalUser   TotalSys
>    rebal+4+fix+04-55      57.42     238.32    3675.77      17.68
>       rebal+4+fix-55      60.06     252.96    3844.62      18.88
>        mini+rebal-55      58.15     245.30    3722.38      19.64
>              stock55     123.96     513.66    7934.07      26.39
>
>
> And here is the results from running numa_test 32 on rebal+4+fix+04:
>
> Executing 32 times: ./randupdt 1000000
> Running 'hackbench 20' in the background: Time: 8.383
> Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
>   1   100.0    0.0    0.0    0.0 |    0     0    |  56.19
>   2   100.0    0.0    0.0    0.0 |    0     0    |  53.80
>   3     0.0    0.0  100.0    0.0 |    2     2    |  55.61
>   4   100.0    0.0    0.0    0.0 |    0     0    |  54.13
>   5     3.7    0.0    0.0   96.3 |    3     3    |  56.48
>   6     0.0    0.0  100.0    0.0 |    2     2    |  55.11
>   7     0.0    0.0  100.0    0.0 |    2     2    |  55.94
>   8     0.0    0.0  100.0    0.0 |    2     2    |  55.69
>   9    80.6   19.4    0.0    0.0 |    1     0   *|  56.53
>  10     0.0    0.0    0.0  100.0 |    3     3    |  53.00
>  11     0.0   99.2    0.0    0.8 |    1     1    |  56.72
>  12     0.0    0.0    0.0  100.0 |    3     3    |  54.58
>  13     0.0  100.0    0.0    0.0 |    1     1    |  59.38
>  14     0.0   55.6    0.0   44.4 |    3     1   *|  63.06
>  15     0.0  100.0    0.0    0.0 |    1     1    |  56.02
>  16     0.0   19.2    0.0   80.8 |    1     3   *|  58.07
>  17     0.0  100.0    0.0    0.0 |    1     1    |  53.78
>  18     0.0    0.0  100.0    0.0 |    2     2    |  55.28
>  19     0.0   78.6    0.0   21.4 |    3     1   *|  63.20
>  20     0.0  100.0    0.0    0.0 |    1     1    |  53.27
>  21     0.0    0.0  100.0    0.0 |    2     2    |  55.79
>  22     0.0    0.0    0.0  100.0 |    3     3    |  57.23
>  23    12.4   19.1    0.0   68.5 |    1     3   *|  61.05
>  24     0.0    0.0  100.0    0.0 |    2     2    |  54.50
>  25     0.0    0.0    0.0  100.0 |    3     3    |  56.82
>  26     0.0    0.0  100.0    0.0 |    2     2    |  56.28
>  27    15.3    0.0    0.0   84.7 |    3     3    |  57.12
>  28   100.0    0.0    0.0    0.0 |    0     0    |  53.85
>  29    32.7   67.2    0.0    0.0 |    0     1   *|  62.66
>  30   100.0    0.0    0.0    0.0 |    0     0    |  53.86
>  31   100.0    0.0    0.0    0.0 |    0     0    |  53.94
>  32   100.0    0.0    0.0    0.0 |    0     0    |  55.36
> AverageUserTime 56.38 seconds
> ElapsedTime     124.09
> TotalUserTime   1804.67
> TotalSysTime    7.71
>
> Ideally, there would be nothing but 100.0 in all non-zero entries.
> I'll try adding in the 05 patch, and if that does not help, will
> try a few other adjustments.
>
> Thanks for the quick effort on putting together the node rebalance
> code.  I'll also get some hackbench numbers soon.

Best regards,

Erich

