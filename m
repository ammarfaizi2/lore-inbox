Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbSJSO5U>; Sat, 19 Oct 2002 10:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265609AbSJSO5U>; Sat, 19 Oct 2002 10:57:20 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:57232 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265608AbSJSO5T>;
	Sat, 19 Oct 2002 10:57:19 -0400
Message-ID: <3DB17426.5010505@colorfullife.com>
Date: Sat, 19 Oct 2002 17:03:02 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] support large pid values for ipc/sem.c
Content-Type: multipart/mixed;
 boundary="------------010603040106020202020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603040106020202020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ipc/sem.c assumes that pid values are 16 bit:

try_atomic_semop():
 >
 > 	curr->sempid = (curr->sempid << 16) | pid;
 >
 > undo:
 > 	curr->sempid >>= 16;	
 >


What about the attached fix?

--
	Manfred

--------------010603040106020202020705
Content-Type: text/plain;
 name="patch-sem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sem"

--- 2.5/ipc/sem.c	Sat Oct 19 11:40:17 2002
+++ build-2.5/ipc/sem.c	Sat Oct 19 11:52:36 2002
@@ -263,39 +263,39 @@
 	for (sop = sops; sop < sops + nsops; sop++) {
 		curr = sma->sem_base + sop->sem_num;
 		sem_op = sop->sem_op;
-
-		if (!sem_op && curr->semval)
+		result = curr->semval;
+  
+		if (!sem_op && result)
 			goto would_block;
 
-		curr->sempid = (curr->sempid << 16) | pid;
-		curr->semval += sem_op;
-		if (sop->sem_flg & SEM_UNDO)
-		{
+		result += sem_op;
+		if (result < 0)
+			goto would_block;
+		if (result > SEMVMX)
+			goto out_of_range;
+		if (sop->sem_flg & SEM_UNDO) {
 			int undo = un->semadj[sop->sem_num] - sem_op;
 			/*
 	 		 *	Exceeding the undo range is an error.
 			 */
 			if (undo < (-SEMAEM - 1) || undo > SEMAEM)
-			{
-				/* Don't undo the undo */
-				sop->sem_flg &= ~SEM_UNDO;
 				goto out_of_range;
-			}
-			un->semadj[sop->sem_num] = undo;
 		}
-		if (curr->semval < 0)
-			goto would_block;
-		if (curr->semval > SEMVMX)
-			goto out_of_range;
+		curr->semval = result;
 	}
 
-	if (do_undo)
-	{
-		sop--;
+	if (do_undo) {
 		result = 0;
 		goto undo;
 	}
-
+	sop--;
+	while (sop >= sops) {
+		sma->sem_base[sop->sem_num].sempid = pid;
+		if (sop->sem_flg & SEM_UNDO)
+			un->semadj[sop->sem_num] -= sop->sem_op;
+		sop--;
+	}
+	
 	sma->sem_otime = CURRENT_TIME;
 	return 0;
 
@@ -310,13 +310,9 @@
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
 
@@ -637,7 +633,7 @@
 		err = curr->semval;
 		goto out_unlock;
 	case GETPID:
-		err = curr->sempid & 0xffff;
+		err = curr->sempid;
 		goto out_unlock;
 	case GETNCNT:
 		err = count_semncnt(sma,semnum);

--------------010603040106020202020705--


