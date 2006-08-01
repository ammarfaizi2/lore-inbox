Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWHALJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWHALJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWHALGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10461 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932620AbWHALGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:12 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
Date: Tue,  1 Aug 2006 05:03:24 -0600
Message-Id: <115443023544-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does two very simple things.
It adds a serial output capability to the decompressor.
It adds a command line parser for the early_printk
option so we know which output method to use for the decompressor.

This makes debugging the decompressor a little easier, and
keeps us from assuming we always have a vga console on all
hardware.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/boot/compressed/misc.c |  258 +++++++++++++++++++++++++++++++++++---
 1 files changed, 241 insertions(+), 17 deletions(-)

diff --git a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
index 905c37e..fcaa9f0 100644
--- a/arch/i386/boot/compressed/misc.c
+++ b/arch/i386/boot/compressed/misc.c
@@ -9,11 +9,14 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#define __init
 #include <linux/config.h>
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
+#include <linux/serial_reg.h>
 #include <linux/screen_info.h>
 #include <asm/io.h>
+#include <asm/setup.h>
 
 /*
  * gzip declarations
@@ -24,7 +27,9 @@ #define STATIC static
 
 #undef memset
 #undef memcpy
+#undef memcmp
 #define memzero(s, n)     memset ((s), 0, (n))
+char *strstr(const char *haystack, const char *needle);
 
 typedef unsigned char  uch;
 typedef unsigned short ush;
@@ -78,12 +83,17 @@ static void gzip_release(void **);
  * This is set up by the setup-routine at boot-time
  */
 static unsigned char *real_mode; /* Pointer to real-mode data */
+static char saved_command_line[COMMAND_LINE_SIZE];
 
 #define RM_EXT_MEM_K   (*(unsigned short *)(real_mode + 0x2))
 #ifndef STANDARD_MEMORY_BIOS_CALL
 #define RM_ALT_MEM_K   (*(unsigned long *)(real_mode + 0x1e0))
 #endif
 #define RM_SCREEN_INFO (*(struct screen_info *)(real_mode+0))
+#define RM_NEW_CL_POINTER ((char *)(unsigned long)(*(unsigned *)(real_mode+0x228)))
+#define RM_OLD_CL_MAGIC (*(unsigned short *)(real_mode + 0x20))
+#define RM_OLD_CL_OFFSET (*(unsigned short *)(real_mode + 0x22))
+#define OLD_CL_MAGIC 0xA33F
 
 extern unsigned char input_data[];
 extern int input_len;
@@ -97,8 +107,10 @@ static void free(void *where);
 
 static void *memset(void *s, int c, unsigned n);
 static void *memcpy(void *dest, const void *src, unsigned n);
+static int memcmp(const void *s1, const void *s2, unsigned n);
 
 static void putstr(const char *);
+static unsigned simple_strtou(const char *cp,char **endp,unsigned base);
 
 extern int end;
 static long free_mem_ptr = (long)&end;
@@ -112,14 +124,25 @@ static unsigned int low_buffer_end, low_
 static int high_loaded =0;
 static uch *high_buffer_start /* = (uch *)(((ulg)&end) + HEAP_SIZE)*/;
 
-static char *vidmem = (char *)0xb8000;
+static char *vidmem;
 static int vidport;
 static int lines, cols;
 
 #ifdef CONFIG_X86_NUMAQ
-static void * xquad_portio = NULL;
+static void * xquad_portio;
 #endif
 
+/* The early serial console */
+
+#define DEFAULT_BAUD 9600
+#define DEFAULT_BASE 0x3f8 /* ttyS0 */
+static unsigned serial_base = DEFAULT_BASE;
+
+#define CONSOLE_NOOP   0
+#define CONSOLE_VID    1
+#define CONSOLE_SERIAL 2
+static int console = CONSOLE_NOOP;
+
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
@@ -154,7 +177,8 @@ static void gzip_release(void **ptr)
 	free_mem_ptr = (long) *ptr;
 }
  
-static void scroll(void)
+/* The early video console */
+static void vid_scroll(void)
 {
 	int i;
 
@@ -163,7 +187,7 @@ static void scroll(void)
 		vidmem[i] = ' ';
 }
 
-static void putstr(const char *s)
+static void vid_putstr(const char *s)
 {
 	int x,y,pos;
 	char c;
@@ -175,7 +199,7 @@ static void putstr(const char *s)
 		if ( c == '\n' ) {
 			x = 0;
 			if ( ++y >= lines ) {
-				scroll();
+				vid_scroll();
 				y--;
 			}
 		} else {
@@ -183,7 +207,7 @@ static void putstr(const char *s)
 			if ( ++x >= cols ) {
 				x = 0;
 				if ( ++y >= lines ) {
-					scroll();
+					vid_scroll();
 					y--;
 				}
 			}
@@ -200,6 +224,178 @@ static void putstr(const char *s)
 	outb_p(0xff & (pos >> 1), vidport+1);
 }
 
+static void vid_console_init(void)
+{
+	if (RM_SCREEN_INFO.orig_video_mode == 7) {
+		vidmem = (char *) 0xb0000;
+		vidport = 0x3b4;
+	} else {
+		vidmem = (char *) 0xb8000;
+		vidport = 0x3d4;
+	}
+
+	lines = RM_SCREEN_INFO.orig_video_lines;
+	cols = RM_SCREEN_INFO.orig_video_cols;
+}
+
+/* The early serial console */
+static void serial_putc(int ch)
+{
+	if (ch == '\n') {
+		serial_putc('\r');
+	}
+	/* Wait until I can send a byte */
+	while ((inb(serial_base + UART_LSR) & UART_LSR_THRE) == 0)
+		;
+
+	/* Send the byte */
+	outb(ch, serial_base + UART_TX);
+
+	/* Wait until the byte is transmitted */
+	while (!(inb(serial_base + UART_LSR) & UART_LSR_TEMT))
+		;
+}
+
+static void serial_putstr(const char *str)
+{
+	int ch;
+	while((ch = *str++) != '\0') {
+		if (ch == '\n') {
+			serial_putc('\r');
+		}
+		serial_putc(ch);
+	}
+}
+
+static void serial_console_init(char *s)
+{
+	unsigned base = DEFAULT_BASE;
+	unsigned baud = DEFAULT_BAUD;
+	unsigned divisor;
+	char *e;
+
+	if (*s == ',')
+		++s;
+	if (*s && (*s != ' ')) {
+		if (memcmp(s, "0x", 2) == 0) {
+			base = simple_strtou(s, &e, 16);
+		} else {
+			static const unsigned bases[] = { 0x3f8, 0x2f8 };
+			unsigned port;
+
+			if (memcmp(s, "ttyS", 4) == 0)
+				s += 4;
+			port = simple_strtou(s, &e, 10);
+			if ((port > 1) || (s == e))
+				port = 0;
+			base = bases[port];
+		}
+		s = e;
+		if (*s == ',')
+			++s;
+	}
+	if (*s && (*s != ' ')) {
+		baud = simple_strtou(s, &e, 0);
+		if ((baud == 0) || (s == e))
+			baud = DEFAULT_BAUD;
+	}
+	divisor = 115200 / baud;
+	serial_base = base;
+
+	outb(0x00, serial_base + UART_IER); /* no interrupt */
+	outb(0x00, serial_base + UART_FCR); /* no fifo */
+	outb(0x03, serial_base + UART_MCR); /* DTR + RTS */
+
+	/* Set Baud Rate divisor  */
+	outb(0x83, serial_base + UART_LCR);
+	outb(divisor & 0xff, serial_base + UART_DLL);
+	outb(divisor >> 8, serial_base + UART_DLM);
+	outb(0x03, serial_base + UART_LCR); /* 8n1 */
+
+}
+
+static void putstr(const char *str)
+{
+	if (console == CONSOLE_VID) {
+		vid_putstr(str);
+	} else if (console == CONSOLE_SERIAL) {
+		serial_putstr(str);
+	}
+}
+
+static void console_init(char *cmdline)
+{
+	cmdline = strstr(cmdline, "earlyprintk=");
+	if (!cmdline)
+		return;
+	cmdline += 12;
+	if (memcmp(cmdline, "vga", 3) == 0) {
+		vid_console_init();
+		console = CONSOLE_VID;
+	} else if (memcmp(cmdline, "serial", 6) == 0) {
+		serial_console_init(cmdline + 6);
+		console = CONSOLE_SERIAL;
+	} else if (memcmp(cmdline, "ttyS", 4) == 0) {
+		serial_console_init(cmdline);
+		console = CONSOLE_SERIAL;
+	}
+}
+
+static inline int tolower(int ch)
+{
+	return ch | 0x20;
+}
+
+static inline int isdigit(int ch)
+{
+	return (ch >= '0') && (ch <= '9');
+}
+
+static inline int isxdigit(int ch)
+{
+	ch = tolower(ch);
+	return isdigit(ch) || ((ch >= 'a') && (ch <= 'f'));
+}
+
+
+static inline int digval(int ch)
+{
+	return isdigit(ch)? (ch - '0') : tolower(ch) - 'a' + 10;
+}
+
+/**
+ * simple_strtou - convert a string to an unsigned
+ * @cp: The start of the string
+ * @endp: A pointer to the end of the parsed string will be placed here
+ * @base: The number base to use
+ */
+static unsigned simple_strtou(const char *cp, char **endp, unsigned base)
+{
+	unsigned result = 0,value;
+
+	if (!base) {
+		base = 10;
+		if (*cp == '0') {
+			base = 8;
+			cp++;
+			if ((tolower(*cp) == 'x') && isxdigit(cp[1])) {
+				cp++;
+				base = 16;
+			}
+		}
+	} else if (base == 16) {
+		if (cp[0] == '0' && tolower(cp[1]) == 'x')
+			cp += 2;
+	}
+	while (isxdigit(*cp) && ((value = digval(*cp)) < base)) {
+		result = result*base + value;
+		cp++;
+	}
+	if (endp)
+		*endp = (char *)cp;
+	return result;
+}
+
 static void* memset(void* s, int c, unsigned n)
 {
 	int i;
@@ -218,6 +414,29 @@ static void* memcpy(void* dest, const vo
 	return dest;
 }
 
+static int memcmp(const void *s1, const void *s2, unsigned n)
+{
+	const unsigned char *str1 = s1, *str2 = s2;
+	size_t i;
+	int result = 0;
+	for(i = 0; (result == 0) && (i < n); i++) {
+		result = *str1++ - *str2++;
+		}
+	return result;
+}
+
+char *strstr(const char *haystack, const char *needle)
+{
+	size_t len;
+	len = strlen(needle);
+	while(*haystack) {
+		if (memcmp(haystack, needle, len) == 0)
+			return (char *)haystack;
+		haystack++;
+	}
+	return NULL;
+}
+
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
  * and at least one byte is really needed.
@@ -346,20 +565,25 @@ static void close_output_buffer_if_we_ru
 	}
 }
 
-asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
+static void save_command_line(void)
 {
-	real_mode = rmode;
-
-	if (RM_SCREEN_INFO.orig_video_mode == 7) {
-		vidmem = (char *) 0xb0000;
-		vidport = 0x3b4;
-	} else {
-		vidmem = (char *) 0xb8000;
-		vidport = 0x3d4;
+	/* Find the command line */
+	char *cmdline;
+	cmdline = saved_command_line;
+	if (RM_NEW_CL_POINTER) {
+		cmdline = RM_NEW_CL_POINTER;
+	} else if (OLD_CL_MAGIC == RM_OLD_CL_MAGIC) {
+		cmdline = real_mode + RM_OLD_CL_OFFSET;
 	}
+	memcpy(saved_command_line, cmdline, COMMAND_LINE_SIZE);
+	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+}
 
-	lines = RM_SCREEN_INFO.orig_video_lines;
-	cols = RM_SCREEN_INFO.orig_video_cols;
+asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
+{
+	real_mode = rmode;
+	save_command_line();
+	console_init(saved_command_line);
 
 	if (free_mem_ptr < 0x100000) setup_normal_output_buffer();
 	else setup_output_buffer_if_we_run_high(mv);
-- 
1.4.2.rc2.g5209e

