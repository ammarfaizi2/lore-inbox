Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbUEKFKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUEKFKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 01:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEKFKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 01:10:33 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:8585 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262052AbUEKFKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 01:10:20 -0400
Subject: [PATCH] Sort kallsyms in name order: kernel shrinks by 30k
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, randy.dunlap@osdl.org,
       Sam Ravnborg <sam@ravnborg.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1084252135.31802.312.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 15:08:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Admittedly, anyone who sets CONFIG_KALLSYMS doesn't care about space,
it's a fairly trivial change.

Name: Sort Kallsyms for Stem Compression
Status: Booted on 2.6.6
Depends: Misc/kallsyms-include-aliases.patch.gz

Leaving the symbols sorted by name rather than address, so stem
compression works more effectively.  Saves a little over 30k here.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5923-linux-2.6.6/Makefile .5923-linux-2.6.6.updated/Makefile
--- .5923-linux-2.6.6/Makefile	2004-05-10 15:12:44.000000000 +1000
+++ .5923-linux-2.6.6.updated/Makefile	2004-05-11 14:45:37.000000000 +1000
@@ -567,7 +567,7 @@ ifdef CONFIG_KALLSYMS
 kallsyms.o := .tmp_kallsyms2.o
 
 quiet_cmd_kallsyms = KSYM    $@
-cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) > $@
+cmd_kallsyms = $(NM) $< | $(KALLSYMS) > $@
 
 .tmp_kallsyms1.o .tmp_kallsyms2.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5923-linux-2.6.6/kernel/kallsyms.c .5923-linux-2.6.6.updated/kernel/kallsyms.c
--- .5923-linux-2.6.6/kernel/kallsyms.c	2004-05-11 14:45:36.000000000 +1000
+++ .5923-linux-2.6.6.updated/kernel/kallsyms.c	2004-05-11 14:49:45.000000000 +1000
@@ -62,7 +62,7 @@ const char *kallsyms_lookup(unsigned lon
 			    unsigned long *offset,
 			    char **modname, char *namebuf)
 {
-	unsigned long i, best = 0;
+	unsigned long i, best = -1UL;
 
 	/* This kernel should never had been booted. */
 	BUG_ON(!kallsyms_addresses);
@@ -74,10 +74,12 @@ const char *kallsyms_lookup(unsigned lon
 		unsigned long symbol_end;
 		char *name = kallsyms_names;
 
-		/* They're sorted, we could be clever here, but who cares? */
+		/* Look for closest symbol <= address. */
 		for (i = 0; i < kallsyms_num_syms; i++) {
-			if (kallsyms_addresses[i] > kallsyms_addresses[best] &&
-			    kallsyms_addresses[i] <= addr)
+			if (kallsyms_addresses[i] > addr)
+				continue;
+			if (best == -1UL
+			    ||kallsyms_addresses[i] > kallsyms_addresses[best])
 				best = i;
 		}
 
@@ -94,12 +96,11 @@ const char *kallsyms_lookup(unsigned lon
 		else
 			symbol_end = (unsigned long)_etext;
 
-		/* Search for next non-aliased symbol */
-		for (i = best+1; i < kallsyms_num_syms; i++) {
-			if (kallsyms_addresses[i] > kallsyms_addresses[best]) {
+		/* Search for next symbol */
+		for (i = 0; i < kallsyms_num_syms; i++) {
+			if (kallsyms_addresses[i] > kallsyms_addresses[best]
+			    && kallsyms_addresses[i] < symbol_end)
 				symbol_end = kallsyms_addresses[i];
-				break;
-			}
 		}
 
 		*symbolsize = symbol_end - kallsyms_addresses[best];


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

