Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbTAGMAm>; Tue, 7 Jan 2003 07:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTAGMAm>; Tue, 7 Jan 2003 07:00:42 -0500
Received: from peabody.ximian.com ([141.154.95.10]:17298 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S267047AbTAGMAk>; Tue, 7 Jan 2003 07:00:40 -0500
Subject: unix_getname buglet - > 2.5.4(?)
From: Michael Meeks <michael@ximian.com>
To: linux-kernel@vger.kernel.org
Cc: evolution <evolution-hackers@ximian.com>, orbit <orbit-list@gnome.org>
Content-Type: text/plain
Organization: Ximian.
Message-Id: <1041941192.25619.293.camel@michael.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Jan 2003 12:06:32 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

	Evolution is non-functioning on recent 2.5.X kernels, due to
mal-performance in getpeername => net/unix/af_unix.c (unix_getname),
where it seems we switch 'sk' on 'peer', but not the (previously)
typecast pointer to it; this fixes it.

--- af_unix.c.old       Tue Jan  7 11:59:09 2003
+++ af_unix.c   Tue Jan  7 12:00:45 2003
@@ -1097,7 +1097,7 @@
 static int unix_getname(struct socket *sock, struct sockaddr *uaddr,
int *uaddr_len, int peer)
 {
        struct sock *sk = sock->sk;
-       struct unix_sock *u = unix_sk(sk);
+       struct unix_sock *u;
        struct sockaddr_un *sunaddr=(struct sockaddr_un *)uaddr;
        int err = 0;
  
@@ -1112,6 +1112,7 @@
                sock_hold(sk);
        }
  
+       u = unix_sk(sk);
        unix_state_rlock(sk);
        if (!u->addr) {
                sunaddr->sun_family = AF_UNIX;

	Thanks Joaquim Fellmann (AFAIR) who chased this down to bitkeeper
changeset 1.262.2.2. Sadly I didn't have time to read the rest of that
changeset to see if the mistake pops up elsewhere as well. Please CC me
with replies, not on linux-kernel.

	HTH,

		Michael Meeks.

-- 
 mmeeks@gnu.org  <><, Pseudo Engineer, itinerant idiot

