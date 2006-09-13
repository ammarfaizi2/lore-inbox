Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbWIMIKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWIMIKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWIMIKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:10:23 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:50156 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751685AbWIMIKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:10:22 -0400
Date: Wed, 13 Sep 2006 10:11:22 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [-mm patch] AVR32: Use parse_early_param
Message-ID: <20060913101122.72d7c0a1@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the AVR32-specific parse_cmdline_early function and call
parse_early_param instead. Parsing of the "fbmem=" parameter has been
implemented using early_param, allowing it to be greatly simplified.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/setup.c |   60 ++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 41 deletions(-)

Index: linux-2.6.18-rc5-mm1/arch/avr32/kernel/setup.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/arch/avr32/kernel/setup.c	2006-09-07 09:40:48.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/avr32/kernel/setup.c	2006-09-07 10:05:07.000000000 +0200
@@ -90,48 +90,24 @@ static struct resource mem_res[] = {
 static unsigned long __initdata fbmem_start;
 static unsigned long __initdata fbmem_size;
 
-/* --- */
-
-static void __init parse_cmdline_early(char **cmdline_p)
+/*
+ * "fbmem=xxx[kKmM]" allocates the specified amount of boot memory for
+ * use as framebuffer.
+ *
+ * "fbmem=xxx[kKmM]@yyy[kKmM]" defines a memory region of size xxx and
+ * starting at yyy to be reserved for use as framebuffer.
+ *
+ * The kernel won't verify that the memory region starting at yyy
+ * actually contains usable RAM.
+ */
+static int __init early_parse_fbmem(char *p)
 {
-	char *to = command_line, *from = saved_command_line;
-	int len = 0;
-	char c = ' ';
-
-	for (;;) {
-		if (c != ' ')
-			goto next_char;
-
-		/*
-		 * "fbmem=xxx[kKmM]" allocates the specified amount of
-		 * boot memory for use as framebuffer.
-		 * "fbmem=xxx[kKmM]@yyy" defines a memory region of
-		 * size xxx and starting at yyy to be reserved for use
-		 * as framebuffer.
-		 *
-		 * The kernel won't verify that the memory region
-		 * starting at yyy actually contains usable RAM.
-		 */
-		if (!memcmp(from, "fbmem=", 6)) {
-			if (to != command_line)
-				to--;
-			fbmem_size = memparse(from + 6, &from);
-			if (*from == '@')
-				fbmem_start = memparse(from + 1, &from);
-		}
-
-	next_char:
-		c = *(from++);
-		if (c == '\0')
-			break;
-		if (COMMAND_LINE_SIZE <= ++len)
-			break;
-		*(to++) = c;
-	}
-
-	*to = '\0';
-	*cmdline_p = command_line;
+	fbmem_size = memparse(p, &p);
+	if (*p == '@')
+		fbmem_start = memparse(p, &p);
+	return 0;
 }
+early_param("fbmem", early_parse_fbmem);
 
 static inline void __init resource_init(void)
 {
@@ -341,7 +317,9 @@ void __init setup_arch (char **cmdline_p
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
-	parse_cmdline_early(cmdline_p);
+	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
+	parse_early_param();
 
 	setup_bootmem();
 
