Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVFTU2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVFTU2B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFTU0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:26:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13479 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261562AbVFTUYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:24:37 -0400
Date: Tue, 21 Jun 2005 01:51:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: jan malstrom <xanon@snacksy.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, rjw@sisk.pl
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Message-ID: <20050620202145.GC4622@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <42B6BEC2.405@snacksy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B6BEC2.405@snacksy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 03:04:02PM +0200, jan malstrom wrote:
> right at booting:
> 
> 
> Jun 20 14:38:07 hades kernel: kernel BUG at fs/open.c:935!
> Jun 20 14:38:07 hades kernel: invalid operand: 0000 [#1]
> Jun 20 14:38:07 hades kernel: PREEMPT
> Jun 20 14:38:07 hades kernel: Modules linked in: ipw2100 i2c_i801
> Jun 20 14:38:07 hades kernel: CPU:    0
> Jun 20 14:38:07 hades kernel: EIP:    0060:[fd_install+309/400]    Not 
> tainted VLI

Can you try the following patch and let me know if it fixes any
of your problems ? I have only touch tested this patch on a P4 box.
Applies on top of 2.6.12-mm1.

Thanks
Dipankar



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
--- linux-2.6.12-mm1-test/fs/file.c~fix-expand-files	2005-06-22 10:35:31.000000000 +0530
+++ linux-2.6.12-mm1-test-dipankar/fs/file.c	2005-06-22 10:44:56.000000000 +0530
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
