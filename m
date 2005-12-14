Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVLNJMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVLNJMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVLNJMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:12:38 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:20879 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932231AbVLNJMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:12:37 -0500
Date: Wed, 14 Dec 2005 01:12:35 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@w-sridhar.beaverton.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 1/3] TCP/IP Critical socket communication mechanism
Message-ID: <Pine.LNX.4.58.0512140045370.31720@w-sridhar.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new socket option SO_CRITICAL to mark a socket as critical.
This socket option takes a integer boolean flag that can be set using
setsockopt() and read with getsockopt().
-----------------------------------------------------------------------

 include/asm-i386/socket.h    |    2 ++
 include/asm-powerpc/socket.h |    2 ++
 net/core/sock.c              |   13 ++++++++++++-
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/include/asm-i386/socket.h b/include/asm-i386/socket.h
index 802ae76..bd4ce8e 100644
--- a/include/asm-i386/socket.h
+++ b/include/asm-i386/socket.h
@@ -49,4 +49,6 @@

 #define SO_PEERSEC		31

+#define SO_CRITICAL		100
+
 #endif /* _ASM_SOCKET_H */
diff --git a/include/asm-powerpc/socket.h b/include/asm-powerpc/socket.h
index e4b8177..6cfb79a 100644
--- a/include/asm-powerpc/socket.h
+++ b/include/asm-powerpc/socket.h
@@ -56,4 +56,6 @@

 #define SO_PEERSEC		31

+#define SO_CRITICAL		100
+
 #endif	/* _ASM_POWERPC_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index 13cc3be..d2d10cb 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -456,6 +456,13 @@ set_rcvbuf:
 			ret = -ENONET;
 			break;

+		case SO_CRITICAL:
+			if (valbool)
+				sk->sk_allocation |= __GFP_CRITICAL;
+			else
+				sk->sk_allocation &= ~__GFP_CRITICAL;
+			break;
+
 		/* We implement the SO_SNDLOWAT etc to
 		   not be settable (1003.1g 5.3) */
 		default:
@@ -616,7 +623,11 @@ int sock_getsockopt(struct socket *sock,

 		case SO_PEERSEC:
 			return security_socket_getpeersec(sock, optval, optlen, len);
-
+
+		case SO_CRITICAL:
+			v.val = ((sk->sk_allocation & __GFP_CRITICAL) != 0);
+			break;
+
 		default:
 			return(-ENOPROTOOPT);
 	}

