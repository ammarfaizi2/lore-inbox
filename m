Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292656AbSCGWhs>; Thu, 7 Mar 2002 17:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310564AbSCGWhj>; Thu, 7 Mar 2002 17:37:39 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:12940 "EHLO q-ag.de")
	by vger.kernel.org with ESMTP id <S292656AbSCGWhR>;
	Thu, 7 Mar 2002 17:37:17 -0500
Message-ID: <3C87EBA0.8DD34D29@colorfullife.com>
Date: Thu, 07 Mar 2002 23:37:20 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.5-pre1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Content-Type: multipart/mixed;
 boundary="------------A34EF5A159A2645ACB765DB0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A34EF5A159A2645ACB765DB0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Maybe Alan will mutter something about sysvipc.
> Roughly speaking there are only advantages, especially since
> I think we'll have to do this sooner or later, and in such cases
> sooner is better.

The sysvipc situation isn't that bad. The new interfaces added for
32-bit uids also contain 32-bit pid values.
The semaphore code contains a stupid hack that assumes 16-bit uids,
appart from that apps linked against new glibc version should run fine.

[patch vs. 2.5.6-pre2 attached, but untested].

--
	Manfred
--------------A34EF5A159A2645ACB765DB0
Content-Type: text/plain; charset=us-ascii;
 name="patch-sem"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sem"

--- 2.5/ipc/sem.c	Sun Mar  3 12:04:00 2002
+++ build-2.5/ipc/sem.c	Thu Mar  7 23:33:02 2002
@@ -251,39 +251,39 @@
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
 
@@ -298,13 +298,9 @@
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
 
@@ -624,7 +620,7 @@
 		err = curr->semval;
 		goto out_unlock;
 	case GETPID:
-		err = curr->sempid & 0xffff;
+		err = curr->sempid;
 		goto out_unlock;
 	case GETNCNT:
 		err = count_semncnt(sma,semnum);

--------------A34EF5A159A2645ACB765DB0--

