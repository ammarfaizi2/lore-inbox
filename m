Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132922AbRECQSY>; Thu, 3 May 2001 12:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132958AbRECQSO>; Thu, 3 May 2001 12:18:14 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:26384 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S132922AbRECQSH>; Thu, 3 May 2001 12:18:07 -0400
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDD1@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "'Andrew Morton'" <andrewm@uow.edu.au>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'davem@redhat.com'" <davem@redhat.com>
Cc: "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'andrea@suse.de'" <andrea@suse.de>
Subject: [BUG] freeze Alpha ES40 SMP 2.4.4.ac3, another TCP/IP Problem ? (
	was 2.4.4 kernel crash , possibly tcp related )
Date: Thu, 3 May 2001 18:16:02 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I have a bug on an Alpha ES40 SMP 2.4.4.ac3 modified (TCP Bug from lkml)

Platform:

Linux Version:
-----------------------

My kernel is 2.4.4-ac3 with the tcp.c file modified as suggested by the
following patch.


>I see! Dave, please, take the second Andrea's patch (appended).
>It is really the cleanest one.

>Alexey


>--- 2.4.4aa3/net/ipv4/tcp.c.~1~	Tue May  1 10:44:57 2001
>+++ 2.4.4aa3/net/ipv4/tcp.c	Tue May  1 12:00:25 2001
>@@ -1183,11 +1183,8 @@
 
> do_fault:
> 	if (skb->len==0) {
>-		if (tp->send_head == skb) {
>-			tp->send_head = skb->next;
>-			if (tp->send_head == (struct
sk_buff*)&sk->write_queue)
>-				tp->send_head = NULL;
>-		}
>+		if (tp->send_head == skb)
>+			tp->send_head = NULL;
> 		__skb_unlink(skb, skb->list);
> 		tcp_free_skb(sk, skb);
> 	}
>
>-

This time, to show that it has nothing to do with the ftp server I used a
simple
rcp:

Experiment 1:
----------------------

 ES40-06					ES40-05

 rcp es40-05:/mnt/big/mid /tmp/toto		Machine fine

 with a mid file not too big (1.4Megabytes) everything is fine
 

Experiment 2:
----------------------

 ES40-06					ES40-05

 rcp es40-05:/mnt/big/1Giga /tmp/toto		Machine frozen

 the ES40-06 managed to retrieve only 11 Mbytes so I guess I can start again
with a 12 Megabytes file, It should trigger the bug.

Here is the log of the machine who crashed:
-----------------------------------------------------------------------

May  3 17:27:57 es40-05 PAM_unix[651]: (system-auth) session opened for user
root by (uid=0)
May  3 17:27:57 es40-05 in.rshd[651]: root@es40-06.idris.domain as root:
cmd='rcp -f /mnt/big/mid'
May  3 17:29:36 es40-05 PAM_unix[662]: (system-auth) session opened for user
root by (uid=0)
May  3 17:29:36 es40-05 in.rshd[662]: root@es40-06.idris.domain as root:
cmd='rcp -f /mnt/big/1Giga'
May  3 17:29:36 es40-05 kernel: <oomerang_rx(): status e001
May  3 17:29:36 es40-05 kernel: <<7>eth0: interrupt, status e401, latency 4
ticks.
May  3 17:29:36 es40-05 kernel: .
May  3 17:29:36 es40-05 kernel: <th0: interrupt, status e401, latency 3
ticks.
May  3 17:29:36 es40-05 kernel: <7
May  3 17:29:36 es40-05 kernel: <7t()
May  3 17:29:37 es40-05 kernel: <01, latency 4 ticks.
May  3 17:29:37 es40-05 kernel: <7
May  3 17:29:37 es40-05 kernel: <7
May  3 17:29:37 es40-05 kernel: th0: interrupt, status e401, latency 4
ticks.
May  3 17:29:37 es40-05 kernel: <7o send a packet, Tx index 5905.
May  3 17:29:37 es40-05 kernel: <7<7>eth0: exiting interrupt, status e000.
May  3 17:29:37 es40-05 kernel:  e201.
May  3 17:29:37 es40-05 kernel: <7<7>eth0: In interrupt loop, status e401.
May  3 17:29:37 es40-05 kernel: <7omerang_start_xmit()
May  3 17:29:37 es40-05 kernel: <7omerang_start_xmit()

The next line is:
--------------------------
May  3 17:36:17 es40-05 syslogd 1.3-3: restart.



What could I do to be sure where the problem is ?

I tested the machine under high cpu load, memory, swap, combination of the
three.
The only thing that does not work under load is the network.... TCP/IP ?

Andrew Morton is pretty sure this has nothing to do with his driver...

Any ideas of how I could find where the problem is ?

Thx for any help.
