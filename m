Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWICNln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWICNln (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 09:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWICNln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 09:41:43 -0400
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:29111 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751079AbWICNln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 09:41:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=QQc9XOtQ4RldeQruktU9d1yM0gN4hS4aegdtBoWUeC48YLX1dSY4Q+A+t1cg6kskDZHEVh7s6H7NjHdk2W1ociaQfyjJ8szuzaNV4QV0AB/G0XX1idmVe7UMaQq1oJJwBH47AOR14aZB+kiFT9E6S4HZqV2Qsn1o+XTD6uxAohY=  ;
From: Vincent Pelletier <subdino2004@yahoo.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sched.c: Be a bit more conservative in SMP
Date: Sun, 3 Sep 2006 15:41:31 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5707670.b11W0OXBSE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609031541.39984.subdino2004@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5707670.b11W0OXBSE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've often seen the following use case happening on the few linux SMP boxes
I have access to : one process eats one cpu becaus eit has a big
computation to do, all cpu being idle, and the process keeps on hopping
from one cpu to another.
This patch is a quick try to make this behaviour disapear without requiring
to bind all processes manually with taskset.
I don't know if there is any practical performance increase (although I
believe there locally is).

Patch principle is simple :
When calculating the load of "source" cpu (the one the process is on)
substract one to the number of runing processes so we don't count the
process to be balanced.
As I only know sched.c for 5 minutes, I added a max(..., 0) to make sure the
load can't be negative if the function happens to be called on a cpu with
only idle tasks. No idea if it can actually happen.

I tested its efficiency this way :
Before :
=2Dstart a command eating one full cpu on an idle smp machine.
I used dd if=3D/dev/urandom of=3D/dev/null.
=2Dwait for ~30 seconds, and see that it switched to another cpu.
After :
=2Drepeat the same test and see that it does not switch to another cpu (the
patch does what it's meant to).
=2Dstart a second dd, and bind both to the same cpu with taskset, then free
one of them (allow it to use 2 cpus, including the one it can already
access) and see that the task gets moved to the second cpu (load balancing
still works).

Disclaimer :=20
This patch is just the result of a 5 minutes hacking rush. Although I think
it technically work, I'm no SMP expert.

=2D-- linux-2.6-2.6.17/kernel/sched.c     2006-06-18 03:49:35.000000000 +02=
00
+++ linux-2.6-2.6.17-conservative/kernel/sched.c        2006-09-03
13:18:11.000000000 +0200
@@ -952,7 +952,7 @@ void kick_process(task_t *p)
 static inline unsigned long source_load(int cpu, int type)
 {
        runqueue_t *rq =3D cpu_rq(cpu);
=2D       unsigned long load_now =3D rq->nr_running * SCHED_LOAD_SCALE;
+       unsigned long load_now =3D (max(rq->nr_running - 1, 0)) *
SCHED_LOAD_SCALE;
        if (type =3D=3D 0)
                return load_now;

=2D-=20
Vincent Pelletier

--nextPart5707670.b11W0OXBSE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE+tuTFEQoKRQyjtURAtJaAJ4/Ka53Zc8JOtzSDLxCn2kD/BSqPQCeIWr5
m/OZ9TpNdk0E4lbhR8nxqXI=
=rq+g
-----END PGP SIGNATURE-----

--nextPart5707670.b11W0OXBSE--

	
 p2.vert.ukl.yahoo.com uncompressed Sun Sep  3 13:27:00 GMT 2006 
	
		
___________________________________________________________________________ 
Dicouvrez un nouveau moyen de poser toutes vos questions quelque soit le sujet ! 
Yahoo! Questions/Riponses pour partager vos connaissances, vos opinions et vos expiriences. 
http://fr.answers.yahoo.com 


-- 
VGER BF report: U 0.851625
