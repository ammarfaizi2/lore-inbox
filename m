Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269564AbUJGNiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269564AbUJGNiC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269508AbUJGNiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:38:02 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43181 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269356AbUJGNho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:37:44 -0400
Message-Id: <200410070542.i975gkHV031259@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org, SELinux@tycho.nsa.gov,
       Ingo Molnar <mingo@redhat.com>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org
Subject: 2.6.9-rc2-mm4-VP-S7 - ksoftirq and selinux oddity
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1477279884P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 01:42:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1477279884P
Content-Type: text/plain; charset=us-ascii

(linux-net and netdev please cc: on replies - am only on lkml and selinux lists)

Found this in the kernel msgs during system startup.

Behavior has been there at least since rc2-mm3-VP-S6.  Am running with
SELinx enabled in permissive mode.  I haven't built a rc3-mm2 kernel that I can
test on - rc3-mm2-VP-T1 dies for me with the already-known USB issues, and I haven't
backed that patch out yet (maybe will try that later tonight).

audit(1097111349.727:0): avc:  denied  { tcp_recv } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:netif_lo_t tclass=netif
audit(1097111349.754:0): avc:  denied  { tcp_recv } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:node_lo_t tclass=node
audit(1097111349.782:0): avc:  denied  { recv_msg } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket

At least for the recv_msg error, I *think* the message is generated because
when we get into net/socket.c, we call security_socket_recvmsg() in
__recv_msg() - and (possibly only when we have the VP patch applied?) at that
point we're in a softirqd context rather than the context of the process that
will finally receive the packet, so the SELinux code ends up checking the wrong
credentials.  I've not waded through the code enough to figure out exactly
where the two tcp_recv messages are generated, but I suspect the root cause is
the same for all three messages.

The messages are happening when smartd is generating an e-mail alert (the
source of the fsdaemon_t).  I'm not sure yet whether it's because sendmail
hasn't started yet, and we're seeing ksoftirqd trying to drive the TCP stack
sending an RST back to the SYN, or if there's something else strange going on.


--==_Exmh_1477279884P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZNdWcC3lWbTT17ARAsn/AJ0Waq3x671FYyFgLjQIt6Rqq3wh+ACeMNHE
tKOke6la/wQKZu+x3dFwViI=
=Egwh
-----END PGP SIGNATURE-----

--==_Exmh_1477279884P--
