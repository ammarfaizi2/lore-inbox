Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVEDOqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVEDOqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 10:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVEDOqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 10:46:21 -0400
Received: from p4.gsnoc.net ([209.51.147.210]:52667 "EHLO p4.gsnoc.net")
	by vger.kernel.org with ESMTP id S261840AbVEDOqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 10:46:14 -0400
Message-ID: <4278E03A.1000605@cachola.com.br>
Date: Wed, 04 May 2005 11:46:18 -0300
From: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A patch for the file kernel/fork.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p4.gsnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - cachola.com.br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I think that the file kernel/fork.c should be patched as following:

--- linux-2.6.12-rc3.orig/kernel/fork.c 2005-05-03 22:31:21.000000000 -0300
+++ linux-2.6.12-rc3/kernel/fork.c      2005-05-04 09:37:46.000000000 -0300
@@ -429,7 +429,7 @@
                tsk->vfork_done = NULL;
                complete(vfork_done);
        }
-       if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
+       if (mm && tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
                u32 __user * tidptr = tsk->clear_child_tid;
                tsk->clear_child_tid = NULL;

If a process is killed and, for some reason, when closing all files a 
pagefault is generated (should not happen, but...) after the function 
exit_mm had been called, the kernel will try to exit this process again, 
calling exit_mm and mm_release with a null mm, and will generate another 
pagefault in atomic_read(&mm->mm_users), and so on and the system will 
hang. I think this patch solve this problem.
