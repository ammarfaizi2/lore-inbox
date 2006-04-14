Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWDNEVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWDNEVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 00:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDNEVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 00:21:21 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:26057 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751110AbWDNEVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 00:21:20 -0400
Date: Thu, 13 Apr 2006 21:21:20 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Poll microoptimizations.
Message-ID: <Pine.LNX.4.58.0604132115290.29982@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to provide some microoptimizations for the poll() system call
implementation. The loop that traverses over the "struct pollfd" entries
was moved from do_pollfd() to its single caller do_poll(), so that
do_pollfd() no longer mucks around with the "count" and the "pt"
variables that should belong to do_poll() alone. This saves unnecessary
levels of indirection. Modifications were run tested.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru linux-2.6.17-rc1/fs/select.c linux-new/fs/select.c
--- linux-2.6.17-rc1/fs/select.c	2006-04-12 20:31:54.000000000 -0700
+++ linux-new/fs/select.c	2006-04-13 18:54:14.000000000 -0700
@@ -544,37 +544,30 @@ struct poll_list {

 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))

-static void do_pollfd(unsigned int num, struct pollfd * fdpage,
-	poll_table ** pwait, int *count)
+static int do_pollfd(struct pollfd * pollfd, poll_table * pwait)
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
+			mask &= pollfd->events | POLLERR | POLLHUP;
+			fput_light(file, fput_needed);
 		}
-		fdp->revents = mask;
 	}
+	pollfd->revents = mask;
+
+	return (mask != 0);
 }

 static int do_poll(unsigned int nfds,  struct poll_list *list,
@@ -592,10 +585,19 @@ static int do_poll(unsigned int nfds,  s
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
+				int ev;
+
+				ev = do_pollfd(pfd, pt);
+				count += ev;
+				ev--;
+				pt = (poll_table*)((unsigned long)pt & ev);
+			}
 		}
 		pt = NULL;
 		if (count || !*timeout || signal_pending(current))
