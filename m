Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbTABSJh>; Thu, 2 Jan 2003 13:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbTABSJh>; Thu, 2 Jan 2003 13:09:37 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:3335 "HELO
	ritz.dnsart.com") by vger.kernel.org with SMTP id <S266274AbTABSJg> convert rfc822-to-8bit;
	Thu, 2 Jan 2003 13:09:36 -0500
Date: Thu, 2 Jan 2003 19:17:59 +0200
X-Mailer: i.Scribe v1.84 (Win32 v5.00, Release)
To: <ak@muc.de>, <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
From: "Daniel Ritz" <daniel.ritz@gmx.ch>
Subject: [PATCH] Fix kallsyms stem compression crash
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20030102181810.7A6E24AB4@ritz.dnsart.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc, i'm not on the list]

the attached patch fixes the crash top or cat /proc/*/wchan produces when using KALLSYMS
it's a buffer overrun that should not happen. maybe 128 chars is just too small...i'm going to check that...
based on patch by andi kleen.

against 2.5.54. please apply.


beep
-daniel


--- 2554-clean/kernel/kallsyms.c	2003-01-02 04:23:14.000000000 +0100
+++ 2554/kernel/kallsyms.c	2003-01-02 18:51:39.000000000 +0100
@@ -32,6 +32,7 @@
 		BUG();
 
 	namebuf[127] = 0;
+	namebuf[0] = 0;
 
 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {
 		unsigned long symbol_end;
@@ -46,10 +47,10 @@
 
 		/* Grab name */
 		for (i = 0; i < best; i++) { 
-			++name;
-			strncpy(namebuf + name[-1], name, 127); 
-			name += strlen(name)+1;
-		} 
+			unsigned prefix = *name++;
+			strncpy(namebuf + prefix, name, 127 - prefix);
+			name += strlen(name) + 1;
+		}
 
 		/* Base symbol size on next symbol. */
 		if (best + 1 < kallsyms_num_syms)
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



