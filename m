Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVCAGOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVCAGOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCAGOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:14:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:46268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261252AbVCAGF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:05:28 -0500
Date: Mon, 28 Feb 2005 22:05:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: ebiederm@xmission.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3/3] Kdump: Export crash notes section address
 through sysfs
Message-Id: <20050228220502.177f75a1.akpm@osdl.org>
In-Reply-To: <1109261865.5148.819.camel@terminator.in.ibm.com>
References: <1109261865.5148.819.camel@terminator.in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> o Following patch exports kexec global variable "crash_notes" to user space
>    through sysfs as kernel attribute in /sys/kernel.

It breaks the x86_64 build.  A fix for that is below.

Please test kexec/kdump patches on all three architectures, both with your
config option enabled and with it disabled.  There are cross-compilers at
http://developer.osdl.org/dev/plm/cross_compile/


It also breaks the ppc build:

kernel/ksysfs.c: In function `crash_notes_show':
kernel/ksysfs.c:38: error: `crash_notes' undeclared (first use in this function)
kernel/ksysfs.c:38: error: (Each undeclared identifier is reported only once
kernel/ksysfs.c:38: error: for each function it appears in.)

but as ppc doesn't support crashdump, that is unfixable.

Why is the crashdump feature linked to CONFIG_KEXEC?  It should have its
own config option, which is dependent upon kexec.




kernel/ksysfs.c: In function `crash_notes_show':
kernel/ksysfs.c:38: error: `crash_notes' undeclared (first use in this function)
kernel/ksysfs.c:38: error: (Each undeclared identifier is reported only once
kernel/ksysfs.c:38: error: for each function it appears in.)


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/crash.c |    3 ---
 25-akpm/include/asm-x86_64/kexec.h |    5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff -puN include/asm-x86_64/kexec.h~kdump-export-crash-notes-section-address-through-x86_64-fix include/asm-x86_64/kexec.h
--- 25/include/asm-x86_64/kexec.h~kdump-export-crash-notes-section-address-through-x86_64-fix	2005-02-28 21:54:41.000000000 -0800
+++ 25-akpm/include/asm-x86_64/kexec.h	2005-02-28 21:55:12.000000000 -0800
@@ -25,4 +25,9 @@
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_X86_64
 
+#define MAX_NOTE_BYTES 1024
+typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
+
+extern note_buf_t crash_notes[];
+
 #endif /* _X86_64_KEXEC_H */
diff -puN arch/x86_64/kernel/crash.c~kdump-export-crash-notes-section-address-through-x86_64-fix arch/x86_64/kernel/crash.c
--- 25/arch/x86_64/kernel/crash.c~kdump-export-crash-notes-section-address-through-x86_64-fix	2005-02-28 21:58:39.000000000 -0800
+++ 25-akpm/arch/x86_64/kernel/crash.c	2005-02-28 21:58:55.000000000 -0800
@@ -22,9 +22,6 @@
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
 
-#define MAX_NOTE_BYTES 1024
-typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
-
 note_buf_t crash_notes[NR_CPUS];
 
 void machine_crash_shutdown(void)
_

