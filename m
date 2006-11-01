Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946134AbWKAFfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946134AbWKAFfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946146AbWKAFfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:35:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1991 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946111AbWKAFex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:34:53 -0500
Message-Id: <20061101053435.175168000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:41 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       David S Miller <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/61] [DECNET]: Fix sfuzz hanging on 2.6.18
Content-Disposition: inline; filename=fix-sfuzz-hanging-on-2.6.18.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

Dave Jones wrote:
> sfuzz         D 724EF62A  2828 28717  28691                     (NOTLB)
>        cd69fe98 00000082 0000012d 724ef62a 0001971a 00000010 00000007 df6d22b0
>        dfd81080 725bbc5e 0001971a 000cc634 00000001 df6d23bc c140e260 00000202
>        de1d5ba0 cd69fea0 de1d5ba0 00000000 00000000 de1d5b60 de1d5b8c de1d5ba0
> Call Trace:
>  [<c05b1708>] lock_sock+0x75/0xa6
>  [<e0b0b604>] dn_getname+0x18/0x5f [decnet]
>  [<c05b083b>] sys_getsockname+0x5c/0xb0
>  [<c05b0b46>] sys_socketcall+0xef/0x261
>  [<c0403f97>] syscall_call+0x7/0xb
> DWARF2 unwinder stuck at syscall_call+0x7/0xb
>
> I wonder if the plethora of lockdep related changes inadvertantly broke something?

Looks like unbalanced locking.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/decnet/af_decnet.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.18.1.orig/net/decnet/af_decnet.c
+++ linux-2.6.18.1/net/decnet/af_decnet.c
@@ -1177,8 +1177,10 @@ static int dn_getname(struct socket *soc
 	if (peer) {
 		if ((sock->state != SS_CONNECTED && 
 		     sock->state != SS_CONNECTING) && 
-		    scp->accept_mode == ACC_IMMED)
+		    scp->accept_mode == ACC_IMMED) {
+		    	release_sock(sk);
 			return -ENOTCONN;
+		}
 
 		memcpy(sa, &scp->peer, sizeof(struct sockaddr_dn));
 	} else {

--
