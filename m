Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbRE0DTp>; Sat, 26 May 2001 23:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262735AbRE0DTf>; Sat, 26 May 2001 23:19:35 -0400
Received: from elaine18.Stanford.EDU ([171.64.15.83]:50341 "EHLO
	elaine18.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262734AbRE0DTY>; Sat, 26 May 2001 23:19:24 -0400
Date: Sat, 26 May 2001 20:19:11 -0700 (PDT)
From: John Martin <suntzu@stanford.edu>
To: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: [PATCH] scsi_ioctl.c
Message-ID: <Pine.GSO.4.31.0105262008040.19602-100000@elaine18.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this seems to be a straight forward case of memory not being freed on an
error path.  so i just added in one line to each of the if statements that
could fail.
   -john martin


--- drivers/scsi/scsi_ioctl.c.orig	Fri Apr 27 13:59:19 2001
+++ drivers/scsi/scsi_ioctl.c	Sat May 26 20:13:03 2001
@@ -317,10 +317,16 @@

 		sb_len = (sb_len > OMAX_SB_LEN) ? OMAX_SB_LEN : sb_len;
 		if (copy_to_user(cmd_in, SRpnt->sr_sense_buffer, sb_len))
+		{
+			scsi_release_request(SRpnt);
 			return -EFAULT;
+		}
 	} else
 		if (copy_to_user(cmd_in, buf, outlen))
+		{
+			scsi_release_request(SRpnt);
 			return -EFAULT;
+		}

 	result = SRpnt->sr_result;


