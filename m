Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUB0IK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 03:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUB0IK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 03:10:57 -0500
Received: from jozlin.snap.net.nz ([202.37.101.35]:33213 "EHLO
	jozlin.snap.net.nz") by vger.kernel.org with ESMTP id S261745AbUB0IKz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 03:10:55 -0500
Date: Fri, 27 Feb 2004 21:15:52 +1300 (NZDT)
From: Keith Duthie <psycho@albatross.co.nz>
To: alsa-devel@alsa-project.org
cc: linux-kernel@vger.kernel.org
Subject: APM suspend causes uninterruptible sleep
Message-ID: <Pine.LNX.4.53.0402272054010.164@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Between alsa-driver 0.9.4 and alsa-driver 0.9.5 the change below was made.
Since then, suspending with a program outputting to the pcm device
causes that program to enter the uninterruptible sleep state. Reverting
this patch fixes the problem. The problem exists in 0.9.5 through 1.0.2c.

This problem affects kernel 2.6.3; applying the reversion of this patch
fixes it.

diff -urN alsa-driver-0.9.4/alsa-kernel/isa/cs423x/cs4231_lib.c alsa-driver-0.9.5/alsa-kernel/isa/cs423x/cs4231_lib.c
--- alsa-driver-0.9.4/alsa-kernel/isa/cs423x/cs4231_lib.c	Wed Apr 30 23:53:17 2003
+++ alsa-driver-0.9.5/alsa-kernel/isa/cs423x/cs4231_lib.c	Tue Jul  8 22:42:09 2003
@@ -1401,8 +1401,10 @@

 	switch (rqst) {
 	case PM_SUSPEND:
-		if (chip->suspend)
+		if (chip->suspend) {
+			snd_pcm_suspend_all(chip->pcm);
 			(*chip->suspend)(chip);
+		}
 		break;
 	case PM_RESUME:
 		if (chip->resume)

-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
