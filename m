Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbULEG6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbULEG6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 01:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbULEG6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 01:58:39 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:16317 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261265AbULEG6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 01:58:36 -0500
Date: Sat, 4 Dec 2004 23:57:38 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH] NX: Fix noexec kernel parameter / x86_64
In-Reply-To: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0412042356340.6378@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

noexec_setup runs too late to take any effect, so parse it earlier.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-rc2/arch/x86_64/kernel/setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/x86_64/kernel/setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup.c
--- linux-2.6.10-rc2/arch/x86_64/kernel/setup.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/x86_64/kernel/setup.c	5 Dec 2004 06:43:11 -0000
@@ -312,6 +312,12 @@ static __init void parse_cmdline_early (
 		if (!memcmp(from,"oops=panic", 10))
 			panic_on_oops = 1;
 
+		if (!memcmp(from, "noexec=", 7)) {
+			extern void nonx_setup(char *str);
+	
+			nonx_setup(from + 7);
+		}
+
 	next_char:
 		c = *(from++);
 		if (!c)
Index: linux-2.6.10-rc2/arch/x86_64/kernel/setup64.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/x86_64/kernel/setup64.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup64.c
--- linux-2.6.10-rc2/arch/x86_64/kernel/setup64.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/x86_64/kernel/setup64.c	5 Dec 2004 06:43:49 -0000
@@ -50,7 +50,7 @@ Control non executable mappings for 64bi
 on	Enable(default)
 off	Disable
 */ 
-static int __init nonx_setup(char *str)
+void __init nonx_setup(char *str)
 {
 	if (!strcmp(str, "on")) {
                 __supported_pte_mask |= _PAGE_NX; 
@@ -59,11 +59,8 @@ static int __init nonx_setup(char *str)
 		do_not_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
         } 
-        return 1;
 } 
 
-__setup("noexec=", nonx_setup); 
-
 /*
  * Great future plan:
  * Declare PDA itself and support (irqstack,tss,pml4) as per cpu data.
