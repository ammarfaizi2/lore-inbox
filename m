Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbTFLT5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbTFLT5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:57:36 -0400
Received: from lioth.frs.linpro.no ([64.28.20.130]:58577 "EHLO
	lioth.frs.linpro.no") by vger.kernel.org with ESMTP id S264975AbTFLT5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:57:31 -0400
To: linux-kernel@vger.kernel.org
Subject: Logical bug in ipv4 (and ipv6?) PMTU handling?
From: hnh@linpro.no (Harald  =?ISO-8859-1?Q?=20Nordg=E5rd-Hansen?=)
Date: Thu, 12 Jun 2003 22:11:15 +0200
Message-ID: <xon1xxzys2k.fsf@ruth.frs.linpro.no>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I was helping a collegue here trying to get some udp packets through a
link, and stumbled upon what seems to be a bug in the ipv4 code of
current kernels (checked 2.4.20, 2.4.21-pre8 and 2.5.70).

According to 'man 7 ip', the IP_PMTU_DISCOVER flag i controlled by the
ip_no_pmtu_disc sysctl for SOCK_STREAM, and off for all other socket
types.  But in net/ipv4/af_inet.c, the flag is set based on
ip_no_pmtu_disc, regardless of socket type.

This causes all udp packets to be send out with the ip don't fragment
flag set, and unless the application happens to handle the resulting
error messages generated, the packets will not get through on
lower-mtu path segments.  A quick dump of some udp packets confirms
that the don't fragment flag is set on all the packets.

The attached one-liner will limit setting IP_PMTU_DISCOVER on sockets
to only those of the SOCK_STREAM type, which is what the documentation
says should happen (as would be logical, as other sockets need the
application to explicitly handle the size adjustments).  It should
apply cleanly to 2.4.20 and 2.4.21-pre8, and shouldn't be hard to
adapt to 2.5.x.

I don't know enough about ipv6 to understand if this behaviour should
be the same there, but net/ipv6/af_inet6.c contains mostly the same
logic, and should probably be fixed as well.

-Harald
-- 
Harald Nordgård-Hansen, Linpro AS <>< http://harald.nordgard-hansen.net/
Pancoveien 7, NO-1624 Gressvik, Norway  ><>  Phone/Fax: +47 6935 2424/25

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=af_inet.c.patch
Content-Description: IP_PMTU_DISCOVER fix for af_inet.c

--- net/ipv4/af_inet.c.orig	2003-06-12 21:18:05.000000000 +0200
+++ net/ipv4/af_inet.c	2003-06-12 21:18:41.000000000 +0200
@@ -369,7 +369,7 @@
 			sk->protinfo.af_inet.hdrincl = 1;
 	}
 
-	if (ipv4_config.no_pmtu_disc)
+	if (SOCK_STREAM != sock->type || ipv4_config.no_pmtu_disc)
 		sk->protinfo.af_inet.pmtudisc = IP_PMTUDISC_DONT;
 	else
 		sk->protinfo.af_inet.pmtudisc = IP_PMTUDISC_WANT;

--=-=-=--
