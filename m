Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbTELWp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbTELWp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:45:59 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:13399 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262865AbTELWpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:45:52 -0400
Date: Mon, 12 May 2003 15:54:17 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 must-fix list, v2
Message-Id: <20030512155417.67a9fdec.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2003 22:58:32.0097 (UTC) FILETIME=[0288E910:01C318DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There have been surprisingly few additions.  The original and updated lists
are at

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/

Nothing has been deleted.  This means either that nobody is doing anything
or people forgot to tell me.


The changes are:


--- /tmp/must-fix-1.txt	Mon May 12 15:49:48 2003
+++ /tmp/must-fix-2.txt	Mon May 12 15:50:01 2003
@@ -5,11 +5,12 @@
 drivers/char/
 -------------
 
-- TTY locking is broken (see FIXME in do_tty_hangup())
+- TTY locking is broken.
+
+  - see FIXME in do_tty_hangup().  This causes ppp BUGs in local_bh_enable()
+
+  - Other problems: aviro, dipankar, Alan have details.
 
-  "One bug that was found is that the dropping of lock_kernel from do_exit
-   caused races in the exit tty cleanup.  There was a patch for that, but I'm
-   not sure it was merged."
 
 
 drivers/block/
@@ -64,6 +65,41 @@
 
 - Lots of drivers don't compile, others do but don't work.
 
+drivers/scsi/
+-------------
+
+- hch: large parts of the locking are hosed or not existant
+
+  - shost->my_devices isn't locked down at all
+
+  - the host list ist locked but not refcounted, mess can happen when the
+    spinlock is dropped
+
+  - there are lots of members of struct Scsi_Host/scsi_device/scsi_cmnd
+    with very unclear locking, many of them probably want to become
+    atomic_t's or bitmaps (for the 1bit bitfields).
+
+  - there's lots of volatile abuse in the scsi code that needs to be
+    thought about.
+
+  - there's some global variables incremented without any locks
+
+
+  (Mike Anderson, Patrick Mansfield, Badari Pulavarty)
+
+  - large parts of the locking are hosed or non existent
+
+    -- shost->my_devices isn't locked at all
+
+    -- host list locked but not refcounted
+
+    -- lots of members of struct scsi_host/scsi_device/ scsi_cmd with
+       very unclear locking
+
+    -- lots of volatile abuse in scsi code
+
+    -- global variables incremented without locks.
+
 fs/
 ---
 
@@ -90,6 +126,11 @@
   whole lot of bogus packets start appearing.  They look severely corrupted,
   (they even crashed ethereal once 8-)
 
+- hch: devfs: there's a fundamental lookup vs devfsd race that's only
+  fixable by introducing a lookup vs devfs deadlock.  I can't see how this is
+  fixable without getting rid of the current devfsd design.  Mandrake seems
+  to have a workaround for this so this is at least not triggered so easily,
+  but that's not what I'd consider a fix..
 
 kernel/
 -------
@@ -286,6 +327,8 @@
 
 - Integrate userspace irq balancing daemon.
 
+- kexec.  Seems to work, is in -mm.
+
 mm/
 ---
 
@@ -365,7 +408,7 @@
 - Arch-independent code for performing state transitions, that calls 
   platform-specific methods along the way. 
 
-- A better suspend-to-disk mechanism that swsusp. 
+- A better suspend-to-disk mechanism than swsusp. 
 
   There are various other details to be worked out, which are the real fun
   part.  And of course, driver support, but that is something that can happen
@@ -390,6 +433,11 @@
 
 - Pat's swsusp rework?
 
+- Pat: There are already CPU device structures; MTRRs should be a
+  dynamically registered interface of CPUs, which implies there needs
+  to be some other glue to know that there are MTRRs that need to be
+  saved/restored.
+
 arch/i386/
 ----------
 

