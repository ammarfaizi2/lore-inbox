Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbTCQXPm>; Mon, 17 Mar 2003 18:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262008AbTCQXPm>; Mon, 17 Mar 2003 18:15:42 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:13544 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262005AbTCQXP1>; Mon, 17 Mar 2003 18:15:27 -0500
Date: Mon, 17 Mar 2003 20:25:25 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] race on rpc code
Message-ID: <20030317232525.GC23932@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

The following patch fixes a race on the rpc code, it is the
same race that was reported some weeks ago:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D104462124226133&w=3D2

After some minutes doing transfer of multiple files in parallel, it Oopses
at xprt_timer because task->tk_client is NULL. It can happens because
rpc_del_timer don't call timer_del_sync if the timer is running. But
if xprt_timer is running, it can can setup itself to run again, even if
the task is already being released by rpc_release_task.

--=20
Eduardo

diff -Nru a/net/sunrpc/sched.c b/net/sunrpc/sched.c
--- a/net/sunrpc/sched.c        Mon Mar 17 20:19:20 2003
+++ b/net/sunrpc/sched.c        Mon Mar 17 20:19:20 2003
@@ -169,10 +169,8 @@
 static inline void
 rpc_delete_timer(struct rpc_task *task)
 {
-       if (timer_pending(&task->tk_timer)) {
-               dprintk("RPC: %4d deleting timer\n", task->tk_pid);
-               del_timer_sync(&task->tk_timer);
-       }
+       dprintk("RPC: %4d deleting timer\n", task->tk_pid);
+       del_timer_sync(&task->tk_timer);
 }

 /*

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+dlllcaRJ66w1lWgRAnGfAJ9OBt24fL4Y6mv93q4NVpC9jyC4KgCgmSu2
4zKJbnWXGPY1QHEFlFPXU38=
=Cl2Y
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
