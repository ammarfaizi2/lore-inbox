Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUEKCuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUEKCuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 22:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUEKCuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 22:50:55 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:8598 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S261380AbUEKCut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 22:50:49 -0400
Subject: Re: [PATCH*] show last kernel-image symbol in /proc/kallsyms
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20040510162413.6db2d60e.rddunlap@osdl.org>
References: <20040509171452.09ee1ca0.rddunlap@osdl.org>
	 <1084162450.8121.6.camel@bach> <20040510105606.27554ad0.rddunlap@osdl.org>
	 <20040510162413.6db2d60e.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1084243805.31807.280.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 12:50:07 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 09:24, Randy.Dunlap wrote:
> On Mon, 10 May 2004 10:56:06 -0700 Randy.Dunlap wrote:
> | And thanks for taking time to fix it.
> | It now works as expected.  :)
> 
> Welllll, almost as expected.  I now see _einittext as hoped and
> expected.  However, sometimes I don't see _etext... if it has the
> same address as another (previous) symbol, which it can.

I've been reconsidering this optimization anyway: there are only a few
symbols which are aliases for other symbols.

How's this?

Rusty.

Name: Include Aliases in kallsyms
Status: Booted on 2.6.6-mm1
Version: -mm

Kallsyms discards symbols with the same address, but these are
sometimes useful.  Skip this minor optimization and make
kallsyms_lookup deal with aliases

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31104-linux-2.6.6-mm1/kernel/kallsyms.c .31104-linux-2.6.6-mm1.updated/kernel/kallsyms.c
--- .31104-linux-2.6.6-mm1/kernel/kallsyms.c	2004-03-12 07:57:28.000000000 +1100
+++ .31104-linux-2.6.6-mm1.updated/kernel/kallsyms.c	2004-05-11 10:42:52.000000000 +1000
@@ -88,14 +88,20 @@ const char *kallsyms_lookup(unsigned lon
 			name += strlen(name) + 1;
 		}
 
-		/* Base symbol size on next symbol. */
-		if (best + 1 < kallsyms_num_syms)
-			symbol_end = kallsyms_addresses[best + 1];
-		else if (is_kernel_inittext(addr))
+		/* At worst, symbol ends at end of section. */
+		if (is_kernel_inittext(addr))
 			symbol_end = (unsigned long)_einittext;
 		else
 			symbol_end = (unsigned long)_etext;
 
+		/* Search for next non-aliased symbol */
+		for (i = best+1; i < kallsyms_num_syms; i++) {
+			if (kallsyms_addresses[i] > kallsyms_addresses[best]) {
+				symbol_end = kallsyms_addresses[i];
+				break;
+			}
+		}
+
 		*symbolsize = symbol_end - kallsyms_addresses[best];
 		*modname = NULL;
 		*offset = addr - kallsyms_addresses[best];
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31104-linux-2.6.6-mm1/scripts/kallsyms.c .31104-linux-2.6.6-mm1.updated/scripts/kallsyms.c
--- .31104-linux-2.6.6-mm1/scripts/kallsyms.c	2003-09-22 10:07:21.000000000 +1000
+++ .31104-linux-2.6.6-mm1.updated/scripts/kallsyms.c	2004-05-11 10:39:14.000000000 +1000
@@ -93,7 +93,6 @@ read_map(FILE *in)
 static void
 write_src(void)
 {
-	unsigned long long last_addr;
 	int i, valid = 0;
 	char *prev;
 
@@ -111,16 +110,12 @@ write_src(void)
 	printf(".globl kallsyms_addresses\n");
 	printf("\tALGN\n");
 	printf("kallsyms_addresses:\n");
-	for (i = 0, last_addr = 0; i < cnt; i++) {
+	for (i = 0; i < cnt; i++) {
 		if (!symbol_valid(&table[i]))
 			continue;
-		
-		if (table[i].addr == last_addr)
-			continue;
 
 		printf("\tPTR\t%#llx\n", table[i].addr);
 		valid++;
-		last_addr = table[i].addr;
 	}
 	printf("\n");
 
@@ -134,20 +129,16 @@ write_src(void)
 	printf("\tALGN\n");
 	printf("kallsyms_names:\n");
 	prev = ""; 
-	for (i = 0, last_addr = 0; i < cnt; i++) {
+	for (i = 0; i < cnt; i++) {
 		int k;
 
 		if (!symbol_valid(&table[i]))
 			continue;
-		
-		if (table[i].addr == last_addr)
-			continue;
 
 		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
 			; 
 
 		printf("\t.byte 0x%02x\n\t.asciz\t\"%s\"\n", k, table[i].sym + k);
-		last_addr = table[i].addr;
 		prev = table[i].sym;
 	}
 	printf("\n");

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

