Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWEVTIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWEVTIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWEVTIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:08:48 -0400
Received: from mail.gmx.de ([213.165.64.20]:6315 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750967AbWEVTIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:08:47 -0400
X-Authenticated: #31060655
Message-ID: <44720BD2.7060809@gmx.net>
Date: Mon, 22 May 2006 21:06:58 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Consoldidate arch/{i386,x86_64}/boot/compressed/misc.c
References: <4471FD34.8050202@gmx.net> <200605222028.32934.ak@suse.de>
In-Reply-To: <200605222028.32934.ak@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>> Would a series of incremental patches to consolidate these two
>> subtrees get accepted?
>>     
>
> Yes.
>
> I have some plans to change the 64bit boot up though - the uncompression
> should already run as 64bit - but that shouldnt' affect these files.
>   

Clean up arch/{i386,x86_64}/boot/compressed/misc.c a bit to reduce their
differences. Should have zero effect on code generation.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

Regards,
Carl-Daniel

--- linux-2.6.17-rc4/arch/i386/boot/compressed/misc.c.old	2006-05-12 01:31:53.000000000 +0200
+++ linux-2.6.17-rc4/arch/i386/boot/compressed/misc.c	2006-05-22 20:56:09.000000000 +0200
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
@@ -93,7 +85,7 @@
 #endif
 #define RM_SCREEN_INFO (*(struct screen_info *)(real_mode+0))
 
-extern char input_data[];
+extern unsigned char input_data[];
 extern int input_len;
 
 static long bytes_out = 0;
@@ -103,6 +95,9 @@
 static void *malloc(int size);
 static void free(void *where);
 
+static void *memset(void *s, int c, unsigned n);
+static void *memcpy(void *dest, const void *src, unsigned n);
+
 static void putstr(const char *);
 
 extern int end;
@@ -205,7 +200,7 @@
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-static void* memset(void* s, int c, size_t n)
+static void* memset(void* s, int c, unsigned n)
 {
 	int i;
 	char *ss = (char*)s;
@@ -214,14 +209,13 @@
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
@@ -309,7 +303,7 @@
 #else
 	if ((RM_ALT_MEM_K > RM_EXT_MEM_K ? RM_ALT_MEM_K : RM_EXT_MEM_K) < 1024) error("Less than 2MB of memory");
 #endif
-	output_data = (char *)__PHYSICAL_START; /* Normally Points to 1M */
+	output_data = (unsigned char *)__PHYSICAL_START; /* Normally Points to 1M */
 	free_mem_end_ptr = (long)real_mode;
 }
 
@@ -324,11 +318,9 @@
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
--- linux-2.6.17-rc4/arch/x86_64/boot/compressed/misc.c.old	2006-05-12 01:31:53.000000000 +0200
+++ linux-2.6.17-rc4/arch/x86_64/boot/compressed/misc.c	2006-05-22 20:56:30.000000000 +0200
@@ -77,11 +77,11 @@
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
@@ -92,9 +92,9 @@
 
 static void *malloc(int size);
 static void free(void *where);
- 
-void* memset(void* s, int c, unsigned n);
-void* memcpy(void* dest, const void* src, unsigned n);
+
+static void *memset(void *s, int c, unsigned n);
+static void *memcpy(void *dest, const void *src, unsigned n);
 
 static void putstr(const char *);
 
@@ -162,8 +162,8 @@
 	int x,y,pos;
 	char c;
 
-	x = SCREEN_INFO.orig_x;
-	y = SCREEN_INFO.orig_y;
+	x = RM_SCREEN_INFO.orig_x;
+	y = RM_SCREEN_INFO.orig_y;
 
 	while ( ( c = *s++ ) != '\0' ) {
 		if ( c == '\n' ) {
@@ -184,8 +184,8 @@
 		}
 	}
 
-	SCREEN_INFO.orig_x = x;
-	SCREEN_INFO.orig_y = y;
+	RM_SCREEN_INFO.orig_x = x;
+	RM_SCREEN_INFO.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
 	outb_p(14, vidport);
@@ -194,7 +194,7 @@
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
-void* memset(void* s, int c, unsigned n)
+static void* memset(void* s, int c, unsigned n)
 {
 	int i;
 	char *ss = (char*)s;
@@ -203,7 +203,7 @@
 	return s;
 }
 
-void* memcpy(void* dest, const void* src, unsigned n)
+static void* memcpy(void* dest, const void* src, unsigned n)
 {
 	int i;
 	char *d = (char *)dest, *s = (char *)src;
@@ -278,15 +278,15 @@
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
@@ -297,13 +297,13 @@
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
@@ -319,7 +319,7 @@
 	mv->high_buffer_start = high_buffer_start;
 }
 
-void close_output_buffer_if_we_run_high(struct moveparams *mv)
+static void close_output_buffer_if_we_run_high(struct moveparams *mv)
 {
 	if (bytes_out > low_buffer_size) {
 		mv->lcount = low_buffer_size;
@@ -335,7 +335,7 @@
 {
 	real_mode = rmode;
 
-	if (SCREEN_INFO.orig_video_mode == 7) {
+	if (RM_SCREEN_INFO.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
 	} else {
@@ -343,8 +343,8 @@
 		vidport = 0x3d4;
 	}
 
-	lines = SCREEN_INFO.orig_video_lines;
-	cols = SCREEN_INFO.orig_video_cols;
+	lines = RM_SCREEN_INFO.orig_video_lines;
+	cols = RM_SCREEN_INFO.orig_video_cols;
 
 	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);



-- 
http://www.hailfinger.org/

