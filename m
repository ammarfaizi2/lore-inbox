Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317088AbSEXFrb>; Fri, 24 May 2002 01:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317089AbSEXFr3>; Fri, 24 May 2002 01:47:29 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:2269 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317088AbSEXFrW>;
	Fri, 24 May 2002 01:47:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15597.54106.812433.485262@gargle.gargle.HOWL>
Date: Fri, 24 May 2002 15:44:58 +1000
From: Christopher Yeoh <cyeoh@samba.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] SUSv2 msgctl compliance
X-Mailer: VM 7.05 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For msgctl SUSv2 states:

"IPC_SET can only be executed by a process with appropriate privileges
or that has an effective user ID equal to the value of msg_perm.cuid
or msg_perm.uid in the msqid_ds data structure associated with
msqid. Only a process with appropriate privileges can raise the value
of msg_qbytes."

The current linux behaviour is to allow for the value of msg_qbytes to
be raised even if the process is not privileged. The following
patch (against 2.4.19pre8) fixes this problem:

--- ipc/msg.c.orig	Fri May 24 14:51:12 2002
+++ ipc/msg.c	Fri May 24 14:58:36 2002
@@ -539,7 +539,8 @@
 	switch (cmd) {
 	case IPC_SET:
 	{
-		if (setbuf.qbytes > msg_ctlmnb && !capable(CAP_SYS_RESOURCE))
+		if (setbuf.qbytes > min(msg_ctlmnb, msq->q_qbytes) &&
+                    !capable(CAP_SYS_RESOURCE))
 			goto out_unlock_up;
 		msq->q_qbytes = setbuf.qbytes;
 
Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
