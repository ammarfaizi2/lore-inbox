Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRB0QFX>; Tue, 27 Feb 2001 11:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRB0QFN>; Tue, 27 Feb 2001 11:05:13 -0500
Received: from colorfullife.com ([216.156.138.34]:2321 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129444AbRB0QFF>;
	Tue, 27 Feb 2001 11:05:05 -0500
Message-ID: <3A9BCFE8.D3FB1AAE@colorfullife.com>
Date: Tue, 27 Feb 2001 17:03:52 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] minor bug in ipc/sem.c
Content-Type: multipart/mixed;
 boundary="------------AF9806053F3951D164FEDB4A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AF9806053F3951D164FEDB4A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

try_atomic_semop() corrupts the process id associated with a semaphore
if a semaphore operation with semval==0 (i.e. wait until the semaphore
value becomes zero) blocks.

I've attached a patch against 2.4.2-ac4, it also applies to 2.4.2

--
	Manfred
--------------AF9806053F3951D164FEDB4A
Content-Type: text/plain; charset=us-ascii;
 name="patch-sem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sem"

--- 2.4/ipc/sem.c	Mon Feb 26 21:10:44 2001
+++ build-2.4/ipc/sem.c	Mon Feb 26 21:16:00 2001
@@ -248,27 +248,31 @@
 	for (sop = sops; sop < sops + nsops; sop++) {
 		curr = sma->sem_base + sop->sem_num;
 		sem_op = sop->sem_op;
+		result = curr->semval;
 
-		if (!sem_op && curr->semval)
+		if (!sem_op && result)
 			goto would_block;
 
-		curr->sempid = (curr->sempid << 16) | pid;
-		curr->semval += sem_op;
-		if (sop->sem_flg & SEM_UNDO)
-			un->semadj[sop->sem_num] -= sem_op;
-
-		if (curr->semval < 0)
+		result += sem_op;
+		if (result < 0)
 			goto would_block;
-		if (curr->semval > SEMVMX)
+		if (result > SEMVMX)
 			goto out_of_range;
+		curr->semval = result;
 	}
 
 	if (do_undo)
 	{
-		sop--;
 		result = 0;
 		goto undo;
 	}
+	sop--;
+	while (sop >= sops) {
+		sma->sem_base[sop->sem_num].sempid = pid;
+		if (sop->sem_flg & SEM_UNDO)
+			un->semadj[sop->sem_num] -= sop->sem_op;
+		sop--;
+	}
 
 	sma->sem_otime = CURRENT_TIME;
 	return 0;
@@ -284,13 +288,9 @@
 		result = 1;
 
 undo:
+	sop--;
 	while (sop >= sops) {
-		curr = sma->sem_base + sop->sem_num;
-		curr->semval -= sop->sem_op;
-		curr->sempid >>= 16;
-
-		if (sop->sem_flg & SEM_UNDO)
-			un->semadj[sop->sem_num] += sop->sem_op;
+		sma->sem_base[sop->sem_num].semval -= sop->sem_op;
 		sop--;
 	}
 
@@ -610,7 +610,7 @@
 		err = curr->semval;
 		goto out_unlock;
 	case GETPID:
-		err = curr->sempid & 0xffff;
+		err = curr->sempid;
 		goto out_unlock;
 	case GETNCNT:
 		err = count_semncnt(sma,semnum);


--------------AF9806053F3951D164FEDB4A--


