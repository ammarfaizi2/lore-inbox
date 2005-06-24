Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263250AbVFXLDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbVFXLDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbVFXK7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:59:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40921 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263245AbVFXK5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:57:50 -0400
Date: Fri, 24 Jun 2005 16:25:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] files: doc update
Message-ID: <20050624105500.GF4804@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050624105011.GB4804@in.ibm.com> <20050624105209.GC4804@in.ibm.com> <20050624105318.GD4804@in.ibm.com> <20050624105410.GE4804@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624105410.GE4804@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update files documentation to mention the need for reloading
fdtable pointer if ->file_lock is dropped.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 Documentation/filesystems/files.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

diff -puN Documentation/filesystems/files.txt~files-doc-update Documentation/filesystems/files.txt
--- linux-2.6.12-mm1-fix/Documentation/filesystems/files.txt~files-doc-update	2005-06-26 06:01:40.000000000 +0530
+++ linux-2.6.12-mm1-fix-dipankar/Documentation/filesystems/files.txt	2005-06-26 06:13:09.000000000 +0530
@@ -101,3 +101,23 @@ the fdtable structure -
    API. If they are looked up lock-free, rcu_dereference()
    must be used. However it is advisable to use files_fdtable()
    and fcheck()/fcheck_files() which take care of these issues.
+
+7. While updating, the fdtable pointer must be looked up while
+   holding files->file_lock. If ->file_lock is dropped, then
+   another thread expand the files thereby creating a new
+   fdtable and making the earlier fdtable pointer stale.
+   For example :
+
+	spin_lock(&files->file_lock);
+	fd = locate_fd(files, file, start);
+	if (fd >= 0) {
+		/* locate_fd() may have expanded fdtable, load the ptr */
+		fdt = files_fdtable(files);
+		FD_SET(fd, fdt->open_fds);
+		FD_CLR(fd, fdt->close_on_exec);
+		spin_unlock(&files->file_lock);
+	.....
+
+   Since locate_fd() can drop ->file_lock (and reacquire ->file_lock),
+   the fdtable pointer (fdt) must be loaded after locate_fd().
+

_
