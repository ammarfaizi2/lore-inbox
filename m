Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbTATTkE>; Mon, 20 Jan 2003 14:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbTATTiu>; Mon, 20 Jan 2003 14:38:50 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3844 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266795AbTATTiV>;
	Mon, 20 Jan 2003 14:38:21 -0500
Date: Sun, 19 Jan 2003 22:40:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Make restoring of graphics state on S3 resume run-time settable
Message-ID: <20030119214047.GA27865@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This makes it possible to select method of bios restoring after S3
resume. [=> no more ugly ifdefs]. Please apply,
								Pavel

--- clean/arch/i386/kernel/acpi.c	2003-01-17 23:13:33.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi.c	2003-01-19 19:10:48.000000000 +0100
@@ -454,6 +454,7 @@
 
 /* address in low memory of the wakeup routine. */
 unsigned long acpi_wakeup_address = 0;
+unsigned long acpi_video_flags;
 extern char wakeup_start, wakeup_end;
 
 extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
@@ -520,4 +547,20 @@
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
 }
 
+static int __init acpi_sleep_setup(char *str)
+{
+	while ((str != NULL) && (*str != '\0')) {
+		if (strncmp(str, "s3_bios", 7) == 0)
+			acpi_video_flags = 1;
+		if (strncmp(str, "s3_mode", 7) == 0)
+			acpi_video_flags |= 2;
+		str = strchr(str, ',');
+		if (str != NULL)
+			str += strspn(str, ", \t");
+	}
+	return 1;
+}
+
+
+__setup("acpi_sleep=", acpi_sleep_setup);
 #endif /*CONFIG_ACPI_SLEEP*/
--- clean/arch/i386/kernel/acpi_wakeup.S	2002-12-18 22:20:47.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2003-01-19 17:39:21.000000000 +0100
@@ -41,20 +41,19 @@
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
-#if 1
+	testl	$1, video_flags - wakeup_code
+	jz	1f
 	lcall   $0xc000,$3
-#endif
-#if 0
+1:
+
+	testl	$2, video_flags - wakeup_code
+	jz	1f
 	mov	video_mode - wakeup_code, %ax
 	call	mode_set
-#endif
+1:
 
 	# set up page table
-#if 1
 	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
-#else
-	movl    (real_save_cr3 - wakeup_data), %eax
-#endif
 	movl	%eax, %cr3
 
 	# make sure %cr4 is set correctly (features, etc)
@@ -86,6 +85,7 @@
 real_save_cr4:	.long 0
 real_magic:	.long 0
 video_mode:	.long 0
+video_flags:	.long 0
 
 bogus_real_magic:
 	movw	$0x0e00 + 'B', %fs:(0x12)
@@ -254,6 +254,8 @@
 
 	movl	saved_videomode, %edx
 	movl	%edx, video_mode - wakeup_start (%eax)
+	movl	acpi_video_flags, %edx
+	movl	%edx, video_flags - wakeup_start (%eax)
 	movl	$0x12345678, real_magic - wakeup_start (%eax)
 	movl	$0x12345678, saved_magic
 	ret

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
