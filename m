Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261720AbSJHSy6>; Tue, 8 Oct 2002 14:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSJHSyu>; Tue, 8 Oct 2002 14:54:50 -0400
Received: from host194.steeleye.com ([66.206.164.34]:51978 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261698AbSJHSyd>; Tue, 8 Oct 2002 14:54:33 -0400
Message-Id: <200210081900.g98J0CL09162@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Adrian Bunk <bunk@fs.tum.de>,
       James Bottomley <James.Bottomley@HansenPartnership.com>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.41-ac1 
In-Reply-To: Message from Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> 
   of "Tue, 08 Oct 2002 11:19:34 CDT." <Pine.LNX.4.44.0210081116180.32256-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-20773223800"
Date: Tue, 08 Oct 2002 15:00:12 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-20773223800
Content-Type: text/plain; charset=us-ascii

kai@tp1.ruhr-uni-bochum.de said:
> And you do not really want to do this, you rather want CONFIG_VOYAGER
> to  define_bool CONFIG_X86_SMP y and be done without ugly hacks in the
>  Makefiles. 

I'm afraid voyager can't do that.  CONFIG_SMP was split from CONFIG_X86_SMP 
for precisely this reason.  CONFIG_X86_SMP is for generic intel SMP 
architectures (i.e. APIC based).  The voyager has it's own rather wierd VIC 
based SMP architecture.

However, how about the attached patch, which fixes the problem for me (I can 
only compile, not test, because my voyager system is at home and I'm away on 
business)

James


--==_Exmh_-20773223800
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== arch/i386/config.in 1.55 vs edited =====
--- 1.55/arch/i386/config.in	Tue Oct  8 13:40:32 2002
+++ edited/arch/i386/config.in	Tue Oct  8 13:53:06 2002
@@ -472,6 +472,9 @@
    define_bool CONFIG_X86_IO_APIC n
    define_bool CONFIG_X86_LOCAL_APIC n
    define_bool CONFIG_X86_FIND_SMP_CONFIG y
+   if [ "$CONFIG_SMP" = "y" ]; then
+      define_bool CONFIG_X86_TRAMPOLINE y
+   fi
 else
    if [ "$CONFIG_SMP" = "y" ]; then
       define_bool CONFIG_X86_SMP y
@@ -479,6 +482,7 @@
       define_bool CONFIG_X86_IO_APIC y
       define_bool CONFIG_X86_LOCAL_APIC y
       define_bool CONFIG_X86_MPPARSE y
+      define_bool CONFIG_X86_TRAMPOLINE y
    fi
    define_bool CONFIG_X86_BIOS_REBOOT y
 fi
===== arch/i386/kernel/Makefile 1.28 vs edited =====
--- 1.28/arch/i386/kernel/Makefile	Tue Oct  8 13:40:32 2002
+++ edited/arch/i386/kernel/Makefile	Tue Oct  8 13:51:46 2002
@@ -20,7 +20,8 @@
 obj-$(CONFIG_APM)		+= apm.o
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o
-obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o trampoline.o
+obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
+obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
===== arch/i386/mach-voyager/Makefile 1.8 vs edited =====
--- 1.8/arch/i386/mach-voyager/Makefile	Sun Sep 22 11:58:59 2002
+++ edited/arch/i386/mach-voyager/Makefile	Tue Oct  8 13:52:16 2002
@@ -10,11 +10,8 @@
 EXTRA_CFLAGS	+= -I../kernel
 export-objs	:=
 
-# VPATH is needed for trampoline.o
-VPATH		:= ../kernel
-
 obj-y			:= setup.o voyager_basic.o voyager_thread.o
 
-obj-$(CONFIG_SMP)	+= voyager_smp.o voyager_cat.o trampoline.o
+obj-$(CONFIG_SMP)	+= voyager_smp.o voyager_cat.o
 
 include $(TOPDIR)/Rules.make

--==_Exmh_-20773223800--


