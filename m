Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUJCGwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUJCGwK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 02:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUJCGwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 02:52:10 -0400
Received: from almesberger.net ([63.105.73.238]:40206 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S267740AbUJCGvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 02:51:51 -0400
Date: Sun, 3 Oct 2004 03:51:36 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] boot parameters: quoting of environment variables
Message-ID: <20041003035136.A15226@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel currently allows boot parameters to be quoted (so
that they can contain spaces) in the following way:

param="value"

Unfortunately, when init/main.c:unknown_bootoption reconstructs
the parameter line for environment variables, it does not expect
that there could be two \0s between the parameter name and its
value. My patch corrects this by shifting the parameter name.

The patch is for 2.6.7, but also works with 2.6.8.1. Furthermore,
I've checked that nothing relevant seems to have changed until
2.6.9-rc3.

- Werner

---------------------------------- cut here -----------------------------------

Signed-off-by: Werner Almesberger <werner@almesberger.net>

--- linux-2.6.7/init/main.c.orig	Sun Oct  3 03:27:12 2004
+++ linux-2.6.7/init/main.c	Sun Oct  3 03:44:54 2004
@@ -246,8 +246,14 @@
 static int __init unknown_bootoption(char *param, char *val)
 {
 	/* Change NUL term back to "=", to make "param" the whole string. */
-	if (val)
+	if (val) {
 		val[-1] = '=';
+		/* If the value was quoted, shift the parameter name. */
+		if (!val[-2]) {
+			memmove(param+1,param,strlen(param));
+			param++;
+		}
+	}
 
 	/* Handle obsolete-style parameters */
 	if (obsolete_checksetup(param))

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
