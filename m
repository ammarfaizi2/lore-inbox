Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSKTT2W>; Wed, 20 Nov 2002 14:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKTT2W>; Wed, 20 Nov 2002 14:28:22 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:44674 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262783AbSKTT2S>;
	Wed, 20 Nov 2002 14:28:18 -0500
Date: Wed, 20 Nov 2002 20:35:19 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: willy@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make {posix,flock}_lock_file interface simpler
Message-ID: <20021120193519.GB25126@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,
  some months ago, after your fs/locks.c cleanup, and after 
troubles we had with getting tests for non-blocking vs. blocking
calls correct, I wrote following patch. If you are still 
interested in cleaning up fs/locks.c, can you review it, and 
either dump to the floor, or send to Linus?

  With old version, we do wait_event_interruptible()
when lock function returned -EAGAIN and we did blocking call.

  Patch below changes locking code to return -EAGAIN if
wait_event_interruptible() should not called, and -ERESTARTSYS
if wait_event_interruptible() should be called (that is,
locking code called locks_insert_block()). So now calling
rule is simple: if you got -ERESTARTSYS, you must do
wait_event_interruptible, otherwise you have error code to
return to userspace.

  I choosed ERESTARTSYS just arbitrary: it was not used by
currentl locking code, it must not be returned to userspace,
and it already exists.
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz

diff -urdN linux/fs/locks.c linux/fs/locks.c
--- linux/fs/locks.c	2002-11-20 18:33:14.000000000 +0000
+++ linux/fs/locks.c	2002-11-20 18:42:01.000000000 +0000
@@ -678,7 +678,7 @@
 
 	for (;;) {
 		error = posix_lock_file(filp, &fl);
-		if (error != -EAGAIN)
+		if (error != -ERESTARTSYS)
 			break;
 		error = wait_event_interruptible(fl.fl_wait, !fl.fl_next);
 		if (!error) {
@@ -749,6 +749,7 @@
 		error = -EAGAIN;
 		if (new_fl->fl_flags & FL_SLEEP) {
 			locks_insert_block(fl, new_fl);
+			error = -ERESTARTSYS;
 		}
 		goto out;
 	}
@@ -812,7 +813,7 @@
 			error = -EDEADLK;
 			if (posix_locks_deadlock(request, fl))
 				goto out;
-			error = -EAGAIN;
+			error = -ERESTARTSYS;
 			locks_insert_block(fl, request);
 			goto out;
   		}
@@ -1295,7 +1296,7 @@
 
 	for (;;) {
 		error = flock_lock_file(filp, lock);
-		if ((error != -EAGAIN) || (cmd & LOCK_NB))
+		if (error != -ERESTARTSYS)
 			break;
 		error = wait_event_interruptible(lock->fl_wait, !lock->fl_next);
 		if (!error)
@@ -1453,7 +1454,7 @@
 
 	for (;;) {
 		error = posix_lock_file(filp, file_lock);
-		if ((error != -EAGAIN) || (cmd == F_SETLK))
+		if (error != -ERESTARTSYS)
 			break;
 		error = wait_event_interruptible(file_lock->fl_wait,
 				!file_lock->fl_next);
@@ -1593,7 +1594,7 @@
 
 	for (;;) {
 		error = posix_lock_file(filp, file_lock);
-		if ((error != -EAGAIN) || (cmd == F_SETLK64))
+		if (error != -ERESTARTSYS)
 			break;
 		error = wait_event_interruptible(file_lock->fl_wait,
 				!file_lock->fl_next);
