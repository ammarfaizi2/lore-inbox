Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWBWQH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWBWQH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWBWQH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:07:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4503 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751558AbWBWQH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:07:56 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/23] proc: Kill proc_mem_inode_operations.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:06:49 -0700
In-Reply-To: <m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:05:35 -0700")
Message-ID: <m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The inode operations only exist to support the proc_permission
function.  Currently mem_read and mem_write have all the same
permission checks as ptrace.  The fs check makes no sense
in this context, and we can trivially get around it by
calling ptrace.

So simply the code by killing the strange weird case.

I admit the code has had this check since 2.2 but even
there it doesn't seem to make sense.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

c5af674b972bf21e1bc69b8d9c343e3158d2b3c0
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8b938ef..1d1feb7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -881,10 +881,6 @@ static struct file_operations proc_oom_a
 	.write		= oom_adjust_write,
 };
 
-static struct inode_operations proc_mem_inode_operations = {
-	.permission	= proc_permission,
-};
-
 #ifdef CONFIG_AUDITSYSCALL
 #define TMPBUFLEN 21
 static ssize_t proc_loginuid_read(struct file * file, char __user * buf,
@@ -1645,7 +1641,6 @@ static struct dentry *proc_pident_lookup
 #endif
 		case PROC_TID_MEM:
 		case PROC_TGID_MEM:
-			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
 			break;
 #ifdef CONFIG_SECCOMP
-- 
1.2.2.g709a

