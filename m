Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271507AbRIFRSs>; Thu, 6 Sep 2001 13:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271502AbRIFRSh>; Thu, 6 Sep 2001 13:18:37 -0400
Received: from nwcst336.netaddress.usa.net ([204.68.23.81]:6339 "HELO
	nwcst336.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S271507AbRIFRS1> convert rfc822-to-8bit; Thu, 6 Sep 2001 13:18:27 -0400
Message-ID: <20010906171847.8057.qmail@nwcst336.netaddress.usa.net>
Date: 6 Sep 2001 11:18:46 MDT
From: Andrey Ilinykh <ailinykh@usa.net>
To: linux-kernel@vger.kernel.org
Subject: msgrcv bug?
X-Mailer: USANET web-mailer (34FM.0700.21.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
sys_msgrcv contains such code as (ipc/msg.c): 

771                 list_del(&msg->m_list);
772                 msq->q_qnum--;
773                 msq->q_rtime = CURRENT_TIME;
774                 msq->q_lrpid = current->pid;
775                 msq->q_cbytes -= msg->m_ts;
776                 atomic_sub(msg->m_ts,&msg_bytes);
777                 atomic_dec(&msg_hdrs);
778                 ss_wakeup(&msq->q_senders,0);
779                 msg_unlock(msqid);
780 out_success:
781                 msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
782                 if (put_user (msg->m_type, &msgp->mtype) ||
783                     store_msg(msgp->mtext, msg, msgsz)) {
784                             msgsz = -EFAULT;
785                 }
786                 free_msg(msg);
787                 return msgsz;

if put_user fails (user process passed wrond address) message will not be
delivered, but it is already removed from list. So nobody will receive this
message. Is this behavior correct?
Thank you,
  Andrey
Please cc to my e-mail also.
