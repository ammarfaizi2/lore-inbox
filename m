Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUCRSzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUCRSzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:55:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3785 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262873AbUCRSzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:55:03 -0500
Date: Thu, 18 Mar 2004 19:55:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, hch@infradead.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity usability
Message-ID: <20040318185548.GA4292@elte.hu>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org> <20040318182407.GA1287@elte.hu> <20040318103352.1a65126a.akpm@osdl.org> <20040318183944.GA3710@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318183944.GA3710@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> x86-64 has a VDSO page as well, [...]

hm, i'm not sure this is the case. It does have a vsyscall page but
doesnt fill out AT_SYSINFO. ia64 seems to have something like a vdso,
passed down via AT_SYSINFO.

We could introduce AT_VDSO to standardize this, and switch x86 from
AT_SYSINFO to AT_VDSO, and all architectures that implement the VDSO. 
I.e. something like the draft patch below. (this would also decrease the
size of the auxiliary table - glibc doesnt need to know the exception
header address.).

(this could also put an end to the AT_ bloat - eg. we could even get rid
of some of the constant AT_ values in the future: AT_PAGESZ, AT_CLKTCK,
AT_HWCAP, AT_PHENT and AT_FLAGS, and move them into the VDSO?)

	Ingo

--- linux/include/linux/elf.h.orig
+++ linux/include/linux/elf.h
@@ -162,6 +162,7 @@ typedef __s64	Elf64_Sxword;
 #define AT_PLATFORM 15  /* string identifying CPU for optimizations */
 #define AT_HWCAP  16    /* arch dependent hints at CPU capabilities */
 #define AT_CLKTCK 17	/* frequency at which times() increments */
+#define AT_VDSO   18	/* VDSO address */
 
 #define AT_SECURE 23   /* secure mode boolean */
 
--- linux/include/asm-i386/elf.h.orig
+++ linux/include/asm-i386/elf.h
@@ -132,10 +132,9 @@ extern int dump_task_extended_fpu (struc
 #define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
 extern void __kernel_vsyscall;
 
-#define ARCH_DLINFO						\
-do {								\
-		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
+#define ARCH_DLINFO					\
+do {							\
+	NEW_AUX_ENT(AT_VDSO, VSYSCALL_BASE);		\
 } while (0)
 
 /*
