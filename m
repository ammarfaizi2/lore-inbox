Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266682AbUHIOjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUHIOjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUHIOg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:36:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:55733 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266678AbUHIOgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:36:02 -0400
Message-ID: <41178C49.3080305@sgi.com>
Date: Mon, 09 Aug 2004 09:38:01 -0500
From: Josh Aas <josha@sgi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       steiner@sgi.com
Subject: [PATCH] Reduce bkl usage in do_coredump
Content-Type: multipart/mixed;
 boundary="------------050004060106010308080007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050004060106010308080007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A patch that reduces bkl usage in do_coredump is attached. I don't see 
anywhere that it is necessary except for the call to format_corename, 
which is controlled via sysctl (sys_sysctl holds the bkl).

Also make format_corename() static.

Signed-off-by: Josh Aas <josha@sgi.com>

-- 
Josh Aas
Silicon Graphics, Inc. (SGI)
Linux System Software
651-683-3068

--------------050004060106010308080007
Content-Type: text/x-patch;
 name="coredump_bkl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="coredump_bkl.patch"

--- a/fs/exec.c	2004-08-09 09:14:53.000000000 -0500
+++ b/fs/exec.c	2004-08-09 09:18:50.000000000 -0500
@@ -1193,7 +1193,7 @@ EXPORT_SYMBOL(set_binfmt);
  * name into corename, which must have space for at least
  * CORENAME_MAX_SIZE bytes plus one byte for the zero terminator.
  */
-void format_corename(char *corename, const char *pattern, long signr)
+static void format_corename(char *corename, const char *pattern, long signr)
 {
 	const char *pat_ptr = pattern;
 	char *out_ptr = corename;
@@ -1357,7 +1357,6 @@ int do_coredump(long signr, int exit_cod
 	struct file * file;
 	int retval = 0;
 
-	lock_kernel();
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
@@ -1375,7 +1374,13 @@ int do_coredump(long signr, int exit_cod
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail_unlock;
 
- 	format_corename(corename, core_pattern, signr);
+	/* 
+	 * lock_kernel() because format_corename() is controlled by sysctl, which
+	 * uses lock_kernel()
+	 */
+ 	lock_kernel();
+	format_corename(corename, core_pattern, signr);
+	unlock_kernel();
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
 	if (IS_ERR(file))
 		goto fail_unlock;
@@ -1402,6 +1407,5 @@ close_fail:
 fail_unlock:
 	complete_all(&mm->core_done);
 fail:
-	unlock_kernel();
 	return retval;
 }

--------------050004060106010308080007--
