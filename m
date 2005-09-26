Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVIZUDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVIZUDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVIZUDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:03:34 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:31654 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932486AbVIZUDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:03:33 -0400
Subject: [PATCH] sys_sendmsg() alignment bug fix
From: Alex Williamson <alex.williamson@hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain
Organization: LOSL
Date: Mon, 26 Sep 2005 14:02:01 -0600
Message-Id: <1127764921.6529.60.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   The patch below adds an alignment attribute to the buffer used in
sys_sendmsg().  This eliminates an unaligned access warning on ia64.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>

diff -r db9b9552a2b4 net/socket.c
--- a/net/socket.c	Sat Sep 24 23:56:08 2005
+++ b/net/socket.c	Mon Sep 26 13:44:09 2005
@@ -1700,7 +1700,9 @@
 	struct socket *sock;
 	char address[MAX_SOCK_ADDR];
 	struct iovec iovstack[UIO_FASTIOV], *iov = iovstack;
-	unsigned char ctl[sizeof(struct cmsghdr) + 20];	/* 20 is size of ipv6_pktinfo */
+	unsigned char ctl[sizeof(struct cmsghdr) + 20]
+	                  __attribute__ ((aligned (sizeof(__kernel_size_t))));
+	                  /* 20 is size of ipv6_pktinfo */
 	unsigned char *ctl_buf = ctl;
 	struct msghdr msg_sys;
 	int err, ctl_len, iov_size, total_len;


