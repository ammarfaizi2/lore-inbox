Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268114AbUIGObf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268114AbUIGObf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268116AbUIGObf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:31:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:29831 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268114AbUIGO24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:28:56 -0400
Date: Tue, 7 Sep 2004 16:27:53 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: bastian@suse.de
Subject: [PATCH] Add prctl to modify current->comm
Message-ID: <20040907142753.GA20981@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a prctl to modify current->comm as shown in /proc.
This feature was requested by KDE developers. In KDE most programs
are started by forking from a kdeinit program that already has the 
libraries loaded and some other state. 

Problem is to give these forked programs the proper name.
It already writes the command line in the environment (as seen in ps),
but top uses a different field in /proc/pid/status that reports
current->comm. And that was always "kdeinit" instead of the
real command name. So you ended up with lots of kdeinits
in your top listing, which was not very useful.

This patch adds a new prctl PR_SET_NAME to allow a program to change its 
comm field. 

I considered the potential security issues of a program obscuring
itself with this interface, but I don't think it matters much
because a program can already obscure itself when the admin uses
ps instead of top. In case of a KDE desktop calling everything
kdeinit is much more obfuscation than the alternative.

diff -u linux-2.6.8-5/kernel/sys.c-o linux-2.6.8-5/kernel/sys.c
--- linux-2.6.8-5/kernel/sys.c-o	2004-08-14 07:36:16.000000000 +0200
+++ linux-2.6.8-5/kernel/sys.c	2004-09-07 11:34:07.000000000 +0200
@@ -1660,6 +1660,13 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_SET_NAME: {
+			struct task_struct *me = current;
+			me->comm[sizeof(me->comm)-1] = 0;
+			if (strncpy_from_user(me->comm, (char *)arg2, sizeof(me->comm)-1) < 0)
+				return -EFAULT;
+			return 0;
+		}
 		default:
 			error = -EINVAL;
 			break;
diff -u linux-2.6.8-5/include/linux/prctl.h-o linux-2.6.8-5/include/linux/prctl.h
--- linux-2.6.8-5/include/linux/prctl.h-o	2004-08-14 07:37:14.000000000 +0200
+++ linux-2.6.8-5/include/linux/prctl.h	2004-09-07 11:35:02.000000000 +0200
@@ -49,5 +49,6 @@
 # define PR_TIMING_TIMESTAMP    1       /* Accurate timestamp based
                                                    process timing */
 
+#define PR_SET_NAME    15		/* Set process name. */
 
 #endif /* _LINUX_PRCTL_H */
