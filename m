Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWJLMMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWJLMMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWJLMMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:12:14 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:908 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S1751328AbWJLMMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:12:13 -0400
Date: Thu, 12 Oct 2006 16:13:37 +0400
Message-Id: <200610121213.k9CCDbPi004548@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: OpenVZ Developers List <devel@openvz.org>
Subject: [PATCH] block layer: ioprio_best function fix
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Thu, 12 Oct 2006 16:12:11 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ioprio_best function first checks wethere aioprio or bioprio equals
IOPRIO_CLASS_NONE (ioprio_valid() macros does that) and if it is so it returns
bioprio/aioprio appropriately. Thus the next four lines, that set aclass/bclass
to IOPRIO_CLASS_BE, if aclass/bclass == IOPRIO_CLASS_NONE, are never executed.

The second problem: if aioprio from class IOPRIO_CLASS_NONE and bioprio from
class IOPRIO_CLASS_IDLE are passed to ioprio_best function, it will return
IOPRIO_CLASS_IDLE. It means that during __make_request we can merge two
requests and set the priority of merged request to IDLE, while one of
the initial requests originates from a process with NONE (default) priority.
So we can get a situation when a process with default ioprio will experience
IO starvation, while there is no process from real-time class in the system.

Just removing ioprio_valid check should correct situation.

Signed-off-by: Vasily Tarasov <vtaras@openvz.org>

--

--- linux-2.6.18/fs/ioprio.c.orig	2006-09-20 07:42:06.000000000 +0400
+++ linux-2.6.18/fs/ioprio.c	2006-10-12 14:52:36.000000000 +0400
@@ -145,11 +145,6 @@ int ioprio_best(unsigned short aprio, un
 	unsigned short aclass = IOPRIO_PRIO_CLASS(aprio);
 	unsigned short bclass = IOPRIO_PRIO_CLASS(bprio);
 
-	if (!ioprio_valid(aprio))
-		return bprio;
-	if (!ioprio_valid(bprio))
-		return aprio;
-
 	if (aclass == IOPRIO_CLASS_NONE)
 		aclass = IOPRIO_CLASS_BE;
 	if (bclass == IOPRIO_CLASS_NONE)
