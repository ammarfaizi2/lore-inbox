Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTEYNUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 09:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTEYNUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 09:20:49 -0400
Received: from web9607.mail.yahoo.com ([216.136.129.186]:4358 "HELO
	web9607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262100AbTEYNUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 09:20:48 -0400
Message-ID: <20030525133358.75349.qmail@web9607.mail.yahoo.com>
Date: Sun, 25 May 2003 06:33:58 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] sigprocmask and invalid how parameter
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-518996958-1053869638=:74780"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-518996958-1053869638=:74780
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello,

I was playing around with sigprocmask and found that if the
"how" parameter was bad, the kernel treated it just like a
SIG_SETMASK was passed in except that it returned an error.
I think that it should perform no action if "how" is
invalid.

The attached patch makes the kernel unlock the irq and
leave if how is invalid. The patch was created against a
2.4.18 kernel, but this function hasn't changed. Even the
2.5 kernels look the same for this function.

Best Regards,
-Steve Grubb

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
--0-518996958-1053869638=:74780
Content-Type: text/plain; name="inv_how.patch"
Content-Description: inv_how.patch
Content-Disposition: inline; filename="inv_how.patch"

--- signal.c.orig	2003-05-25 07:12:46.000000000 -0400
+++ signal.c	2003-05-25 07:15:02.000000000 -0400
@@ -885,11 +885,13 @@
 			break;
 		}
 
+		if (error) {
+			spin_unlock_irq(&current->sigmask_lock);
+			goto out;
+		}
 		current->blocked = new_set;
 		recalc_sigpending(current);
 		spin_unlock_irq(&current->sigmask_lock);
-		if (error)
-			goto out;
 		if (oset)
 			goto set_old;
 	} else if (oset) {

--0-518996958-1053869638=:74780--
