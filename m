Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752043AbWCNJf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbWCNJf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbWCNJfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:35:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:16836 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752043AbWCNJfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:35:55 -0500
Date: Tue, 14 Mar 2006 15:03:14 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Plug kdump shutdown race window
Message-ID: <20060314093314.GB4577@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please include below patch for 2.6.16 if it is not too late.


Thanks
Maneesh



-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-51776416



o lapic_shutdown() re-enables which is un-desirable for panic case,
  so use local_irq_save() and local_irq_restore() to keep the irqs
  disabled for kexec on panic case, and close a possible race window 
  while kdump shutdown as shown in this stack trace

-- BUG: spinlock lockup on CPU#1, bash/4396, c52781a0
[<c01c1870>] _raw_spin_lock+0xb7/0xd2
[<c029e148>] _spin_lock+0x6/0x8
[<c011b33f>] scheduler_tick+0xe7/0x328
[<c0128a7c>] update_process_times+0x51/0x5d
[<c0114592>] smp_apic_timer_interrupt+0x4f/0x58
[<c01141ff>] lapic_shutdown+0x76/0x7e
[<c0104d7c>] apic_timer_interrupt+0x1c/0x30
[<c01141ff>] lapic_shutdown+0x76/0x7e
[<c0116659>] machine_crash_shutdown+0x83/0xaa
[<c013cc36>] crash_kexec+0xc1/0xe3
[<c029e148>] _spin_lock+0x6/0x8
[<c013cc22>] crash_kexec+0xad/0xe3
[<c0215280>] __handle_sysrq+0x84/0xfd
[<c018d937>] write_sysrq_trigger+0x2c/0x35
[<c015e47b>] vfs_write+0xa2/0x13b
[<c015ea73>] sys_write+0x3b/0x64
[<c0103c69>] syscall_call+0x7/0xb



Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.16-rc5-git14-maneesh/arch/i386/kernel/apic.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/apic.c~kdump-shutdown-hang-fix arch/i386/kernel/apic.c
--- linux-2.6.16-rc5-git14/arch/i386/kernel/apic.c~kdump-shutdown-hang-fix	2006-03-10 17:42:48.473188808 +0530
+++ linux-2.6.16-rc5-git14-maneesh/arch/i386/kernel/apic.c	2006-03-10 17:43:40.390296208 +0530
@@ -570,16 +570,18 @@ void __devinit setup_local_APIC(void)
  */
 void lapic_shutdown(void)
 {
+	unsigned long flags;
+
 	if (!cpu_has_apic)
 		return;
 
-	local_irq_disable();
+	local_irq_save(flags);
 	clear_local_APIC();
 
 	if (enabled_via_apicbase)
 		disable_local_APIC();
 
-	local_irq_enable();
+	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_PM
_
