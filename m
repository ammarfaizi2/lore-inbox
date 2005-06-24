Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263246AbVFXK6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbVFXK6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbVFXK6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:58:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9926 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263246AbVFXK4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:56:04 -0400
Date: Fri, 24 Jun 2005 16:23:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] files: fix expand_files return code
Message-ID: <20050624105318.GD4804@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050624105011.GB4804@in.ibm.com> <20050624105209.GC4804@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624105209.GC4804@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If expand_fdtable() sees that someone else expanded the fdtable
while it dropped the lock, it can return 0 which in turn
can be returned by expand_files() even though there has
been an expansion of the fdtable since expand_files()
was originally called. This could lead to locate_fd()
not repeating the fd search and returning a bogus fd.
This patch fixes this problem.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 fs/file.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff -puN fs/file.c~fix-expand-files fs/file.c
--- linux-2.6.12-mm1-fix/fs/file.c~fix-expand-files	2005-06-25 16:42:18.000000000 +0530
+++ linux-2.6.12-mm1-fix-dipankar/fs/file.c	2005-06-25 16:42:18.000000000 +0530
@@ -304,13 +304,14 @@ out:
 /*
  * Expands the file descriptor table - it will allocate a new fdtable and
  * both fd array and fdset. It is expected to be called with the
- * files_lock held.
+ * files_lock held. It returns 1 if fdtable expanded or -errno if
+ * expansion failed.
  */
 static int expand_fdtable(struct files_struct *files, int nr)
 	__releases(files->file_lock)
 	__acquires(files->file_lock)
 {
-	int error = 0;
+	int error = 1;
 	struct fdtable *fdt;
 	struct fdtable *nfdt = NULL;
 
@@ -350,7 +351,7 @@ out:
  */
 int expand_files(struct files_struct *files, int nr)
 {
-	int err, expand = 0;
+	int err;
 	struct fdtable *fdt;
 
 	fdt = files_fdtable(files);
@@ -360,11 +361,9 @@ int expand_files(struct files_struct *fi
 			err = -EMFILE;
 			goto out;
 		}
-		expand = 1;
-		if ((err = expand_fdtable(files, nr)))
-			goto out;
-	}
-	err = expand;
+		err = expand_fdtable(files, nr);
+	} else 
+		err = 0;
 out:
 	return err;
 }

_
