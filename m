Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262753AbTCJId6>; Mon, 10 Mar 2003 03:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262754AbTCJId6>; Mon, 10 Mar 2003 03:33:58 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262753AbTCJIde>;
	Mon, 10 Mar 2003 03:33:34 -0500
Date: Sun, 9 Mar 2003 23:16:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Fix mem= options
Message-ID: <20030309221624.GA26517@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

HPA told me bootloaders need to parse mem=, so we should invent other
option for stuff like mem=exactmap. Please apply,
								Pavel

--- clean/arch/i386/kernel/setup.c	2003-03-06 23:25:14.000000000 +0100
+++ linux/arch/i386/kernel/setup.c	2003-03-08 00:18:21.000000000 +0100
@@ -527,6 +527,9 @@
 		 * to <mem>, overriding the bios size.
 		 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
 		 * <start> to <start>+<mem>, overriding the bios size.
+		 *
+		 * HPA tells me bootloaders need to parse mem=, so no new
+		 * option should be mem=
 		 */
 		if (c == ' ' && !memcmp(from, "mem=", 4)) {
 			if (to != command_line)
@@ -535,8 +538,24 @@
 				from += 9+4;
 				clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
 				disable_pse = 1;
-			} else if (!memcmp(from+4, "exactmap", 8)) {
-				from += 8+4;
+			} else {
+				/* If the user specifies memory size, we
+				 * limit the BIOS-provided memory map to
+				 * that size. exactmap can be used to specify
+				 * the exact map. mem=number can be used to
+				 * trim the existing memory map.
+				 */
+				unsigned long long start_at, mem_size;
+ 
+				mem_size = memparse(from+4, &from);
+			}
+		}
+
+		if (c == ' ' && !memcmp(from, "memmap=", 7)) {
+			if (to != command_line)
+				to--;
+			if (!memcmp(from+7, "exactmap", 8)) {
+				from += 8+7;
 				e820.nr_map = 0;
 				userdef = 1;
 			} else {
@@ -548,7 +567,7 @@
 				 */
 				unsigned long long start_at, mem_size;
  
-				mem_size = memparse(from+4, &from);
+				mem_size = memparse(from+7, &from);
 				if (*from == '@') {
 					start_at = memparse(from+1, &from);
 					add_memory_region(start_at, mem_size, E820_RAM);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
