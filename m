Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbSI0DkK>; Thu, 26 Sep 2002 23:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbSI0DkK>; Thu, 26 Sep 2002 23:40:10 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:25355
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261618AbSI0DkJ>; Thu, 26 Sep 2002 23:40:09 -0400
Subject: Re: bug in sys_getpid() comment?
From: Robert Love <rml@tech9.net>
To: Shaya Potter <spotter@cs.columbia.edu>,
       Commander Marcelo <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1033096884.5495.8.camel@zaphod>
References: <1033096884.5495.8.camel@zaphod>
Content-Type: multipart/mixed; boundary="=-YChzh4qwEqSn+6Oy1L+W"
Organization: 
Message-Id: <1033098309.17641.237.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 26 Sep 2002 23:45:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YChzh4qwEqSn+6Oy1L+W
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2002-09-26 at 23:21, Shaya Potter wrote:

> asmlinkage long sys_getpid(void)
> {
>         /* This is SMP safe - current->pid doesn't change */
>         return current->tgid;
> }
> 
> I assume we are returning tgid so that no matter what thread of a
> multithreaded program calls getpid we return the same value, and that
> the comment with pid is old and should have been updated when it was
> changed to return tgid.  A student in my Operating Systems class pointed
> this out, so I figured no harm in pointing the possible bug out.

Yes, you are correct, the comment is wrong.  We switched to returning
the tgid in early 2.4 when CLONE_THREAD was introduced.  The tgid and
pid are identical unless CLONE_THREAD was used.

Attached patch fixes the typo and adds some comments explaining this. 
Marcelo, patch is against 2.4.20-pre8, please apply.

	Robert Love


--=-YChzh4qwEqSn+6Oy1L+W
Content-Disposition: attachment; filename=getpid-typo-rml-2.4.20-pre8-1.patch
Content-Type: text/plain; name=getpid-typo-rml-2.4.20-pre8-1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.4.20-pre8/kernel/timer.c	Thu Sep 26 23:37:02 2002
+++ linux/kernel/timer.c	Thu Sep 26 23:39:25 2002
@@ -740,10 +740,18 @@
  * The Alpha uses getxpid, getxuid, and getxgid instead.  Maybe this
  * should be moved into arch/i386 instead?
  */
- 
+
+/**
+ * sys_getpid - return the thread group id of the current process
+ *
+ * Note, despite the name, this returns the tgid not the pid.  The tgid and
+ * the pid are identical unless CLONE_THREAD was specified on clone() in
+ * which case the tgid is the same in all threads of the same group.
+ *
+ * This is SMP safe as current->tgid does not change.
+ */
 asmlinkage long sys_getpid(void)
 {
-	/* This is SMP safe - current->pid doesn't change */
 	return current->tgid;
 }
 

--=-YChzh4qwEqSn+6Oy1L+W--

