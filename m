Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUAHBrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUAHBrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:47:43 -0500
Received: from [193.138.115.2] ([193.138.115.2]:64778 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263448AbUAHBrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:47:42 -0500
Date: Thu, 8 Jan 2004 02:44:57 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: linux-kernel@vger.kernel.org
cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl - arg
 is unsigned.
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC074B2059@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 'arg' argument to the function do_fcntl in fs/fcntl.c is of type
'unsigned long', thus it can never be less than zero (all callers of
do_fcntl take unsigned arguments as well and pass on unsigned values),
thus the check for 'arg < 0' in the F_SETSIG case of the switch in
do_fcntl can never be true and thus does not need to be there in the first
place.  Patch below (against 2.6.1-rc1-mm2) removes this dead code.


--- linux-2.6.1-rc1-mm2-orig/fs/fcntl.c 2004-01-06 01:33:08.000000000 +0100
+++ linux-2.6.1-rc1-mm2/fs/fcntl.c      2004-01-08 02:44:45.000000000 +0100
@@ -331,9 +331,8 @@ static long do_fcntl(unsigned int fd, un
 			break;
 		case F_SETSIG:
 			/* arg == 0 restores default behaviour. */
-			if (arg < 0 || arg > _NSIG) {
+			if (arg > _NSIG)
 				break;
-			}
 			err = 0;
 			filp->f_owner.signum = arg;
 			break;


Patch is only compile tested, but as far as I can see it should be
correct.


Kind regards,

Jesper Juhl



PS. CC'ing Matthew Wilcox as he's listed as 'file locking' maintainer in
MAINTAINERS, and Linus Torvalds as he's listed as original author in the
file - sorry for the inconvenience, if any.

