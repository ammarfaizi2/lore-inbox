Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316414AbSEOPVe>; Wed, 15 May 2002 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316412AbSEOPUJ>; Wed, 15 May 2002 11:20:09 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59525 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316410AbSEOPTk>; Wed, 15 May 2002 11:19:40 -0400
Date: Wed, 15 May 2002 10:19:33 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] Thread group exit problem reappeared
Message-ID: <25020000.1021475973@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1829309384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1829309384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


A long time ago there was thread group code that at exit time tried to
reparent a task to another task in the thread group.  I discovered a major
race condition in this code, and submitted a patch that removed it.  This
patch was accepted in, I think, 2.4.12.  The code reappeared in 2.4.18 and
sometime in the 2.5 tree before 2.5.15, breaking applications that use
thread groups.

As part of chasing this down, I figured out a way to remove the race
condition while still preserving this behavior.  I've attached a patch
against 2.5.15 that fixes it.

My apologies for including it as an attachment, but it appears to be the
only feasible way to keep my mail client from trashing it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1829309384==========
Content-Type: text/plain; charset=us-ascii; name="exit-2.5.15.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="exit-2.5.15.diff"; size=792

--- linux-2.5.15-orig/./kernel/exit.c	Thu May  9 17:23:28 2002
+++ linux-2.5.15-reparent/./kernel/exit.c	Fri May 10 13:35:50 2002
@@ -231,7 +231,7 @@
 
 /*
  * When we die, we re-parent all our children.
- * Try to give them to another thread in our process
+ * Try to give them to another thread in our thread
  * group, and if no such member exists, give it to
  * the global child reaper process (ie "init")
  */
@@ -241,8 +241,14 @@
 
 	read_lock(&tasklist_lock);
 
-	/* Next in our thread group */
-	reaper = next_thread(father);
+	/* Next in our thread group, if they're not already exiting */
+	reaper = father;
+	do {
+		reaper = next_thread(reaper);
+		if (!(reaper->flags & PF_EXITING))
+			break;
+	} while (reaper != father);
+
 	if (reaper == father)
 		reaper = child_reaper;
 

--==========1829309384==========--

