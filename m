Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUGXAEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUGXAEe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 20:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268190AbUGXAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 20:04:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12946 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264640AbUGXAD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 20:03:59 -0400
Date: Fri, 23 Jul 2004 17:03:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: bh_lru_install
Message-Id: <20040723170338.0c9a38ef.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__23_Jul_2004_17_03_38_-0700_+.JmKg9q56X5VDsq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__23_Jul_2004_17_03_38_-0700_+.JmKg9q56X5VDsq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


So I was doing some profiling of memcpy() calls to try and tune
the UltraSPARC-III memcpy a little more, and you wouldn't believe
what was at the top of the list during a kernel build :-)

It's bh_lru_install.  On a 64-bit system every time the local
cpu's lru->bh[0] doesn't match 'bh' we do a 64-byte memcpy()
from the stack into the lru->bh[] array.

It shouldn't be too hard to make the code just work without
an on-stack copy, shuffling the lru->bh[] array entries
directly.

For the curious, attached is profiling output after a full kernel
build on this box.  I basically rigged it such that the per-cpu
timer profiling stuff didn't touch prof_buffer, and every
memcpy() call recorded __builtin_return_address(0).  It also
keeps alignment and length distribution information accessible
via proc.  Example dumps and that debugging patch are attached
too.

--Multipart=_Fri__23_Jul_2004_17_03_38_-0700_+.JmKg9q56X5VDsq
Content-Type: text/plain;
 name="memcpy_stats.diff"
Content-Disposition: attachment;
 filename="memcpy_stats.diff"
Content-Transfer-Encoding: 7bit

===== arch/sparc64/kernel/setup.c 1.54 vs edited =====
--- 1.54/arch/sparc64/kernel/setup.c	2004-06-27 00:19:38 -07:00
+++ edited/arch/sparc64/kernel/setup.c	2004-07-23 15:58:47 -07:00
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/initrd.h>
+#include <linux/profile.h>
 
 #include <asm/segment.h>
 #include <asm/system.h>
@@ -714,3 +715,80 @@
 }
 
 subsys_initcall(topology_init);
+
+static u64 memcpy_lens[256 + 1];
+static u64 src_align[64];
+static u64 dst_align[64];
+
+extern __kernel_size_t __real_memcpy(void *, const void *, __kernel_size_t);
+
+__kernel_size_t __memcpy(void *dst, const void *src, __kernel_size_t len)
+{
+	memcpy_lens[(len <= 256) ? len : 256]++;
+	src_align[((long)src) & 63]++;
+	dst_align[((long)dst) & 63]++;
+
+	if (prof_buffer) {
+		unsigned long pc;
+
+		pc = (unsigned long) __builtin_return_address(0);
+		pc -= (unsigned long) _stext;
+		pc >>= prof_shift;
+		if (pc >= prof_len)
+			pc = prof_len - 1;
+		atomic_inc((atomic_t *)&prof_buffer[pc]);
+	}
+
+	return __real_memcpy(dst, src, len);
+}
+
+static int show_memcpy_lens(struct seq_file *m, void *__unused)
+{
+	int i;
+
+	for (i = 0; i <= 256; i++)
+		seq_printf(m, "[%3d]: %lu\n", i, memcpy_lens[i]);
+
+	return 0;
+}
+
+struct seq_operations memcpy_lens_op = {
+	.start =c_start,
+	.next =	c_next,
+	.stop =	c_stop,
+	.show =	show_memcpy_lens,
+};
+
+static int show_memcpy_src_align(struct seq_file *m, void *__unused)
+{
+	int i;
+
+	for (i = 0; i < 64; i++)
+		seq_printf(m, "[%2d]: %lu\n", i, src_align[i]);
+
+	return 0;
+}
+
+struct seq_operations src_align_op = {
+	.start =c_start,
+	.next =	c_next,
+	.stop =	c_stop,
+	.show =	show_memcpy_src_align,
+};
+
+static int show_memcpy_dst_align(struct seq_file *m, void *__unused)
+{
+	int i;
+
+	for (i = 0; i < 64; i++)
+		seq_printf(m, "[%2d]: %lu\n", i, dst_align[i]);
+
+	return 0;
+}
+
+struct seq_operations dst_align_op = {
+	.start =c_start,
+	.next =	c_next,
+	.stop =	c_stop,
+	.show =	show_memcpy_dst_align,
+};
===== arch/sparc64/kernel/time.c 1.53 vs edited =====
--- 1.53/arch/sparc64/kernel/time.c	2004-05-07 07:17:21 -07:00
+++ edited/arch/sparc64/kernel/time.c	2004-07-23 15:09:34 -07:00
@@ -443,11 +443,12 @@
 
 void sparc64_do_profile(struct pt_regs *regs)
 {
+#if 0
 	unsigned long pc = regs->tpc;
 	unsigned long o7 = regs->u_regs[UREG_RETPC];
-
+#endif
 	profile_hook(regs);
-
+#if 0
 	if (user_mode(regs))
 		return;
 
@@ -480,6 +481,7 @@
 			pc = prof_len - 1;
 		atomic_inc((atomic_t *)&prof_buffer[pc]);
 	}
+#endif
 }
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
===== arch/sparc64/lib/VIScopy.S 1.6 vs edited =====
--- 1.6/arch/sparc64/lib/VIScopy.S	2004-02-10 21:34:37 -08:00
+++ edited/arch/sparc64/lib/VIScopy.S	2004-07-23 15:05:25 -07:00
@@ -306,11 +306,11 @@
 		.globl			__memcpy_begin
 __memcpy_begin:
 
-		.globl			__memcpy
-		.type			__memcpy,@function
+		.globl			__real_memcpy
+		.type			__real_memcpy,@function
 
 memcpy_private:
-__memcpy:
+__real_memcpy:
 memcpy:		mov		ASI_P, asi_src			! IEU0	Group
 		brnz,pt		%o2, __memcpy_entry		! CTI
 		 mov		ASI_P, asi_dest			! IEU1
===== fs/proc/proc_misc.c 1.103 vs edited =====
--- 1.103/fs/proc/proc_misc.c	2004-06-24 01:55:46 -07:00
+++ edited/fs/proc/proc_misc.c	2004-07-23 15:05:25 -07:00
@@ -270,6 +270,42 @@
 	.release	= seq_release,
 };
 
+extern struct seq_operations memcpy_lens_op;
+static int memcpy_lens_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &memcpy_lens_op);
+}
+static struct file_operations proc_memcpy_lens_operations = {
+	.open		= memcpy_lens_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+extern struct seq_operations src_align_op;
+static int src_align_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &src_align_op);
+}
+static struct file_operations proc_src_align_operations = {
+	.open		= src_align_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+extern struct seq_operations dst_align_op;
+static int dst_align_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &dst_align_op);
+}
+static struct file_operations proc_dst_align_operations = {
+	.open		= dst_align_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 extern struct seq_operations vmstat_op;
 static int vmstat_open(struct inode *inode, struct file *file)
 {
@@ -671,6 +707,9 @@
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+	create_seq_entry("memcpy_lens", 0, &proc_memcpy_lens_operations);
+	create_seq_entry("src_align", 0, &proc_src_align_operations);
+	create_seq_entry("dst_align", 0, &proc_dst_align_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);

--Multipart=_Fri__23_Jul_2004_17_03_38_-0700_+.JmKg9q56X5VDsq
Content-Type: text/plain;
 name="memcpy_lens.txt"
Content-Disposition: attachment;
 filename="memcpy_lens.txt"
Content-Transfer-Encoding: 7bit

[  0]: 14327
[  1]: 9635
[  2]: 985
[  3]: 1457
[  4]: 3597
[  5]: 3239
[  6]: 6793
[  7]: 18824
[  8]: 74059
[  9]: 5082
[ 10]: 34084
[ 11]: 5275
[ 12]: 5593
[ 13]: 5262
[ 14]: 4803
[ 15]: 4873
[ 16]: 13796
[ 17]: 2949
[ 18]: 2468
[ 19]: 1833
[ 20]: 1438
[ 21]: 991
[ 22]: 788
[ 23]: 561
[ 24]: 493
[ 25]: 381
[ 26]: 391
[ 27]: 399
[ 28]: 611
[ 29]: 541
[ 30]: 669
[ 31]: 764
[ 32]: 989
[ 33]: 573
[ 34]: 401
[ 35]: 356
[ 36]: 310
[ 37]: 261
[ 38]: 244
[ 39]: 210
[ 40]: 239
[ 41]: 176
[ 42]: 153
[ 43]: 140
[ 44]: 97
[ 45]: 111
[ 46]: 85
[ 47]: 73
[ 48]: 53421
[ 49]: 50
[ 50]: 20
[ 51]: 32
[ 52]: 22
[ 53]: 11
[ 54]: 8
[ 55]: 6
[ 56]: 217
[ 57]: 7
[ 58]: 8
[ 59]: 2
[ 60]: 27
[ 61]: 5
[ 62]: 1
[ 63]: 6
[ 64]: 347173
[ 65]: 4
[ 66]: 15
[ 67]: 3
[ 68]: 0
[ 69]: 3
[ 70]: 4905
[ 71]: 2
[ 72]: 8
[ 73]: 2
[ 74]: 5
[ 75]: 2
[ 76]: 1
[ 77]: 1
[ 78]: 17
[ 79]: 1
[ 80]: 132
[ 81]: 0
[ 82]: 0
[ 83]: 0
[ 84]: 0
[ 85]: 0
[ 86]: 2
[ 87]: 0
[ 88]: 3
[ 89]: 0
[ 90]: 0
[ 91]: 0
[ 92]: 0
[ 93]: 0
[ 94]: 2
[ 95]: 0
[ 96]: 748
[ 97]: 0
[ 98]: 0
[ 99]: 0
[100]: 0
[101]: 0
[102]: 1
[103]: 0
[104]: 87
[105]: 0
[106]: 0
[107]: 0
[108]: 0
[109]: 0
[110]: 0
[111]: 0
[112]: 4
[113]: 2
[114]: 1
[115]: 0
[116]: 0
[117]: 0
[118]: 468
[119]: 0
[120]: 76
[121]: 0
[122]: 0
[123]: 0
[124]: 0
[125]: 0
[126]: 0
[127]: 0
[128]: 29
[129]: 0
[130]: 0
[131]: 0
[132]: 0
[133]: 0
[134]: 5
[135]: 0
[136]: 0
[137]: 0
[138]: 0
[139]: 0
[140]: 0
[141]: 0
[142]: 0
[143]: 3
[144]: 5
[145]: 0
[146]: 1
[147]: 0
[148]: 0
[149]: 3
[150]: 5
[151]: 0
[152]: 4
[153]: 0
[154]: 0
[155]: 0
[156]: 0
[157]: 0
[158]: 0
[159]: 0
[160]: 39
[161]: 0
[162]: 0
[163]: 0
[164]: 0
[165]: 0
[166]: 2
[167]: 0
[168]: 6
[169]: 0
[170]: 0
[171]: 1
[172]: 0
[173]: 0
[174]: 0
[175]: 0
[176]: 5
[177]: 0
[178]: 2
[179]: 0
[180]: 0
[181]: 0
[182]: 0
[183]: 0
[184]: 0
[185]: 0
[186]: 0
[187]: 0
[188]: 1
[189]: 0
[190]: 0
[191]: 0
[192]: 293
[193]: 0
[194]: 0
[195]: 0
[196]: 0
[197]: 0
[198]: 1
[199]: 0
[200]: 0
[201]: 0
[202]: 0
[203]: 2
[204]: 0
[205]: 0
[206]: 0
[207]: 0
[208]: 1
[209]: 0
[210]: 0
[211]: 0
[212]: 0
[213]: 0
[214]: 2
[215]: 0
[216]: 800
[217]: 0
[218]: 0
[219]: 0
[220]: 0
[221]: 0
[222]: 1
[223]: 0
[224]: 0
[225]: 0
[226]: 0
[227]: 0
[228]: 0
[229]: 0
[230]: 0
[231]: 0
[232]: 287
[233]: 0
[234]: 0
[235]: 0
[236]: 0
[237]: 0
[238]: 0
[239]: 0
[240]: 172
[241]: 0
[242]: 0
[243]: 0
[244]: 0
[245]: 0
[246]: 0
[247]: 0
[248]: 1
[249]: 0
[250]: 0
[251]: 0
[252]: 0
[253]: 0
[254]: 0
[255]: 0
[256]: 109129

--Multipart=_Fri__23_Jul_2004_17_03_38_-0700_+.JmKg9q56X5VDsq
Content-Type: text/plain;
 name="src_align.txt"
Content-Disposition: attachment;
 filename="src_align.txt"
Content-Transfer-Encoding: 7bit

[ 0]: 133126
[ 1]: 410
[ 2]: 5616
[ 3]: 502
[ 4]: 370
[ 5]: 425
[ 6]: 12269
[ 7]: 1461
[ 8]: 25298
[ 9]: 1274
[10]: 698
[11]: 948
[12]: 1568
[13]: 1072
[14]: 2402
[15]: 1153
[16]: 187582
[17]: 1911
[18]: 5353
[19]: 3508
[20]: 2431
[21]: 2084
[22]: 1139
[23]: 970
[24]: 6759
[25]: 983
[26]: 791
[27]: 804
[28]: 1136
[29]: 732
[30]: 668
[31]: 625
[32]: 108013
[33]: 511
[34]: 431
[35]: 344
[36]: 346
[37]: 326
[38]: 286
[39]: 241
[40]: 37509
[41]: 9326
[42]: 252
[43]: 217
[44]: 164
[45]: 125
[46]: 117
[47]: 112
[48]: 177770
[49]: 173
[50]: 65
[51]: 72
[52]: 61
[53]: 33
[54]: 19
[55]: 9
[56]: 7211
[57]: 8
[58]: 31
[59]: 8
[60]: 21
[61]: 5
[62]: 3
[63]: 37

--Multipart=_Fri__23_Jul_2004_17_03_38_-0700_+.JmKg9q56X5VDsq
Content-Type: text/plain;
 name="dst_align.txt"
Content-Disposition: attachment;
 filename="dst_align.txt"
Content-Transfer-Encoding: 7bit

[ 0]: 57697
[ 1]: 481
[ 2]: 492
[ 3]: 414
[ 4]: 2022
[ 5]: 436
[ 6]: 439
[ 7]: 458
[ 8]: 31460
[ 9]: 445
[10]: 403
[11]: 431
[12]: 6565
[13]: 428
[14]: 532
[15]: 445
[16]: 54026
[17]: 477
[18]: 2681
[19]: 480
[20]: 26670
[21]: 771
[22]: 449
[23]: 440
[24]: 359729
[25]: 482
[26]: 461
[27]: 462
[28]: 1618
[29]: 483
[30]: 518
[31]: 498
[32]: 65700
[33]: 443
[34]: 507
[35]: 422
[36]: 1585
[37]: 413
[38]: 417
[39]: 478
[40]: 33925
[41]: 486
[42]: 463
[43]: 468
[44]: 1721
[45]: 1011
[46]: 434
[47]: 408
[48]: 59710
[49]: 406
[50]: 3858
[51]: 1063
[52]: 1659
[53]: 489
[54]: 1022
[55]: 482
[56]: 14815
[57]: 449
[58]: 447
[59]: 466
[60]: 1625
[61]: 490
[62]: 482
[63]: 450

--Multipart=_Fri__23_Jul_2004_17_03_38_-0700_+.JmKg9q56X5VDsq--
