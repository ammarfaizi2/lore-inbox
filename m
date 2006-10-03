Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWJCEgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWJCEgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWJCEgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:36:46 -0400
Received: from xenotime.net ([66.160.160.81]:58529 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965153AbWJCEgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:36:45 -0400
Date: Mon, 2 Oct 2006 21:38:09 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Message-Id: <20061002213809.7a3f995f.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	<p73venk2sjw.fsf@verdi.suse.de>
	<9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
	<Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
	<20061002191638.093fde85.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, how about something more direct and less obtrusive, like this?

---
From: Randy Dunlap <rdunlap@xenotime.net>

Honor "nofxsr" boot option during init.
Eliminates the math fault during boot.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/kernel/cpu/common.c |    2 +-
 arch/i386/kernel/i387.c       |    2 +-
 include/asm-i386/i387.h       |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2618-g18.orig/arch/i386/kernel/cpu/common.c
+++ linux-2618-g18/arch/i386/kernel/cpu/common.c
@@ -28,7 +28,7 @@ DEFINE_PER_CPU(unsigned char, cpu_16bit_
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
 static int cachesize_override __cpuinitdata = -1;
-static int disable_x86_fxsr __cpuinitdata;
+int disable_x86_fxsr __cpuinitdata;
 static int disable_x86_serial_nr __cpuinitdata = 1;
 static int disable_x86_sep __cpuinitdata;
 
--- linux-2618-g18.orig/arch/i386/kernel/i387.c
+++ linux-2618-g18/arch/i386/kernel/i387.c
@@ -30,7 +30,7 @@ void mxcsr_feature_mask_init(void)
 {
 	unsigned long mask = 0;
 	clts();
-	if (cpu_has_fxsr) {
+	if (cpu_has_fxsr && !disable_x86_fxsr) {
 		memset(&current->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
 		asm volatile("fxsave %0" : : "m" (current->thread.i387.fxsave)); 
 		mask = current->thread.i387.fxsave.mxcsr_mask;
--- linux-2618-g18.orig/include/asm-i386/i387.h
+++ linux-2618-g18/include/asm-i386/i387.h
@@ -18,6 +18,8 @@
 #include <asm/sigcontext.h>
 #include <asm/user.h>
 
+extern int disable_x86_fxsr;
+
 extern void mxcsr_feature_mask_init(void);
 extern void init_fpu(struct task_struct *);
 
