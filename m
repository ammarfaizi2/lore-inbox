Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUC2BfH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 20:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUC2BfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 20:35:07 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:15341
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262556AbUC2Bev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 20:34:51 -0500
Message-ID: <40677D1B.9060801@redhat.com>
Date: Sun, 28 Mar 2004 17:34:19 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040328
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kern >> Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: For the almost 4-year anniversary: O_CLOEXEC again
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last time I commented about this was almost exactly 4 years ago.
And the problem is still not resolved.

The situation is this:

       thread 1                           thread 2

       fd = open(...)

                                          fork()

       fcntl(fd, F_SETFD, FD_CLOEXEC)

                                          execve()


Multi-threaded apps can use fork().  Requiring theese use of fork() to
syncronize with every other thread and every piece of code which they
use wrt to opening files is impossible.  Likewise impossible is it to
change the default to FD_CLOEXEC by default.

Some (vocal) people requested to always use separate processes when
security sensitive files are opened, processes which then can be single
threaded.  I find this hardly acceptable especially since it just
introduces additional problems.  Just think about opendir() which just
opens the directory using open().

The proposed solution is simple and already implemented on some systems
(QNX, BeOS, maybe more).  Beside the definition of O_CLOEXEC the
untested patch below should be all that's needed.  It does *not* solve
the related problem of socket descriptors etc.  I've no good idea for
those situations.  It cannot be done through a per-thread switch which
decides whether newly allocated descriptors are CLOEXEC until further
notice since open() is a signal-safe interface.  The signal handler code
might not be aware of this mode and create descriptors which are not
inherited.  At least this little change can handle open().

I sincerely hope that this is not again answered with curses on POSIX
and its authors.  POSIX is here to stay and we should do whatever is
possible to fix it.


--- fs/open.c   2004-03-13 21:16:11.000000000 -0800
+++ fs/open.c-ud        2004-03-28 15:43:23.000000000 -0800
@@ -938,11 +938,14 @@ asmlinkage long sys_open(const char __us
        if (!IS_ERR(tmp)) {
                fd = get_unused_fd();
                if (fd >= 0) {
-                       struct file *f = filp_open(tmp, flags, mode);
+                       struct file *f = filp_open(tmp, flags & ~O_CLOEXEC,
+                                                  mode);
                        error = PTR_ERR(f);
                        if (IS_ERR(f))
                                goto out_error;
                        fd_install(fd, f);
+                       if (flags & O_CLOEXEC)
+                               set_close_on_exec(fd, 1);
                }
 out:
                putname(tmp);


-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
