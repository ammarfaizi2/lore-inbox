Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWDCPQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWDCPQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWDCPQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:16:28 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:61964 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751669AbWDCPQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:16:27 -0400
Message-ID: <44313C43.7070701@gmail.com>
Date: Mon, 03 Apr 2006 17:15:56 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sds@tycho.nsa.gov, jmorris@namei.org, selinux@tycho.nsa.gov
Subject: Re: 2.6.17-rc1 compile failure
References: <200604030521.k335LRu4018913@laptop11.inf.utfsm.cl>
In-Reply-To: <200604030521.k335LRu4018913@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------040607050101050902060705"
X-SpamReason: {}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040607050101050902060705
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand napsal(a):
> It ends with:
> 
>   CC      security/selinux/xfrm.o
>   security/selinux/xfrm.c: In function â??selinux_socket_getpeer_dgramâ??:
>   security/selinux/xfrm.c:284: error: â??struct sec_pathâ?? has no member named â??xâ??
>   security/selinux/xfrm.c: In function â??selinux_xfrm_sock_rcv_skbâ??:
>   security/selinux/xfrm.c:317: error: â??struct sec_pathâ?? has no member named â??xâ??
>   make[2]: *** [security/selinux/xfrm.o] Error 1
Could you test attached patch?

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEMTxDMsxVwznUen4RAgLCAJ9WEAU018cecP1emeMZKfCTrttVeQCgric6
g9Cq+yh5IvmVJGHqlVsIEXs=
=9MLb
-----END PGP SIGNATURE-----

--------------040607050101050902060705
Content-Type: text/plain;
 name="selinux-xfrm.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-xfrm.txt"

SELinux-xfrm-compilation-fix

sec_path struct no longer contains sec_decap_state struct, but only
xfrm_state.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 87b9e5f728ab1f5f805f1db9d96d569b1218b611
tree 60d080432a06f8bdddb8665a89dd825a33b2b01f
parent 9e4a4f43bab1268fc459295a673d00470d5e150d
author Jiri Slaby <ku@bellona.localdomain> Mon, 03 Apr 2006 17:11:07 +0159
committer Jiri Slaby <ku@bellona.localdomain> Mon, 03 Apr 2006 17:11:07 +0159

 security/selinux/xfrm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index dfab6c8..abe99d8 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -281,7 +281,7 @@ u32 selinux_socket_getpeer_dgram(struct 
 		int i;
 
 		for (i = sp->len-1; i >= 0; i--) {
-			struct xfrm_state *x = sp->x[i].xvec;
+			struct xfrm_state *x = sp->xvec[i];
 			if (selinux_authorizable_xfrm(x)) {
 				struct xfrm_sec_ctx *ctx = x->security;
 				return ctx->ctx_sid;
@@ -314,7 +314,7 @@ int selinux_xfrm_sock_rcv_skb(u32 isec_s
 		 *  Only need to verify the existence of an authorizable sp.
 		 */
 		for (i = 0; i < sp->len; i++) {
-			struct xfrm_state *x = sp->x[i].xvec;
+			struct xfrm_state *x = sp->xvec[i];
 
 			if (x && selinux_authorizable_xfrm(x))
 				goto accept;

--------------040607050101050902060705--
