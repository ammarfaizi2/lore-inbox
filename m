Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWCYLU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWCYLU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 06:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWCYLU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 06:20:27 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:10662 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750836AbWCYLU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 06:20:26 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] vt: TIOCL to read kmsg_redirect from user space
Date: Sat, 25 Mar 2006 12:19:08 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251219.08415.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The userland suspend tool we're working on needs to get the current value
of kmsg_redirect from the kernel so that it can save it and restore it after
resume.  Unfortunetely there only is TIOCL_SETKMSGREDIRECT allowing us to
set this value from the user space.

The appended patch adds the "missing" TIOCL_GETKMSGREDIRECT that we need.

Comments welcome.

Greetings,
Rafael

---
 drivers/char/vt.c     |    4 ++++
 include/linux/tiocl.h |    1 +
 2 files changed, 5 insertions(+)

Index: linux-2.6.16-mm1/drivers/char/vt.c
===================================================================
--- linux-2.6.16-mm1.orig/drivers/char/vt.c
+++ linux-2.6.16-mm1/drivers/char/vt.c
@@ -2328,6 +2328,10 @@ int tioclinux(struct tty_struct *tty, un
 		case TIOCL_SETVESABLANK:
 			set_vesa_blanking(p);
 			break;
+		case TIOCL_GETKMSGREDIRECT:
+			data = kmsg_redirect;
+			ret = __put_user(data, p);
+			break;
 		case TIOCL_SETKMSGREDIRECT:
 			if (!capable(CAP_SYS_ADMIN)) {
 				ret = -EPERM;
Index: linux-2.6.16-mm1/include/linux/tiocl.h
===================================================================
--- linux-2.6.16-mm1.orig/include/linux/tiocl.h
+++ linux-2.6.16-mm1/include/linux/tiocl.h
@@ -34,5 +34,6 @@ struct tiocl_selection {
 #define TIOCL_SCROLLCONSOLE	13	/* scroll console */
 #define TIOCL_BLANKSCREEN	14	/* keep screen blank even if a key is pressed */
 #define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
+#define TIOCL_GETKMSGREDIRECT	17	/* get the vt the kernel messages are restricted to */
 
 #endif /* _LINUX_TIOCL_H */
