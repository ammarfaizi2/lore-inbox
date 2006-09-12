Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWILNmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWILNmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 09:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWILNmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 09:42:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:61321 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030257AbWILNmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 09:42:50 -0400
Message-ID: <4506B955.7080000@fr.ibm.com>
Date: Tue, 12 Sep 2006 15:42:45 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, containers@lists.osdl.org
Subject: [S390] update fs3270 to use a struct pid
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch replaces the pid_t value with a struct pid to avoid pid wrap
around problems.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: containers@lists.osdl.org

---
 drivers/s390/char/fs3270.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: 2.6.18-rc6/drivers/s390/char/fs3270.c
===================================================================
--- 2.6.18-rc6.orig/drivers/s390/char/fs3270.c
+++ 2.6.18-rc6/drivers/s390/char/fs3270.c
@@ -28,7 +28,7 @@ struct raw3270_fn fs3270_fn;

 struct fs3270 {
 	struct raw3270_view view;
-	pid_t fs_pid;			/* Pid of controlling program. */
+	struct pid* fs_pid;		/* Pid of controlling program. */
 	int read_command;		/* ccw command to use for reads. */
 	int write_command;		/* ccw command to use for writes. */
 	int attention;			/* Got attention. */
@@ -103,7 +103,7 @@ fs3270_restore_callback(struct raw3270_r
 	fp = (struct fs3270 *) rq->view;
 	if (rq->rc != 0 || rq->rescnt != 0) {
 		if (fp->fs_pid)
-			kill_proc(fp->fs_pid, SIGHUP, 1);
+			kill_pid(fp->fs_pid, SIGHUP, 1);
 	}
 	fp->rdbuf_size = 0;
 	raw3270_request_reset(rq);
@@ -174,7 +174,7 @@ fs3270_save_callback(struct raw3270_requ
 	 */
 	if (rq->rc != 0 || rq->rescnt == 0) {
 		if (fp->fs_pid)
-			kill_proc(fp->fs_pid, SIGHUP, 1);
+			kill_pid(fp->fs_pid, SIGHUP, 1);
 		fp->rdbuf_size = 0;
 	} else
 		fp->rdbuf_size = fp->rdbuf->size - rq->rescnt;
@@ -443,7 +443,7 @@ fs3270_open(struct inode *inode, struct
 		return PTR_ERR(fp);

 	init_waitqueue_head(&fp->wait);
-	fp->fs_pid = current->pid;
+	fp->fs_pid = get_pid(task_pid(current));
 	rc = raw3270_add_view(&fp->view, &fs3270_fn, minor);
 	if (rc) {
 		fs3270_free_view(&fp->view);
@@ -481,7 +481,8 @@ fs3270_close(struct inode *inode, struct
 	fp = filp->private_data;
 	filp->private_data = NULL;
 	if (fp) {
-		fp->fs_pid = 0;
+		put_pid(fp->fs_pid);
+		fp->fs_pid = NULL;
 		raw3270_reset(&fp->view);
 		raw3270_put_view(&fp->view);
 		raw3270_del_view(&fp->view);
