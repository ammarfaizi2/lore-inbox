Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVG1UYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVG1UYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVG1UW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:22:26 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:25234 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261721AbVG1UUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:20:39 -0400
Subject: [patch] selinux: Fix address length checks in connect hook
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 28 Jul 2005 16:18:45 -0400
Message-Id: <1122581925.6573.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the address length checks in the selinux_socket_connect
hook to be no more restrictive than the underlying ipv4 and ipv6 code;
otherwise, this hook can reject valid connect calls.  This patch is in
response to a bug report where an application was calling connect on an
INET6 socket with an address that didn't include the optional scope id
and failing due to these checks.  Please apply.  To 2.6.13, if possible.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

---

 security/selinux/hooks.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -rup linux-2.6.13-rc3-mm3/security/selinux/hooks.c linux-2.6.13-rc3-mm3-fix/security/selinux/hooks.c
--- linux-2.6.13-rc3-mm3/security/selinux/hooks.c	2005-07-28 14:59:58.000000000 -0400
+++ linux-2.6.13-rc3-mm3-fix/security/selinux/hooks.c	2005-07-28 14:56:58.000000000 -0400
@@ -3073,12 +3073,12 @@ static int selinux_socket_connect(struct
 
 		if (sk->sk_family == PF_INET) {
 			addr4 = (struct sockaddr_in *)address;
-			if (addrlen != sizeof(struct sockaddr_in))
+			if (addrlen < sizeof(struct sockaddr_in))
 				return -EINVAL;
 			snum = ntohs(addr4->sin_port);
 		} else {
 			addr6 = (struct sockaddr_in6 *)address;
-			if (addrlen != sizeof(struct sockaddr_in6))
+			if (addrlen < SIN6_LEN_RFC2133)
 				return -EINVAL;
 			snum = ntohs(addr6->sin6_port);
 		}
  
-- 
Stephen Smalley
National Security Agency

