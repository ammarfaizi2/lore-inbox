Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbULEF6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbULEF6z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 00:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbULEF6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 00:58:55 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:9916 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261254AbULEF6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 00:58:52 -0500
Date: Sat, 4 Dec 2004 22:58:09 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][1/2] NX: Fix noexec kernel parameter
Message-ID: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

noexec_setup runs too late to take any effect, so parse it earlier.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-rc2/arch/i386/kernel/setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/i386/kernel/setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup.c
--- linux-2.6.10-rc2/arch/i386/kernel/setup.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/i386/kernel/setup.c	4 Dec 2004 18:43:17 -0000
@@ -737,6 +737,12 @@ static void __init parse_cmdline_early (
 			}
 		}
 
+		else if (!memcmp(from, "noexec=", 7)) {
+			extern void noexec_setup(char *str);
+
+			noexec_setup(from + 7);
+		}
+
 #ifdef  CONFIG_X86_SMP
 		/*
 		 * If the BIOS enumerates physical processors before logical,
Index: linux-2.6.10-rc2/arch/i386/mm/init.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2/arch/i386/mm/init.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init.c
--- linux-2.6.10-rc2/arch/i386/mm/init.c	25 Nov 2004 19:45:32 -0000	1.1.1.1
+++ linux-2.6.10-rc2/arch/i386/mm/init.c	4 Dec 2004 18:42:40 -0000
@@ -424,7 +424,7 @@ u64 __supported_pte_mask = ~_PAGE_NX;
  * on      Enable
  * off     Disable
  */
-static int __init noexec_setup(char *str)
+void __init noexec_setup(char *str)
 {
 	if (!strncmp(str, "on",2) && cpu_has_nx) {
 		__supported_pte_mask |= _PAGE_NX;
@@ -433,11 +433,8 @@ static int __init noexec_setup(char *str
 		disable_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
 	}
-	return 1;
 }
 
-__setup("noexec=", noexec_setup);
-
 int nx_enabled = 0;
 #ifdef CONFIG_X86_PAE
 
