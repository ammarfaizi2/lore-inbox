Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262152AbSJFRXa>; Sun, 6 Oct 2002 13:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262150AbSJFRW1>; Sun, 6 Oct 2002 13:22:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57604 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262152AbSJFRWK>; Sun, 6 Oct 2002 13:22:10 -0400
Subject: PATCH: make jffs/jffs2 work with signal changes
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dwmw2@redhat.com
Date: Sun, 6 Oct 2002 18:18:55 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yF3P-0001tL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/fs/jffs/intrep.c linux.2.5.40-ac5/fs/jffs/intrep.c
--- linux.2.5.40/fs/jffs/intrep.c	2002-10-02 21:34:06.000000000 +0100
+++ linux.2.5.40-ac5/fs/jffs/intrep.c	2002-10-04 15:39:36.000000000 +0100
@@ -3376,10 +3376,13 @@
 		 */
 		while (signal_pending(current)) {
 			siginfo_t info;
-			unsigned long signr;
+			unsigned long signr = 0;
 
 			spin_lock_irq(&current->sig->siglock);
-			signr = dequeue_signal(&current->blocked, &info);
+			if (current->sig->shared_pending.head)
+				signr = dequeue_signal(&current->sig->shared_pending, &current->blocked, &info);
+			if (!signr)
+				signr = dequeue_signal(&current->pending, &current->blocked, &info);
 			spin_unlock_irq(&current->sig->siglock);
 
 			switch(signr) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/fs/jffs2/background.c linux.2.5.40-ac5/fs/jffs2/background.c
--- linux.2.5.40/fs/jffs2/background.c	2002-10-02 21:34:06.000000000 +0100
+++ linux.2.5.40-ac5/fs/jffs2/background.c	2002-10-04 15:46:29.000000000 +0100
@@ -112,10 +112,13 @@
                  */
                 while (signal_pending(current)) {
                         siginfo_t info;
-                        unsigned long signr;
+                        unsigned long signr = 0 ;
 
                         spin_lock_irq(&current->sig->siglock);
-                        signr = dequeue_signal(&current->blocked, &info);
+			if (current->sig->shared_pending.head)
+				signr = dequeue_signal(&current->sig->shared_pending, &current->blocked, &info);
+			if (!signr)
+				signr = dequeue_signal(&current->pending, &current->blocked, &info);
                         spin_unlock_irq(&current->sig->siglock);
 
                         switch(signr) {
