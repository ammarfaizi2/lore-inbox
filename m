Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSHBSjz>; Fri, 2 Aug 2002 14:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSHBSjz>; Fri, 2 Aug 2002 14:39:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:58862 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316594AbSHBSjw>; Fri, 2 Aug 2002 14:39:52 -0400
Message-ID: <3D4AD2B8.70901@us.ibm.com>
Date: Fri, 02 Aug 2002 11:43:04 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kevin O'Connor" <kevin@koconnor.net>
CC: linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [RFC] Push BKL into chrdev opens
References: <3D490BF2.2000709@us.ibm.com> <20020802142046.A28878@arizona.localdomain>
Content-Type: multipart/mixed;
 boundary="------------060801030309040902070208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060801030309040902070208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kevin O'Connor wrote:
> The returnout macro is incredibly ugly.  It is also broken.  (The "goto
> out" is on the same level as the if and is executed regardless of the if
> condition.)

You are very, very right.  Ugh.  I made this during a 10-second moment 
of weakness when I wondered if we should have a macro to do this.

Cleanup attached.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------060801030309040902070208
Content-Type: text/plain;
 name="cdev-bkl-2.5.30+bk-7-istallionfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdev-bkl-2.5.30+bk-7-istallionfix.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.545   -> 1.546  
#	drivers/char/istallion.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/02	haveblue@nighthawk.sr71.net	1.546
# fix ugliness
# --------------------------------------------
#
diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Fri Aug  2 11:42:09 2002
+++ b/drivers/char/istallion.c	Fri Aug  2 11:42:09 2002
@@ -1022,8 +1022,6 @@
 
 /*****************************************************************************/
 
-#define returnout(x) ret=x;goto out;
-
 static int stli_open(struct tty_struct *tty, struct file *filp)
 {
 	stlibrd_t	*brdp;
@@ -1038,23 +1036,34 @@
 
 	minordev = minor(tty->device);
 	brdnr = MINOR2BRD(minordev);
-	if (brdnr >= stli_nrbrds)
-		returnout(-ENODEV);
+	if (brdnr >= stli_nrbrds) {
+		ret = -ENODEV; 
+		goto out;
+	}
 	brdp = stli_brds[brdnr];
-	if (brdp == (stlibrd_t *) NULL)
-		returnout(-ENODEV);
-	if ((brdp->state & BST_STARTED) == 0)
-		returnout(-ENODEV);
+	if (brdp == (stlibrd_t *) NULL) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if ((brdp->state & BST_STARTED) == 0) {
+		ret = -ENODEV;
+		goto out;
+	}
 	portnr = MINOR2PORT(minordev);
-	if ((portnr < 0) || (portnr > brdp->nrports))
-		returnout(-ENODEV);
+	if ((portnr < 0) || (portnr > brdp->nrports)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	portp = brdp->ports[portnr];
-	if (portp == (stliport_t *) NULL)
-		returnout(-ENODEV);
-	if (portp->devnr < 1)
-		returnout(-ENODEV);
-
+	if (portp == (stliport_t *) NULL) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if (portp->devnr < 1) {
+		ret =-ENODEV;
+		goto out;
+	}
 	MOD_INC_USE_COUNT;
 
 /*
@@ -1065,9 +1074,12 @@
  */
 	if (portp->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&portp->close_wait);
-		if (portp->flags & ASYNC_HUP_NOTIFY)
-			returnout(-EAGAIN);
-		returnout(-ERESTARTSYS);
+		if (portp->flags & ASYNC_HUP_NOTIFY) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		ret = -ERESTARTSYS;
+		goto out;
 	}
 
 /*
@@ -1081,8 +1093,10 @@
 	portp->refcount++;
 
 	while (test_bit(ST_INITIALIZING, &portp->state)) {
-		if (signal_pending(current))
-			returnout(-ERESTARTSYS);
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			goto out;
+		}
 		interruptible_sleep_on(&portp->raw_wait);
 	}
 
@@ -1094,8 +1108,10 @@
 		}
 		clear_bit(ST_INITIALIZING, &portp->state);
 		wake_up_interruptible(&portp->raw_wait);
-		if (rc < 0)
-			returnout(rc);
+		if (rc < 0) {
+			ret = rc;
+			goto out;
+		}
 	}
 
 /*
@@ -1106,9 +1122,12 @@
  */
 	if (portp->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&portp->close_wait);
-		if (portp->flags & ASYNC_HUP_NOTIFY)
-			returnout(-EAGAIN);
-		returnout(-ERESTARTSYS);
+		if (portp->flags & ASYNC_HUP_NOTIFY) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		ret = -ERESTARTSYS;
+		goto out;
 	}
 
 /*
@@ -1117,24 +1136,34 @@
  *	then also we might have to wait for carrier.
  */
 	if (tty->driver.subtype == STL_DRVTYPCALLOUT) {
-		if (portp->flags & ASYNC_NORMAL_ACTIVE)
-			returnout(-EBUSY);
+		if (portp->flags & ASYNC_NORMAL_ACTIVE) {
+			ret = -EBUSY;
+			goto out;
+		}
 		if (portp->flags & ASYNC_CALLOUT_ACTIVE) {
 			if ((portp->flags & ASYNC_SESSION_LOCKOUT) &&
-			    (portp->session != current->session))
-				returnout(-EBUSY);
+			    (portp->session != current->session)) {
+				ret = -EBUSY;
+				goto out;
+			}
 			if ((portp->flags & ASYNC_PGRP_LOCKOUT) &&
-			    (portp->pgrp != current->pgrp))
-				returnout(-EBUSY);
+			    (portp->pgrp != current->pgrp)) {
+				ret = -EBUSY);
+				goto out;
+			}
 		}
 		portp->flags |= ASYNC_CALLOUT_ACTIVE;
 	} else {
 		if (filp->f_flags & O_NONBLOCK) {
-			if (portp->flags & ASYNC_CALLOUT_ACTIVE)
-				returnout(-EBUSY);
+			if (portp->flags & ASYNC_CALLOUT_ACTIVE) {
+				ret = -EBUSY;
+				goto out;
+			}
 		} else {
-			if ((rc = stli_waitcarrier(brdp, portp, filp)) != 0)
-				returnout(rc);
+			if ((rc = stli_waitcarrier(brdp, portp, filp)) != 0) {
+				ret = rc;
+				goto out;
+			}
 		}
 		portp->flags |= ASYNC_NORMAL_ACTIVE;
 	}
@@ -1151,7 +1180,7 @@
 	portp->pgrp = current->pgrp;
 out:
 	unlock_kernel();
-	return 0;
+	return ret;
 }
 
 /*****************************************************************************/

--------------060801030309040902070208--

