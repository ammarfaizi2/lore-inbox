Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWHTAmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWHTAmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 20:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWHTAmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 20:42:37 -0400
Received: from mother.openwall.net ([195.42.179.200]:22670 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751345AbWHTAmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 20:42:36 -0400
Date: Sun, 20 Aug 2006 04:38:40 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820003840.GA17249@openwall.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Willy and all,

Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
set*uid() kill the current process rather than proceed with -EAGAIN when
the kernel is running out of memory.  Apparently, alloc_uid() can't fail
and return anyway due to properties of the allocator, in which case the
patch does not change a thing.  But better safe than sorry.

As you're probably aware, 2.6 kernels are affected to a greater extent,
where set*uid() may also fail on trying to exceed RLIMIT_NPROC.  That
needs to be fixed, too.

Opinions are welcome.

Thanks,

Alexander

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-set_user.diff"

diff -urpPX nopatch linux-2.4.33/kernel/sys.c linux/kernel/sys.c
--- linux-2.4.33/kernel/sys.c	Fri Nov 28 21:26:21 2003
+++ linux/kernel/sys.c	Wed Aug 16 05:19:21 2006
@@ -514,8 +514,10 @@ static int set_user(uid_t new_ruid, int 
 	struct user_struct *new_user;
 
 	new_user = alloc_uid(new_ruid);
-	if (!new_user)
+	if (!new_user) {
+		force_sig(SIGSEGV, current);
 		return -EAGAIN;
+	}
 	switch_uid(new_user);
 
 	if(dumpclear)

--ibTvN161/egqYuK8--
