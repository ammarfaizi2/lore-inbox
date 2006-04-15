Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWDOC0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWDOC0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 22:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWDOC0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 22:26:13 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:2440 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030200AbWDOC0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 22:26:13 -0400
Date: Fri, 14 Apr 2006 19:26:06 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Poll cleanups/microoptimizations.
In-Reply-To: <20060414143820.6a04b696.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0604141916480.25270@shell3.speakeasy.net>
References: <Pine.LNX.4.58.0604132115290.29982@shell3.speakeasy.net>
 <20060414123118.0a8fb24c.akpm@osdl.org> <Pine.LNX.4.58.0604141413260.21335@shell2.speakeasy.net>
 <20060414143820.6a04b696.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Poll cleanup and microoptimization patch.

The "count" and "pt" variables are declared and modified by do_poll(),
as well as accessed and written indirectly in the do_pollfd()
subroutine. This patch pulls all handling of these variables into the
do_poll() function, thereby eliminating the odd use of indirection in
do_pollfd(). This is done by pulling the "struct pollfd" traversal loop
from do_pollfd() into its only caller do_poll(). As an added bonus, the
patch saves a few clock cycles, and also adds comments to make the code
easier to follow.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru linux-2.6.17-rc1/fs/select.c linux-new/fs/select.c
--- linux-2.6.17-rc1/fs/select.c	2006-04-12 20:31:54.000000000 -0700
+++ linux-new/fs/select.c	2006-04-14 19:12:37.000000000 -0700
@@ -544,37 +544,38 @@ struct poll_list {

 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))

-static void do_pollfd(unsigned int num, struct pollfd * fdpage,
-	poll_table ** pwait, int *count)
+/*
+ * Fish for pollable events on the pollfd->fd file descriptor. We're only
+ * interested in events matching the pollfd->events mask, and the result
+ * matching that mask is both recorded in pollfd->revents and returned. The
+ * pwait poll_table will be used by the fd-provided poll handler for waiting,
+ * if non-NULL.
+ */
+static inline unsigned int do_pollfd(struct pollfd *pollfd, poll_table *pwait)
 {
-	int i;
+	unsigned int mask;
+	int fd;

-	for (i = 0; i < num; i++) {
-		int fd;
-		unsigned int mask;
-		struct pollfd *fdp;
-
-		mask = 0;
-		fdp = fdpage+i;
-		fd = fdp->fd;
-		if (fd >= 0) {
-			int fput_needed;
-			struct file * file = fget_light(fd, &fput_needed);
-			mask = POLLNVAL;
-			if (file != NULL) {
-				mask = DEFAULT_POLLMASK;
-				if (file->f_op && file->f_op->poll)
-					mask = file->f_op->poll(file, *pwait);
-				mask &= fdp->events | POLLERR | POLLHUP;
-				fput_light(file, fput_needed);
-			}
-			if (mask) {
-				*pwait = NULL;
-				(*count)++;
-			}
+	mask = 0;
+	fd = pollfd->fd;
+	if (fd >= 0) {
+		int fput_needed;
+		struct file * file;
+
+		file = fget_light(fd, &fput_needed);
+		mask = POLLNVAL;
+		if (file != NULL) {
+			mask = DEFAULT_POLLMASK;
+			if (file->f_op && file->f_op->poll)
+				mask = file->f_op->poll(file, pwait);
+			/* Mask out unneeded events. */
+			mask &= pollfd->events | POLLERR | POLLHUP;
+			fput_light(file, fput_needed);
 		}
-		fdp->revents = mask;
 	}
+	pollfd->revents = mask;
+
+	return mask;
 }

 static int do_poll(unsigned int nfds,  struct poll_list *list,
@@ -592,11 +593,29 @@ static int do_poll(unsigned int nfds,  s
 		long __timeout;

 		set_current_state(TASK_INTERRUPTIBLE);
-		walk = list;
-		while(walk != NULL) {
-			do_pollfd( walk->len, walk->entries, &pt, &count);
-			walk = walk->next;
+		for (walk = list; walk != NULL; walk = walk->next) {
+			struct pollfd * pfd, * pfd_end;
+
+			pfd = walk->entries;
+			pfd_end = pfd + walk->len;
+			for (; pfd != pfd_end; pfd++) {
+				/*
+				 * Fish for events. If we found one, record it
+				 * and kill the poll_table, so we don't
+				 * needlessly register any other waiters after
+				 * this. They'll get immediately deregistered
+				 * when we break out and return.
+				 */
+				if (do_pollfd(pfd, pt)) {
+					count++;
+					pt = NULL;
+				}
+			}
 		}
+		/*
+		 * All waiters have already been registered, so don't provide
+		 * a poll_table to them on the next loop iteration.
+		 */
 		pt = NULL;
 		if (count || !*timeout || signal_pending(current))
 			break;
