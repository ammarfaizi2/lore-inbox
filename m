Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTEGA72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbTEGA72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:59:28 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:33041 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262274AbTEGA70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:59:26 -0400
Date: Tue, 6 May 2003 22:12:29 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Sridhar Samudrala <sri@us.ibm.com>, Roger Luethi <rl@hellgate.ch>,
       netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/socket: fix bug in sys_accept
Message-ID: <20030507011229.GD27162@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Sridhar Samudrala <sri@us.ibm.com>, Roger Luethi <rl@hellgate.ch>,
	netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Please pull from:

bk://kernel.bkbits.net/acme/unix-2.5

	Sridhar, thanks, this indeed fixed the problems that Roger was
having, I tested this in vmware using unix sockets as modules and running
a full gnome2 installation + gkrellm.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1081, 2003-05-06 21:50:40-03:00, sri@us.ibm.com
  o net/socket: fix bug in sys_accept
  
  module_put() gets called twice on error. Once via the explicit module_put and
  the second via sock_release(). Also i think we should do a __module_get() with
  newsock's owner(although same as the original listening sock).


 socket.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)


diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Tue May  6 21:57:15 2003
+++ b/net/socket.c	Tue May  6 21:57:15 2003
@@ -1280,26 +1280,26 @@
 	 * We don't need try_module_get here, as the listening socket (sock)
 	 * has the protocol module (sock->ops->owner) held.
 	 */
-	__module_get(sock->ops->owner);
+	__module_get(newsock->ops->owner);
 
 	err = sock->ops->accept(sock, newsock, sock->file->f_flags);
 	if (err < 0)
-		goto out_module_put;
+		goto out_release;
 
 	if (upeer_sockaddr) {
 		if(newsock->ops->getname(newsock, (struct sockaddr *)address, &len, 2)<0) {
 			err = -ECONNABORTED;
-			goto out_module_put;
+			goto out_release;
 		}
 		err = move_addr_to_user(address, len, upeer_sockaddr, upeer_addrlen);
 		if (err < 0)
-			goto out_module_put;
+			goto out_release;
 	}
 
 	/* File flags are not inherited via accept() unlike another OSes. */
 
 	if ((err = sock_map_fd(newsock)) < 0)
-		goto out_module_put;
+		goto out_release;
 
 	security_socket_post_accept(sock, newsock);
 
@@ -1307,8 +1307,6 @@
 	sockfd_put(sock);
 out:
 	return err;
-out_module_put:
-	module_put(sock->ops->owner);
 out_release:
 	sock_release(newsock);
 	goto out_put;

===================================================================


This BitKeeper patch contains the following changesets:
1.1081
## Wrapped with gzip_uu ##


M'XL( .M9N#X  ^V576^;,!2&K_&O.%(OUF@*L0%#PI0J_9BZJ9-:=>IUY!@G
M6 4[LDW22OSX.21KVG51U6F[&QB.,.\Y?G7\(([@S@J3!]9(= 1?M'5YT-A0
MSNJ0Z]I/W6KMIP:EKL7@[&K0*/G0CT**_*L;YG@)*V%L'I P?IIQCTN1![>?
M+^^^G=XB-![#><G40GP7#L9CY+19L:JP$^;*2JO0&:9L+1S;K-@^2=L(X\B?
ME&0QIFE+4IQD+2<%(2PAHL!1,DP39'3%5#&9&SU[G>\3<1KAF,:TC>,LP>@"
M2$CPD ".!Y@.< H1R2G.$]S'<8XQ^$9,]@V CP3Z&)W!WS5]CCAH4,(-K.;W
MPN4PEP\P:Q8@%=A'.V6<BZ7S*C]J7325F"X;=]R#A7 6.*LJ48!;2RY *Q#&
M:!/"M?*/*\G E0+$P[*27+IGZ> ;Y>MMWEK!M2HZ\<;!U(A*,"N.>R&<5E:#
M]"JI[F'MI:5NJ@(*#0RFTUTU;\.;64M7^H)*K#=%/EC0:R7,,:N<SUF48%DM
M@-EN16WD0BI6026M$TJJ1;=R+T17$/M>1>AFCPGJO_- "#.,3M[8IGW#0_Y\
MIT8T:],DRVC+\3R+4C:G-)O/HA'_!8=7%3: 91@G*<9M@M/1L,/]N>IMXM_O
M"C%>BXG?0<&=7'55PIGYK3E_44I(FZ0D(1W]-'O!?I)ZZ@^P3Z&?_6?_W[*_
MI>8:^F;=#<_RS0N _N!;N"#1, :"ONYB\,+[SG+_1"^MOVUL]SYU.=DN9Q.#
M8*&=!MVXGPWJ-*-HJ^EB<$B4[D3I85&,MY6V\8"&8(CV?QI>"GYOFWJ,&<GF
,5,S1#S\WRP^^!@  
 
