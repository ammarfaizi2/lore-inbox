Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270005AbTGLJ6j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 05:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270006AbTGLJ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 05:58:39 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:59404 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270005AbTGLJ6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 05:58:35 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: devfs@oss.sgi.com
Subject: [PATCH][2.5.75] devfsd hangs on restart - is_devfsd_or_child() problem
Date: Sat, 12 Jul 2003 14:11:41 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Thierry Vignaud <tvignaud@mandrakesoft.com>,
       Andrew Morton <akpm@osdl.org>
References: <200307112247.12646.arvidjaar@mail.ru>
In-Reply-To: <200307112247.12646.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d79D/ejDfe6Z1Wd"
Message-Id: <200307121411.41131.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_d79D/ejDfe6Z1Wd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 11 July 2003 22:47, Andrey Borzenkov wrote:
> I cannot believe it is so fragile ...
>
> is_devfsd_or_child() simplemindedly checks for pgrp:
>
> static int is_devfsd_or_child (struct fs_info *fs_info)
> {
>     if (current == fs_info->devfsd_task) return (TRUE);
>     if (current->pgrp == fs_info->devfsd_pgrp) return (TRUE);
>     return (FALSE);
> }   /*  End Function is_devfsd_or_child  */
>

Andrew, one more for your collection :)

The code that did proper check existed in 2.4 and was removed in 2.5 for 
whatever reason. The patch restores it slightly modified as below.

2.4 code looks somewhat unclean in that

- it traverses task list without lock. 
- is starts from current->real_parent but nothing prevents current be 
init_task itself. This hung for me on 2.5 during boot. May be 2.4 does 
something differently.

Comments?

regards

-andrey

This is trivially reproduced under 2.5 by using devfsd.conf lines

LOOKUP  ^foo$   EXECUTE /home/bor/tmp/devfsd/handler /dev/bar
LOOKUP  ^bar$   EXECUTE /home/bor/tmp/devfsd/handler /dev/foo

and handler like

-------- cut here ----------
#include <unistd.h>

int
main(int argc, char **argv, char **envp)
{
        if (argc <= 1)
                return 0;

        setpgrp();
        return access(argv[1], R_OK);
}
-------- cut here ----------

and doing ls /dev/foo
--Boundary-00=_d79D/ejDfe6Z1Wd
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.5.75-is_devfsd_or_child.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.75-is_devfsd_or_child.patch"

--- linux-2.5.75-smp/fs/devfs/base.c.devfsd_child	2003-07-11 19:41:46.000000000 +0400
+++ linux-2.5.75-smp/fs/devfs/base.c	2003-07-12 13:51:49.000000000 +0400
@@ -676,6 +676,7 @@
 #include <linux/smp.h>
 #include <linux/version.h>
 #include <linux/rwsem.h>
+#include <linux/sched.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1325,8 +1326,20 @@ static void free_dentry (struct devfs_en
 
 static int is_devfsd_or_child (struct fs_info *fs_info)
 {
-    if (current == fs_info->devfsd_task) return (TRUE);
-    if (current->pgrp == fs_info->devfsd_pgrp) return (TRUE);
+    struct task_struct *p = current;
+
+    if (p == fs_info->devfsd_task) return (TRUE);
+    if (p->pgrp == fs_info->devfsd_pgrp) return (TRUE);
+    read_lock(&tasklist_lock);
+    for ( ; p != &init_task; p = p->real_parent)
+    {
+	if (p == fs_info->devfsd_task)
+	{
+	    read_unlock (&tasklist_lock);
+	    return (TRUE);
+	}
+    }
+    read_unlock (&tasklist_lock);
     return (FALSE);
 }   /*  End Function is_devfsd_or_child  */
 

--Boundary-00=_d79D/ejDfe6Z1Wd--

