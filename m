Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbSJ1RFm>; Mon, 28 Oct 2002 12:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261379AbSJ1RFm>; Mon, 28 Oct 2002 12:05:42 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:47239 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261377AbSJ1RFj>; Mon, 28 Oct 2002 12:05:39 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Date: Mon, 28 Oct 2002 18:11:47 +0100
User-Agent: KMail/1.4.1
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
References: <200210280132.33624.efocht@ess.nec.de> <3129290732.1035737182@[10.10.2.3]>
In-Reply-To: <3129290732.1035737182@[10.10.2.3]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_NRBPC8M3C2STDO6OJYH0"
Message-Id: <200210281811.47708.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_NRBPC8M3C2STDO6OJYH0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 28 October 2002 01:46, Martin J. Bligh wrote:
> Erich, what does all the pool stuff actually buy us over what
> Michael is doing? Seems to be rather more complex, but maybe
> it's useful for something we're just not measuring here?

The more complicated stuff is for achieving equal load between the
nodes. It delays steals more when the stealing node is averagely loaded,
less when it is unloaded. This is the place where we can make it cope
with more complex machines with multiple levels of memory hierarchy
(like our 32 CPU TX7). Equal load among the nodes is important if you
have memory bandwidth eaters, as the bandwidth in a node is limited.

When introducing node affinity (which shows good results for me!) you
also need a more careful ranking of the tasks which are candidates to
be stolen. The routine task_to_steal does this and is another source
of complexity. It is another point where the multilevel stuff comes in.
In the core part of the patch the rank of the steal candidates is compute=
d
by only taking into account the time which a task has slept.

I attach the script for getting some statistics on the numa_test. I=20
consider this test more sensitive to NUMA effects, as it is a bandwidth
eater also needing good latency.
(BTW, Martin: in the numa_test script I've sent you the PROBLEMSIZE must
be set to 1000000!).

Regards,
Erich


>
>               2.5.44-mm4     Virgin
>       2.5.44-mm4-focht-1     Focht main
>       2.5.44-mm4-hbaum-1     Hbaum main
>      2.5.44-mm4-focht-12     Focht main + Focht balance_exec
>       2.5.44-mm4-hbaum-1     Hbaum main + Hbaum balance_exec
>         2.5.44-mm4-f1-h2     Focht main + Hbaum balance_exec
>
> Kernbench:
>                              Elapsed        User      System         CP=
U
>               2.5.44-mm4     19.676s    192.794s     42.678s     1197.4=
%
>       2.5.44-mm4-focht-1      19.46s    189.838s     37.938s       1171=
%
>       2.5.44-mm4-hbaum-1     19.746s    189.232s     38.354s     1152.2=
%
>      2.5.44-mm4-focht-12      20.32s        190s       44.4s     1153.6=
%
>      2.5.44-mm4-hbaum-12     19.322s    190.176s     40.354s     1192.6=
%
>         2.5.44-mm4-f1-h2     19.398s    190.118s      40.06s       1186=
%
>
> Schedbench 4:
>                              Elapsed   TotalUser    TotalSys     AvgUse=
r
>               2.5.44-mm4       32.45       49.47      129.86        0.8=
2
>       2.5.44-mm4-focht-1       38.61       45.15      154.48        1.0=
6
>       2.5.44-mm4-hbaum-1       37.81       46.44      151.26        0.7=
8
>      2.5.44-mm4-focht-12       23.23       38.87       92.99        0.8=
5
>      2.5.44-mm4-hbaum-12       22.26       34.70       89.09        0.7=
0
>         2.5.44-mm4-f1-h2       21.39       35.97       85.57        0.8=
1
>
> Schedbench 8:
>                              Elapsed   TotalUser    TotalSys     AvgUse=
r
>               2.5.44-mm4       39.90       61.48      319.26        2.7=
9
>       2.5.44-mm4-focht-1       37.76       61.09      302.17        2.5=
5
>       2.5.44-mm4-hbaum-1       43.18       56.74      345.54        1.7=
1
>      2.5.44-mm4-focht-12       28.40       34.43      227.25        2.0=
9
>      2.5.44-mm4-hbaum-12       30.71       45.87      245.75        1.4=
3
>         2.5.44-mm4-f1-h2       36.11       45.18      288.98        2.1=
0
>
> Schedbench 16:
>                              Elapsed   TotalUser    TotalSys     AvgUse=
r
>               2.5.44-mm4       62.99       93.59     1008.01        5.1=
1
>       2.5.44-mm4-focht-1       51.69       60.23      827.20        4.9=
5
>       2.5.44-mm4-hbaum-1       52.57       61.54      841.38        3.9=
3
>      2.5.44-mm4-focht-12       51.24       60.86      820.08        4.2=
3
>      2.5.44-mm4-hbaum-12       52.33       62.23      837.46        3.8=
4
>         2.5.44-mm4-f1-h2       51.76       60.15      828.33        5.6=
7
>
> Schedbench 32:
>                              Elapsed   TotalUser    TotalSys     AvgUse=
r
>               2.5.44-mm4       88.13      194.53     2820.54       11.5=
2
>       2.5.44-mm4-focht-1       56.71      123.62     1815.12        7.9=
2
>       2.5.44-mm4-hbaum-1       54.57      153.56     1746.45        9.2=
0
>      2.5.44-mm4-focht-12       55.69      118.85     1782.25        7.2=
8
>      2.5.44-mm4-hbaum-12       54.36      135.30     1739.95        8.0=
9
>         2.5.44-mm4-f1-h2       55.97      119.28     1791.39        7.2=
0
>
> Schedbench 64:
>                              Elapsed   TotalUser    TotalSys     AvgUse=
r
>               2.5.44-mm4      159.92      653.79    10235.93       25.1=
6
>       2.5.44-mm4-focht-1       55.60      232.36     3558.98       17.6=
1
>       2.5.44-mm4-hbaum-1       71.48      361.77     4575.45       18.5=
3
>      2.5.44-mm4-focht-12       56.03      234.45     3586.46       15.7=
6
>      2.5.44-mm4-hbaum-12       56.91      240.89     3642.99       15.6=
7
>         2.5.44-mm4-f1-h2       56.48      246.93     3615.32       16.9=
7

--------------Boundary-00=_NRBPC8M3C2STDO6OJYH0
Content-Type: application/x-shellscript;
  name="numabench"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="numabench"

#!/bin/bash
#
# run multiple times numa_test, collect data and print statistical information
# Usage:   runtests NJOBS NTIMES
#
if [ $# -ne 2 ] ; then
	echo "Please supply the number of parallel jobs and tests to run!"
	exit 1
fi
export PATH=.:$PATH
NJOBS=$1
NTESTS=$2

OUT=numatsts_$$
[[ -f $OUT ]] && rm -f $OUT

export PATH=$PATH:`pwd`

Average() {
   awk 'BEGIN { n=0; sum=0; sum2=0;};
        {n=n+1; sum=sum+$1; sum2=sum2+($1*$1);};
        END {avg=sum/n; std=sqrt(sum2/n-(avg*avg));
             printf("%.4f %.4f\n",avg,std); }'
}

n=0
while [ $n -lt $NTESTS ]; do
   n=`expr $n + 1`
   echo -n "$n "
   numa_test $NJOBS >> $OUT 2>&1
done
echo

VARS="AverageUserTime ElapsedTime TotalUserTime TotalSysTime"
echo "numa_test $NJOBS   avg time +- stddev"
for name in $VARS ; do
   printf "%15s  %7.2f(%.2f)\n" $name `grep $name <$OUT| awk '{print $2}'| Average`
done


--------------Boundary-00=_NRBPC8M3C2STDO6OJYH0--

