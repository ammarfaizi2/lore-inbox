Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWB1WJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWB1WJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWB1WJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:09:04 -0500
Received: from fsmlabs.com ([168.103.115.128]:36563 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932519AbWB1WJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:09:03 -0500
X-ASG-Debug-ID: 1141164531-9658-17-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Tue, 28 Feb 2006 14:13:19 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nathan Lynch <ntl@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
Subject: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
In-Reply-To: <20060228213412.GB2856@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602281412450.28074@montezuma.fsmlabs.com>
References: <20060219235826.GF3293@localhost.localdomain>
 <Pine.LNX.4.64.0602210800290.1579@montezuma.fsmlabs.com>
 <20060227075033.GK3293@localhost.localdomain> <Pine.LNX.4.64.0602270748240.1579@montezuma.fsmlabs.com>
 <20060228213412.GB2856@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9289
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Nathan Lynch wrote:

> Zwane Mwaikambo wrote:
> > On Mon, 27 Feb 2006, Nathan Lynch wrote:
> > 
> > > Zwane Mwaikambo wrote:
> > > > On Sun, 19 Feb 2006, Nathan Lynch wrote:
> > > > 
> > > > > On a dual P3 Xeon machine, offlining and then onlining a cpu makes the
> > > > > box instantly reboot.  I've been seeing this throughout the 2.6.16-rc
> > > > > series, but wasn't able to collect more information until now.  Not
> > > > > sure when this last worked, unfortunately.
> > > > > 
> > > > > With the debugging patch below, I get this on serial console:
> > > > 
> > > > Does 2.6.14 work? Also i wonder if it gets out of the trampoline...
> > > 
> > > 2.6.14 works (albeit with an APIC error reported).  When retesting
> > > 2.6.16-rc4 with your patch on top of my debugging patch, I don't see the
> > > "startup_secondary" line:
> > 
> > Hi Nathan,
> > 
> > Can you try the following patch? We can start moving the WARM_BOOT_HLT 
> > down until it triple faults (i'm assuming it at least gets this far).
> 
> Here's what I got with this one on top of a day-old -git (all
> debugging patches still applied):

Looks good, how about the following

Index: linux-2.6.16-rc2-mm1/arch/i386/kernel/head.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.16-rc2-mm1/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 head.S
--- linux-2.6.16-rc2-mm1/arch/i386/kernel/head.S	11 Feb 2006 16:55:14 -0000	1.1.1.1
+++ linux-2.6.16-rc2-mm1/arch/i386/kernel/head.S	28 Feb 2006 22:12:25 -0000
@@ -146,6 +146,12 @@ page_pde_offset = (__PAGE_OFFSET >> 20);
  * we know the trampoline has already loaded the boot_gdt_table GDT
  * for us.
  */
+#define warm_boot	tsc_sync_disabled-__PAGE_OFFSET
+#define WARM_BOOT_HLT		\
+	cmpl	$0, warm_boot;	\
+10:				\
+	jne	10b
+
 ENTRY(startup_32_smp)
 	cld
 	movl $(__BOOT_DS),%eax
@@ -324,6 +330,7 @@ is386:	movl $2,%ecx		# set MP
 	cmpb $0,%cl
 	je 1f			# the first CPU calls start_kernel
 				# all other CPUs call initialize_secondary
+	WARM_BOOT_HLT
 	call initialize_secondary
 	jmp L6
 1:
Index: linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c	11 Feb 2006 16:55:14 -0000	1.1.1.1
+++ linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c	28 Feb 2006 15:34:42 -0000
@@ -102,7 +102,7 @@ static cpumask_t smp_commenced_mask;
  * is no way to resync one AP against BP. TBD: for prescott and above, we
  * should use IA64's algorithm
  */
-static int __devinitdata tsc_sync_disabled;
+int __devinitdata tsc_sync_disabled;
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
