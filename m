Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSKEJP5>; Tue, 5 Nov 2002 04:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSKEJP5>; Tue, 5 Nov 2002 04:15:57 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:28631 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S263246AbSKEJPy>; Tue, 5 Nov 2002 04:15:54 -0500
To: gerg@snapgear.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.46-uc0 (MMU-less fixups)
References: <3DC77832.6040600@snapgear.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Nov 2002 18:22:25 +0900
In-Reply-To: <3DC77832.6040600@snapgear.com>
Message-ID: <buoznsofk1a.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Here's a v850 update for 2.5.46-uc0.

Thanks,

-Miles

Patch:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.5.46-uc0-v850-20021105-dist.patch
Content-Description: linux-2.5.46-uc0-v850-20021105-dist.patch

diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/Makefile arch/v850/Makefile
--- ../orig/linux-2.5.46-uc0/arch/v850/Makefile	2002-11-05 11:25:21.000000000 +0900
+++ arch/v850/Makefile	2002-11-05 17:45:00.000000000 +0900
@@ -22,6 +22,8 @@
 CFLAGS += -fno-builtin
 CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
+ARCHBLOBLFLAGS := -I binary -O elf32-little -B v850e
+
 
 HEAD := $(arch_dir)/kernel/head.o $(arch_dir)/kernel/init_task.o
 core-y += $(arch_dir)/kernel/
@@ -40,10 +42,8 @@
 # This results in it being built anew each time, but that's alright.
 root_fs_image.o: root_fs_image_force
 
-# Note that we use the build-system's objcopy, as the v850 tools are fairly
-# old, and don't have the --rename-section option.
 root_fs_image_force: $(ROOT_FS_IMAGE)
-	objcopy -I binary -O elf32-little -B i386 --rename-section .data=.root,alloc,load,readonly,data,contents $< root_fs_image.o
+	$(OBJCOPY) $(ARCHBLOBLFLAGS) --rename-section .data=.root,alloc,load,readonly,data,contents $< root_fs_image.o
 endif
 
 
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/anna-rom.ld arch/v850/anna-rom.ld
--- ../orig/linux-2.5.46-uc0/arch/v850/anna-rom.ld	2002-11-05 11:25:21.000000000 +0900
+++ arch/v850/anna-rom.ld	2002-11-05 17:53:54.000000000 +0900
@@ -80,6 +80,11 @@
 		__root_fs_image_start = . ;
 		*(.root)
 		__root_fs_image_end = . ;
+
+		. = ALIGN (4096) ;
+		___initramfs_start = . ;
+			*(.init.initramfs)
+		___initramfs_end = . ;
 	} > ROM
 
 	__rom_copy_src_start = . ;
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/anna.ld arch/v850/anna.ld
--- ../orig/linux-2.5.46-uc0/arch/v850/anna.ld	2002-11-05 11:25:21.000000000 +0900
+++ arch/v850/anna.ld	2002-11-05 17:55:17.000000000 +0900
@@ -103,6 +103,12 @@
 			*(.initcall7.init)
 		. = ALIGN (4) ;
 		___initcall_end = . ;
+
+		. = ALIGN (4096) ;
+		___initramfs_start = . ;
+			*(.init.initramfs)
+		___initramfs_end = . ;
+
 		__init_end = . ;
 
 		__kram_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/kernel/irq.c arch/v850/kernel/irq.c
--- ../orig/linux-2.5.46-uc0/arch/v850/kernel/irq.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/irq.c	2002-11-05 17:32:20.000000000 +0900
@@ -252,7 +252,7 @@
 	unsigned int status;
 
 	irq_enter();
-	kstat.irqs[cpu][irq]++;
+	kstat_cpu(cpu).irqs[irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/rte_ma1_cb-ksram.ld arch/v850/rte_ma1_cb-ksram.ld
--- ../orig/linux-2.5.46-uc0/arch/v850/rte_ma1_cb-ksram.ld	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/rte_ma1_cb-ksram.ld	2002-11-05 17:50:48.000000000 +0900
@@ -93,6 +93,11 @@
 			*(.initcall7.init)
 		. = ALIGN (4) ;
 		___initcall_end = . ;
+
+		. = ALIGN (4096) ;
+		___initramfs_start = . ;
+			*(.init.initramfs)
+		___initramfs_end = . ;
 	} > SRAM
 
 	/* This provides address at which the interrupt vectors are
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/rte_ma1_cb-rom.ld arch/v850/rte_ma1_cb-rom.ld
--- ../orig/linux-2.5.46-uc0/arch/v850/rte_ma1_cb-rom.ld	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/rte_ma1_cb-rom.ld	2002-11-05 17:54:54.000000000 +0900
@@ -45,9 +45,14 @@
 		___stop___ksymtab = . ;
 		. = ALIGN (4) ;
 		__etext = . ;
+
+		. = ALIGN (4096) ;
+		___initramfs_start = . ;
+			*(.init.initramfs)
+		___initramfs_end = . ;
 	} > ROM
 
-	__data_load_start = . ;
+	__rom_copy_src_start = . ;
 
 	.data : {
 	        __kram_start = . ;
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/rte_ma1_cb.ld arch/v850/rte_ma1_cb.ld
--- ../orig/linux-2.5.46-uc0/arch/v850/rte_ma1_cb.ld	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/rte_ma1_cb.ld	2002-11-05 17:50:27.000000000 +0900
@@ -98,6 +98,11 @@
 			*(.initcall7.init)
 		. = ALIGN (4) ;
 		___initcall_end = . ;
+
+		. = ALIGN (4096) ;
+		___initramfs_start = . ;
+			*(.init.initramfs)
+		___initramfs_end = . ;
 	} > SDRAM
 
 	/* This provides address at which the interrupt vectors are
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/sim.ld arch/v850/sim.ld
--- ../orig/linux-2.5.46-uc0/arch/v850/sim.ld	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/sim.ld	2002-11-05 17:52:44.000000000 +0900
@@ -96,6 +96,12 @@
 			*(.initcall7.init)
 		. = ALIGN (4) ;
 		___initcall_end = . ;
+
+		. = ALIGN (4096) ;
+		___initramfs_start = . ;
+			*(.init.initramfs)
+		___initramfs_end = . ;
+
 		__init_end = . ;
 
 		__kram_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/arch/v850/sim85e2c.ld arch/v850/sim85e2c.ld
--- ../orig/linux-2.5.46-uc0/arch/v850/sim85e2c.ld	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/sim85e2c.ld	2002-11-05 17:53:16.000000000 +0900
@@ -86,6 +86,12 @@
 			*(.initcall7.init)
 		. = ALIGN (4) ;
 		___initcall_end = . ;
+
+		. = ALIGN (4096) ;
+		___initramfs_start = . ;
+			*(.init.initramfs)
+		___initramfs_end = . ;
+
 		__init_end = . ;
 	} > IRAM
 
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/drivers/serial/nb85e_uart.c drivers/serial/nb85e_uart.c
--- ../orig/linux-2.5.46-uc0/drivers/serial/nb85e_uart.c	2002-11-05 16:58:31.000000000 +0900
+++ drivers/serial/nb85e_uart.c	2002-11-05 17:37:51.000000000 +0900
@@ -304,7 +304,7 @@
 		port->icount.tx++;
 
 		if (uart_circ_chars_pending (xmit) < WAKEUP_CHARS)
-			uart_event (port, EVT_WRITE_WAKEUP);
+			uart_write_wakeup (port);
 	}
 
  no_xmit:
diff -ruN -X../cludes ../orig/linux-2.5.46-uc0/include/asm-v850/percpu.h include/asm-v850/percpu.h
--- ../orig/linux-2.5.46-uc0/include/asm-v850/percpu.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/percpu.h	2002-11-05 18:03:44.000000000 +0900
@@ -3,4 +3,12 @@
 
 #include <asm-generic/percpu.h>
 
+/* This is a stupid hack to satisfy some grotty implicit include-file
+   dependency; basically, <linux/smp.h> uses BUG_ON, which calls BUG, but
+   doesn't include the necessary headers to define it.  In the twisted
+   festering mess of includes this must all be resolved somehow on other
+   platforms, but I haven't the faintest idea how, and don't care; here will
+   do, even though doesn't actually make any sense.  */
+#include <asm/page.h>
+
 #endif /* __V850_PERCPU_H__ */

--=-=-=




-- 
"Most attacks seem to take place at night, during a rainstorm, uphill,
 where four map sheets join."   -- Anon. British Officer in WW I

--=-=-=--
