Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTBLCxX>; Tue, 11 Feb 2003 21:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTBLCxX>; Tue, 11 Feb 2003 21:53:23 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:57223 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265457AbTBLCxW>;
	Tue, 11 Feb 2003 21:53:22 -0500
Date: Wed, 12 Feb 2003 02:59:02 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>, ak@suse.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212025902.GA14092@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>, ak@suse.de,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <629040000.1045013743@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629040000.1045013743@flay>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 05:35:43PM -0800, Martin J. Bligh wrote:

 > The reason it rewrites SYSENTER_CS is non obviously vm86 which
 > doesn't guarantee the MSR stays constant (sigh). I think this would 
 > be better handled by having a global flag or process flag when any process
 > uses vm86 and not do it when this flag is not set (as in 99% of all 
 > normal use cases)

I feel I'm missing something obvious here, but is this part the
low-hanging fruit that it seems ?

		Dave

--- bk-linus/arch/i386/kernel/sysenter.c	2003-02-12 00:10:15.000000000 -0100
+++ linux-2.5/arch/i386/kernel/sysenter.c	2003-02-12 01:53:58.000000000 -0100
@@ -20,6 +20,8 @@
 
 extern asmlinkage void sysenter_entry(void);
 
+int trashed_sysenter_cs;
+
 /*
  * Create a per-cpu fake "SEP thread" stack, so that we can
  * enter the kernel without having to worry about things like
--- bk-linus/include/asm-i386/processor.h	2003-02-12 00:15:23.000000000 -0100
+++ linux-2.5/include/asm-i386/processor.h	2003-02-12 01:53:43.000000000 -0100
@@ -408,19 +408,26 @@ struct thread_struct {
 	.io_bitmap	= { [ 0 ... IO_BITMAP_SIZE ] = ~0 },		\
 }
 
+extern int trashed_sysenter_cs;
+
 static inline void load_esp0(struct tss_struct *tss, unsigned long esp0)
 {
 	tss->esp0 = esp0;
 	if (cpu_has_sep) {
-		wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
+		if (trashed_sysenter_cs==1) {
+			wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
+			trashed_sysenter_cs = 0;
+		}
 		wrmsr(MSR_IA32_SYSENTER_ESP, esp0, 0);
 	}
 }
 
 static inline void disable_sysenter(void)
 {
-	if (cpu_has_sep)  
+	if (cpu_has_sep) {
 		wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);
+		trashed_sysenter_cs = 1;
+	}
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
