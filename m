Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVB0KRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVB0KRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 05:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVB0KRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 05:17:46 -0500
Received: from [61.135.145.13] ([61.135.145.13]:3864 "EHLO
	websmtp2.mail.sohu.com") by vger.kernel.org with ESMTP
	id S261292AbVB0KRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 05:17:34 -0500
Message-ID: <17855236.1109499454066.JavaMail.postfix@mx20.mail.sohu.com>
Date: Sun, 27 Feb 2005 18:17:34 +0800 (CST)
From: <stone_wang@sohu.com>
To: <riel@redhat.com>, <akpm@osdl.org>
Subject: [PATCH] Linux-2.6.11-rc5: kernel/sys.c setrlimit() RLIMIT_RSS cleanup
Cc: <linux-mm@kvack.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 210.21.32.84
X-Priority: 3
X-SHMOBILE: 0
X-Sohu-Antivirus: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ulimit dont enforce RLIMIT_RSS now,while sys_setrlimit() pretend it(RLIMIT_RSS) is enforced. 

This may cause confusion to users, and may lead to un-guaranteed dependence on "ulimit -m" to limit users/applications.

The patch fixed the problem. 

-- snip from system run with patched(patch attached) 2.6.11-rc5 kernel
$ ulimit  -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
file size               (blocks, -f) unlimited
pending signals                 (-i) 1024
max locked memory       (kbytes, -l) 32
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 4091
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

$ ulimit  -m 100000
bash: ulimit: max memory size: cannot modify limit: Function not implemented

-
patch: 2.6.11-rc5 kernel/sys.c setrlimit() RLIMIT_RSS cleanup

Signed-Off-By: Stone Wang  <stone_wang@sohu.com>

diff -urpN linux-2.6.11-rc5-original/kernel/sys.c linux-2.6.11-rc5-cleanup/kernel/sys.c
--- linux-2.6.11-rc5-original/kernel/sys.c      2005-02-26 17:34:38.000000000 -0500
+++ linux-2.6.11-rc5-cleanup/kernel/sys.c       2005-02-27 17:27:20.000000000 -0500
@@ -1488,6 +1488,14 @@ asmlinkage long sys_setrlimit(unsigned i
        if (new_rlim.rlim_cur > new_rlim.rlim_max)
                return -EINVAL;
        old_rlim = current->signal->rlim + resource;
+
+       /* We dont enforce RLIMIT_RSS ulimit yet. But for application
+          compatability, we warn only when asked to change system default value. */
+       if( resource == RLIMIT_RSS &&
+           ((new_rlim.rlim_max != old_rlim->rlim_max)||
+            (new_rlim.rlim_cur != old_rlim->rlim_cur)) )
+               return -ENOSYS;
+
        if ((new_rlim.rlim_max > old_rlim->rlim_max) &&
            !capable(CAP_SYS_RESOURCE))
                return -EPERM;
