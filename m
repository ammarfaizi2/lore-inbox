Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVAYXyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVAYXyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVAYXvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:51:40 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:41941 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262239AbVAYXrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:47:40 -0500
Date: Tue, 25 Jan 2005 18:47:13 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: wait_for_completion API extension addition
In-reply-to: <20050125210102.GA6452@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <41F6DA81.9000503@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_mS2eFW3t48CPAe+RRZ+EBg)"
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41F6AA83.20306@sun.com> <20050125210102.GA6452@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_mS2eFW3t48CPAe+RRZ+EBg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Molnar wrote:
> * Mike Waychison <Michael.Waychison@Sun.COM> wrote:
> 
> 
>>Hi Ingo,
>>
>>I noticed that the wait_for_completion API extensions made it into
>>mainline.
>>
>>However, I posted that the patch in question is broken a while back:
>>
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=110131832828126&w=2
>>
>>Can we fix this?
> 
> 
> (/me pokes himself in the eyes)
> 
> could you send an incremental patch against BK-curr?
> 
> 	Ingo


Attached.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9tpBdQs4kOxk3/MRArUtAJ4+O7CCH8HdGqeREJb7yVQjOdJSkQCfRTIX
al9JVahdnQcOJIwyIW3LeDU=
=zhk+
-----END PGP SIGNATURE-----

--Boundary_(ID_mS2eFW3t48CPAe+RRZ+EBg)
Content-type: text/x-patch; name=fix_completion_api.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=fix_completion_api.patch

Fix up signal_pending and timeout paths for wait_for_completion API extensions.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>

---

 sched.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

Index: linux-2.6-bk-curr/kernel/sched.c
===================================================================
--- linux-2.6-bk-curr.orig/kernel/sched.c	2005-01-25 18:22:04.667957792 -0500
+++ linux-2.6-bk-curr/kernel/sched.c	2005-01-25 18:38:54.421451928 -0500
@@ -3020,15 +3020,17 @@ wait_for_completion_timeout(struct compl
 			__set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock_irq(&x->wait.lock);
 			timeout = schedule_timeout(timeout);
-			if (!timeout)
-				goto out;
 			spin_lock_irq(&x->wait.lock);
+			if (!timeout) {
+				__remove_wait_queue(&x->wait, &wait);
+				goto out;
+			}
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
 	}
 	x->done--;
-	spin_unlock_irq(&x->wait.lock);
 out:
+	spin_unlock_irq(&x->wait.lock);
 	return timeout;
 }
 EXPORT_SYMBOL(wait_for_completion_timeout);
@@ -3048,6 +3050,7 @@ int fastcall __sched wait_for_completion
 		do {
 			if (signal_pending(current)) {
 				ret = -ERESTARTSYS;
+				__remove_wait_queue(&x->wait, &wait);
 				goto out;
 			}
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -3080,21 +3083,23 @@ wait_for_completion_interruptible_timeou
 		do {
 			if (signal_pending(current)) {
 				timeout = -ERESTARTSYS;
-				goto out_unlock;
+				__remove_wait_queue(&x->wait, &wait);
+				goto out;
 			}
 			__set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock_irq(&x->wait.lock);
 			timeout = schedule_timeout(timeout);
-			if (!timeout)
-				goto out;
 			spin_lock_irq(&x->wait.lock);
+			if (!timeout) {
+				__remove_wait_queue(&x->wait, &wait);
+				goto out;
+			}
 		} while (!x->done);
 		__remove_wait_queue(&x->wait, &wait);
 	}
 	x->done--;
-out_unlock:
-	spin_unlock_irq(&x->wait.lock);
 out:
+	spin_unlock_irq(&x->wait.lock);
 	return timeout;
 }
 EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);

--Boundary_(ID_mS2eFW3t48CPAe+RRZ+EBg)--
