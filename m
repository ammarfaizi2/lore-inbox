Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758991AbWK2X2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758991AbWK2X2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758993AbWK2X2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:28:51 -0500
Received: from mailgw1.fnal.gov ([131.225.111.11]:20414 "EHLO mailgw1.fnal.gov")
	by vger.kernel.org with ESMTP id S1758989AbWK2X2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:28:50 -0500
Date: Wed, 29 Nov 2006 17:28:45 -0600
From: Wenji Wu <wenji@fnal.gov>
Subject: [patch 1/4] - Potential performance bottleneck for Linxu TCP
In-reply-to: <HNEBLGGMEGLPMPPDOPMGCEAKCGAA.wenji@fnal.gov>
To: wenji@fnal.gov, netdev@vger.kernel.org, davem@davemloft.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Reply-to: wenji@fnal.gov
Message-id: <HNEBLGGMEGLPMPPDOPMGGEAKCGAA.wenji@fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: multipart/mixed; boundary="Boundary_(ID_gFjaBE753OBkV/vIbVJKdg)"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_gFjaBE753OBkV/vIbVJKdg)
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

Attached is the patch 1/4

best regards,

wenji

Wenji Wu
Network Researcher
Fermilab, MS-368
P.O. Box 500
Batavia, IL, 60510
(Email): wenji@fnal.gov
(O): 001-630-840-4541

--Boundary_(ID_gFjaBE753OBkV/vIbVJKdg)
Content-type: application/octet-stream; name=tcp.c.patch
Content-transfer-encoding: QUOTED-PRINTABLE
Content-disposition: attachment; filename=tcp.c.patch

--- linux-2.6.14-old/net/ipv4/tcp.c=092006-11-29 16:24:56.000000000 -=
0600=0A+++ linux-2.6.14/net/ipv4/tcp.c=092006-11-29 11:25:57.00000000=
0 -0600=0A@@ -1109,6 +1109,8 @@=0A =09int target;=09=09/* Read at lea=
st this many bytes */=0A =09long timeo;=0A =09struct task_struct *use=
r_recv =3D NULL;=0A+=09=0A+=09current->backlog_flag =3D 1;=0A =0A =
=09lock_sock(sk);=0A =0A@@ -1394,6 +1396,13 @@=0A =0A =09TCP_CHECK_TI=
MER(sk);=0A =09release_sock(sk);=0A+=0A+=09current->backlog_flag =
=3D 0;=0A+=09if(current->extrarun_flag =3D=3D 1){=0A+=09=09current->e=
xtrarun_flag =3D 0;=0A+=09=09yield();=0A+=09}=0A+=0A =09return copied=
;=0A =0A out:=0A=

--Boundary_(ID_gFjaBE753OBkV/vIbVJKdg)--
