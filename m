Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbTABJFY>; Thu, 2 Jan 2003 04:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTABJFY>; Thu, 2 Jan 2003 04:05:24 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:17362 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264867AbTABJFX>; Thu, 2 Jan 2003 04:05:23 -0500
Date: Thu, 2 Jan 2003 10:13:25 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: andrew.morton@digeo.com
Subject: [PATCH] Fix kallsyms crashes in 2.5.54
Message-ID: <20030102091325.GA24352@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel symbol stem compression patch included in 2.5.54 unfortunately
had a few problems, triggered by various circumstances.

On some gas \x... in string constants seems to randomly eat any following
hex like character.

Hardens it more against bogus symbol table entries.

This should fix the reported crashes. No need anymore for akpm to 
back it out.

Please apply.

-Andi



--- linux-vanilla/kernel/kallsyms.c	2003-01-02 06:55:55.000000000 +0100
+++ linux/kernel/kallsyms.c	2003-01-02 11:06:30.000000000 +0100
@@ -32,6 +32,7 @@
 		BUG();
 
 	namebuf[127] = 0;
+	namebuf[0] = 0;
 
 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {
 		unsigned long symbol_end;
@@ -46,9 +47,9 @@
 
 		/* Grab name */
 		for (i = 0; i < best; i++) { 
-			++name;
-			strncpy(namebuf + name[-1], name, 127); 
-			name += strlen(name)+1;
+			unsigned prefix = *name++;
+			strncpy(namebuf + prefix, name, 127); 
+			name += strlen(name) + 1; 
 		} 
 
 		/* Base symbol size on next symbol. */
--- linux-vanilla/scripts/kallsyms.c	2003-01-02 06:55:56.000000000 +0100
+++ linux/scripts/kallsyms.c	2003-01-02 11:02:18.000000000 +0100
@@ -144,7 +144,7 @@
 		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
 			; 
 
-		printf("\t.asciz\t\"\\x%02x%s\"\n", k, table[i].sym + k);
+		printf("\t.byte 0x%02x ; .asciz\t\"%s\"\n", k, table[i].sym + k);
 		last_addr = table[i].addr;
 		prev = table[i].sym;
 	}
