Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932786AbWCRPSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbWCRPSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWCRPSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:18:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50316 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932786AbWCRPSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:18:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, janak@us.ibm.com, viro@ftp.linux.org.uk,
       hch@lst.de, mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: [PATCH] unshare: Error if passed unsupported flags
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
	<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>
	<441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 18 Mar 2006 08:10:16 -0700
In-Reply-To: <20060317125607.78a5dbe4.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 17 Mar 2006 12:56:07 -0800")
Message-ID: <m13bhf3i1z.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch does a bare bones trivial patch to ensure we always
get -EINVAL on the unsupported cases for sys_unshare.  If this
goes in before 2.6.16 it allows us to forward compatible with
future applications using sys_unshare.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/fork.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

46868b4b6ebeb9042dded68a6f6301ffe06820c9
diff --git a/kernel/fork.c b/kernel/fork.c
index 46060cb..411b10d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1535,6 +1535,12 @@ asmlinkage long sys_unshare(unsigned lon
 	struct sem_undo_list *new_ulist = NULL;
 
 	check_unshare_flags(&unshare_flags);
+       
+	/* Return -EINVAL for all unsupported flags */
+	err = -EINVAL;
+	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
+				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM))
+		goto bad_unshare_out;
 
 	if ((err = unshare_thread(unshare_flags)))
 		goto bad_unshare_out;
-- 
1.2.4.g2d33

