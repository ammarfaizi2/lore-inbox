Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUHNMSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUHNMSH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 08:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUHNMSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 08:18:02 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:48069 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262768AbUHNMRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 08:17:37 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6 
In-reply-to: Your message of "Sat, 14 Aug 2004 05:50:50 +0100."
             <411D9A2A.1000202@grupopie.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Aug 2004 22:17:24 +1000
Message-ID: <8634.1092485844@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2004 05:50:50 +0100, 
Paulo Marques <pmarques@grupopie.com> wrote:
>Well, I found some time and decided to give it a go :)

This patch regresses some recent changes to kallsyms which handle
aliased symbols, IOW symbols with the same address.  The speed up is
very good, but it has two problems with repeated addresses.

The binary chop will give different results on different configs.
Depending on the chop, it will pick any one of the aliased symbols, the
previous kallsyms would always pick the first name.  For consistent bug
reports, always report the first symbol from an aliased set.

When calculating the size of a symbol, you must skip the aliased
entries.

Patch over kallsyms-speedup, to handle aliased symbols again.  Also
removes a warning about mixing code and declarations.

Index: linux/kernel/kallsyms.c
===================================================================
--- linux.orig/kernel/kallsyms.c	Sat Aug 14 22:16:06 2004
+++ linux/kernel/kallsyms.c	Sat Aug 14 22:16:04 2004
@@ -107,7 +107,8 @@ const char *kallsyms_lookup(unsigned lon
 	namebuf[0] = 0;
 
 	if (is_kernel_text(addr) || is_kernel_inittext(addr)) {
-		unsigned long symbol_end;
+		unsigned long symbol_end = 0;
+		unsigned prefix;
 		char *name;
 
 		/* do a binary search on the sorted kallsyms_addresses array */
@@ -118,6 +119,7 @@ const char *kallsyms_lookup(unsigned lon
 			if( kallsyms_addresses[mid] <= addr ) low = mid;
 			else high = mid;
 		}
+		while (low && kallsyms_addresses[low-1] == kallsyms_addresses[low]) --low;
 
 		/* Grab name */
 		i = 0;
@@ -135,7 +137,6 @@ const char *kallsyms_lookup(unsigned lon
 		}
 
 		/* find the last stem before the actual symbol that as 0 prefix */
-		unsigned prefix;
 		for (; i <= low; i++) { 
 			prefix=*name;
 			if (prefix == 0) {
@@ -156,15 +157,20 @@ const char *kallsyms_lookup(unsigned lon
 			name += strlen(name) + 1;
 		}
 
-		if(low == kallsyms_num_syms - 1) {
+		/* Search for next non-aliased symbol */
+		for (i = low + 1; i < kallsyms_num_syms; i++) {
+			if (kallsyms_addresses[i] > kallsyms_addresses[low]) {
+				symbol_end = kallsyms_addresses[i];
+				break;
+			}
+		}
+		if (!symbol_end) {
 			/* At worst, symbol ends at end of section. */
 			if (is_kernel_inittext(addr))
 				symbol_end = (unsigned long)_einittext;
 			else
 				symbol_end = (unsigned long)_etext;
 		}
-		else
-			symbol_end = kallsyms_addresses[low + 1];
 		
 		*symbolsize = symbol_end - kallsyms_addresses[low];
 		*modname = NULL;

