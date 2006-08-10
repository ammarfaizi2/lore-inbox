Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWHJHYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWHJHYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWHJHYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:24:14 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:39145 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751441AbWHJHYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:24:14 -0400
Date: Thu, 10 Aug 2006 09:23:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4 warning on arch/x86_64/boot/compressed/head.o
In-Reply-To: <200608090909.19985.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0608100911160.10926@yvahk01.tjqt.qr>
References: <7161.1155005268@kao2.melbourne.sgi.com> <200608080455.34702.ak@suse.de>
 <Pine.LNX.4.61.0608090823570.11585@yvahk01.tjqt.qr> <200608090909.19985.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Compiling 2.6.18-rc4 on x86_64 gets this warning.
>> >> 
>> >>   gcc -Wp,-MD,arch/x86_64/boot/compressed/.head.o.d  -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude -Iinclude2 -I$KBUILD_OUTPUT/linux/include -include include/linux/autoconf.h -D__ASSEMBLY__ -m64 -traditional -m32  -c -o arch/x86_64/boot/compressed/head.o $KBUILD_OUTPUT/linux/arch/x86_64/boot/compressed/head.S
>> >>   ld -m elf_i386  -Ttext 0x100000 -e startup_32 -m elf_i386 arch/x86_64/boot/compressed/head.o arch/x86_64/boot/compressed/misc.o arch/x86_64/boot/compressed/piggy.o -o arch/x86_64/boot/compressed/vmlinux 
>> >> ld: warning: i386:x86-64 architecture of input file `arch/x86_64/boot/compressed/head.o' is incompatible with i386 output
>> >
>> >It always gave that since some binutils update long ago.
>> >If you know how to fix it please submit a patch, but as far as I know it's harmless.
>> 
>If you think you have a solution please submit a tested patch.

Ok here:

Actually you have to look some lines above, namely

  gcc -Wp,-MD,arch/x86_64/boot/compressed/.head.o.d  -nostdinc -isystem 
/usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude  
-include include/linux/autoconf.h -D__ASSEMBLY__ -m64 -traditional -m32   
-c -o arch/x86_64/boot/compressed/head.o arch/x86_64/boot/compressed/head.S

It specifies both -m64 and -m32 on the line. Let's see what happens:

$ file arch/x86_64/boot/compressed/head.o
arch/x86_64/boot/compressed/head.o: ELF 64-bit LSB relocatable, AMD x86-64, 
version 1 (SYSV), not stripped

$ grep AFLAGS arch/x86_64/boot/compressed/Makefile
EXTRA_AFLAGS    := -traditional -m32

I would have expected it to become an ELF32 object, but it is not.
Bug or feature of gcc/as?

$ gcc -v
gcc version 4.1.0 (SUSE Linux/10.1)
$ as -v
GNU assembler version 2.16.91.0.5 (x86_64-suse-linux) using BFD version 
2.16.91.0.5 20051219 (SUSE Linux)

Patch below kills the warning, but I question how appropriate this is (it 
feels like casting a warning in C away).. I did not test how the resulting 
kernel image behaves, as I do not have any x64 that I could just reboot or 
install vmware on.

diff --fast -Ndpru linux-2.6.18-rc4/arch/x86_64/boot/compressed/Makefile linux-2.6.18-rc4+/arch/x86_64/boot/compressed/Makefile
--- linux-2.6.18-rc4/arch/x86_64/boot/compressed/Makefile	2006-08-06 14:20:11.000000000 -0400
+++ linux-2.6.18-rc4+/arch/x86_64/boot/compressed/Makefile	2006-08-10 03:19:34.000000000 -0400
@@ -7,6 +7,7 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+AFLAGS		:= $(filter-out -m64,$(AFLAGS))
 EXTRA_AFLAGS	:= -traditional -m32
 
 # cannot use EXTRA_CFLAGS because base CFLAGS contains -mkernel which conflicts with
#<<eof>>



Jan Engelhardt
-- 
