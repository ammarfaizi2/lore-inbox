Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263244AbVFXK5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbVFXK5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVFXK5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:57:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21400 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263244AbVFXKyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:54:55 -0400
Date: Fri, 24 Jun 2005 16:22:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] files: fix dupfd by fdt reload
Message-ID: <20050624105209.GC4804@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050624105011.GB4804@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624105011.GB4804@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



locate_fd() may expand fdtable, so the fdtable pointer must be
reloaded after locate_fd(). Fixes bugme #4770.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 fs/fcntl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN fs/fcntl.c~fix-dupfd-reacquire-fdt fs/fcntl.c
--- linux-2.6.12-mm1-fix/fs/fcntl.c~fix-dupfd-reacquire-fdt	2005-06-25 14:56:58.000000000 +0530
+++ linux-2.6.12-mm1-fix-dipankar/fs/fcntl.c	2005-06-25 14:58:26.000000000 +0530
@@ -118,9 +118,10 @@ static int dupfd(struct file *file, unsi
 	int fd;
 
 	spin_lock(&files->file_lock);
-	fdt = files_fdtable(files);
 	fd = locate_fd(files, file, start);
 	if (fd >= 0) {
+		/* locate_fd() may have expanded fdtable, load the ptr */
+		fdt = files_fdtable(files);
 		FD_SET(fd, fdt->open_fds);
 		FD_CLR(fd, fdt->close_on_exec);
 		spin_unlock(&files->file_lock);

_
