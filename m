Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967352AbWK2XbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967352AbWK2XbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934356AbWK2XbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:31:13 -0500
Received: from mailgw1.fnal.gov ([131.225.111.11]:3007 "EHLO mailgw1.fnal.gov")
	by vger.kernel.org with ESMTP id S935044AbWK2XbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:31:10 -0500
Date: Wed, 29 Nov 2006 17:31:05 -0600
From: Wenji Wu <wenji@fnal.gov>
Subject: [patch 4/4] - Potential performance bottleneck for Linxu TCP
In-reply-to: <HNEBLGGMEGLPMPPDOPMGOEAKCGAA.wenji@fnal.gov>
To: netdev@vger.kernel.org, davem@davemloft.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Reply-to: wenji@fnal.gov
Message-id: <HNEBLGGMEGLPMPPDOPMGCEALCGAA.wenji@fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: multipart/mixed; boundary="Boundary_(ID_li4hDdoClOdbXctA3VlaaA)"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_li4hDdoClOdbXctA3VlaaA)
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

--Boundary_(ID_li4hDdoClOdbXctA3VlaaA)
Content-type: application/octet-stream; name=fork.c.patch
Content-transfer-encoding: QUOTED-PRINTABLE
Content-disposition: attachment; filename=fork.c.patch

--- linux-2.6.14-old/kernel/fork.c=092006-11-29 16:22:25.000000000 -0=
600=0A+++ linux-2.6.14/kernel/fork.c=092006-11-29 11:23:20.000000000 =
-0600=0A@@ -868,7 +868,7 @@=0A  *=0A  * It copies the registers, and =
all the appropriate=0A  * parts of the process environment (as per th=
e clone=0A- * flags). The actual kick-off is left to the caller.=0A+ =
* flags). The actual kick-off is left to the caller.copy_process=0A  =
*/=0A static task_t *copy_process(unsigned long clone_flags,=0A =09=
=09=09=09 unsigned long stack_start,=0A@@ -1154,6 +1154,9 @@=0A =09wr=
ite_unlock_irq(&tasklist_lock);=0A =09retval =3D 0;=0A =0A+=09p->back=
log_flag =3D 0;=0A+=09p->extrarun_flag =3D 0;=0A+=0A fork_out:=0A =
=09if (retval)=0A =09=09return ERR_PTR(retval);=0A=

--Boundary_(ID_li4hDdoClOdbXctA3VlaaA)--
