Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUANJGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUANJGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:06:50 -0500
Received: from pD9E5637F.dip.t-dialin.net ([217.229.99.127]:18816 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265150AbUANJGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:06:11 -0500
Date: Wed, 14 Jan 2004 10:06:03 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jh@suse.cz
Subject: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040114090603.GA1935@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using -mregparm=3 shrinks the kernel further:

(compiled with gcc 3.4, without -funit-at-a-time, using the later
and together with -Os shrinks .text even more, making over 700KB difference) 

4129346  708629  207240 5045215  4cfbdf vmlinux
3892905  708629  207240 4808774  496046 vmlinux-regparm

This one helps even more, >236KB .text difference. Clearly worth
the effort.

This patch adds an option to use -mregparm=3 while compiling the kernel.
I did an LTP run and it showed no additional failures over an non 
regparm kernel.

According to some gcc developers it should be safe to use in all
gccs that are still supports (2.95 and up) 

I didn't make it the default because it will break all binary only
modules (although they can be fixed by adding a wrapper that 
calls them with "asmlinkage"). Actually it may be a good idea to 
make this default with 2.7.1 or somesuch.

diff -u linux-34/arch/i386/Kconfig-o linux-34/arch/i386/Kconfig
--- linux-34/arch/i386/Kconfig-o	2004-01-09 09:27:09.000000000 +0100
+++ linux-34/arch/i386/Kconfig	2004-01-14 08:43:29.815530072 +0100
@@ -820,6 +820,14 @@
 	depends on (((X86_SUMMIT || X86_GENERICARCH) && NUMA) || (X86 && EFI))
 	default y
 
+config REGPARM
+	bool "Use register arguments (EXPERIMENTAL)"
+	default n
+	help
+	Compile the kernel with -mregparm=3. This uses an different ABI
+	and passes the first three arguments of a function call in registers.
+	This will probably break binary only modules.	
+	
 endmenu
 
 
diff -u linux-34/arch/i386/Makefile-o linux-34/arch/i386/Makefile
--- linux-34/arch/i386/Makefile-o	2003-09-28 10:53:14.000000000 +0200
+++ linux-34/arch/i386/Makefile	2004-01-13 20:16:32.000000000 +0100
@@ -47,6 +47,8 @@
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 
+cflags-$(CONFIG_REGPARM) 	+= -mregparm=3
+
 CFLAGS += $(cflags-y)
 
 # Default subarch .c files



