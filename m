Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271906AbRIMRJC>; Thu, 13 Sep 2001 13:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271911AbRIMRIw>; Thu, 13 Sep 2001 13:08:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20668 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271910AbRIMRIo>; Thu, 13 Sep 2001 13:08:44 -0400
Message-ID: <3BA111FD.499BBF1D@us.ibm.com>
Date: Thu, 13 Sep 2001 10:07:25 -1000
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org, manfreds@colorfullife.com
Subject: [PATCH]Fix bug in msgsnd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linus & Alan,

This patch fixes a bug in msgsnd.  If a message is sent via
pipelined_send(), the q_lrpid field of the associated message queue
(last pid receive) is not updated correctly.  The existing code
(apparently by mistake) updates the lspid field instead. The second
problem is that, for the pipelinesend case, q_lstime(last msgsnd time)
is set AFTER q_lrtime(last msgrcv time), yielding a negative time delta.

This patch is against kernel 2.4.9 and has been tested.  Please
apply.  

Please CC your feedback to me also, thanks.

-- 
Mingming Cao
IBM Linux Technology Center

diff -urN -X dontdiff linux/ipc/msg.c linux-tk/ipc/msg.c
--- linux/ipc/msg.c	Tue Sep 11 16:21:42 2001
+++ linux-tk/ipc/msg.c	Tue Sep 11 16:21:31 2001
@@ -613,7 +613,7 @@
 				wake_up_process(msr->r_tsk);
 			} else {
 				msr->r_msg = msg;
-				msq->q_lspid = msr->r_tsk->pid;
+				msq->q_lrpid = msr->r_tsk->pid;
 				msq->q_rtime = CURRENT_TIME;
 				wake_up_process(msr->r_tsk);
 				return 1;
@@ -683,6 +683,9 @@
 		goto retry;
 	}
 
+	msq->q_lspid = current->pid;
+	msq->q_stime = CURRENT_TIME;
+
 	if(!pipelined_send(msq,msg)) {
 		/* noone is waiting for this message, enqueue it */
 		list_add_tail(&msg->m_list,&msq->q_messages);
@@ -694,8 +697,6 @@
 	
 	err = 0;
 	msg = NULL;
-	msq->q_lspid = current->pid;
-	msq->q_stime = CURRENT_TIME;
 
 out_unlock_free:
 	msg_unlock(msqid);
