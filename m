Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWHCUNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWHCUNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWHCUNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:13:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:37773 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932480AbWHCUND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:13:03 -0400
Date: Thu, 3 Aug 2006 15:13:01 -0500
To: akpm@osdl.org, hollisbl@us.ibm.com
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pSeries hvsi char driver null pointer deref
Message-ID: <20060803201300.GB10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 
Please apply.

Under certain rare circumstances, it appears that there can be
be a NULL-pointer deref when a user fiddles with terminal
emeulation programs while outpu is being sent to the console.
This patch checks for and avoids a NULL-pointer deref.

Signed-off-by: Hollis Blanchard <hollisbl@austin.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/char/hvsi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc3-git1/drivers/char/hvsi.c
===================================================================
--- linux-2.6.18-rc3-git1.orig/drivers/char/hvsi.c	2006-08-03 14:50:00.000000000 -0500
+++ linux-2.6.18-rc3-git1/drivers/char/hvsi.c	2006-08-03 14:51:46.000000000 -0500
@@ -311,7 +311,8 @@ static void hvsi_recv_control(struct hvs
 				/* CD went away; no more connection */
 				pr_debug("hvsi%i: CD dropped\n", hp->index);
 				hp->mctrl &= TIOCM_CD;
-				if (!(hp->tty->flags & CLOCAL))
+				/* If userland hasn't done an open(2) yet, hp->tty is NULL. */
+				if (hp->tty && !(hp->tty->flags & CLOCAL))
 					*to_hangup = hp->tty;
 			}
 			break;
