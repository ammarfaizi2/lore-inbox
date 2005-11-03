Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbVKCR4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbVKCR4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVKCR4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:56:44 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:61353 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1030380AbVKCR4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:56:43 -0500
Date: Thu, 3 Nov 2005 18:56:42 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: do_sendfile ppos check ...
Message-ID: <20051103175642.GB18015@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew!

friend of mine stumbled over the following issue:

do_sendfile() does an overflow check near the end, like this:

        if (*ppos > max)
                retval = -EOVERFLOW;

now both sys_sendfile and sys_sendfile64 do call do_sendfile()
similar to this:

        if (offset) {
		...
                ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
                return ret;
        }
	return do_sendfile(out_fd, in_fd, NULL, count, 0);

which passes ppos as NULL, which in turn leads to an oops ...

here is a patch (suggestion) to handle this properly, which
also adjusts the max for sys_sendfile()
(let me know what you think!)


--- linux-2.6.14/fs/read_write.c	2005-10-28 20:49:45 +0200
+++ linux-2.6.14-sendfile/fs/read_write.c	2005-11-03 18:48:37 +0100
@@ -731,7 +731,8 @@ asmlinkage ssize_t sys_sendfile(int out_
		return ret;
	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	pos = 0;
+	return do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
 }
 
 asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t __user *offset, size_t count)
@@ -748,5 +749,6 @@ asmlinkage ssize_t sys_sendfile64(int ou
		return ret;
	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	pos = 0;
+	return do_sendfile(out_fd, in_fd, &pos, count, 0);
 }

