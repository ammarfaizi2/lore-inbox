Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTJRUMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTJRUMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:12:30 -0400
Received: from gprs144-147.eurotel.cz ([160.218.144.147]:38019 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261806AbTJRUM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:12:27 -0400
Date: Sat, 18 Oct 2003 22:12:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [pm] Strange cleanups in -test8 kernel/acpi/wakeup.S
Message-ID: <20031018201214.GA12037@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some more changes landed in -test8. I have not seen them
before. Patrick, please, if you change something, can you post patch
somewhere for review before merging with Linus?

bkcvs info is:
BitKeeper to RCS/CVS export
----------------------------
revision 1.5
date: 2003/10/08 22:55:45;  author: mochel;  state: Exp;  lines: +37
-89
[power] Clean up ACPI STR assembly.

diff -Nru a/arch/i386/kernel/acpi/wakeup.S
b/arch/i386/kernel/acpi/wakeup.S
--- a/arch/i386/kernel/acpi/wakeup.S    Fri Oct 17 14:43:50 2003
+++ b/arch/i386/kernel/acpi/wakeup.S    Fri Oct 17 14:43:50 2003
@@ -172,14 +172,13 @@
 .org   0x1000

 wakeup_pmode_return:
-       movl    $__KERNEL_DS, %eax
-       movl    %eax, %ds
-       movw    $0x0e00 + 'u', %ds:(0xb8016)
-
-       # restore other segment registers
-       xorl    %eax, %eax
+       movw    $__KERNEL_DS, %ax
+       movw    %ax, %ss
+       movw    %ax, %ds
+       movw    %ax, %es
        movw    %ax, %fs
        movw    %ax, %gs
+       movw    $0x0e00 + 'u', 0xb8016

        # reload the gdt, as we need the full 32 bit address
        lgdt    saved_gdt
	~~~~~~~~~~~~~~~~~

Notice lgdt here. You have moved setup of segment registers before
loading gdt. This is actually okay, if you can be sure that all such
registers are in gdt (and not in ldt, for example).

Now, if you are sure this is okay (there is another load of gdt in
real mode), you can kill this lgdt, too, and  kill the comment below.

@@ -192,46 +191,30 @@
        wbinvd

        # and restore the stack ... but you need gdt for this to work
-       movl    $__KERNEL_DS, %eax
-       movw    %ax, %ss
-       movw    %ax, %ds
-       movw    %ax, %es
-       movw    %ax, %fs
-       movw    %ax, %gs
-       movl    saved_esp, %esp
+       movl    saved_context_esp, %esp

...

-       movw    $0x0e00 + 'W', %ds:(0xb8018)
-       movl    $(1024*1024*3), %ecx
-       movl    $0, %esi
-       rep     lodsb
-       movw    $0x0e00 + 'O', %ds:(0xb8018)
+       movw    $0x0e00 + 'W', 0xb8018
+       outl    %eax, $0x80
+       outl    %eax, $0x80
+       movw    $0x0e00 + 'O', 0xb8018

What are these outl-s? I do not see %ax being initialized... Some kind
of debugging hack? If you are trying to emulate delays, those are not
needed, what you killed were debugging hacks.

You no longer save %eax, %ecx, %edx, %esp, %ebp, %edi, %esi. This
means you probably need to add asmlinkage somewhere...
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
