Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTEOPMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbTEOPMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:12:45 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:59265
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264083AbTEOPLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:11:47 -0400
Date: Thu, 15 May 2003 11:15:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH][2.5] VMWare doesn't like sysenter
In-Reply-To: <20030515074739.223a6c28.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.50.0305151114020.19782-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0305150400550.19782-100000@montezuma.mastecende.com>
 <20030515074739.223a6c28.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Randy.Dunlap wrote:

> On Thu, 15 May 2003 04:02:31 -0400 (EDT) Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> 
> | I get a monitor error in VMWare4 with a sysenter syscall enabled kernel, 
> | this patch simply disables sysenter based syscalls but doesn't clear the 
> | SEP bit in the capabilities.
> 
> | +static int __init do_nosysenter(char *s)
> | +{
> | +	nosysenter = 1;
> | +	return 1;
> | +}
> | +__setup("nosysenter", do_nosysenter);
> 
> Needs entry in Documentation/kernel-parameters.txt also
> if/when accepted.

Thanks for the heads up.

Index: linux-2.5.69-mm5/Documentation/kernel-parameters.txt
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/Documentation/kernel-parameters.txt,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kernel-parameters.txt
--- linux-2.5.69-mm5/Documentation/kernel-parameters.txt	6 May 2003 12:21:18 -0000	1.1.1.1
+++ linux-2.5.69-mm5/Documentation/kernel-parameters.txt	15 May 2003 15:14:23 -0000
@@ -1063,6 +1063,10 @@ running once the system is up.
 
 	sym53c8xx=	[HW,SCSI]
 			See Documentation/scsi/ncr53c8xx.txt.
+	
+	nosysenter	[IA-32]
+			Disable SYSENTER for syscalls, does not clear the SEP
+			capabilities bit.
 
 	t128=		[HW,SCSI]
 			See header of drivers/scsi/t128.c.
Index: linux-2.5.69-mm5/arch/i386/kernel/sysenter.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/arch/i386/kernel/sysenter.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 sysenter.c
--- linux-2.5.69-mm5/arch/i386/kernel/sysenter.c	6 May 2003 12:20:51 -0000	1.1.1.1
+++ linux-2.5.69-mm5/arch/i386/kernel/sysenter.c	15 May 2003 07:46:05 -0000
@@ -20,6 +20,7 @@
 #include <asm/unistd.h>
 
 extern asmlinkage void sysenter_entry(void);
+static int nosysenter __initdata;
 
 /*
  * Create a per-cpu fake "SEP thread" stack, so that we can
@@ -51,6 +52,13 @@ void enable_sep_cpu(void *info)
 	put_cpu();	
 }
 
+static int __init do_nosysenter(char *s)
+{
+	nosysenter = 1;
+	return 1;
+}
+__setup("nosysenter", do_nosysenter);
+
 /*
  * These symbols are defined by vsyscall.o to mark the bounds
  * of the ELF DSO images included therein.
@@ -64,7 +72,7 @@ static int __init sysenter_setup(void)
 
 	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY);
 
-	if (!boot_cpu_has(X86_FEATURE_SEP)) {
+	if (nosysenter || !boot_cpu_has(X86_FEATURE_SEP)) {
 		memcpy((void *) page,
 		       &vsyscall_int80_start,
 		       &vsyscall_int80_end - &vsyscall_int80_start);
-- 
function.linuxpower.ca
