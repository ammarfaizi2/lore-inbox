Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTFDAoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTFDAoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:44:38 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:24263 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262257AbTFDAoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:44:37 -0400
Date: Wed, 4 Jun 2003 01:58:02 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2.5] Non-blocking write can block
Message-ID: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Non-blocking writes to a tty will block if there is a blocking write
waiting for the atomic_write semaphore.

Peter

--- linux-2.5.70/drivers/char/tty_io.c.orig	2003-06-03 21:34:42.000000000 +0100
+++ linux-2.5.70/drivers/char/tty_io.c	2003-06-04 01:40:33.000000000 +0100
@@ -687,8 +687,13 @@
 {
 	ssize_t ret = 0, written = 0;

-	if (down_interruptible(&tty->atomic_write)) {
-		return -ERESTARTSYS;
+	if (file->f_flags & O_NONBLOCK) {
+		if (down_trylock(&tty->atomic_write))
+			return -EAGAIN;
+	}
+	else {
+		if (down_interruptible(&tty->atomic_write))
+			return -ERESTARTSYS;
 	}
 	if ( test_bit(TTY_NO_WRITE_SPLIT, &tty->flags) ) {
 		lock_kernel();

