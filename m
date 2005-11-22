Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVKVVSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVKVVSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVKVVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:07:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965188AbVKVVGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:06:55 -0500
Date: Tue, 22 Nov 2005 13:06:25 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [patch 05/23] [PATCH] VFS: Fix memory leak with file leases
Message-ID: <20051122210625.GF28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-memory-leak-with-file-leases.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

The patch
http://linux.bkbits.net:8080/linux-2.6/diffs/fs/locks.c@1.70??nav=index.html
introduced a pretty nasty memory leak in the lease code. When freeing
the lease, the code in locks_delete_lock() will correctly clean up
the fasync queue, but when we return to fcntl_setlease(), the freed
fasync entry will be reinstated.

This patch ensures that we skip the call to fasync_helper() when we're
freeing up the lease.

Signed-off-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/locks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.2.orig/fs/locks.c
+++ linux-2.6.14.2/fs/locks.c
@@ -1418,7 +1418,7 @@ int fcntl_setlease(unsigned int fd, stru
 	lock_kernel();
 
 	error = __setlease(filp, arg, &flp);
-	if (error)
+	if (error || arg == F_UNLCK)
 		goto out_unlock;
 
 	error = fasync_helper(fd, filp, 1, &flp->fl_fasync);

--
