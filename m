Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbUKPWy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUKPWy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbUKPWxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:53:11 -0500
Received: from linares.terra.com.br ([200.154.55.228]:41104 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S261873AbUKPWu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:50:59 -0500
X-Terra-Karma: -2%
X-Terra-Hash: e1e75f07be1bf76aad025950a1a9f3c8
Date: Tue, 16 Nov 2004 18:55:17 -0200
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davem@davemloft.net
Subject: [PATCH 1/2] - net/socket.c::sys_bind() cleanup.
Message-Id: <20041116185517.3314ac35.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

 net/socket.c::sys_bind() is a bit complex function, the patch
bellow makes it more clear.

 Note that the code does the same thing, it only makes difference
for the programmer.

 Agains't 2.6.10-rc2.


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 net/socket.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/net/socket.c a~/net/socket.c
--- a/net/socket.c	2004-10-31 18:44:25.000000000 -0200
+++ a~/net/socket.c	2004-10-31 18:52:01.000000000 -0200
@@ -1286,18 +1286,23 @@ asmlinkage long sys_bind(int fd, struct 
 	char address[MAX_SOCK_ADDR];
 	int err;
 
-	if((sock = sockfd_lookup(fd,&err))!=NULL)
-	{
-		if((err=move_addr_to_kernel(umyaddr,addrlen,address))>=0) {
-			err = security_socket_bind(sock, (struct sockaddr *)address, addrlen);
-			if (err) {
-				sockfd_put(sock);
-				return err;
-			}
-			err = sock->ops->bind(sock, (struct sockaddr *)address, addrlen);
-		}
-		sockfd_put(sock);
-	}			
+	sock = sockfd_lookup(fd, &err);
+	if (!sock)
+		goto out;
+
+	err = move_addr_to_kernel(umyaddr, addrlen, address);
+	if (err)
+		goto out_put;
+
+	err = security_socket_bind(sock, (struct sockaddr *)address, addrlen);
+	if (err)
+		goto out_put;
+
+	err = sock->ops->bind(sock, (struct sockaddr *)address, addrlen);
+
+ out_put:
+	sockfd_put(sock);
+ out:
 	return err;
 }
 
