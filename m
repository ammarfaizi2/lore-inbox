Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266482AbUGUOpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUGUOpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUGUOpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:45:52 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:11930 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S266482AbUGUOps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:45:48 -0400
Date: Wed, 21 Jul 2004 18:45:47 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Subject: UNIX98 pty indices leak
Message-ID: <20040721144546.GA9740@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.26
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I noticed that our PPPoE/PPtP access concentrator leaks pty devices.
When all 4096 indices are leaked, there was need to reboot it.

The following patch fixes this problem (tested on 2.6.7-mm7,
but applies cleanly to 2.6.8-rc2).

--- tmp/linux-2.6.7/drivers/char/tty_io.c	Wed Jul 21 17:47:18 2004
+++ linux-2.6.7/drivers/char/tty_io.c	Wed Jul 21 17:54:33 2004
@@ -1060,7 +1060,7 @@
 {
 	struct tty_struct *tty, *o_tty;
 	int	pty_master, tty_closing, o_tty_closing, do_sleep;
-	int	devpts_master;
+	int	devpts_master, devpts;
 	int	idx;
 	char	buf[64];
 	
@@ -1075,7 +1075,8 @@
 	idx = tty->index;
 	pty_master = (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 		      tty->driver->subtype == PTY_TYPE_MASTER);
-	devpts_master = pty_master && (tty->driver->flags & TTY_DRIVER_DEVPTS_MEM);
+	devpts = (tty->driver->flags & TTY_DRIVER_DEVPTS_MEM) != 0;
+	devpts_master = pty_master && devpts;
 	o_tty = tty->link;
 
 #ifdef TTY_PARANOIA_CHECK
@@ -1300,7 +1301,7 @@
 
 #ifdef CONFIG_UNIX98_PTYS
 	/* Make this pty number available for reallocation */
-	if (devpts_master) {
+	if (devpts) {
 		down(&allocated_ptys_lock);
 		idr_remove(&allocated_ptys, idx);
 		up(&allocated_ptys_lock);

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

