Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbTHYWYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTHYWYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:24:32 -0400
Received: from [195.97.124.116] ([195.97.124.116]:50850 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S262293AbTHYWY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:24:28 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: acpi-devel@lists.sourceforge.net
Subject: [PATCH] 2.6.0-test4: Trivial /sys/power/state patch, sleep status report
Date: Tue, 26 Aug 2003 01:25:30 +0300
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_azoS/pSZkFiWC8B"
Message-Id: <200308260125.30194.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_azoS/pSZkFiWC8B
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just found out that by 'echo sth_wrong > /sys/power/state' the kernel would 
oops in a fatal way (no clean exit from there).
The oops suggested that the code would enter an invalid fn.

You may apply the included patch to solve the bug. IMHO doing a clean exit is 
much preferrable than having BUG() there.

In the patch I also added some double checking of the fn. You may disable that  
(although sleeping is a one time fn which won't be slowed dow by that). 

Status report:  (HP Omnibook XE3GC)
S1 ('standby') works
S3, S4bios will suspend, but NOT resume.
that's the same as previous kernels I've tested so far.

I still have the ALSA-artsd deadlock I reported w. -test1 (in short, artsd 
resumes from S1 in a 'disk I/O' process state, which deadlocks maestro3)
see: http://marc.theaimsgroup.com/?l=linux-kernel&m=105836807605512&w=2



--Boundary-00=_azoS/pSZkFiWC8B
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sys-power-state.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sys-power-state.diff"

diff -Bbur /diskb/users/panos/linux-off/kernel/power/main.c /usr/src/linux/kernel/power/main.c
--- /diskb/users/panos/linux-off/kernel/power/main.c	2003-08-23 12:13:17.000000000 +0300
+++ /usr/src/linux/kernel/power/main.c	2003-08-26 00:59:34.000000000 +0300
@@ -304,6 +304,20 @@
 		goto Unlock;
 	}
 
+# if 1 		/* disable once we're sure we got it right */
+	/* double - check  code */
+	if (!s ) {
+		printk (KERN_ERR "Invalid suspend state %d\n",state);
+		error = -EINVAL;
+		goto Unlock ;
+	}
+	if (! s->fn) {
+		printk(KERN_ERR "Invalid fn for suspend state %d\n", state );
+		error = -EINVAL ;
+		goto Unlock;
+	}
+# endif
+
 	pr_debug("PM: Preparing system for suspend.\n");
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
@@ -500,7 +514,7 @@
 		if (s->name && !strcmp(buf,s->name))
 			break;
 	}
-	if (s)
+	if ( (s) && (state < PM_SUSPEND_MAX) )
 		error = enter_state(state);
 	else
 		error = -EINVAL;

--Boundary-00=_azoS/pSZkFiWC8B--

