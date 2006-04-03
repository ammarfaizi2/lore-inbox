Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWDCEbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDCEbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 00:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWDCEbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 00:31:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40857 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751333AbWDCEbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 00:31:36 -0400
Date: Sun, 2 Apr 2006 23:31:34 -0500
From: Dave Jones <davej@redhat.com>
To: netdev@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IPSEC]: Kill unused decap state argument
Message-ID: <20060403043134.GA7173@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, netdev@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200604022014.k32KE6LH011600@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604022014.k32KE6LH011600@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 08:14:06PM +0000, Linux Kernel wrote:
 > commit e695633e21ffb6a443a8c2f8b3f095c7f1a48eb0
 > tree 52a679683a11eb42ec5888309a82ec5811a21e03
 > parent 15901dc93fa4253bfb3661644ecad67c2e83213c
 > author Herbert Xu <herbert@gondor.apana.org.au> Sat, 01 Apr 2006 16:52:46 -0800
 > committer David S. Miller <davem@davemloft.net> Sat, 01 Apr 2006 16:52:46 -0800
 > 
 > [IPSEC]: Kill unused decap state argument
 > 
 > This patch removes the decap_state argument from the xfrm input hook.
 > Previously this function allowed the input hook to share state with
 > the post_input hook.  The latter has since been removed.
 > 
 > The only purpose for it now is to check the encap type.  However, it
 > is easier and better to move the encap type check to the generic
 > xfrm_rcv function.  This allows us to get rid of the decap state
 > argument altogether.
 > 
 > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
 > Signed-off-by: David S. Miller <davem@davemloft.net>

This breaks SELinux compilation.
security/selinux/xfrm.c: In function 'selinux_socket_getpeer_dgram':
security/selinux/xfrm.c:284: error: 'struct sec_path' has no member named 'x'
security/selinux/xfrm.c: In function 'selinux_xfrm_sock_rcv_skb':
security/selinux/xfrm.c:317: error: 'struct sec_path' has no member named 'x'

Does this look sane ?

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/security/selinux/xfrm.c~	2006-04-02 23:27:07.000000000 -0500
+++ linux-2.6.16.noarch/security/selinux/xfrm.c	2006-04-02 23:27:40.000000000 -0500
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

-- 
http://www.codemonkey.org.uk
