Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWHPQMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWHPQMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWHPQMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:12:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42981 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750958AbWHPQMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:12:18 -0400
Subject: PATCH: Stop the tty vanishing under procfs access
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:33:03 +0100
Message-Id: <1155745983.24077.360.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would appreciate people double checking this one.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/fs/proc/array.c linux-2.6.18-rc4-mm1/fs/proc/array.c
--- linux.vanilla-2.6.18-rc4-mm1/fs/proc/array.c	2006-08-15 15:39:31.000000000 +0100
+++ linux-2.6.18-rc4-mm1/fs/proc/array.c	2006-08-15 16:02:56.000000000 +0100
@@ -347,6 +347,8 @@
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
 	cutime = cstime = utime = stime = cputime_zero;
+	
+	mutex_lock(&tty_mutex);
 	read_lock(&tasklist_lock);
 	if (task->sighand) {
 		spin_lock_irq(&task->sighand->siglock);
@@ -388,6 +390,7 @@
 	}
 	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
+	mutex_unlock(&tty_mutex);
 
 	if (!whole || num_threads<2)
 		wchan = get_wchan(task);

