Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262165AbSJFUUl>; Sun, 6 Oct 2002 16:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262172AbSJFUUl>; Sun, 6 Oct 2002 16:20:41 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:48370 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262165AbSJFUUd>; Sun, 6 Oct 2002 16:20:33 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [RFC] NUMA schedulers benchmark results
Date: Sun, 6 Oct 2002 22:24:50 +0200
User-Agent: KMail/1.4.1
Cc: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
References: <200210061851.45401.efocht@ess.nec.de>
In-Reply-To: <200210061851.45401.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_E1UK3PA0I7Z0PUS1610T"
Message-Id: <200210062224.50087.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_E1UK3PA0I7Z0PUS1610T
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

here comes the benchmark I used for the NUMA scheduler test. Would
be interesting to know whether it is useful to any other NUMA
developer...

Regards,
Erich

PS: it uses a 'time' command that understands the --format option,
e.g. GNU time 1.7. Change it in the main script, if it doesn't
work for you.


On Sunday 06 October 2002 18:51, Erich Focht wrote:
> Hi,
>
> here are some results from testing various versions and approaches
> to a NUMA scheduler. I used the numa_test benchmark which I'll post
> in a separate email. It runs in parallel N tasks doing the same job:
> access randomly a large array. As the array is large enough not to
> fit into cache, this is very memory latency sensitive. Also it is
> memory bandwidth sensitive. To emulate a real multi-user environment, t=
he
> jobs are disturbed by a short load peak. This is simulated by a call
> to "hackbench" 3 seconds after the tasks were started. The performance
> of the user tasks is depending very much on where they are scheduled
> and are CPU hoggers such that the user times are quite independent of
> the non-scheduler part of the underlying kernel. The elapsed times
> are depending on "hackbench" which actually blocks the machine for the
> time it is running. Hackbench is depending on the underlying kernel
> and one should compare "elapsed_time - hackbench_time".
>
> The test machine is a 16 CPU NEC Azusa with Itanium processors and
> four nodes. The tested schedulers are:
>
> A: O(1) scheduler in 2.5.39
> B: O(1) scheduler with task steal limited to only one task (node
>    affine scheduler with CONFIG_NUMA_SCHED=3Dn) under 2.4.18
> C: Michael Hohnbaum's "simple NUMA scheduler" under 2.5.39
> D: pooling NUMA scheduler, no initial load balancing, idle pool_delay
>    set to 0, under 2.4.18
> E: node affine scheduler with initial load balancing and static homenod=
e
> F: node affine scheduler without initial load balancing and dynamic
>    homenode selection (homenode selected where most of the memory is
>    allocated).
>
> As I'm rewriting the node affine scheduler to be more modular, I'll
> redo the tests for cases D, E, F on top of 2.5.X kernels soon.
>
> The results are summarized in the tables below. A set of outputs (for
> N=3D8, 16, 32) is attached. They show clearly why the node affine
> scheduler beats them all: The initial load balancing is node-aware,
> the task-stealing too. Sometimes the node affine force is not large
> enough to bring the task back to the homenode, but it is almost always
> good enough.
>
> The (F) solution with dynamically determined homenode show that the
> initial load balancing is crucial, as the equal node balance is not
> strongly enforced dynamically. So the optimal solution is probably
> (F) with initial load balancing.
>
>
> Average user time (U) and total user time (TU). Minimum per row should
> be considered.
> ----------------------------------------------------------------------
> Scheduler:=09A=09B=09C=09D=09E=09F
> N=3D4=09U=0928.12=0930.77=0933.00=09-=0927.20=0930.29
> =09TU=09112.55=09123.13=09132.08=09-=09108.88=09121.25
> N=3D8=09U=0930.47=0931.39=0931.65=0930.76=0928.67=0930.08
> =09TU=09243.86=09251.27=09253.30=09246.23=09229.51=09240.75
> N=3D16=09U=0936.42=0933.64=0932.18=0932.27=0931.50=0932.83
> =09TU=09582.91=09538.49=09515.11=09516.53=09504.17=09525.59
> N=3D32=09U=0938.69=0934.83=0934.05=0933.76=0933.89=0934.11
> =09TU=091238.4=091114.9=091090.1=091080.8=091084.9=091091.9
> N=3D64=09U=0939.73=0934.73=0934.23=09-=09(33.32)=0934.98
> =09TU=092543.4=092223.4=092191.7=09-=09(2133)=092239.5
>
>
> Elapsed time (E), hackbench time (H). Diferences between 2.4.18 and
> 2.5.39 based kernels due to "hackbench", which performs differently.
> Compare E-H within a row, but don't take it too seriously.
> --------------------------------------------------------------------
> Scheduler:=09A=09B=09C=09D=09E=09F
> N=3D4=09E=0937.33=0937.96=0948.31=09-=0928.14=0935.91
> =09H=099.98=091.49=0910.65=09-=091.99=091.43
> N=3D8=09E=0946.17=0939.50=0942.53=0939.72=0930.28=0938.28
> =09H=099.64=091.86=097.27=092.07=092.33=091.86
> N=3D16=09E=0947.21=0944.67=0949.66=0942.97=0936.98=0942.51
> =09H=095.90=094.69=092.93=095.178=095.56=095.94
> N=3D32=09E=0988.60=0979.92=0980.34=0978.35=0976.84=0977.38
> =09H=096.29=095.23=092.85=094.51=095.29=094.28
> N=3D64=09E=09167.10=09147.16=09150.59=09-=09(133.9)=09148.94
> =09H=095.96=094.67=093.10=09-=09(-)=096.86
>
> (The E:N=3D64 results are without hackbench disturbance.)
>
> Best regards,
> Erich

--------------Boundary-00=_E1UK3PA0I7Z0PUS1610T
Content-Type: application/x-shellscript;
  name="numa_test"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="numa_test"

#!/bin/bash
#
# Small synthetic benchmark sensitive to both memory
# access latency and memory bandwidth. The perl script
# starts NTASKS processes in parallel which access their
# memory following a random pattern.
#
# This benchmark is thought as test for the capability of
# ccNUMA platforms to provide minimum memory access latency
# and maximize the memory bandwidth available for the
# processes in parallel. The table printed after all NTASKS
# processes finished to run shows the percentage of time
# spent by the "jobs" on each node. It also outputs the
# node on which the job was initially scheduled and the node on
# which the job spent most of its time (iSched, MSched). If
# these are different, an asterisc is printed.
# Ideally most of the time should be spent on the node where the
# memory is allocated.
#
# Copyright 2001, Erich Focht <efocht@ess.nec.de>
#

if [ $# != "1" ]; then
  echo "$#"
  echo "Usage: $0 NTASKS"
  exit 1
fi

NTASKS=$1
PROBLEMSIZE=1000000
tmpdir=numatst_$$

####################
if [ ! -f cpu_to_node ]; then
  echo "Please create a file called cpu_to_node in the current directory!"
  echo "It must contain the node numbers for each logical CPU in the system,"
  echo "separated by blanks. For example: 4 nodes of 4 cpus each could"
  echo "look like:"
  echo "echo \"0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3\" >cpu_to_node"
  exit 1
fi
mkdir $tmpdir || { echo "Could not create run directory!"; exit 1; }
cd $tmpdir
cp ../cpu_to_node .

uudecode << 'UUU_EOF'
begin 644 randupdt.c.bz2
M0EIH.3%!629360C0)^0``53?@%`P>_W]7S^GWDZ__]_Z4`/[SMF.ZZ;.G36D
M)321HIY#(4PRF]%/T-3349J::-#!`/4!I@T1&`E&]#4T"::9`::`T``#0T`-
M3T*8*FAZF91IZ0]0``&@``!H&APTTR,1A-,!#`)IA&"8F0TR-#0"4U!!/4T-
M-,2/4GIIJ,FF&D``:&FF3(R,`'-<L`&,#23&51`*T0D@N!`>UC*J$HXL6,'C
MA(:\M2/#W.[HS9*F<5(R-&HF`:*`&BPU:&*7CF`+MAT["6R&'3TJ*+%B`SQZ
MGCOYL.85D>6:"S,#J-6GR3HRN'K-=),D_.K:U(55MWWP8/;`_$Q$'S)9^51B
M9U)C$4$*!B>RNR)O)E@M5XA<E"-!,!=90\I9:)\T)E;51.>'EHK:ZD;2\Z!]
M1(KE_:AX3A,"WQMM();@B+()C`'%!3:^1DLXK8TURD1QQK1@G0%(0&SLP33S
MK%JTIXPSQBB[D9W9_BL7[H;'F%01I-E@5%B'5M2EJ]D)F4Z$M4Q;O`P1F"<1
MDHP(AR'K`E1NG<T3U:2E4:66.:IWU%TENMBP#+2^EU2AGS3)$RA'6IH<,&.Z
M7'F:FX]U^_@-\ATEV>NM-!G7[>TAKMK[?/).ZC":2=HO,1,^U38*A37GJ!F%
MPU+K*3`B\F^]L-KU=`B^<%4P@DQZI:[Q(-Q(NJO31)X=<R,<"BH?DGET!^?Q
M1FSON.3F.H3=9%OBR[S]D3L'-$AM.MQO#Y%/)V+M'D1.[6B;:/#C25N46A.A
MV'^>K4EGM..[1R[9,,QK1%W;46_T[0\R/AZOB<V>WI]'4B'Z4YDO?;"B8Z$8
M"R!V>QB6I0Z(4LPO6Q*I/P$3DRDIYZ@F6P"9HCUUHYG2\^YO144-0M[0,D&@
M/O,8??U'YTT/,"T4]XL8_N@^'*.*";"9Y.?XO#,'>3M)(6ZZRG&^3:M3#RC3
M6[H5:TDTZ&7BQ"22P!CFII6*)/"QA)010K\G$!?QO)$)P8#!M15(T#196%[/
M+I(P$YBLU#QY-[,1Q&\!N&PO(I)))L@6-OY:'MPUFA?D'L.\7;A)JG.+!VT"
M>Z6@L13O&);*7T8Z1:0D;(29)B0W/@8+&R=1"J&FC-0<.*XF"%CRA[5/,]TB
M^;S"XF7!`6LSHT8@Q-.V\-@[AZN![4DA-23^+#VAI)CG$/"$XYD(AR6[I/PQ
MYR@,@5"$XEO;`*(B,(N5S5R!CPO@,*]F`8Y99">8<9<K0)C%6:["G%SH-@I#
MS4!=.A%PF'&5L^%+^,EH.`6FS+.1&[IV"[$Y3?:*P,NNYVF4$.OE3P$QOFFV
M.81?25$]LUAK.!<N-LB2UX$L1"(@3,]GJS+%CKCJ@ZDG=206;%2:0-!OAQ@.
GAFI-K2=S&@=F6O)%F196C#AJB&QMYDKS)-E=A>0NY(IPH2`1H$_(
`
end
UUU_EOF
bzip2 -d randupdt.c.bz2
gcc -O3 -o randupdt randupdt.c

############################
cat >print_hz.c <<EOF
#include <asm/param.h>
int main(){ printf("%d\n",HZ);}
EOF
gcc -o print_hz print_hz.c

############################
uudecode << 'UUU_EOF'
begin 644 hackbench.c.bz2
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
(%.%"0R'#6X``
`
end
UUU_EOF
bzip2 -d hackbench.c.bz2
gcc -o hackbench hackbench.c

############################
uudecode << 'UUU_EOF'
begin 755 dispatch.bz2
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
5#;,R^$S+27N@_XNY(IPH2'K1?#<`
`
end
UUU_EOF
bzip2 -d dispatch.bz2
chmod +x dispatch

################
# Run the tests!
################
# requires GNU time 1.7 or higher.
#---------------------------------
'time' --format="ElapsedTime     %e\nTotalUserTime   %U\nTotalSysTime    %S\n" \
   ./dispatch $NTASKS ./randupdt $PROBLEMSIZE

cd ..
rm -rf $tmpdir

--------------Boundary-00=_E1UK3PA0I7Z0PUS1610T--

