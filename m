Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbTEPT4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 15:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTEPT4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 15:56:05 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:30942 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261172AbTEPT4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 15:56:03 -0400
Subject: Re: [PATCH] Process Attribute API for Security Modules 2.5.69
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <1052319765.1044.60.camel@moss-huskers.epoch.ncsc.mil>
References: <1052237601.1377.991.camel@moss-huskers.epoch.ncsc.mil>
	 <20030507105038.GN10374@parcelfarce.linux.theplanet.co.uk>
	 <1052319765.1044.60.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1053115706.4729.913.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 16:08:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, relative to the /proc/pid/attr patch against 2.5.69, fixes
the mode values of the /proc/pid/attr nodes to avoid interference by the
normal Linux access checks for these nodes (and also fixes the
/proc/pid/attr/prev mode to reflect its read-only nature).  Otherwise,
when the dumpable flag is cleared by a set[ug]id or unreadable
executable, a process will lose the ability to set its own attributes
via writes to /proc/pid/attr due to a DAC failure (/proc/pid inodes are
assigned the root uid/gid if the task is not dumpable, and the original
mode only permitted the owner to write).  The security module should
implement appropriate permission checking in its [gs]etprocattr hook
functions.  In the case of SELinux, the setprocattr hook function only
allows a process to write to its own /proc/pid/attr nodes as well as
imposing other policy-based restrictions, and the getprocattr hook
function performs a permission check between the security labels of the
current process and target process to determine whether the operation is
permitted.

 base.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.5/fs/proc/base.c
===================================================================
RCS file: /home/pal/CVS/linux-2.5/fs/proc/base.c,v
retrieving revision 1.11
retrieving revision 1.12
diff -u -r1.11 -r1.12
--- linux-2.5/fs/proc/base.c	14 May 2003 12:05:37 -0000	1.11
+++ linux-2.5/fs/proc/base.c	16 May 2003 18:34:39 -0000	1.12
@@ -99,10 +99,10 @@
 };
 #ifdef CONFIG_SECURITY
 static struct pid_entry attr_stuff[] = {
-  E(PROC_PID_ATTR_CURRENT,	"current",	S_IFREG|S_IRUGO|S_IWUSR),
-  E(PROC_PID_ATTR_PREV,	"prev",	S_IFREG|S_IRUGO|S_IWUSR),
-  E(PROC_PID_ATTR_EXEC,	"exec",	S_IFREG|S_IRUGO|S_IWUSR),
-  E(PROC_PID_ATTR_FSCREATE,	"fscreate",	S_IFREG|S_IRUGO|S_IWUSR),
+  E(PROC_PID_ATTR_CURRENT,	"current",	S_IFREG|S_IRUGO|S_IWUGO),
+  E(PROC_PID_ATTR_PREV,	"prev",	S_IFREG|S_IRUGO),
+  E(PROC_PID_ATTR_EXEC,	"exec",	S_IFREG|S_IRUGO|S_IWUGO),
+  E(PROC_PID_ATTR_FSCREATE,	"fscreate",	S_IFREG|S_IRUGO|S_IWUGO),
   {0,0,NULL,0}
 };
 #endif


 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

