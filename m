Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262605AbTCIUVC>; Sun, 9 Mar 2003 15:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262606AbTCIUVC>; Sun, 9 Mar 2003 15:21:02 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:41367 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262605AbTCIUU7>;
	Sun, 9 Mar 2003 15:20:59 -0500
Date: Sun, 9 Mar 2003 23:30:48 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: NCPFS memleak/crazyness?
Message-ID: <20030309203048.GA31393@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Looking at fs/ncpfs/ioctl.c (latest 2.4 bk tree), I seem to see a place
   where we use userspace-pointers directly (And eventually doing kfree on
   these). In NCP_IOC_SETOBJECTNAME handler, we allocated space (newname
   pointer), copy stuff from userspace to there and then assign userspace
   pointer to our internal structure, whoops! Or am I missing something?

   Seems that following patch is needed. (Same problem is present in 2.5
   and same patch should apply)

   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== fs/ncpfs/ioctl.c 1.3 vs edited =====
--- 1.3/fs/ncpfs/ioctl.c	Mon Sep  9 22:36:07 2002
+++ edited/fs/ncpfs/ioctl.c	Sun Mar  9 23:23:12 2003
@@ -434,7 +434,7 @@
 			oldprivatelen = server->priv.len;
 			server->auth.auth_type = user.auth_type;
 			server->auth.object_name_len = user.object_name_len;
-			server->auth.object_name = user.object_name;
+			server->auth.object_name = newname;
 			server->priv.len = 0;
 			server->priv.data = NULL;
 			/* leave critical section */
