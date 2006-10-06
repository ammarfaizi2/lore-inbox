Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422990AbWJFVyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422990AbWJFVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422991AbWJFVyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:54:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18638 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422990AbWJFVyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:54:15 -0400
Date: Fri, 6 Oct 2006 17:54:12 -0400
From: Dave Jones <davej@redhat.com>
To: ak@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Compress stack unwinder output
Message-ID: <20061006215412.GB15420@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ak@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The unwinder has some extra newlines, which eat up loads of screen
space when it spews. (See https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=137900
for a nasty example).

warning_symbol-> and warning-> already printk a newline, so don't add one
in the strings passed to them.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.18.noarch/arch/x86_64/kernel/traps.c~	2006-10-06 17:42:47.000000000 -0400
+++ linux-2.6.18.noarch/arch/x86_64/kernel/traps.c	2006-10-06 17:47:23.000000000 -0400
@@ -289,21 +289,21 @@ void dump_trace(struct task_struct *tsk,
 		}
 		if (unw_ret > 0) {
 			if (call_trace == 1 && !arch_unw_user_mode(&info)) {
-				ops->warning_symbol(data, "DWARF2 unwinder stuck at %s\n",
+				ops->warning_symbol(data, "DWARF2 unwinder stuck at %s",
 					     UNW_PC(&info));
 				if ((long)UNW_SP(&info) < 0) {
-					ops->warning(data, "Leftover inexact backtrace:\n");
+					ops->warning(data, "Leftover inexact backtrace:");
 					stack = (unsigned long *)UNW_SP(&info);
 					if (!stack)
 						return;
 				} else
-					ops->warning(data, "Full inexact backtrace again:\n");
+					ops->warning(data, "Full inexact backtrace again:");
 			} else if (call_trace >= 1)
 				return;
 			else
-				ops->warning(data, "Full inexact backtrace again:\n");
+				ops->warning(data, "Full inexact backtrace again:");
 		} else
-			ops->warning(data, "Inexact backtrace:\n");
+			ops->warning(data, "Inexact backtrace:");
 	}
 	if (!stack) {
 		unsigned long dummy;
--- linux-2.6.18.noarch/arch/i386/kernel/traps.c~	2006-10-06 17:47:28.000000000 -0400
+++ linux-2.6.18.noarch/arch/i386/kernel/traps.c	2006-10-06 17:47:45.000000000 -0400
@@ -194,22 +194,22 @@ void dump_trace(struct task_struct *task
 		}
 		if (unw_ret > 0) {
 			if (call_trace == 1 && !arch_unw_user_mode(&info)) {
-				ops->warning_symbol(data, "DWARF2 unwinder stuck at %s\n",
+				ops->warning_symbol(data, "DWARF2 unwinder stuck at %s",
 					     UNW_PC(&info));
 				if (UNW_SP(&info) >= PAGE_OFFSET) {
-					ops->warning(data, "Leftover inexact backtrace:\n");
+					ops->warning(data, "Leftover inexact backtrace:");
 					stack = (void *)UNW_SP(&info);
 					if (!stack)
 						return;
 					ebp = UNW_FP(&info);
 				} else
-					ops->warning(data, "Full inexact backtrace again:\n");
+					ops->warning(data, "Full inexact backtrace again:");
 			} else if (call_trace >= 1)
 				return;
 			else
-				ops->warning(data, "Full inexact backtrace again:\n");
+				ops->warning(data, "Full inexact backtrace again:");
 		} else
-			ops->warning(data, "Inexact backtrace:\n");
+			ops->warning(data, "Inexact backtrace:");
 	}
 	if (!stack) {
 		unsigned long dummy;
-- 
http://www.codemonkey.org.uk
