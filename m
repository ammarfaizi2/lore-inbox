Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbTCaW3M>; Mon, 31 Mar 2003 17:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbTCaW3M>; Mon, 31 Mar 2003 17:29:12 -0500
Received: from dp.samba.org ([66.70.73.150]:49640 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261875AbTCaW3K>;
	Mon, 31 Mar 2003 17:29:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Put all functions in kallsyms
Date: Mon, 31 Mar 2003 18:14:03 +1000
Message-Id: <20030331224033.489DD2C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Simple, untested patch.  Any objections?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Include All Functions in kallsyms
Author: Rusty Russell
Status: Experimental

D: Do not discard functions outside _stext and _etext, but include all
D: 't' or 'T' functions.  This means __init functions are included (in my
D: config this means an increas from 5691 to 6442 functions.
D:
D: TODO: Allow multiple kallsym tables, discard init one after init.
D: TODO: Use huffman name compression and 16-bit offsets (see IDE
D: oopser patch)

--- working-2.5.66-uml/scripts/kallsyms.c.~1~	2003-02-07 19:22:29.000000000 +1100
+++ working-2.5.66-uml/scripts/kallsyms.c	2003-03-31 18:08:41.000000000 +1000
@@ -14,14 +14,12 @@
 
 struct sym_entry {
 	unsigned long long addr;
-	char type;
 	char *sym;
 };
 
 
 static struct sym_entry *table;
 static int size, cnt;
-static unsigned long long _stext, _etext;
 
 static void
 usage(void)
@@ -35,8 +33,9 @@
 {
 	char str[500];
 	int rc;
+	char type;
 
-	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &s->type, str);
+	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &type, str);
 	if (rc != 3) {
 		if (rc != EOF) {
 			/* skip line */
@@ -44,19 +43,18 @@
 		}
 		return -1;
 	}
+
+	/* Only interested in functions. */
+	if (type != 't' && type != 'T')
+		return -1;
+
 	s->sym = strdup(str);
 	return 0;
 }
 
-static int
+static inline int
 symbol_valid(struct sym_entry *s)
 {
-	if (s->addr < _stext)
-		return 0;
-
-	if (s->addr > _etext)
-		return 0;
-
 	if (strstr(s->sym, "_compiled."))
 		return 0;
 
@@ -80,12 +78,6 @@
 		if (read_symbol(in, &table[cnt]) == 0)
 			cnt++;
 	}
-	for (i = 0; i < cnt; i++) {
-		if (strcmp(table[i].sym, "_stext") == 0)
-			_stext = table[i].addr;
-		if (strcmp(table[i].sym, "_etext") == 0)
-			_etext = table[i].addr;
-	}
 }
 
 static void
