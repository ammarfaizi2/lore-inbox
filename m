Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266766AbUHIRbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266766AbUHIRbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbUHIRa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:30:59 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:26802 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266766AbUHIRaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:30:46 -0400
Subject: Re: [PATCH] Reduce bkl usage in do_coredump
From: Dave Hansen <haveblue@us.ibm.com>
To: Josh Aas <josha@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, steiner@sgi.com
In-Reply-To: <41178C49.3080305@sgi.com>
References: <41178C49.3080305@sgi.com>
Content-Type: multipart/mixed; boundary="=-l1RUyeSoaa4wcLXzqFmd"
Message-Id: <1092072631.6496.14553.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 10:30:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l1RUyeSoaa4wcLXzqFmd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-08-09 at 07:38, Josh Aas wrote:
> A patch that reduces bkl usage in do_coredump is attached. I don't see 
> anywhere that it is necessary except for the call to format_corename, 
> which is controlled via sysctl (sys_sysctl holds the bkl).

> -       format_corename(corename, core_pattern, signr);
> +       /* 
> +        * lock_kernel() because format_corename() is controlled by sysctl, which
> +        * uses lock_kernel()
> +        */
> +       lock_kernel();
> +       format_corename(corename, core_pattern, signr);
> +       unlock_kernel();

Might be nicer to just put the locking inside of format_corename() if it
is the function itself that really needs the locking.  If another use of
it popped up, that user would get the locking for free and couldn't
possibly forget it.  Also, it's nicer to put the lock closer to the code
that actually needs it.  Untested patch to do that attached.

BTW, were you actually seeing a BKL contention problem, or was this just
for cleanliness?

-- Dave

--=-l1RUyeSoaa4wcLXzqFmd
Content-Disposition: attachment; filename=coredump_bkl-1.patch
Content-Type: text/x-patch; name=coredump_bkl-1.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- clean-fixup.1/fs/exec.c.orig	2004-08-09 10:25:27.000000000 -0700
+++ clean-fixup.1/fs/exec.c	2004-08-09 10:27:25.000000000 -0700
@@ -1209,7 +1209,7 @@ EXPORT_SYMBOL(set_binfmt);
  * name into corename, which must have space for at least
  * CORENAME_MAX_SIZE bytes plus one byte for the zero terminator.
  */
-void format_corename(char *corename, const char *pattern, long signr)
+static void format_corename(char *corename, const char *pattern, long signr)
 {
 	const char *pat_ptr = pattern;
 	char *out_ptr = corename;
@@ -1217,6 +1217,10 @@ void format_corename(char *corename, con
 	int rc;
 	int pid_in_pattern = 0;
 
+	/* 
+	 * the format is controlled by sysctl, which uses lock_kernel()
+	 */
+	lock_kernel();
 	/* Repeat as long as we have more pattern to process and more output
 	   space */
 	while (*pat_ptr) {
@@ -1317,6 +1321,8 @@ void format_corename(char *corename, con
 	}
       out:
 	*out_ptr = 0;
+
+	unlock_kernel();
 }
 
 static void zap_threads (struct mm_struct *mm)
@@ -1373,7 +1379,6 @@ int do_coredump(long signr, int exit_cod
 	struct file * file;
 	int retval = 0;
 
-	lock_kernel();
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
@@ -1418,6 +1423,5 @@ close_fail:
 fail_unlock:
 	complete_all(&mm->core_done);
 fail:
-	unlock_kernel();
 	return retval;
 }

--=-l1RUyeSoaa4wcLXzqFmd--

