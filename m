Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVAJSLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVAJSLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVAJSLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:11:20 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50358 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262415AbVAJSJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:09:49 -0500
Subject: [PATCH 6/6] 2.4.19-rc1 xprt_sendmsg() stack reduction patch
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-GfnEhcwC9atJtTrWiC4j"
Organization: 
Message-Id: <1105378932.4000.146.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jan 2005 09:42:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GfnEhcwC9atJtTrWiC4j
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-GfnEhcwC9atJtTrWiC4j
Content-Disposition: attachment; filename=xprt_sendmsg.patch
Content-Type: text/plain; name=xprt_sendmsg.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
--- linux-2.4.29-rc1.org/net/sunrpc/xprt.c	2004-11-17 03:54:22.000000000 -0800
+++ linux-2.4.29-rc1/net/sunrpc/xprt.c	2005-01-10 00:09:12.000000000 -0800
@@ -221,9 +221,9 @@ static inline int
 xprt_sendmsg(struct rpc_xprt *xprt, struct rpc_rqst *req)
 {
 	struct socket	*sock = xprt->sock;
-	struct msghdr	msg;
+	struct msghdr	*msg;
 	struct xdr_buf	*xdr = &req->rq_snd_buf;
-	struct iovec	niv[MAX_IOVEC];
+	struct iovec	*niv;
 	unsigned int	niov, slen, skip;
 	mm_segment_t	oldfs;
 	int		result;
@@ -231,6 +231,15 @@ xprt_sendmsg(struct rpc_xprt *xprt, stru
 	if (!sock)
 		return -ENOTCONN;
 
+	msg = kmalloc(sizeof(struct msghdr), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	niv = kmalloc(sizeof(struct iovec)*MAX_IOVEC, GFP_KERNEL);
+	if (!niv) {
+		kfree(msg);
+		return -ENOMEM;
+	}
+
 	xprt_pktdump("packet data:",
 				req->rq_svec->iov_base,
 				req->rq_svec->iov_len);
@@ -248,20 +257,20 @@ xprt_sendmsg(struct rpc_xprt *xprt, stru
 			break;
 		}
 
-		msg.msg_flags   = MSG_DONTWAIT|MSG_NOSIGNAL;
-		msg.msg_iov	= niv;
-		msg.msg_iovlen	= niov;
-		msg.msg_name	= (struct sockaddr *) &xprt->addr;
-		msg.msg_namelen = sizeof(xprt->addr);
-		msg.msg_control = NULL;
-		msg.msg_controllen = 0;
+		msg->msg_flags   = MSG_DONTWAIT|MSG_NOSIGNAL;
+		msg->msg_iov	= niv;
+		msg->msg_iovlen	= niov;
+		msg->msg_name	= (struct sockaddr *) &xprt->addr;
+		msg->msg_namelen = sizeof(xprt->addr);
+		msg->msg_control = NULL;
+		msg->msg_controllen = 0;
 
 		slen_part = 0;
 		for (n = 0; n < niov; n++)
 			slen_part += niv[n].iov_len;
 
 		clear_bit(SOCK_ASYNC_NOSPACE, &sock->flags);
-		result = sock_sendmsg(sock, &msg, slen_part);
+		result = sock_sendmsg(sock, msg, slen_part);
 
 		xdr_kunmap(xdr, skip, niov);
 
@@ -272,9 +281,9 @@ xprt_sendmsg(struct rpc_xprt *xprt, stru
 
 	dprintk("RPC:      xprt_sendmsg(%d) = %d\n", slen, result);
 
-	if (result >= 0)
-		return result;
-
+	if (result >= 0) 
+		goto out_free;
+	
 	switch (result) {
 	case -ECONNREFUSED:
 		/* When the server has died, an ICMP port unreachable message
@@ -292,6 +301,9 @@ xprt_sendmsg(struct rpc_xprt *xprt, stru
 	default:
 		printk(KERN_NOTICE "RPC: sendmsg returned error %d\n", -result);
 	}
+out_free:
+	kfree(niv);
+	kfree(msg);
 	return result;
 }
 

--=-GfnEhcwC9atJtTrWiC4j--

