Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbSJULn3>; Mon, 21 Oct 2002 07:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbSJULn3>; Mon, 21 Oct 2002 07:43:29 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:55306 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261325AbSJULn2>; Mon, 21 Oct 2002 07:43:28 -0400
Date: Mon, 21 Oct 2002 15:49:10 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 on Alpha
Message-ID: <20021021154910.A26742@jurassic.park.msu.ru>
References: <20021020182053.GC30418@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021020182053.GC30418@lug-owl.de>; from jbglaw@lug-owl.de on Sun, Oct 20, 2002 at 08:20:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 08:20:53PM +0200, Jan-Benedict Glaw wrote:
> I can't figure out what had changed between 2.5.43 and 2.5.44. I've
> looked over the patch, but I cannot find the offender:-( Has anybody
> seen the same (and got some hint for me)?

See changes in linux/init.h.
Here is the patch from Jeff Wiedemeier that fixes this and
some other compile problems.

Ivan.

--- 2.5.44/drivers/pnp/isapnp/core.c	Sat Oct 19 08:01:56 2002
+++ linux/drivers/pnp/isapnp/core.c	Mon Oct 21 15:33:14 2002
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/isapnp.h>
 #include <linux/pnp.h>
+#include <asm/io.h>
 
 LIST_HEAD(isapnp_cards);
 LIST_HEAD(isapnp_devices);
--- 2.5.44/arch/alpha/kernel/irq_impl.h	Sat Oct 19 08:02:35 2002
+++ linux/arch/alpha/kernel/irq_impl.h	Mon Oct 21 14:52:51 2002
@@ -10,6 +10,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/profile.h>
 
 
 #define RTC_IRQ    8
--- 2.5.44/arch/alpha/vmlinux.lds.S	Sat Oct 19 08:01:54 2002
+++ linux/arch/alpha/vmlinux.lds.S	Mon Oct 21 14:54:31 2002
@@ -31,18 +31,27 @@ SECTIONS
 	*(__ksymtab)
 	__stop___ksymtab = .;
   }
+
+  /* All kernel symbols */
+  __kallsyms ALIGN(8) : {
+	__start___kallsyms = .;
+	*(__kallsyms)
+	__stop___kallsyms = .;
+  }
+
   .kstrtab : { *(.kstrtab) }
+  .rodata : { *(.rodata) *(.rodata.*) }
 
   /* Startup code */
-  .text.init ALIGN(8192) : {
+  .init.text ALIGN(8192) : {
 	__init_begin = .;
-	*(.text.init)
+	*(.init.text)
   }
-  .data.init : { *(.data.init) }
+  .init.data : { *(.init.data) }
 
-  .setup.init ALIGN(16): {
+  .init.setup ALIGN(16): {
 	__setup_start = .;
-	*(.setup.init)
+	*(.init.setup)
 	__setup_end = .;
   }
 
@@ -71,11 +80,11 @@ SECTIONS
   }
 
   /* Global data */
-  .data.cacheline_aligned : {
+  .data.page_aligned ALIGN(8192) : {
 	_data = .;
-	*(.data.cacheline_aligned)
+	*(.data.page_aligned) 
   }
-  .rodata : { *(.rodata) *(.rodata.*) }
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
   .data : { *(.data) CONSTRUCTORS }
   .got : { *(.got) }
   .sdata : {
@@ -120,5 +129,5 @@ SECTIONS
   .debug_typenames 0 : { *(.debug_typenames) }
   .debug_varnames  0 : { *(.debug_varnames) }
 
-  /DISCARD/ : { *(.text.exit) *(.data.exit) *(.exitcall.exit) }
+  /DISCARD/ : { *(.exit.text) *(.exit.data) *(.exitcall.exit) }
 }
