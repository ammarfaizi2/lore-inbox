Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUEJGGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUEJGGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 02:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUEJGGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 02:06:21 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:29685 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264531AbUEJGGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 02:06:17 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] All Symbols in /proc/kallsyms 
In-reply-to: Your message of "Mon, 10 May 2004 15:28:37 +1000."
             <1084166916.8127.46.camel@bach> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 May 2004 16:05:32 +1000
Message-ID: <11752.1084169132@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 15:28:37 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>Debuggers (ie. xmon) can use kallsyms, but they want all symbols, not
>just functions.  Fair enough.
>
>Name: Debugging Option to Put text symbols in kallsyms
>Status: Tested on 2.6.6-rc3-bk11
>
>kallsyms contains only function names, but some debuggers (eg. xmon on
>PPC/PPC64) use it to lookup symbols: it'd be much nicer if it included
>data symbols too.

The patch needs some more work.  You are including absolute symbols
that are outside the kernel text and data space, which can be very
misleading.  For debugging, you want all symbols, even if they have the
same address as the previous symbol.

The kdb 2.6.6 patch for scripts/kallsyms follows.  I cannot remember
why I excluded kallsyms_addresses, kallsyms_num_syms and
kallsyms_names, there must have been a good reason at the time.

Index: linux/scripts/kallsyms.c
--- linux.orig/scripts/kallsyms.c	Mon May 10 12:33:21 2004
+++ linux/scripts/kallsyms.c	Mon May 10 14:07:41 2004
@@ -6,6 +6,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * Usage: nm -n vmlinux | scripts/kallsyms > symbols.S
+ * If CONFIG_KDB is defined, generate all symbols for kdb.
  */
 
 #include <stdio.h>
@@ -21,7 +22,12 @@ struct sym_entry {
 
 static struct sym_entry *table;
 static int size, cnt;
-static unsigned long long _stext, _etext, _sinittext, _einittext;
+static unsigned long long _stext, _etext, _sinittext, _einittext, _end;
+#ifdef CONFIG_KDB
+#define kdb 1
+#else
+#define kdb 0
+#endif
 
 static void
 usage(void)
@@ -51,12 +57,18 @@ read_symbol(FILE *in, struct sym_entry *
 static int
 symbol_valid(struct sym_entry *s)
 {
-	if ((s->addr < _stext || s->addr > _etext)
+	if ((s->addr < _stext || (kdb && s->addr > _end) || (!kdb && s->addr > _etext))
 	    && (s->addr < _sinittext || s->addr > _einittext))
 		return 0;
 
 	if (strstr(s->sym, "_compiled."))
 		return 0;
+	if (kdb) {
+		if (strcmp(s->sym, "kallsyms_addresses") == 0 ||
+		    strcmp(s->sym, "kallsyms_num_syms") == 0 ||
+		    strcmp(s->sym, "kallsyms_names") == 0)
+		return 0;
+	}
 
 	return 1;
 }
@@ -87,6 +99,8 @@ read_map(FILE *in)
 			_sinittext = table[i].addr;
 		if (strcmp(table[i].sym, "_einittext") == 0)
 			_einittext = table[i].addr;
+		if (kdb && strcmp(table[i].sym, "_end") == 0)
+			_end = table[i].addr;
 	}
 }
 
@@ -115,7 +129,7 @@ write_src(void)
 		if (!symbol_valid(&table[i]))
 			continue;
 		
-		if (table[i].addr == last_addr)
+		if (table[i].addr == last_addr && !kdb)
 			continue;
 
 		printf("\tPTR\t%#llx\n", table[i].addr);
@@ -140,7 +154,7 @@ write_src(void)
 		if (!symbol_valid(&table[i]))
 			continue;
 		
-		if (table[i].addr == last_addr)
+		if (table[i].addr == last_addr && !kdb)
 			continue;
 
 		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)

