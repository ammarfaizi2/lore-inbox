Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSK0S5o>; Wed, 27 Nov 2002 13:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSK0S5o>; Wed, 27 Nov 2002 13:57:44 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:51332 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264666AbSK0S5n>; Wed, 27 Nov 2002 13:57:43 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 27 Nov 2002 11:04:30 -0800
Message-Id: <200211271904.LAA24091@adam.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Re: Modules with list
Cc: ingo.oeser@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I wrote two really buggy examples in my previous reply
to Kai.  First of all, here is a more "correct" version of
vmlinux.lds.S for determining the disposition of devexit at
kernel load time, although I don't know if ld will allow it:

--- linux/arch/i386/vmlinux.lds.S.orig  2002-11-27 09:51:42.000000000 -0800
+++ linux/arch/i386/vmlinux.lds.S       2002-11-27 10:56:20.000000000 -0800
@@ -1,6 +1,8 @@
 /* ld script to make i386 Linux kernel
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
+#include <linux/config.h>
+
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
@@ -12,6 +14,9 @@
   _text = .;                   /* Text and read-only data */
   .text : {
        *(.text)
+#ifdef CONFIG_HOTPLUG
+       *(.devexit.text)
+#endif
        *(.fixup)
        *(.gnu.warning)
        } = 0x9090
@@ -38,6 +43,9 @@
   /* writeable */
   .data : {                    /* Data */
        *(.data)
+#ifdef CONFIG_HOTPLUG
+       *(.devexit.data)
+#endif
        CONSTRUCTORS
        }
 
@@ -96,6 +104,13 @@
 
   _end = . ;
 
+#ifndef CONFIG_HOTPLUG
+  .discard : {
+       *(.devexit.text)
+       *(.devexit.data)
+       } = 0x001               /* Like bss: SEC_ALLOC, but no SEC_LOAD */
+#endif
+
   /* Sections to be discarded */
   /DISCARD/ : {
        *(.exit.text)


Also here is a "corrected" bit of untested code for clearing
devexit references at module load time:

        if (!module->removable) {
                void ***pptr = module->devexit_p_start;
                while (pptr != module->devexit_p_end) {
                        **pptr = NULL;
                        pptr++;
                }
        }

Sorry for responding too hastily before.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
