Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264350AbTH1TDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbTH1TDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:03:47 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:62983 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264350AbTH1TDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:03:36 -0400
Subject: [PATCH] make voyager work again after the cpumask_t changes
From: James Bottomley <James.Bottomley@steeleye.com>
To: wli@holomorphy.com, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-eusK3f4vJfNfVYIQiOyP"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Aug 2003 15:02:55 -0400
Message-Id: <1062097375.1952.41.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eusK3f4vJfNfVYIQiOyP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Most is just simple fixes; however, the needless change from atomic to
non-atomic operations in smp_invalidate_interrupt() caused me a lot of
pain to track down since it introduced some very subtle bugs.

I've also taken phys_cpu_present_map out of smp.h.  Since it
physid_mask_t is defined in mpspec.h anyway, and contains a duplicate
definition, I don't believe it can hurt anything.

James


--=-eusK3f4vJfNfVYIQiOyP
Content-Disposition: attachment; filename=cpumask.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=cpumask.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D arch/i386/mach-voyager/voyager_smp.c 1.15 vs edited =3D=3D=
=3D=3D=3D
--- 1.15/arch/i386/mach-voyager/voyager_smp.c	Mon Aug 18 22:46:23 2003
+++ edited/arch/i386/mach-voyager/voyager_smp.c	Thu Aug 28 12:50:04 2003
@@ -130,7 +130,7 @@
 {
 	int cpu;
=20
-	for_each_cpu(cpu, mk_cpumask_const(cpu_online_map)) {
+	for_each_cpu(cpu, cpu_online_map) {
 		if(cpuset & (1<<cpu)) {
 #ifdef VOYAGER_DEBUG
 			if(!cpu_isset(cpu, cpu_online_map))
@@ -874,10 +874,10 @@
 asmlinkage void=20
 smp_invalidate_interrupt(void)
 {
-	__u8 cpu =3D get_cpu();
+	__u8 cpu =3D smp_processor_id();
=20
-	if (!(smp_invalidate_needed & (1UL << cpu)))
-		goto out;
+	if (!test_bit(cpu, &smp_invalidate_needed))
+		return;
 	/* This will flood messages.  Don't uncomment unless you see
 	 * Problems with cross cpu invalidation
 	VDEBUG(("VOYAGER SMP: CPU%d received INVALIDATE_CPI\n",
@@ -893,9 +893,9 @@
 		} else
 			leave_mm(cpu);
 	}
-	smp_invalidate_needed |=3D 1UL << cpu;
- out:
-	put_cpu_no_resched();
+	smp_mb__before_clear_bit();
+	clear_bit(cpu, &smp_invalidate_needed);
+	smp_mb__after_clear_bit();
 }
=20
 /* All the new flush operations for 2.4 */
@@ -929,6 +929,7 @@
 	send_CPI(cpumask, VIC_INVALIDATE_CPI);
=20
 	while (smp_invalidate_needed) {
+		mb();
 		if(--stuck =3D=3D 0) {
 			printk("***WARNING*** Stuck doing invalidate CPI (CPU%d)\n", smp_proces=
sor_id());
 			break;
@@ -1464,7 +1465,7 @@
 	cpuset &=3D 0xff;		/* only first 8 CPUs vaild for VIC CPI */
 	if(cpuset =3D=3D 0)
 		return;
-	for_each_cpu(cpu, mk_cpumask_const(cpu_online_map)) {
+	for_each_cpu(cpu, cpu_online_map) {
 		if(cpuset & (1<<cpu))
 			set_bit(cpi, &vic_cpi_mailbox[cpu]);
 	}
@@ -1578,7 +1579,7 @@
 	VDEBUG(("VOYAGER: enable_vic_irq(%d) CPU%d affinity 0x%lx\n",
 		irq, cpu, cpu_irq_affinity[cpu]));
 	spin_lock_irqsave(&vic_irq_lock, flags);
-	for_each_cpu(real_cpu, mk_cpumask_const(cpu_online_map)) {
+	for_each_cpu(real_cpu, cpu_online_map) {
 		if(!(voyager_extended_vic_processors & (1<<real_cpu)))
 			continue;
 		if(!(cpu_irq_affinity[real_cpu] & mask)) {
@@ -1723,7 +1724,7 @@
=20
 			printk("VOYAGER SMP: CPU%d lost interrupt %d\n",
 			       cpu, irq);
-			for_each_cpu(real_cpu, mk_cpumask_const(mask)) {
+			for_each_cpu(real_cpu, mask) {
=20
 				outb(VIC_CPU_MASQUERADE_ENABLE | real_cpu,
 				     VIC_PROCESSOR_ID);
@@ -1808,7 +1809,7 @@
 		 * bus) */
 		return;
=20
-	for_each_cpu(cpu, mk_cpumask_const(cpu_online_map)) {
+	for_each_cpu(cpu, cpu_online_map) {
 		unsigned long cpu_mask =3D 1 << cpu;
 	=09
 		if(cpu_mask & real_mask) {
@@ -1874,7 +1875,7 @@
 	int old_cpu =3D smp_processor_id(), cpu;
=20
 	/* dump the interrupt masks of each processor */
-	for_each_cpu(cpu, mk_cpumask_const(cpu_online_map)) {
+	for_each_cpu(cpu, cpu_online_map) {
 		__u16 imr, isr, irr;
 		unsigned long flags;
=20
=3D=3D=3D=3D=3D include/asm-i386/smp.h 1.28 vs edited =3D=3D=3D=3D=3D
--- 1.28/include/asm-i386/smp.h	Mon Aug 18 22:46:23 2003
+++ edited/include/asm-i386/smp.h	Thu Aug 28 08:12:36 2003
@@ -32,7 +32,6 @@
  */
 =20
 extern void smp_alloc_memory(void);
-extern physid_mask_t phys_cpu_present_map;
 extern int pic_mode;
 extern int smp_num_siblings;
 extern int cpu_sibling_map[];

--=-eusK3f4vJfNfVYIQiOyP--

