Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316233AbSEKQko>; Sat, 11 May 2002 12:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316234AbSEKQkn>; Sat, 11 May 2002 12:40:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62198 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316233AbSEKQkn>; Sat, 11 May 2002 12:40:43 -0400
Subject: [PATCH] 2.4-ac: migration_thread locking fix
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-XsQR5K08oc8aFbvOy3e9"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 11 May 2002 09:40:34 -0700
Message-Id: <1021135234.884.1526.camel@summit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XsQR5K08oc8aFbvOy3e9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Anton Blanchard reported a lock vs. interrupt-off ordering bug in
migration_thread.  The bug is already fixed in 2.5.  A patch is attached
to fix O(1) in your tree.

See the comments above double_rq_lock and double_rq_unlock (which,
sadly, I wrote)!  Without this patch there is a possibility to hang,
which Anton observed.

Patch is against 2.4.19-pre8-ac1, please apply.

	Robert Love


--=-XsQR5K08oc8aFbvOy3e9
Content-Disposition: attachment; filename=sched-irq-fix-rml-2.4.19-pre8-ac1-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-irq-fix-rml-2.4.19-pre8-ac1-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-ac1/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre8-ac1/kernel/sched.c	Wed May  8 12:03:14 2002
+++ linux/kernel/sched.c	Sat May 11 09:29:55 2002
@@ -1640,8 +1640,8 @@
 		local_irq_save(flags);
 		double_rq_lock(rq_src, rq_dest);
 		if (p->cpu !=3D cpu_src) {
-			local_irq_restore(flags);
 			double_rq_unlock(rq_src, rq_dest);
+			local_irq_restore(flags);
 			goto repeat;
 		}
 		if (rq_src =3D=3D rq) {
@@ -1651,8 +1651,8 @@
 				activate_task(p, rq_dest);
 			}
 		}
-		local_irq_restore(flags);
 		double_rq_unlock(rq_src, rq_dest);
+		local_irq_restore(flags);
=20
 		up(&req->sem);
 	}

--=-XsQR5K08oc8aFbvOy3e9--

