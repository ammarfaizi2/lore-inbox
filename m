Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUKJD6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUKJD6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 22:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUKJD6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 22:58:37 -0500
Received: from fmr04.intel.com ([143.183.121.6]:42169 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261851AbUKJD6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 22:58:30 -0500
Date: Tue, 9 Nov 2004 19:54:00 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add cpu_relax() in spin loops & clean up barrier() for 2.6.9
Message-ID: <20041109195400.B4895@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The patch adds cpu_relax() in the body of some spin loops
for 2.6.9. The patch also removes redundant
barrier() code after cpu_relax() on ia32.

In the PAUSE instruction section, IA32 SDM claims "it is
recommended that a PASUE instruction be placed in all
spin-wait loops". And x86_64 SDM says that PAUSE instruction
is same as legacy mode in IA-32e mode operation.

This patch is against 2.6.9 (kernel.org). It was tested on
ia32 and x86_64.

Thanks.

-Fenghua 

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="spin_loops.patch"

--- a/arch/x86_64/kernel/smp.c	2004-10-26 11:52:46.000000000 -0700
+++ b/arch/x86_64/kernel/smp.c	2004-10-28 14:37:56.000000000 -0700
@@ -405,11 +405,11 @@ static void __smp_call_function (void (*
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)
-		barrier();
+		cpu_relax();
 
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
-			barrier();
+			cpu_relax();
 }
 
 /*
--- a/arch/i386/kernel/smp.c	2004-10-26 11:52:42.000000000 -0700
+++ b/arch/i386/kernel/smp.c	2004-10-28 14:29:22.000000000 -0700
@@ -538,11 +538,11 @@ int smp_call_function (void (*func) (voi
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)
-		barrier();
+		cpu_relax();
 
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
-			barrier();
+			cpu_relax();
 	spin_unlock(&call_lock);
 
 	return 0;
--- a/include/asm-i386/apic.h	2004-10-26 11:53:32.000000000 -0700
+++ b/include/asm-i386/apic.h	2004-10-28 14:31:58.000000000 -0700
@@ -53,7 +53,8 @@ static __inline unsigned long apic_read(
 
 static __inline__ void apic_wait_icr_idle(void)
 {
-	do { } while ( apic_read( APIC_ICR ) & APIC_ICR_BUSY );
+	while ( apic_read( APIC_ICR ) & APIC_ICR_BUSY )
+		cpu_relax();
 }
 
 int get_physical_broadcast(void);
--- a/arch/i386/kernel/cpu/mtrr/main.c	2004-10-26 11:52:42.000000000 -0700
+++ b/arch/i386/kernel/cpu/mtrr/main.c	2004-10-28 14:27:49.000000000 -0700
@@ -147,10 +147,8 @@ static void ipi_handler(void *info)
 	local_irq_save(flags);
 
 	atomic_dec(&data->count);
-	while(!atomic_read(&data->gate)) {
+	while(!atomic_read(&data->gate))
 		cpu_relax();
-		barrier();
-	}
 
 	/*  The master has cleared me to execute  */
 	if (data->smp_reg != ~0U) 
@@ -160,10 +158,9 @@ static void ipi_handler(void *info)
 		mtrr_if->set_all();
 
 	atomic_dec(&data->count);
-	while(atomic_read(&data->gate)) {
+	while(atomic_read(&data->gate))
 		cpu_relax();
-		barrier();
-	}
+
 	atomic_dec(&data->count);
 	local_irq_restore(flags);
 }
@@ -228,10 +225,9 @@ static void set_mtrr(unsigned int reg, u
 
 	local_irq_save(flags);
 
-	while(atomic_read(&data.count)) {
+	while(atomic_read(&data.count))
 		cpu_relax();
-		barrier();
-	}
+
 	/* ok, reset count and toggle gate */
 	atomic_set(&data.count, num_booting_cpus() - 1);
 	atomic_set(&data.gate,1);
@@ -248,10 +244,9 @@ static void set_mtrr(unsigned int reg, u
 		mtrr_if->set(reg,base,size,type);
 
 	/* wait for the others */
-	while(atomic_read(&data.count)) {
+	while(atomic_read(&data.count))
 		cpu_relax();
-		barrier();
-	}
+
 	atomic_set(&data.count, num_booting_cpus() - 1);
 	atomic_set(&data.gate,0);
 
@@ -259,10 +254,9 @@ static void set_mtrr(unsigned int reg, u
 	 * Wait here for everyone to have seen the gate change
 	 * So we're the last ones to touch 'data'
 	 */
-	while(atomic_read(&data.count)) {
+	while(atomic_read(&data.count))
 		cpu_relax();
-		barrier();
-	}
+
 	local_irq_restore(flags);
 }
 

--JP+T4n/bALQSJXh8--
