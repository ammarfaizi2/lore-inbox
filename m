Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbTCWLQ6>; Sun, 23 Mar 2003 06:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263024AbTCWLQ6>; Sun, 23 Mar 2003 06:16:58 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:13382 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S263022AbTCWLQ4>; Sun, 23 Mar 2003 06:16:56 -0500
Date: Sun, 23 Mar 2003 12:25:49 +0100
Message-Id: <200303231125.h2NBPnVx009682@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari NCR5380 SCSI: bitops operate on long
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari NCR5380 SCSI: bitops operate on long, not char.

This also introduces the DECLARE_BITMAP() and CLEAR_BITMAP() macros we have in
2.5.x.

--- linux-2.4.x/drivers/scsi/atari_NCR5380.c	Fri Mar  1 17:28:31 2002
+++ linux-m68k-2.4.x/drivers/scsi/atari_NCR5380.c	Sat Mar  2 14:31:07 2002
@@ -309,13 +309,8 @@
 #undef TAG_NONE
 #define TAG_NONE 0xff
 
-/* For the m68k, the number of bits in 'allocated' must be a multiple of 32! */
-#if (MAX_TAGS % 32) != 0
-#error "MAX_TAGS must be a multiple of 32!"
-#endif
-
 typedef struct {
-    char	allocated[MAX_TAGS/8];
+    DECLARE_BITMAP(allocated, MAX_TAGS);
     int		nr_allocated;
     int		queue_size;
 } TAG_ALLOC;
@@ -334,7 +329,7 @@
     for( target = 0; target < 8; ++target ) {
 	for( lun = 0; lun < 8; ++lun ) {
 	    ta = &TagAlloc[target][lun];
-	    memset( &ta->allocated, 0, MAX_TAGS/8 );
+	    CLEAR_BITMAP( ta->allocated, MAX_TAGS );
 	    ta->nr_allocated = 0;
 	    /* At the beginning, assume the maximum queue size we could
 	     * support (MAX_TAGS). This value will be decreased if the target
@@ -394,8 +389,8 @@
     else {
 	TAG_ALLOC *ta = &TagAlloc[cmd->target][cmd->lun];
 
-	cmd->tag = find_first_zero_bit( &ta->allocated, MAX_TAGS );
-	set_bit( cmd->tag, &ta->allocated );
+	cmd->tag = find_first_zero_bit( ta->allocated, MAX_TAGS );
+	set_bit( cmd->tag, ta->allocated );
 	ta->nr_allocated++;
 	TAG_PRINTK( "scsi%d: using tag %d for target %d lun %d "
 		    "(now %d tags in use)\n",
@@ -424,7 +419,7 @@
     }
     else {
 	TAG_ALLOC *ta = &TagAlloc[cmd->target][cmd->lun];
-	clear_bit( cmd->tag, &ta->allocated );
+	clear_bit( cmd->tag, ta->allocated );
 	ta->nr_allocated--;
 	TAG_PRINTK( "scsi%d: freed tag %d for target %d lun %d\n",
 		    H_NO(cmd), cmd->tag, cmd->target, cmd->lun );
@@ -443,7 +438,7 @@
     for( target = 0; target < 8; ++target ) {
 	for( lun = 0; lun < 8; ++lun ) {
 	    ta = &TagAlloc[target][lun];
-	    memset( &ta->allocated, 0, MAX_TAGS/8 );
+	    CLEAR_BITMAP( ta->allocated, MAX_TAGS );
 	    ta->nr_allocated = 0;
 	}
     }
--- linux-2.4.x/include/linux/types.h	Wed May 29 10:14:25 2002
+++ linux-m68k-2.4.x/include/linux/types.h	Sun Mar  2 15:58:24 2003
@@ -3,6 +3,13 @@
 
 #ifdef	__KERNEL__
 #include <linux/config.h>
+
+#define BITS_TO_LONGS(bits) \
+	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[BITS_TO_LONGS(bits)]
+#define CLEAR_BITMAP(name,bits) \
+	memset(name, 0, BITS_TO_LONGS(bits)*sizeof(unsigned long))
 #endif
 
 #include <linux/posix_types.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
