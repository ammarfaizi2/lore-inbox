Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbRBASuV>; Thu, 1 Feb 2001 13:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131420AbRBASuL>; Thu, 1 Feb 2001 13:50:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16656 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130565AbRBASuB>; Thu, 1 Feb 2001 13:50:01 -0500
Subject: AF_UNIX hangs
To: linux-kernel@vger.kernel.org
Date: Thu, 1 Feb 2001 18:51:11 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OOp7-0004rR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at net/core/datagram.c:wait_for_packet the code will return 0
when the socket has been shutdown. That causes skb_recv_datagram to loop
which is in itself obviously incorrect for a shutdown socket (its in EOF
state)

I suspect it should read something like

	/* Socket shut down? */
	if (sk->shutdown & RCV_SHUTDOWN)
	{
   		current->state = TASK_RUNNING;
	  	remove_wait_queue(sk->sleep, &wait);
 		*err = 0;
 		return 1;
	}



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
