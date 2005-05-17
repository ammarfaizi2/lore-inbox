Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVEQItO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVEQItO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 04:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVEQItO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 04:49:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10479 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261340AbVEQItD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 04:49:03 -0400
Date: Tue, 17 May 2005 14:18:59 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Kexec: Kexec on panic fix with nmi watchdog enabled 
Message-ID: <20050517084859.GB6196@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="x86-hang-on-nmi-watchdog-fix.patch"


o Problem: Kexec on panic hangs if first kernel is booted with nmi_watchdog
  command line parameter. This problem occurs because kexec crash shutdown
  code replaces the NMI callback handler. This handler saves the cpu register
  states and halts the cpu. If system is booted with nmi_watchdog parameter,
  then crashing cpu also runs this nmi handler and halts itself.

o This patch fixes the problem by keeping a track of crashing cpu and not
  executing the new nmi handler on crashing cpu.

o There is a dependence on smp_processor_id() function which might return
  insane value for cpu, if cpu field of thread_info is corrupted.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc4-mm2-nmi-vivek/arch/i386/kernel/crash.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN arch/i386/kernel/crash.c~x86-hang-on-nmi-watchdog-fix arch/i386/kernel/crash.c
--- linux-2.6.12-rc4-mm2-nmi/arch/i386/kernel/crash.c~x86-hang-on-nmi-watchdog-fix	2005-05-17 14:11:24.724659160 +0530
+++ linux-2.6.12-rc4-mm2-nmi-vivek/arch/i386/kernel/crash.c	2005-05-17 14:11:24.731658096 +0530
@@ -28,6 +28,8 @@
 
 
 note_buf_t crash_notes[NR_CPUS];
+/* This keeps a track of which one is crashing cpu. */
+static int crashing_cpu;
 
 static u32 *append_elf_note(u32 *buf,
 	char *name, unsigned type, void *data, size_t data_len)
@@ -113,6 +115,13 @@ static atomic_t waiting_for_crash_ipi;
 static int crash_nmi_callback(struct pt_regs *regs, int cpu)
 {
 	struct pt_regs fixed_regs;
+
+	/* Don't do anything if this handler is invoked on crashing cpu.
+	 * Otherwise, system will completely hang. Crashing cpu can get
+	 * an NMI if system was initially booted with nmi_watchdog parameter.
+	 */
+	if (cpu == crashing_cpu)
+		return 1;
 	local_irq_disable();
 
 	/* CPU does not save ss and esp on stack if execution is already
@@ -187,6 +196,9 @@ void machine_crash_shutdown(void)
 	 */
 	/* The kernel is broken so disable interrupts */
 	local_irq_disable();
+
+	/* Make a note of crashing cpu. Will be used in NMI callback.*/
+	crashing_cpu = smp_processor_id();
 	nmi_shootdown_cpus();
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)
_

--ZfOjI3PrQbgiZnxM--
