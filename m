Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSKDGtp>; Mon, 4 Nov 2002 01:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbSKDGtp>; Mon, 4 Nov 2002 01:49:45 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:14058 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265863AbSKDGto>;
	Mon, 4 Nov 2002 01:49:44 -0500
Date: Mon, 4 Nov 2002 17:55:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: James.Bottomley@HansenPartnership.com
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Don't invade generic code unneccessarily
Message-Id: <20021104175540.4fe7eee6.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I think this a better way to get access to a sysrq key.
Patch against 2.5.45-BK recent.

Unbuilt, untested, but you should get the idea.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.45-BK/arch/i386/mach-voyager/voyager_basic.c 2.5.45-BK-sfr.1/arch/i386/mach-voyager/voyager_basic.c
--- 2.5.45-BK/arch/i386/mach-voyager/voyager_basic.c	2002-10-31 14:05:08.000000000 +1100
+++ 2.5.45-BK-sfr.1/arch/i386/mach-voyager/voyager_basic.c	2002-11-04 17:50:23.000000000 +1100
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
+#include <linux/sysrq.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/voyager.h>
@@ -41,6 +42,21 @@
 
 struct voyager_SUS *voyager_SUS = NULL;
 
+#ifdef CONFIG_SMP
+static void
+voyager_dump()
+{
+	/* get here via a sysrq */
+	voyager_smp_dump();
+}
+
+static struct sysrq_key_op sysrq_voyager_dump_op = {
+	.handler	= voyager_dump,
+	.help_msg	= "voyager",
+	.action_msg	= "Dump Voyager Status\n",
+};
+#endif
+
 void
 voyager_detect(struct voyager_bios_info *bios)
 {
@@ -62,6 +78,9 @@
 			printk("\n**WARNING**: Voyager HAL only supports Levels 4 and 5 Architectures at the moment\n\n");
 		/* install the power off handler */
 		pm_power_off = voyager_power_off;
+#ifdef CONFIG_SMP
+		register_sysrq_key('c', &sysrq_voyager_dump_op);
+#endif
 	} else {
 		printk("\n\n**WARNING**: No Voyager Subsystem Found\n");
 	}
@@ -143,15 +162,6 @@
 	return retval;
 }
 
-void
-voyager_dump()
-{
-	/* get here via a sysrq */
-#ifdef CONFIG_SMP
-	voyager_smp_dump();
-#endif
-}
-
 /* voyager specific handling code for timer interrupts.  Used to hand
  * off the timer tick to the SMP code, since the VIC doesn't have an
  * internal timer (The QIC does, but that's another story). */
diff -ruN 2.5.45-BK/drivers/char/sysrq.c 2.5.45-BK-sfr.1/drivers/char/sysrq.c
--- 2.5.45-BK/drivers/char/sysrq.c	2002-11-02 12:26:03.000000000 +1100
+++ 2.5.45-BK-sfr.1/drivers/char/sysrq.c	2002-11-04 17:50:23.000000000 +1100
@@ -35,10 +35,6 @@
 
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_VOYAGER
-#include <asm/voyager.h>
-#endif
-
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
@@ -323,14 +319,6 @@
 	action_msg:	"Terminate All Tasks",
 };
 
-#ifdef CONFIG_VOYAGER
-static struct sysrq_key_op sysrq_voyager_dump_op = {
-	handler:	voyager_dump,
-	help_msg:	"voyager",
-	action_msg:	"Dump Voyager Status\n",
-};
-#endif
-
 static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
 			      struct tty_struct *tty) 
 {
@@ -364,11 +352,7 @@
 		 it is handled specially on the sparc
 		 and will never arrive */
 /* b */	&sysrq_reboot_op,
-#ifdef CONFIG_VOYAGER
-/* c */ &sysrq_voyager_dump_op,
-#else
-/* c */	NULL,
-#endif
+/* c */ NULL, /* May be assigned at init time by SMP VOYAGER */
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
diff -ruN 2.5.45-BK/include/asm-i386/voyager.h 2.5.45-BK-sfr.1/include/asm-i386/voyager.h
--- 2.5.45-BK/include/asm-i386/voyager.h	2002-10-31 14:06:05.000000000 +1100
+++ 2.5.45-BK-sfr.1/include/asm-i386/voyager.h	2002-11-04 17:50:23.000000000 +1100
@@ -504,7 +504,6 @@
 extern int voyager_memory_detect(int region, __u32 *addr, __u32 *length);
 extern void voyager_smp_intr_init(void);
 extern __u8 voyager_extended_cmos_read(__u16 cmos_address);
-extern void voyager_dump(void);
 extern void voyager_smp_dump(void);
 extern void voyager_timer_interrupt(struct pt_regs *regs);
 extern void smp_local_timer_interrupt(struct pt_regs * regs);
