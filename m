Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314228AbSEIT1R>; Thu, 9 May 2002 15:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314230AbSEIT1Q>; Thu, 9 May 2002 15:27:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45738 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314228AbSEIT1P>; Thu, 9 May 2002 15:27:15 -0400
Date: Thu, 09 May 2002 14:27:00 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Thread group exit problem reappeared.
Message-ID: <43390000.1020972420@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========890320887=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========890320887==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


A long time ago there was thread group code that at exit time tried to
reparent a task to another task in the thread group.  I discovered a major
race condition in this code, and submitted a patch that removed it.  This
patch was accepted in, I thin, 2.4.12.  The code reappeared in 2.4.18,
breaking applications that use thread groups.

As part of chasing this down, I figured out a way to remove the race
condition while still preserving this behavior.  I've attached a patch
against 2.4.19-pre8 that fixes it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========890320887==========
Content-Type: text/plain; charset=us-ascii; name="exit-2.4.19-pre8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="exit-2.4.19-pre8.diff"; size=797

--- linux-2.4.19-pre8/./kernel/exit.c	Tue May  7 09:18:14 2002
+++ linux-2.4.19-pre8-reparent/./kernel/exit.c	Tue May  7 10:01:56 2002
@@ -152,7 +152,7 @@
 
 /*
  * When we die, we re-parent all our children.
- * Try to give them to another thread in our process
+ * Try to give them to another thread in our thread
  * group, and if no such member exists, give it to
  * the global child reaper process (ie "init")
  */
@@ -162,8 +162,14 @@
 
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
 

--==========890320887==========--

