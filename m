Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbUKDCG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbUKDCG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUKDCFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:05:50 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:9108
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262061AbUKDB4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:56:06 -0500
Subject: [patch 10/20] uml: catch EINTR in generic_console_write
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:37 +0100
Message-Id: <20041103231737.CCD4A55C7B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make generic_console_write() catch the EINTR error code and retry
doing the calls accordingly.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/drivers/chan_user.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff -puN arch/um/drivers/chan_user.c~uml-catch_eintr_generic_console_write arch/um/drivers/chan_user.c
--- vanilla-linux-2.6.9/arch/um/drivers/chan_user.c~uml-catch_eintr_generic_console_write	2004-11-03 23:44:59.720481224 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/chan_user.c	2004-11-03 23:44:59.722480920 +0100
@@ -27,14 +27,26 @@ int generic_console_write(int fd, const 
 	int err;
 
 	if(isatty(fd)){
-		tcgetattr(fd, &save);
+		CATCH_EINTR(err = tcgetattr(fd, &save));
+		if (err)
+			goto error;
 		new = save;
+		/* The terminal becomes a bit less raw, to handle \n also as
+		 * "Carriage Return", not only as "New Line". Otherwise, the new
+		 * line won't start at the first column.*/
 		new.c_oflag |= OPOST;
-		tcsetattr(fd, TCSAFLUSH, &new);
+		CATCH_EINTR(err = tcsetattr(fd, TCSAFLUSH, &new));
+		if (err)
+			goto error;
 	}
 	err = generic_write(fd, buf, n, NULL);
-	if(isatty(fd)) tcsetattr(fd, TCSAFLUSH, &save);
+	/* Restore raw mode, in any case; we *must* ignore any error apart
+	 * EINTR, except for debug.*/
+	if(isatty(fd))
+		CATCH_EINTR(tcsetattr(fd, TCSAFLUSH, &save));
 	return(err);
+error:
+	return(-errno);
 }
 
 struct winch_data {
_
