Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWCAHV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWCAHV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWCAHV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:21:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56295 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932618AbWCAHV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:21:59 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>
Subject: [PATCH] proc: Reference couting fix.
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 01 Mar 2006 00:20:34 -0700
In-Reply-To: <20060228212501.25464659.pj@sgi.com> (Paul Jackson's message of
 "Tue, 28 Feb 2006 21:25:01 -0800")
Message-ID: <m1y7zuocl9.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix reference counts in seccomp_write, and mem_read.

While looking for the bug I found two other places I goofed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

0774b9b05aa41a25d72f31498fc2967bfe8e60b7
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8d73c6a..6a26847 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -671,6 +671,9 @@ static ssize_t mem_read(struct file * fi
 	int ret = -ESRCH;
 	struct mm_struct *mm;
 
+	if (!task)
+		goto out_no_task;
+
 	if (!MAY_PTRACE(task) || !ptrace_may_attach(task))
 		goto out;
 
@@ -720,6 +723,8 @@ out_put:
 out_free:
 	free_page((unsigned long) page);
 out:
+	put_task_struct(task);
+out_no_task:
 	return ret;
 }
 
@@ -965,10 +970,12 @@ static ssize_t seccomp_write(struct file
 	if (unlikely(tsk->seccomp.mode))
 		goto out;
 
+	result = -EFAULT;
 	memset(__buf, 0, sizeof(__buf));
 	count = min(count, sizeof(__buf) - 1);
 	if (copy_from_user(__buf, buf, count))
-		return -EFAULT;
+		goto out;
+
 	seccomp_mode = simple_strtoul(__buf, &end, 0);
 	if (*end == '\n')
 		end++;
-- 
1.2.2.g709a-dirty

