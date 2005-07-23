Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVGWLmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVGWLmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 07:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVGWLmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 07:42:06 -0400
Received: from hermes.domdv.de ([193.102.202.1]:45832 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261188AbVGWLmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 07:42:05 -0400
Message-ID: <42E22D0C.1010608@domdv.de>
Date: Sat, 23 Jul 2005 13:42:04 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.13rc3: RLIMIT_RTPRIO broken
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090305000603040503020101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090305000603040503020101
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

RLIMIT_RTPRIO is supposed to grant non privileged users the right to use
SCHED_FIFO/SCHED_RR scheduling policies with priorites bounded by the
RLIMIT_RTPRIO value via sched_setscheduler(). This is usually used by
audio users.

Unfortunately this is broken in 2.6.13rc3 as you can see in the excerpt
from sched_setscheduler below:

        /*
         * Allow unprivileged RT tasks to decrease priority:
         */
        if (!capable(CAP_SYS_NICE)) {
                /* can't change policy */
                if (policy != p->policy)
                        return -EPERM;

After the above unconditional test which causes sched_setscheduler to
fail with no regard to the RLIMIT_RTPRIO value the following check is made:

               /* can't increase priority */
                if (policy != SCHED_NORMAL &&
                    param->sched_priority > p->rt_priority &&
                    param->sched_priority >
                                p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
                        return -EPERM;

Thus I do believe that the RLIMIT_RTPRIO value must be taken into
account for the policy check, especially as the RLIMIT_RTPRIO limit is
of no use without this change.

The attached patch fixes this problem. I would appreciate it if the fix
would make it into 2.6.13.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------090305000603040503020101
Content-Type: text/plain;
 name="2.6.13rc3-rtprio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.13rc3-rtprio.patch"

--- linux.orig/kernel/sched.c	2005-07-22 19:45:05.000000000 +0200
+++ linux/kernel/sched.c	2005-07-22 19:45:42.000000000 +0200
@@ -3528,7 +3528,8 @@
 	 */
 	if (!capable(CAP_SYS_NICE)) {
 		/* can't change policy */
-		if (policy != p->policy)
+		if (policy != p->policy &&
+			!p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
 			return -EPERM;
 		/* can't increase priority */
 		if (policy != SCHED_NORMAL &&

--------------090305000603040503020101--
