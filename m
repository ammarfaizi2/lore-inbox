Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSE2WT7>; Wed, 29 May 2002 18:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSE2WT7>; Wed, 29 May 2002 18:19:59 -0400
Received: from [195.39.17.254] ([195.39.17.254]:41373 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315593AbSE2WT6>;
	Wed, 29 May 2002 18:19:58 -0400
Date: Thu, 30 May 2002 00:18:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: suspend-to-ram: clean up according to Andy
Message-ID: <20020529221847.GA7741@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Andy did not quite like the comments, please apply this.
								Pavel

--- linux-swsusp.test/arch/i386/kernel/acpi.c	Sun May 26 19:31:44 2002
+++ linux-swsusp/arch/i386/kernel/acpi.c	Wed May 29 22:22:53 2002
@@ -625,23 +625,15 @@
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
 }
 
+
+void do_suspend_lowlevel(int resume)
+{
 /*
- * (KG): Since we affect stack here, we make this function as flat and easy
- * as possible in order to not provoke gcc to use local variables on the stack.
- * Note that on resume, all (expect nosave) variables will have the state from
- * the time of writing (suspend_save_image) and the registers (including the
- * stack pointer, but excluding the instruction pointer) will be loaded with 
- * the values saved at save_processor_context() time.
+ * FIXME: This function should really be written in assembly. Actually
+ * requirement is that it does not touch stack, because %esp will be
+ * wrong during resume before restore_processor_context(). Check
+ * assembly if you modify this.
  */
-void do_suspend_magic(int resume)
-{
-	/* DANGER WILL ROBINSON!
-	 *
-	 * If this function is too difficult for gcc to optimize, it will crash and burn!
-	 * see above.
-	 *
-	 * DO NOT TOUCH.
-	 */
 	if (!resume) {
 		save_processor_context();
 		acpi_save_register_state((unsigned long)&&acpi_sleep_done);
@@ -650,7 +642,6 @@
 	}
 acpi_sleep_done:
 	restore_processor_context();
-	printk("CPU context restored...\n");
 }
 
 #endif /*CONFIG_ACPI_SLEEP*/
--- linux-swsusp.test/arch/i386/kernel/acpi_wakeup.S	Sun May 26 20:27:44 2002
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	Wed May 29 22:31:40 2002
@@ -179,7 +179,7 @@
 	rep	lodsb
 	movw	$0x0e00 + 'O', %ds:(0xb8018)
 
-	movl	%cs:saved_magic2, %eax
+	movl	%cs:saved_magic, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_magic
 
@@ -243,7 +243,7 @@
 	movl	saved_videomode, %edx
 	movl	%edx, video_mode - wakeup_start (%eax)
 	movl	$0x12345678, real_magic - wakeup_start (%eax)
-	movl	$0x12345678, saved_magic2
+	movl	$0x12345678, saved_magic
 
 	# restore the regs we used
 	popl	%edi
@@ -261,7 +261,6 @@
 ENTRY(saved_esp)	.long	0
 
 ENTRY(saved_magic)	.long	0
-ENTRY(saved_magic2)	.long	0	
 
 ALIGN
 # saved registers
--- linux-swsusp.test/drivers/acpi/acpi_system.c	Sun May 26 20:27:44 2002
+++ linux-swsusp/drivers/acpi/acpi_system.c	Wed May 29 22:20:04 2002
@@ -268,7 +268,7 @@
 
 	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
-		do_suspend_magic(0);
+		do_suspend_lowlevel(0);
 		break;
 	}
 

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
