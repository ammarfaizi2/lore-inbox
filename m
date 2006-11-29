Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758986AbWK2X2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758986AbWK2X2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934356AbWK2X2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:28:01 -0500
Received: from mailgw2.fnal.gov ([131.225.111.12]:30868 "EHLO mailgw2.fnal.gov")
	by vger.kernel.org with ESMTP id S1758986AbWK2X17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:27:59 -0500
Date: Wed, 29 Nov 2006 17:27:54 -0600
From: Wenji Wu <wenji@fnal.gov>
Subject: [Changelog] - Potential performance bottleneck for Linxu TCP
In-reply-to: <HNEBLGGMEGLPMPPDOPMGKEAJCGAA.wenji@fnal.gov>
To: netdev@vger.kernel.org, davem@davemloft.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Reply-to: wenji@fnal.gov
Message-id: <HNEBLGGMEGLPMPPDOPMGCEAKCGAA.wenji@fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: multipart/mixed; boundary="Boundary_(ID_+M/VlR2McaLe7ZzZ0UnLww)"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_+M/VlR2McaLe7ZzZ0UnLww)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT


From: Wenji Wu <wenji@fnal.gov>

Greetings,

For Linux TCP, when the network applcaiton make system call to move data
from
socket's receive buffer to user space by calling tcp_recvmsg(). The socket
will
be locked. During the period, all the incoming packet for the TCP socket
will go
to the backlog queue without being TCP processed. Since Linux 2.6 can be
inerrupted mid-task, if the network application expires, and moved to the
expired array with the socket locked, all the packets within the backlog
queue
will not be TCP processed till the network applicaton resume its execution.
If
the system is heavily loaded, TCP can easily RTO in the Sender Side.

Attached is the Changelog for the patch

best regards,

wenji

Wenji Wu
Network Researcher
Fermilab, MS-368
P.O. Box 500
Batavia, IL, 60510
(Email): wenji@fnal.gov
(O): 001-630-840-4541

--Boundary_(ID_+M/VlR2McaLe7ZzZ0UnLww)
Content-type: text/plain; name=Changelog.txt
Content-transfer-encoding: QUOTED-PRINTABLE
Content-disposition: attachment; filename=Changelog.txt


=46rom: Wenji Wu <wenji@fnal.gov>

- Subject

Potential performance bottleneck for Linux TCP (2.6 Desktop, Low-late=
ncy Desktop)


- Why the kernel needed patching

For Linux TCP, when the network applcaiton make system call to move d=
ata from
socket's receive buffer to user space by calling tcp_recvmsg(). The s=
ocket will
be locked. During the period, all the incoming packet for the TCP soc=
ket will go
to the backlog queue without being TCP processed. Since Linux 2.6 can=
 be
inerrupted mid-task, if the network application expires, and moved to=
 the
expired array with the socket locked, all the packets within the back=
log queue
will not be TCP processed till the network applicaton resume its exec=
ution. If
the system is heavily loaded, TCP can easily RTO in the Sender Side.

- The overall design apparoch in the patch

the underlying idea here is that when there are packets waiting on th=
e prequeue=20
or backlog queue, do not allow the data receiving process to release =
the CPU for long.=20

- Implementation details

We have modified the Linux process scheduling policy and tcp_recvmsg(=
).

To summarize, the solution works as follows:=20

an expired data receiving process with packets waiting on backlog que=
ue or=20
prequeue is moved to the active array, instead of expired array as us=
ual.=20
More often than not, the expired data receiving process will continue=
 to run.=20
Even it doesn=92t, the wait time before it resumes its execution will=
 be greatly reduced.=20
However, this gives the process extra runs compared to other processe=
s in the runqueue.=20

For the sake of fairness, the process would be labeled with the extra=
_run_flag.=20

Also considering the facts that:=20

(1) the resumed process will continue its execution within tcp_recvms=
g();=20
(2) tcp_recvmsg() does not return to user space until the prequeue an=
d backlog queue are drained.=20

For the sake of fairness, we modified tcp_recvmsg() as such: after pr=
equeue and backlog=20
queue are drained and before tcp_recvmsg() returns to user space, any=
 process labeled with=20
the extra_run_flag will call yield() to explicitly yield the CPU to o=
ther proc-esses in the runqueue.=20
yield() works by removing the process from the active array (where it=
 current is, because it is running),=20
and inserting it into the expired array. Also, to prevent processes i=
n the expired array from starving,=20

A special rule has been provided for Linux process scheduling (the sa=
me rule used for interactive processes):=20
an expired process is moved to the expired array without respect to i=
ts status if processes in the expired array are starved.

Changed files:

/kernel/sched.c
/kernel/fork.c
/include/linux/sched.h
/net/ipv4/tcp.c

- Testing results

The proposed solution tradeoffs a small amount of fairness performanc=
e to resolve the TCP performance bottleneck.=20
The proposed solution won=92t cause serious fairness issue.

The patch is for Linux kernel 2.6.14 Deskop and Low-latency Desktop


--Boundary_(ID_+M/VlR2McaLe7ZzZ0UnLww)--
