Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUJBRME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUJBRME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUJBRJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:09:58 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:56594
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S267404AbUJBRF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:05:26 -0400
Date: Sat, 2 Oct 2004 19:05:24 +0200
Message-Id: <200410021705.i92H5Ojg021797@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 161] Atari ST-RAM setup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari ST-RAM updates (from Petr Stehlik):
  - Re-add lost early setup parameter `stram_swap'.
  - Disable the broken ST-RAM swap by default, but allow anyone to enable it
    with the `stram_swap' option.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.28-pre3/arch/m68k/atari/stram.c	13 Mar 2003 06:45:40 -0000	1.2.2.2
+++ linux-m68k-2.4.28-pre3/arch/m68k/atari/stram.c	7 Aug 2004 08:28:21 -0000
@@ -190,7 +190,7 @@
  * -1 = do swapping (to whole ST-RAM) if it's less than MAX_STRAM_FRACTION of
  *      total memory
  */
-static int max_swap_size = -1;
+static int max_swap_size = 0;
 
 /* start and end of swapping area */
 static void *swap_start, *swap_end;
@@ -306,7 +306,7 @@
 		reserve_bootmem (0, PAGE_SIZE);
 
 #ifdef CONFIG_STRAM_SWAP
-	{
+	if (max_swap_size) {
 		void *swap_data;
 
 		start_mem = (void *) PAGE_ALIGN ((unsigned long) start_mem);
@@ -961,14 +961,33 @@
 	return( max_start );
 }
 
+#ifdef CONFIG_STRAM_SWAP
 
 /* setup parameters from command line */
-void __init stram_swap_setup(char *str, int *ints)
+void __init stram_swap_setup(char *str)
 {
-	if (ints[0] >= 1)
-		max_swap_size = ((ints[1] < 0 ? 0 : ints[1]) * 1024) & PAGE_MASK;
+	int ints[3];
+	get_options(str, ARRAY_SIZE(ints), ints);
+	if (ints[0] >= 1) {
+		if (ints[1] == 1) {
+			/* always use ST-RAM as swap */
+			max_swap_size = -1;
+			if (ints[0] == 2) {
+				max_swap_size = ((ints[2] < 0 ? 0 : ints[2]) * 1024) & PAGE_MASK;
+			}
+		}
+		else if (ints[1] == 0) {
+			/* never use ST-RAM as swap */
+			max_swap_size = 0;
+		}
+		else {
+			printk( KERN_WARNING "stram_swap=%d - invalid value\n", ints[1] );
+		}
+	}
 }
 
+#endif	/* CONFIG_STRAM_SWAP */
+
 
 /* ------------------------------------------------------------------------ */
 /*								ST-RAM device								*/
--- linux-2.4.28-pre3/arch/m68k/kernel/setup.c	5 Jul 2004 16:39:16 -0000	1.4.2.11
+++ linux-m68k-2.4.28-pre3/arch/m68k/kernel/setup.c	7 Aug 2004 08:28:22 -0000
@@ -295,13 +295,20 @@
 		i = 1;
 	    }
 #ifdef CONFIG_ATARI
-	    /* This option must be parsed very early */
+	    /* These options must be parsed very early */
 	    if (!strncmp( p, "switches=", 9 )) {
 		extern void atari_switches_setup( const char *, int );
 		atari_switches_setup( p+9, (q = strchr( p+9, ' ' )) ?
 				           (q - (p+9)) : strlen(p+9) );
 		i = 1;
 	    }
+#ifdef CONFIG_STRAM_SWAP
+	    if (!strncmp( p, "stram_swap=", 11 )) {
+		extern void stram_swap_setup( char * );
+		stram_swap_setup( p+11 );
+		i = 1;
+	    }
+#endif	/* CONFIG_STRAM_SWAP */
 #endif
 
 	    if (i) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
