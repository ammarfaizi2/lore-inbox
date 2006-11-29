Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935684AbWK2Xa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935684AbWK2Xa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934356AbWK2Xa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:30:26 -0500
Received: from mailgw2.fnal.gov ([131.225.111.12]:54421 "EHLO mailgw2.fnal.gov")
	by vger.kernel.org with ESMTP id S934638AbWK2XaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:30:25 -0500
Date: Wed, 29 Nov 2006 17:30:19 -0600
From: Wenji Wu <wenji@fnal.gov>
Subject: [patch 3/4] - Potential performance bottleneck for Linxu TCP
In-reply-to: <HNEBLGGMEGLPMPPDOPMGKEAKCGAA.wenji@fnal.gov>
To: netdev@vger.kernel.org, davem@davemloft.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Reply-to: wenji@fnal.gov
Message-id: <HNEBLGGMEGLPMPPDOPMGOEAKCGAA.wenji@fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: multipart/mixed; boundary="Boundary_(ID_4Xz5mGCjXxEEa50N90P26g)"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_4Xz5mGCjXxEEa50N90P26g)
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

Attached is the patch 3/4

best regards,

wenji

Wenji Wu
Network Researcher
Fermilab, MS-368
P.O. Box 500
Batavia, IL, 60510
(Email): wenji@fnal.gov
(O): 001-630-840-4541

--Boundary_(ID_4Xz5mGCjXxEEa50N90P26g)
Content-type: application/octet-stream; name=sched.c.patch
Content-transfer-encoding: QUOTED-PRINTABLE
Content-disposition: attachment; filename=sched.c.patch

--- linux-2.6.14-old/kernel/sched.c=092006-11-29 16:22:22.000000000 -=
0600=0A+++ linux-2.6.14/kernel/sched.c=092006-11-29 11:29:34.00000000=
0 -0600=0A@@ -2598,12 +2598,24 @@=0A =0A =09=09if (!rq->expired_times=
tamp)=0A =09=09=09rq->expired_timestamp =3D jiffies;=0A-=09=09if (!TA=
SK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {=0A-=09=09=09enqueue_task=
(p, rq->expired);=0A-=09=09=09if (p->static_prio < rq->best_expired_p=
rio)=0A+=09=09if(p->backlog_flag =3D=3D 0){=0A+=09=09=09if (!TASK_INT=
ERACTIVE(p) || EXPIRED_STARVING(rq)) {=0A+=09=09=09=09enqueue_task(p,=
 rq->expired);=0A+=09=09=09=09if (p->static_prio < rq->best_expired_p=
rio)=0A+=09=09=09=09=09rq->best_expired_prio =3D p->static_prio;=0A+=
=09=09=09} else=0A+=09=09=09=09enqueue_task(p, rq->active);=0A+=09=
=09} else {=0A+=09=09=09if(EXPIRED_STARVING(rq)) {=0A+=09=09=09=09enq=
ueue_task(p,rq->expired);=0A+=09=09=09=09if (p->static_prio < rq->bes=
t_expired_prio)=0A =09=09=09=09rq->best_expired_prio =3D p->static_pr=
io;=0A-=09=09} else=0A-=09=09=09enqueue_task(p, rq->active);=0A+=09=
=09=09} else {=0A+=09=09=09=09if(!TASK_INTERACTIVE(p))=0A+=09=09=09=
=09=09p->extrarun_flag =3D 1;=0A+=09=09=09=09enqueue_task(p,rq->activ=
e);=0A+=09=09=09}=09=0A+=09=09}=0A =09} else {=0A =09=09/*=0A =09=
=09 * Prevent a too long timeslice allowing a task to monopolize=0A=

--Boundary_(ID_4Xz5mGCjXxEEa50N90P26g)--
