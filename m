Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319865AbSINKZU>; Sat, 14 Sep 2002 06:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319866AbSINKZU>; Sat, 14 Sep 2002 06:25:20 -0400
Received: from p026.as-l031.contactel.cz ([212.65.234.218]:16768 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S319865AbSINKZU>;
	Sat, 14 Sep 2002 06:25:20 -0400
Date: Sat, 14 Sep 2002 12:18:11 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: willy@debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.34-bk fcntl lockup
Message-ID: <20020914101811.GA1447@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
   please apply this. 

Fixes endless loop without schedule which happens as soon as smbd 
invokes fcntl64(7, F_SETLK64, ...). fcntl_setlk64 gets cmd F_SETLK64,
not F_SETLK tested in the loop;

Maybe return value from posix_lock_file should be changed to -EINPROGRESS 
or -EJUKEBOX instead of testing passed cmd in callers, but this oneliner 
works too. If you preffer changing posix_lock_file return value to clearly 
distinugish between -EAGAIN and lock request queued, I'll do that.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/fs/locks.c linux/fs/locks.c
--- linux/fs/locks.c	2002-09-13 21:49:17.000000000 +0200
+++ linux/fs/locks.c	2002-09-14 11:19:37.000000000 +0200
@@ -1588,7 +1588,7 @@
 
 	for (;;) {
 		error = posix_lock_file(filp, file_lock);
-		if ((error != -EAGAIN) || (cmd == F_SETLK))
+		if ((error != -EAGAIN) || (cmd == F_SETLK64))
 			break;
 		error = wait_event_interruptible(file_lock->fl_wait,
 				!file_lock->fl_next);
