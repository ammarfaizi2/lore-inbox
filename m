Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292617AbSB0VSJ>; Wed, 27 Feb 2002 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292958AbSB0VRo>; Wed, 27 Feb 2002 16:17:44 -0500
Received: from host194.steeleye.com ([216.33.1.194]:1541 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292957AbSB0VRY>; Wed, 27 Feb 2002 16:17:24 -0500
Message-Id: <200202272117.g1RLHCB05891@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH 2.5.6-pre2] fix task migration code boot hang
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_12086244520"
Date: Wed, 27 Feb 2002 15:17:12 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_12086244520
Content-Type: text/plain; charset=us-ascii

The task migration code of change set 1.373 actually only works on 
architectures where the physical and logical CPU numberings are the same. It 
they aren't, the boot sequence hangs forever. The attached fixes the code to 
work on all architectures.

James Bottomley


--==_Exmh_12086244520
Content-Type: text/plain ; name="migrate.diff"; charset=us-ascii
Content-Description: migrate.diff
Content-Disposition: attachment; filename="migrate.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.425   -> 1.426  
#	      kernel/sched.c	1.51    -> 1.52   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/27	jejb@malley.hansenpartnership.com	1.426
# Fix new SMP migration thread code (introduced in change set 1.373)
# 
# - make migration_mask a logical bitmap with correct conversions.
# --------------------------------------------
#
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Feb 27 15:04:46 2002
+++ b/kernel/sched.c	Wed Feb 27 15:04:46 2002
@@ -1555,7 +1555,8 @@
 	down(&req.sem);
 }
 
-static volatile unsigned long migration_mask;
+/* NOTE: migration_mask is a bitmap of logical CPUs */
+static volatile unsigned long migration_mask = 0;
 
 static int migration_thread(void * unused)
 {
@@ -1585,7 +1586,8 @@
 
 	for (;;) {
 		preempt_disable();
-		if (test_and_clear_bit(smp_processor_id(), &migration_mask))
+		if (test_and_clear_bit(cpu_number_map(smp_processor_id()),
+				       &migration_mask))
 			current->cpus_allowed = 1 << smp_processor_id();
 		if (test_thread_flag(TIF_NEED_RESCHED))
 			schedule();
@@ -1656,7 +1658,7 @@
 	migration_mask = (1 << smp_num_cpus) - 1;
 
 	for (cpu = 0; cpu < smp_num_cpus; cpu++)
-		while (!cpu_rq(cpu)->migration_thread)
+		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
 			schedule_timeout(2);
 	if (migration_mask)
 		BUG();
This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch1387
M'XL(`(1+?3P``[55VX[;-A!]%K]BB@"%E<0R24F6[<+!-INT#=(DQB;[;-#2
MV%)6(A62MFO`'Y^1O,E>DF+;H)4(4Y?A.3-G#N5'<.G0SH*/^''%'L$?QOE9
MT*BZQD-4U9'SB'2)46X:>GUA#+T>-=K+4;=B]/SU:&<.:H-V**.44<A"^;R$
M'5HW"T04?WWB#RW.@HN7OU_^^>L%8_,YG)=*;_`]>IC/F3=VI^K"G2E?UD9'
MWBKM&O2J8SY^#3U*SB6=J<ABGHZ/8LR3[)B+0@B5""RX3";CA'6YG37;>F/5
M#J.!-AK#;T!D)M)DS"=''O-LREZ`B!(Y!BY'-&0&(IFEXQG/AIQ^.9PP3\H0
MDD/=*NLU%5I6;9<E/!$PY.PY_+>UG+,<?JO^`HU[>/]F`4U%5?G*:/"E155`
M;@J$0:6]-<4VQP(J#7E/`H[$I29D<4@@-(;0J"N\@5@VREV!@MILJES5L*I\
MHUK85[XD6&LQ]S3KKIL4[2+V&E*1"+:X:1X;_LN#,:XX>_:`2E=H-=8CEY=8
M1/EMJ:;Q])AD,I;'=+62L<AD/N9%C-/XX19]'U9FA)S&G#HPX:+WYMVXAPWZ
M(^FRIM(;<X:UQZC<_DUJJ90\%M,CGZ33I/=H*N]:-)W%_)];-(5A_+]8--^2
M7;2O#_?=53EH2ZL<&5.Y6U[+V^VUWR*@[\X>R66$XYIVV5J3HW/&+JMB$)X0
M#JY;1:%OD9"\@37MB6U+FZ"WN2<M06G:#34J2S<$9=;W<W&&XI7O%Q&W`XNM
M1=+)WTZK]_G)"^]@:/?](.,N[MGB!ZS_0J3I!`1[U<^2C1[#VW<?7LZ^(YKZ
MLANIC"_)G2\N'3P>,><I-H>=J6FN$;;:51M-NE`O-_>QYL!_Z8@GU\23CC@(
MJC4,/#J_)-66O6I+(AQ0_4N];59H:74[^+8=X5-:'`1P.GZ^2Q:&Q#1.ISW3
M:0Z"?=GE./BI@[:?>H;K@GH*N@_#X;,;H--W+;SY-R&Y\RNW;>9K*5?K9)6P
)SZ-TOJZW!@``
`
end

--==_Exmh_12086244520--


