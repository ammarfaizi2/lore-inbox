Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWHQArp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWHQArp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWHQArp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:47:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932164AbWHQArp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:47:45 -0400
Message-Id: <200608170046.k7H0kfYU014956@pasta.boston.redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix wrong error code on interrupted close syscalls
In-Reply-To: My message of "Thu, 10 Aug 2006 19:36:57 EDT."
             <200608102336.k7ANavV6009581@pasta.boston.redhat.com>
Date: Wed, 16 Aug 2006 20:46:41 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 10-Aug-2006 at 19:36 EDT, Ernie Petrides wrote:

> [...]
> The bottom line is that close() syscalls are not restartable, and
> thus -ERESTARTSYS return values should be mapped to -EINTR.  This
> is consistent with the close(2) manual page.  The fix is below.
> [...]
> --- linux-2.6.17/fs/open.c.orig
> +++ linux-2.6.17/fs/open.c
> @@ -1172,6 +1172,7 @@ asmlinkage long sys_close(unsigned int f
>  	struct file * filp;
>  	struct files_struct *files = current->files;
>  	struct fdtable *fdt;
> +	int retval;
>  
>  	spin_lock(&files->file_lock);
>  	fdt = files_fdtable(files);
> @@ -1184,7 +1185,10 @@ asmlinkage long sys_close(unsigned int f
>  	FD_CLR(fd, fdt->close_on_exec);
>  	__put_unused_fd(files, fd);
>  	spin_unlock(&files->file_lock);
> -	return filp_close(filp, files);
> +	retval = filp_close(filp, files);
> +
> +	/* can't restart close syscall because file table entry was cleared */
> +	return (retval == -ERESTARTSYS) ? -EINTR : retval;
>  
>  out_unlock:
>  	spin_unlock(&files->file_lock);


Hi, Andrew.  Roland McGrath has pointed out to me that my original patch
for this problem only handles the case of ERESTARTSYS, but doesn't treat
the three other restart pseudo-error codes similarly.

I don't see how any code currently in the 2.6.17 source tree could possibly
result in any ERESTARTNOINTR, ERESTARTNOHAND, or ERESTART_RESTARTBLOCK
errors being sent back through filp_close().

But if you prefer the extra checks for completeness, feel free to add
the incremental patch below (on top of my previous patch to check for
ERESTARTSYS).

Cheers.  -ernie



--- linux-2.6.17/fs/open.c.prev
+++ linux-2.6.17/fs/open.c
@@ -1188,7 +1188,13 @@ asmlinkage long sys_close(unsigned int f
 	retval = filp_close(filp, files);
 
 	/* can't restart close syscall because file table entry was cleared */
-	return (retval == -ERESTARTSYS) ? -EINTR : retval;
+	if (unlikely(retval == -ERESTARTSYS ||
+		     retval == -ERESTARTNOINTR ||
+		     retval == -ERESTARTNOHAND ||
+		     retval == -ERESTART_RESTARTBLOCK))
+		retval = -EINTR;
+
+	return retval;
 
 out_unlock:
 	spin_unlock(&files->file_lock);
