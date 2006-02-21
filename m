Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWBURvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWBURvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWBURvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:51:17 -0500
Received: from mail.aknet.ru ([82.179.72.26]:24332 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932331AbWBURvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:51:17 -0500
Message-ID: <43FB5317.60501@aknet.ru>
Date: Tue, 21 Feb 2006 20:51:19 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] Re: 2.6.16-rc4-mm1 (bugs and lockups)
Content-Type: multipart/mixed;
 boundary="------------040008070706090704070601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040008070706090704070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

The history is that -mm kernels do not work for me
for a few months already. The things started from
crashing somewhere after starting init, and for the
last month - no boot at all, just
"Uncompressing... OK, booting kernel", and silence.
Early console didn't work too.
With the latest releases this degraded into an infinite
stream of the "Unknown interrupt or fault" messages.
So today my patience ran out and I started to think how
can I collect at least some info for the bug-report.
Attached is the patch that allows to gather some valueable
debug info on the problem by making an early console more
useable. I can't properly test the patch, as the kernel
still doesn't boot, so I'll explain it in details in a
hope someone else can justify the intrusive changes.


arch_hooks.h: added prototypes for setup_early_printk()
and early_printk().

head.S: added "hlt" to the dummy fault handler. This is
necessary because otherwise the fault retriggers infinitely,
causing the infinite stream of an "Unknown interrupt or fault"
messages, which scrolls away the usefull info. I don't know
if this is a safe change.

setup.c: killed wrong setup_early_printk() prototype.
Moved setup_early_printk() a bit earlier, as it was not
"early enough" to cover the bug I was fighting with.

early_printk.c: made it to start printing from the bottom
of the screen, otherwise the messages interfere with the
ones of the boot-loader, so you can't read them.

main.c: moved smp_prepare_boot_cpu() call earlier. This
was necessary because otherwise printk() can't print
It checks cpu_online(), which returns false. This change
is consistent with the UP case, where's the boot CPU is
"online" from the very beginning, AFAICS. But again, I am
not entirely sure whether this is safe.


OK, so with that patch I was hoping to collect some debug
info. It turned out though, that the main.c change also
fixes the problem itself. The lockup was happening in an
__alloc_bootmem_core(): the "if (!size)" check was succeeding,
and the BUG() was triggering. After my main.c change this no
longer happens, but I don't know where the problem was.

I still can't boot the kernel because of this
http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.2/1244.html
but at least I know that with the attached patch, the boot
process goes much further.

Just in case the patch is going to be applied:
Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------040008070706090704070601
Content-Type: text/x-patch;
 name="bugearly1-16-rc4-mm1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bugearly1-16-rc4-mm1.diff"

--- a/include/asm-i386/arch_hooks.h	2004-01-09 09:59:45.000000000 +0300
+++ b/include/asm-i386/arch_hooks.h	2006-02-21 12:07:40.000000000 +0300
@@ -24,4 +24,7 @@
 extern void time_init_hook(void);
 extern void mca_nmi_hook(void);
 
+extern int setup_early_printk(char *); 
+extern void early_printk(const char *fmt, ...) __attribute__((format(printf,1,2)));
+
 #endif
--- a/arch/i386/kernel/head.S	2006-02-15 12:02:33.000000000 +0300
+++ b/arch/i386/kernel/head.S	2006-02-21 11:39:05.000000000 +0300
@@ -410,6 +410,7 @@
 	popl %ecx
 	popl %eax
 #endif
+	hlt	/* no way out, iret will just retrigger the fault */
 	iret
 
 /*
@@ -439,7 +440,7 @@
 ready:	.byte 0
 
 int_msg:
-	.asciz "Unknown interrupt or fault at EIP %p %p %p\n"
+	.asciz "Unknown interrupt or fault at EIP %p %p %p, press Reset\n"
 
 /*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
--- a/arch/i386/kernel/setup.c	2006-02-21 10:35:36.000000000 +0300
+++ b/arch/i386/kernel/setup.c	2006-02-21 12:09:52.000000000 +0300
@@ -1447,6 +1447,16 @@
 
 	parse_cmdline_early(cmdline_p);
 
+#ifdef CONFIG_EARLY_PRINTK
+	{
+		char *s = strstr(*cmdline_p, "earlyprintk=");
+		if (s) {
+			setup_early_printk(strchr(s, '=') + 1);
+			printk("early console enabled\n");
+		}
+	}
+#endif
+
 	max_low_pfn = setup_memory();
 
 	/*
@@ -1471,19 +1481,6 @@
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
 
-#ifdef CONFIG_EARLY_PRINTK
-	{
-		char *s = strstr(*cmdline_p, "earlyprintk=");
-		if (s) {
-			extern void setup_early_printk(char *);
-
-			setup_early_printk(strchr(s, '=') + 1);
-			printk("early console enabled\n");
-		}
-	}
-#endif
-
-
 	dmi_scan_machine();
 
 #ifdef CONFIG_X86_GENERICARCH
--- a/arch/x86_64/kernel/early_printk.c	2006-02-21 10:35:40.000000000 +0300
+++ b/arch/x86_64/kernel/early_printk.c	2006-02-21 12:19:10.000000000 +0300
@@ -21,7 +21,7 @@
 #define MAX_XPOS	max_xpos
 
 static int max_ypos = 25, max_xpos = 80;
-static int current_ypos = 1, current_xpos = 0;
+static int current_ypos = 25, current_xpos = 0;
 
 static void early_vga_write(struct console *con, const char *str, unsigned n)
 {
@@ -244,6 +244,7 @@
 	           && SCREEN_INFO.orig_video_isVGA == 1) {
 		max_xpos = SCREEN_INFO.orig_video_cols;
 		max_ypos = SCREEN_INFO.orig_video_lines;
+		current_ypos = max_ypos;
 		early_console = &early_vga_console;
  	} else if (!strncmp(buf, "simnow", 6)) {
  		simnow_init(buf + 6);
--- a/init/main.c	2006-02-21 10:36:04.000000000 +0300
+++ b/init/main.c	2006-02-21 15:33:18.000000000 +0300
@@ -449,6 +449,7 @@
  * enable them
  */
 	lock_kernel();
+	smp_prepare_boot_cpu();
 	page_address_init();
 	printk(KERN_NOTICE);
 	printk(linux_banner);
@@ -456,12 +457,6 @@
 	setup_per_cpu_areas();
 
 	/*
-	 * Mark the boot cpu "online" so that it can call console drivers in
-	 * printk() and can access its per-cpu storage.
-	 */
-	smp_prepare_boot_cpu();
-
-	/*
 	 * Set up the scheduler prior starting any interrupts (such as the
 	 * timer interrupt). Full topology setup happens at smp_init()
 	 * time - but meanwhile we still have a functioning scheduler.

--------------040008070706090704070601--
