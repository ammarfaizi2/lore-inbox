Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSEOS0G>; Wed, 15 May 2002 14:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316466AbSEOS0F>; Wed, 15 May 2002 14:26:05 -0400
Received: from relay1.EECS.Berkeley.EDU ([169.229.60.163]:41674 "EHLO
	relay1.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S316465AbSEOS0E>; Wed, 15 May 2002 14:26:04 -0400
Subject: Bug in 2.4.19-pre8 drivers/input/joydev.c
From: "Robert T. Johnson" <rtjohnso@cs.berkeley.edu>
To: linux-kernel@vger.kernel.org
Cc: Sailesh Krishnamurthy <sailesh@EECS.Berkeley.EDU>, vojtech@suse.cz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 May 2002 11:26:02 -0700
Message-Id: <1021487163.12915.37.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sailesh Krishmurthy and I have found what we believe is an exploitable
bug in drivers/input/joydev.c:joydev_ioctl().  It looks like the
JSIOCSAXMAP and JSIOCSBTNMAP cases accidentally reverse the arguments to
copy_from_user().  A user program could call these ioctls with a
maliciously chosen arg to crash the system or gain root access.  A patch
is attached to this message (though my mailer will probably mangle it --
sorry).  We apologize if we have misunderstood the behavior of this
function.

We found this bug using the static analysis tool cqual,
http://www.cs.berkeley.edu/~jfoster/cqual/, developed at UC Berkeley by
Jeff Foster, John Kodumal, and many others.

Please CC us in any replies.

Thanks for all your great work on the kernel.

Best,
Rob Johnson (rtjohnso@cs.berkeley.edu)
Sailesh Krishnamurthy (sailesh@cs.berkeley.edu)



--- joydev.c    Wed May 15 10:25:26 2002
+++ joydev_fixed.c      Wed May 15 10:37:36 2002
@@ -363,7 +363,7 @@
                        return copy_to_user((struct js_corr *) arg,
joydev->corr,
                                                sizeof(struct js_corr) *
joydev->nabs) ? -EFAULT : 0;
                case JSIOCSAXMAP:
-                       if (copy_from_user((__u8 *) arg, joydev->abspam,
sizeof(__u8) *
ABS_MAX))
+                       if (copy_from_user(joydev->abspam, (__u8 *) arg,
sizeof(__u8) *
ABS_MAX))
                                return -EFAULT;
                        for (i = 0; i < ABS_MAX; i++) {
                                if (joydev->abspam[i] > ABS_MAX) return
-EINVAL;
@@ -374,7 +374,7 @@
                        return copy_to_user((__u8 *) arg,
joydev->abspam,
                                                sizeof(__u8) * ABS_MAX)
? -EFAULT : 0;
                case JSIOCSBTNMAP:
-                       if (copy_from_user((__u16 *) arg,
joydev->absmap, sizeof(__u16) *
(KEY_MAX - BTN_MISC)))
+                       if (copy_from_user(joydev->absmap, (__u16 *)
arg, sizeof(__u16) *
(KEY_MAX - BTN_MISC)))
                                return -EFAULT;
                        for (i = 0; i < KEY_MAX - BTN_MISC; i++); {
                                if (joydev->keypam[i] > KEY_MAX ||
joydev->keypam[i] < BTN_MISC)
return -EINVAL;


