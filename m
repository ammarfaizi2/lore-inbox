Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUGCRod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUGCRod (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 13:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUGCRod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 13:44:33 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:36487 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265170AbUGCRoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 13:44:30 -0400
Message-ID: <40E6F068.2060105@colorfullife.com>
Date: Sat, 03 Jul 2004 19:44:08 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ipc 3/3 enforce SEMVMX limit for undo
Content-Type: multipart/mixed;
 boundary="------------030100000308090005050304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030100000308090005050304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Independant from the other patches:
undo operations should not result in out of range semaphore values. The 
test for newval > SEMVMX is missing. The attached patch adds the test 
and a comment.

Andrew - could you add it to -mm?

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------030100000308090005050304
Content-Type: text/plain;
 name="patch-ipc-03-semval"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipc-03-semval"

--- 2.6/ipc/sem.c	2004-07-03 18:15:25.555921328 +0200
+++ build-2.6/ipc/sem.c	2004-07-03 17:40:02.511673112 +0200
@@ -1263,8 +1263,23 @@
 			struct sem * sem = &sma->sem_base[i];
 			if (u->semadj[i]) {
 				sem->semval += u->semadj[i];
+				/*
+				 * Range checks of the new semaphore value,
+				 * not defined by sus:
+				 * - Some unices ignore the undo entirely
+				 *   (e.g. HP UX 11i 11.22, Tru64 V5.1)
+				 * - some cap the value (e.g. FreeBSD caps
+				 *   at 0, but doesn't enforce SEMVMX)
+				 *
+				 * Linux caps the semaphore value, both at 0
+				 * and at SEMVMX.
+				 *
+				 * 	Manfred <manfred@colorfullife.com>
+				 */
 				if (sem->semval < 0)
-					sem->semval = 0; /* shouldn't happen */
+					sem->semval = 0;
+				if (sem->semval > SEMVMX)
+					sem->semval = SEMVMX;
 				sem->sempid = current->tgid;
 			}
 		}

--------------030100000308090005050304--
