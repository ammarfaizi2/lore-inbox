Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318514AbSHAA5u>; Wed, 31 Jul 2002 20:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318563AbSHAA5u>; Wed, 31 Jul 2002 20:57:50 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:24014 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318514AbSHAA5u>;
	Wed, 31 Jul 2002 20:57:50 -0400
Date: Thu, 1 Aug 2002 03:01:08 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200208010101.DAA00248@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.29: bug in ide and hd kernel option handling
Cc: gerald@io.com, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, I wrote:
> On my 486 test box (ISA/VLB only, CONFIG_PCI=n), passing any
> any ide or hd kernel option (like idebus=33) to 2.5.29 results
> in a kernel hang at boot: I get the initial "Uncompressing ..
> booting .." and then nothing.

Problem partially identified.

With CONFIG_PCI=n, include/asm-i386/ide.h:ide_init_default_hwifs()
is defined to ide_register_hw() the PC's standard IDE ports, but
with CONFIG_PCI=y, it's empty.

When drivers/ide/main.c:ide_setup() is called for some "ide..."
kernel option, it starts by calling init_global_data(), which
in turn calls ide_init_default_hwifs(). When CONFIG_PCI=n so
ide_init_default_hwifs() isn't empty, the kernel either hangs
or reboots at that point.

init_global_data() and ide_init_default_hwifs() can also be called
much later from 'module_init(init_ata)'. In that case there is no
hang or reboot -- so my guess is that the initialisation does something
which normally works but is illegal and causes a fault when done
at __setup()-time.

I tested every kernel from 2.5.29 and back, and the problem started
with 2.5.5.

As a workaround I applied the patch below to unconditionally
make ide_init_default_hwifs() do nothing. This solved my problem
and doesn't seem to have had any bad side-effects: the kernel still
finds all standard IDE ports on my 486.

/Mikael

--- linux-2.5.29/include/asm-i386/ide.h.~1~	Sat Jul 20 23:49:45 2002
+++ linux-2.5.29/include/asm-i386/ide.h	Thu Aug  1 02:20:31 2002
@@ -65,7 +65,7 @@
 
 static __inline__ void ide_init_default_hwifs(void)
 {
-#ifndef CONFIG_PCI
+#if 0 && !defined(CONFIG_PCI)
 	hw_regs_t hw;
 	int index;
 
