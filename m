Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268938AbTGTWqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268954AbTGTWqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:46:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:40898 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S268925AbTGTWqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:46:43 -0400
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH][RFC] speeding up fsck -A
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Mon, 21 Jul 2003 01:01:44 +0200
Message-ID: <87adb8dcpz.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, I get a speedup of about 60%. During boot time it is
even more. Can someone please tell me, why and when this WNOHANG was
introduced. fsck seems to work fine without it.

You will probably gain nothing on SMP, because it doesn't hurt when
fsck hogs one CPU and the real fsck.ext2 does the main work on
another CPU.

This is on Debian unstable and kernel 2.5.72.

Regards, Olaf.

--- e2fsprogs/misc/fsck.c.orig	Wed Apr 16 22:13:56 2003
+++ e2fsprogs/misc/fsck.c	Sun Jul 20 23:35:03 2003
@@ -105,6 +105,7 @@
 int parallel_root = 0;
 int progress = 0;
 int force_all_parallel = 0;
+int no_busy_waiting = 0;
 int num_running = 0;
 int max_running = 0;
 volatile int cancel_requested = 0;
@@ -1007,7 +1008,8 @@
 			break;
 		if (verbose > 1)
 			printf(_("--waiting-- (pass %d)\n"), passno);
-		status |= wait_all(pass_done ? 0 : WNOHANG);
+		status |= wait_all((pass_done || no_busy_waiting) ? 0 : WNOHANG);
+
 		if (pass_done) {
 			if (verbose > 1) 
 				printf("----------------------------------\n");
@@ -1153,6 +1155,9 @@
 				fstype = string_copy(tmp);
 				compile_fs_type(fstype, &fs_type_compiled);
 				goto next_arg;
+			case 'X':
+				no_busy_waiting++;
+				break;
 			case '-':
 				opts_for_fsck++;
 				break;
