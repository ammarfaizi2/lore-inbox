Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272926AbRINECZ>; Fri, 14 Sep 2001 00:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272942AbRINECQ>; Fri, 14 Sep 2001 00:02:16 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:31380 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S272926AbRINECD>; Fri, 14 Sep 2001 00:02:03 -0400
Message-ID: <3BA18196.AE7A3155@wipro.com>
Date: Fri, 14 Sep 2001 09:33:35 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Mingming cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Fix bug in msgsnd
In-Reply-To: <3BA111FD.499BBF1D@us.ibm.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

It would be nice, if you could send the test cases you used to test these
fixes or
their outputs before and after the fix, showing the problem and then the
problem
going away.

Thanks,
Balbir Singh.

Mingming cao wrote:

> Hello linus & Alan,
>
> This patch fixes a bug in msgsnd.  If a message is sent via
> pipelined_send(), the q_lrpid field of the associated message queue
> (last pid receive) is not updated correctly.  The existing code
> (apparently by mistake) updates the lspid field instead. The second
> problem is that, for the pipelinesend case, q_lstime(last msgsnd time)
> is set AFTER q_lrtime(last msgrcv time), yielding a negative time delta.
>
> This patch is against kernel 2.4.9 and has been tested.  Please
> apply.
>
> Please CC your feedback to me also, thanks.
>
> --
> Mingming Cao
> IBM Linux Technology Center
>
> diff -urN -X dontdiff linux/ipc/msg.c linux-tk/ipc/msg.c
> --- linux/ipc/msg.c     Tue Sep 11 16:21:42 2001
> +++ linux-tk/ipc/msg.c  Tue Sep 11 16:21:31 2001
> @@ -613,7 +613,7 @@
>                                 wake_up_process(msr->r_tsk);
>                         } else {
>                                 msr->r_msg = msg;
> -                               msq->q_lspid = msr->r_tsk->pid;
> +                               msq->q_lrpid = msr->r_tsk->pid;
>                                 msq->q_rtime = CURRENT_TIME;
>                                 wake_up_process(msr->r_tsk);
>                                 return 1;
> @@ -683,6 +683,9 @@
>                 goto retry;
>         }
>
> +       msq->q_lspid = current->pid;
> +       msq->q_stime = CURRENT_TIME;
> +
>         if(!pipelined_send(msq,msg)) {
>                 /* noone is waiting for this message, enqueue it */
>                 list_add_tail(&msg->m_list,&msq->q_messages);
> @@ -694,8 +697,6 @@
>
>         err = 0;
>         msg = NULL;
> -       msq->q_lspid = current->pid;
> -       msq->q_stime = CURRENT_TIME;
>
>  out_unlock_free:
>         msg_unlock(msqid);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
