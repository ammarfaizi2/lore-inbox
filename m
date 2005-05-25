Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVEYMP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVEYMP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVEYMP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:15:28 -0400
Received: from mailfe10.tele2.se ([212.247.155.33]:58342 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262298AbVEYMPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:15:00 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [Fastboot] [1/2] kdump: Use real pt_regs from exception
From: Alexander Nyberg <alexn@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
In-Reply-To: <20050525020749.1ad56a80.akpm@osdl.org>
References: <1116103798.6153.30.camel@localhost.localdomain>
	 <20050518123500.GA3657@in.ibm.com>
	 <1116427862.22324.5.camel@localhost.localdomain>
	 <20050525020749.1ad56a80.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 25 May 2005 14:14:56 +0200
Message-Id: <1117023296.877.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons 2005-05-25 klockan 02:07 -0700 skrev Andrew Morton:
> Alexander Nyberg <alexn@telia.com> wrote:
> >
> > -extern void machine_crash_shutdown(void);
> >  +extern void machine_crash_shutdown(struct pt_regs *);
> 
> That'll break x86_64, ppc, ppc64 and s/390.

I'm such an idiot.

Make sure all arches take pt_regs * as argument to
machine_crash_shutdown(). (now cross-compiled on above arches except
s/390).


Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: mm/arch/ppc/kernel/machine_kexec.c
===================================================================
--- mm.orig/arch/ppc/kernel/machine_kexec.c	2005-05-25 13:17:41.000000000 +0200
+++ mm/arch/ppc/kernel/machine_kexec.c	2005-05-25 13:18:06.000000000 +0200
@@ -34,7 +34,7 @@
 	}
 }
 
-void machine_crash_shutdown(void)
+void machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (ppc_md.machine_crash_shutdown) {
 		ppc_md.machine_crash_shutdown();
Index: mm/arch/x86_64/kernel/crash.c
===================================================================
--- mm.orig/arch/x86_64/kernel/crash.c	2005-05-25 13:13:18.000000000 +0200
+++ mm/arch/x86_64/kernel/crash.c	2005-05-25 13:15:44.000000000 +0200
@@ -22,7 +22,7 @@
 
 note_buf_t crash_notes[NR_CPUS];
 
-void machine_crash_shutdown(void)
+void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* This function is only called after the system
 	 * has paniced or is otherwise in a critical state.
Index: mm/arch/s390/kernel/crash.c
===================================================================
--- mm.orig/arch/s390/kernel/crash.c	2005-05-25 13:13:18.000000000 +0200
+++ mm/arch/s390/kernel/crash.c	2005-05-25 13:15:58.000000000 +0200
@@ -12,6 +12,6 @@
 
 note_buf_t crash_notes[NR_CPUS];
 
-void machine_crash_shutdown(void)
+void machine_crash_shutdown(struct pt_regs *regs)
 {
 }
Index: mm/arch/ppc64/kernel/machine_kexec.c
===================================================================
--- mm.orig/arch/ppc64/kernel/machine_kexec.c	2005-05-25 13:13:18.000000000 +0200
+++ mm/arch/ppc64/kernel/machine_kexec.c	2005-05-25 13:15:07.000000000 +0200
@@ -34,7 +34,7 @@
  * and if what it will achieve. Letting it be now to compile the code
  * in generic kexec environment
  */
-void machine_crash_shutdown(void)
+void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* do nothing right now */
 	/* smp_relase_cpus() if we want smp on panic kernel */
Index: mm/include/linux/reboot.h
===================================================================
--- mm.orig/include/linux/reboot.h	2005-05-25 13:13:39.000000000 +0200
+++ mm/include/linux/reboot.h	2005-05-25 13:51:49.000000000 +0200
@@ -52,6 +52,7 @@
 extern void machine_power_off(void);
 
 extern void machine_shutdown(void);
+struct pt_regs;
 extern void machine_crash_shutdown(struct pt_regs *);
 
 #endif
Index: mm/include/linux/kexec.h
===================================================================
--- mm.orig/include/linux/kexec.h	2005-05-25 13:13:39.000000000 +0200
+++ mm/include/linux/kexec.h	2005-05-25 13:47:47.000000000 +0200
@@ -124,6 +124,8 @@
 extern struct resource crashk_res;
 
 #else /* !CONFIG_KEXEC */
+struct pt_regs;
+struct task_struct;
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */


