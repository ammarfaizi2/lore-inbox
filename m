Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWFXAUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWFXAUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWFXAUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:20:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:45219 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752184AbWFXAU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:20:27 -0400
Date: Sat, 24 Jun 2006 02:20:26 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       c-d.hailfinger.devel.2006@gmx.net
Subject: [PATCH] [39/82] i386/x86-64: Consolidate 
 arch/{i386,x86_64}/boot/compressed/misc.c
Message-ID: <449C854A.mailDEB11PVJU@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

Clean up arch/{i386,x86_64}/boot/compressed/misc.c a bit to reduce their
Signed-off-by: Andi Kleen <ak@suse.de>

differences. Should have zero effect on code generation.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

---
 arch/i386/boot/compressed/misc.c   |   32 +++++++++----------------
 arch/x86_64/boot/compressed/misc.c |   46 ++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 43 deletions(-)

Index: linux/arch/i386/boot/compressed/misc.c
===================================================================
--- linux.orig/arch/i386/boot/compressed/misc.c
+++ linux/arch/i386/boot/compressed/misc.c
@@ -24,14 +24,6 @@
 
 #undef memset
 #undef memcpy
-
-/*
- * Why do we do this? Don't ask me..
- *
- * Incomprehensible are the ways of bootloaders.
- */
-static void* memset(void *, int, size_t);
-static void* memcpy(void *, __const void *, size_t);
 #define memzero(s, n)     memset ((s), 0, (n))
 
 typedef unsigned char  uch;
@@ -93,7 +85,7 @@ static unsigned char *real_mode; /* Poin
 #endif
 #define RM_SCREEN_INFO (*(struct screen_info *)(real_mode+0))
 
-extern char input_data[];
+extern unsigned char input_data[];
 extern int input_len;
 
 static long bytes_out = 0;
@@ -103,6 +95,9 @@ static unsigned long output_ptr = 0;
 static void *malloc(int size);
 static void free(void *where);
 
+static void *memset(void *s, int c, unsigned n);
+static void *memcpy(void *dest, const void *src, unsigned n);
+
 static void putstr(const char *);
 
 extern int end;
@@ -205,7 +200,7 @@ static void putstr(const char *s)
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-static void* memset(void* s, int c, size_t n)
+static void* memset(void* s, int c, unsigned n)
 {
 	int i;
 	char *ss = (char*)s;
@@ -214,14 +209,13 @@ static void* memset(void* s, int c, size
 	return s;
 }
 
-static void* memcpy(void* __dest, __const void* __src,
-			    size_t __n)
+static void* memcpy(void* dest, const void* src, unsigned n)
 {
 	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
+	char *d = (char *)dest, *s = (char *)src;
 
-	for (i=0;i<__n;i++) d[i] = s[i];
-	return __dest;
+	for (i=0;i<n;i++) d[i] = s[i];
+	return dest;
 }
 
 /* ===========================================================================
@@ -309,7 +303,7 @@ static void setup_normal_output_buffer(v
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (char *)__PHYSICAL_START; /* Normally Points to 1M */
+	output_data = (unsigned char *)__PHYSICAL_START; /* Normally Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -324,11 +318,9 @@ static void setup_output_buffer_if_we_ru
 #ifdef STANDARD_MEMORY_BIOS_CALL
 	if (RM_EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
 #else
-	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) <
-			(3*1024))
-		error("Less than 4MB of memory");
+	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < (3*1024)) error("Less than 4MB of memory");
 #endif	
-	mv->low_buffer_start = output_data = (char *)LOW_BUFFER_START;
+	mv->low_buffer_start = output_data = (unsigned char *)LOW_BUFFER_START;
 	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
 	  ? LOW_BUFFER_MAX : (unsigned int)real_mode) & ~0xfff;
 	low_buffer_size = low_buffer_end - LOW_BUFFER_START;
Index: linux/arch/x86_64/boot/compressed/misc.c
===================================================================
--- linux.orig/arch/x86_64/boot/compressed/misc.c
+++ linux/arch/x86_64/boot/compressed/misc.c
@@ -77,11 +77,11 @@ static void gzip_release(void **);
  */
 static unsigned char *real_mode; /* Pointer to real-mode data */
 
-#define EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
+#define RM_EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
 #ifndef STANDARD_MEMORY_BIOS_CALL
-#define ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
+#define RM_ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
 #endif
-#define SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+#define RM_SCREEN_INFO (*(struct screen_info *)(real_mode+0))
 
 extern unsigned char input_data[];
 extern int input_len;
@@ -92,9 +92,9 @@ static unsigned long output_ptr = 0;
 
 static void *malloc(int size);
 static void free(void *where);
- 
-void* memset(void* s, int c, unsigned n);
-void* memcpy(void* dest, const void* src, unsigned n);
+
+static void *memset(void *s, int c, unsigned n);
+static void *memcpy(void *dest, const void *src, unsigned n);
 
 static void putstr(const char *);
 
@@ -162,8 +162,8 @@ static void putstr(const char *s)
 	int x,y,pos;
 	char c;
 
-	x = SCREEN_INFO.orig_x;
-	y = SCREEN_INFO.orig_y;
+	x = RM_SCREEN_INFO.orig_x;
+	y = RM_SCREEN_INFO.orig_y;
 
 	while ( ( c = *s++ ) != '\0' ) {
 		if ( c == '\n' ) {
@@ -184,8 +184,8 @@ static void putstr(const char *s)
 		}
 	}
 
-	SCREEN_INFO.orig_x = x;
-	SCREEN_INFO.orig_y = y;
+	RM_SCREEN_INFO.orig_x = x;
+	RM_SCREEN_INFO.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
 	outb_p(14, vidport);
@@ -194,7 +194,7 @@ static void putstr(const char *s)
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-void* memset(void* s, int c, unsigned n)
+static void* memset(void* s, int c, unsigned n)
 {
 	int i;
 	char *ss = (char*)s;
@@ -203,7 +203,7 @@ void* memset(void* s, int c, unsigned n)
 	return s;
 }
 
-void* memcpy(void* dest, const void* src, unsigned n)
+static void* memcpy(void* dest, const void* src, unsigned n)
 {
 	int i;
 	char *d = (char *)dest, *s = (char *)src;
@@ -278,15 +278,15 @@ static void error(char *x)
 	putstr(x);
 	putstr("\n\n -- System halted");
 
-	while(1);
+	while(1);	/* Halt */
 }
 
-void setup_normal_output_buffer(void)
+static void setup_normal_output_buffer(void)
 {
 #ifdef STANDARD_MEMORY_BIOS_CALL
-	if (EXT_MEM_K < 1024) error("Less than 2MB of memory");
+	if (RM_EXT_MEM_K < 1024) error("Less than 2MB of memory");
 #else
-	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < 1024) error("Less than 2MB of memory");
+	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
 	output_data = (unsigned char *)__PHYSICAL_START; /* Normally Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
@@ -297,13 +297,13 @@ struct moveparams {
 	uch *high_buffer_start; int hcount;
 };
 
-void setup_output_buffer_if_we_run_high(struct moveparams *mv)
+static void setup_output_buffer_if_we_run_high(struct moveparams *mv)
 {
 	high_buffer_start = (uch *)(((ulg)&end) + HEAP_SIZE);
 #ifdef STANDARD_MEMORY_BIOS_CALL
-	if (EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
+	if (RM_EXT_MEM_K < (3*1024)) error("Less than 4MB of memory");
 #else
-	if ((ALT_MEM_K > EXT_MEM_K ? ALT_MEM_K : EXT_MEM_K) < (3*1024)) error("Less than 4MB of memory");
+	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < (3*1024)) error("Less than 4MB of memory");
 #endif	
 	mv->low_buffer_start = output_data = (unsigned char *)LOW_BUFFER_START;
 	low_buffer_end = ((unsigned int)real_mode > LOW_BUFFER_MAX
@@ -319,7 +319,7 @@ void setup_output_buffer_if_we_run_high(
 	mv->high_buffer_start = high_buffer_start;
 }
 
-void close_output_buffer_if_we_run_high(struct moveparams *mv)
+static void close_output_buffer_if_we_run_high(struct moveparams *mv)
 {
 	if (bytes_out > low_buffer_size) {
 		mv->lcount = low_buffer_size;
@@ -335,7 +335,7 @@ int decompress_kernel(struct moveparams 
 {
 	real_mode = rmode;
 
-	if (SCREEN_INFO.orig_video_mode == 7) {
+	if (RM_SCREEN_INFO.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
 	} else {
@@ -343,8 +343,8 @@ int decompress_kernel(struct moveparams 
 		vidport = 0x3d4;
 	}
 
-	lines = SCREEN_INFO.orig_video_lines;
-	cols = SCREEN_INFO.orig_video_cols;
+	lines = RM_SCREEN_INFO.orig_video_lines;
+	cols = RM_SCREEN_INFO.orig_video_cols;
 
 	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
