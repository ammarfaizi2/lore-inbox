Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272649AbTG3CWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 22:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272651AbTG3CWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 22:22:33 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:4064 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S272649AbTG3CWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 22:22:30 -0400
Date: Wed, 30 Jul 2003 12:21:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Charles Lepple <clepple@ghz.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" after
 2.5.31 (incl. 2.6.0testX)
Message-Id: <20030730122145.77592840.sfr@canb.auug.org.au>
In-Reply-To: <82E003DC-C22E-11D7-BB43-003065DC6B50@ghz.cc>
References: <20030730110548.73919ca0.sfr@canb.auug.org.au>
	<82E003DC-C22E-11D7-BB43-003065DC6B50@ghz.cc>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 21:38:25 -0400 Charles Lepple <clepple@ghz.cc> wrote:
>
> On Tuesday, July 29, 2003, at 09:05  PM, Stephen Rothwell wrote:
> 
> > I may have missed this, but do you have the APIC or IO-APIC enabled?
> 
> Not sure that I have one on this system... it's pre-i686 (Pentium MMX).

OK.

> > The patch in question merely moved where the 0x40 descriptor was 
> > installed
> > in the descriptor table.
> 
> You mean it appears at a different table index? For some reason, I 
> thought that was a different patch (but I can't seem to find anything 
> else from that time period).

I meant that it puts it on the same place in the descriptor table, but the
insertion is done for each APM call instead of once at initialisation
time.

> Do you think it's worth checking the initialized value of the 
> bad_bios_desc fields in a 2.5 kernel with working APM? Or do you have 
> any other ideas on where to look?

I have appended two test patches - both are against 2.6.0-test2.

You could see if this matters at all by applying the first patch below. Be
warned, though, that if your BIOS is broken enough to need the
bad_bios_desc workaround, then this change will cause your machine to OOPS
and burn ... :-)

If you get no OOPS from running the above, then you could try the second
patch below. If your machine still behaves the same way, then you have
completely ruled out that change to the apm code ... so we need to look
elsewhere.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

-------------------first patch----------------------------------------
diff -ruN 2.6.0-test2/arch/i386/kernel/apm.c 2.6.0-test2-apm.1/arch/i386/kernel/apm.c
--- 2.6.0-test2/arch/i386/kernel/apm.c	2003-05-27 12:12:46.000000000 +1000
+++ 2.6.0-test2-apm.1/arch/i386/kernel/apm.c	2003-07-30 12:06:30.000000000 +1000
@@ -425,6 +425,7 @@
 static struct apm_user *	user_list;
 static spinlock_t		user_list_lock = SPIN_LOCK_UNLOCKED;
 static struct desc_struct	bad_bios_desc = { 0, 0x00409200 };
+static struct desc_struct	dummy_bios_desc = { 0, 0};
 
 static char			driver_version[] = "1.16ac";	/* no spaces */
 
@@ -601,7 +602,7 @@
 	
 	cpu = get_cpu();
 	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
+	cpu_gdt_table[cpu][0x40 / 8] = dummy_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
@@ -644,7 +645,7 @@
 	
 	cpu = get_cpu();
 	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
+	cpu_gdt_table[cpu][0x40 / 8] = dummy_bios_desc;
 
 	local_save_flags(flags);
 	APM_DO_CLI;
-------------------second patch----------------------------------------
diff -ruN 2.6.0-test2/arch/i386/kernel/apm.c 2.6.0-test2-apm.2/arch/i386/kernel/apm.c
--- 2.6.0-test2/arch/i386/kernel/apm.c	2003-05-27 12:12:46.000000000 +1000
+++ 2.6.0-test2-apm.2/arch/i386/kernel/apm.c	2003-07-30 12:14:02.000000000 +1000
@@ -594,23 +594,15 @@
 	APM_DECL_SEGS
 	unsigned long		flags;
 	unsigned long		cpus;
-	int			cpu;
-	struct desc_struct	save_desc_40;
 
 	cpus = apm_save_cpus();
 	
-	cpu = get_cpu();
-	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
-
 	local_save_flags(flags);
 	APM_DO_CLI;
 	APM_DO_SAVE_SEGS;
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
-	put_cpu();
 	apm_restore_cpus(cpus);
 	
 	return *eax & 0xff;
@@ -636,24 +628,16 @@
 	APM_DECL_SEGS
 	unsigned long		flags;
 	unsigned long		cpus;
-	int			cpu;
-	struct desc_struct	save_desc_40;
 
 
 	cpus = apm_save_cpus();
 	
-	cpu = get_cpu();
-	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
-	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
-
 	local_save_flags(flags);
 	APM_DO_CLI;
 	APM_DO_SAVE_SEGS;
 	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
-	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
-	put_cpu();
 	apm_restore_cpus(cpus);
 	return error;
 }
