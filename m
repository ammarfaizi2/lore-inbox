Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281079AbRKTOtT>; Tue, 20 Nov 2001 09:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281080AbRKTOtK>; Tue, 20 Nov 2001 09:49:10 -0500
Received: from [195.63.194.11] ([195.63.194.11]:46855 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281079AbRKTOtA>; Tue, 20 Nov 2001 09:49:00 -0500
Message-ID: <3BFA6B1A.D91C5703@evision-ventures.com>
Date: Tue, 20 Nov 2001 15:39:22 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: PATCH 2.4.15-pre6 idt compilation and proc_misc cleanup.
In-Reply-To: <87y9l58pb5.fsf@fadata.bg> <200111171920.fAHJKjJ01550@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------771E0940A3817F717C315539"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------771E0940A3817F717C315539
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The following two patches are:

1. Making the compilation of the idt77252 work without debugging
enabled.

2. Killing some code which is dead since ages in proc_misc.c


Those patches should apply to 2.4.15-pre7 as well.
--------------771E0940A3817F717C315539
Content-Type: text/plain; charset=us-ascii;
 name="compilefix-idt77252.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compilefix-idt77252.patch"

diff -ur linux-mdcki/drivers/atm/idt77252.c linux-mdcki-new/drivers/atm/idt77252.c
--- linux-mdcki/drivers/atm/idt77252.c	Sun Nov 18 15:09:49 2001
+++ linux-mdcki-new/drivers/atm/idt77252.c	Mon Nov 19 12:10:26 2001
@@ -782,7 +782,9 @@
 	if (jiffies - scq->trans_start > HZ) {
 		printk("%s: Error pushing TBD for %d.%d\n",
 		       card->name, vc->tx_vcc->vpi, vc->tx_vcc->vci);
+#ifdef CONFIG_ATM_IDT77252_DEBUG
 		idt77252_tx_dump(card);
+#endif
 		scq->trans_start = jiffies;
 	}
 

--------------771E0940A3817F717C315539
Content-Type: text/plain; charset=us-ascii;
 name="clean-proc_misc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clean-proc_misc.patch"

diff -ur linux-mdcki/fs/proc/proc_misc.c linux-mdcki-new/fs/proc/proc_misc.c
--- linux-mdcki/fs/proc/proc_misc.c	Sun Nov 18 15:09:57 2001
+++ linux-mdcki-new/fs/proc/proc_misc.c	Tue Nov 20 02:46:18 2001
@@ -50,11 +50,6 @@
  * have a way to deal with that gracefully. Right now I used straightforward
  * wrappers, but this needs further analysis wrt potential overflows.
  */
-extern int get_hardware_list(char *);
-extern int get_stram_list(char *);
-#ifdef CONFIG_DEBUG_MALLOC
-extern int get_malloc(char * buffer);
-#endif
 #ifdef CONFIG_MODULES
 extern int get_module_list(char *);
 #endif
@@ -151,19 +146,10 @@
 	si_swapinfo(&i);
 	pg_size = atomic_read(&page_cache_size) - i.bufferram ;
 
-	len = sprintf(page, "        total:    used:    free:  shared: buffers:  cached:\n"
-		"Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
-		"Swap: %8Lu %8Lu %8Lu\n",
-		B(i.totalram), B(i.totalram-i.freeram), B(i.freeram),
-		B(i.sharedram), B(i.bufferram),
-		B(pg_size), B(i.totalswap),
-		B(i.totalswap-i.freeswap), B(i.freeswap));
 	/*
 	 * Tagged format, for easy grepping and expansion.
-	 * The above will go away eventually, once the tools
-	 * have been updated.
 	 */
-	len += sprintf(page+len,
+	len = sprintf(page,
 		"MemTotal:     %8lu kB\n"
 		"MemFree:      %8lu kB\n"
 		"MemShared:    %8lu kB\n"
@@ -222,33 +208,6 @@
 	release:	seq_release,
 };
 
-#ifdef CONFIG_PROC_HARDWARE
-static int hardware_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_hardware_list(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-#endif
-
-#ifdef CONFIG_STRAM_PROC
-static int stram_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_stram_list(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-#endif
-
-#ifdef CONFIG_DEBUG_MALLOC
-static int malloc_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_malloc(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-#endif
-
 #ifdef CONFIG_MODULES
 static int modules_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -541,15 +500,6 @@
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
 		{"version",	version_read_proc},
-#ifdef CONFIG_PROC_HARDWARE
-		{"hardware",	hardware_read_proc},
-#endif
-#ifdef CONFIG_STRAM_PROC
-		{"stram",	stram_read_proc},
-#endif
-#ifdef CONFIG_DEBUG_MALLOC
-		{"malloc",	malloc_read_proc},
-#endif
 #ifdef CONFIG_MODULES
 		{"modules",	modules_read_proc},
 #endif

--------------771E0940A3817F717C315539--

