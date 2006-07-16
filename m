Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWGPErp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWGPErp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 00:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWGPErp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 00:47:45 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:53649 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S964890AbWGPErp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 00:47:45 -0400
Date: Sun, 16 Jul 2006 00:57:31 -0400
From: Catherine Zhang <cxzhang@watson.ibm.com>
To: linux-kernel@vger.kernel.org, michal.k.k.piotrowski@gmail.com,
       catalin.marinas@gmail.com
Cc: czhang.us@gmail.com, James Morris <jmorris@namei.org>,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: kernel memory leak fix for af_unix datagram getpeersec
Message-ID: <20060716045731.GA303@jiayuguan.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Catalin and Michal,

Enclosed please find the patch against 2.6.18-rc1 that fixed the kernel 
memory leak problem.

Thanks for your help!
Catherine

--

From: cxzhang@watson.ibm.com
Fix the memory leak problem of the original unix datagram getpeersec patch. 

---

 include/net/scm.h      |    4 +++-
 net/ipv4/ip_sockglue.c |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff -puN include/net/scm.h~af_unix-datagram-getpeersec-ml-fix include/net/scm.h
--- linux-2.6.18-rc1/include/net/scm.h~af_unix-datagram-getpeersec-ml-fix	2006-07-14 20:44:13.000000000 -0400
+++ linux-2.6.18-rc1-cxzhang/include/net/scm.h	2006-07-14 20:45:07.000000000 -0400
@@ -55,8 +55,10 @@ static __inline__ int scm_send(struct so
 #ifdef CONFIG_SECURITY_NETWORK
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 {
-	if (test_bit(SOCK_PASSSEC, &sock->flags) && scm->secdata != NULL)
+	if (test_bit(SOCK_PASSSEC, &sock->flags) && scm->secdata != NULL) {
 		put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, scm->seclen, scm->secdata);
+		kfree(scm->secdata);
+	}
 }
 #else
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
diff -puN net/ipv4/ip_sockglue.c~af_unix-datagram-getpeersec-ml-fix net/ipv4/ip_sockglue.c
--- linux-2.6.18-rc1/net/ipv4/ip_sockglue.c~af_unix-datagram-getpeersec-ml-fix	2006-07-15 19:03:07.000000000 -0400
+++ linux-2.6.18-rc1-cxzhang/net/ipv4/ip_sockglue.c	2006-07-15 19:03:27.000000000 -0400
@@ -120,6 +120,7 @@ static void ip_cmsg_recv_security(struct
 		return;
 
 	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
+	kfree(secdata);
 }
 
 
_
