Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293026AbSBVWlL>; Fri, 22 Feb 2002 17:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293029AbSBVWlC>; Fri, 22 Feb 2002 17:41:02 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:9710 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293026AbSBVWkt>;
	Fri, 22 Feb 2002 17:40:49 -0500
Subject: [PATCH] 2.4.18-rc2 Fix for get_pid hang
From: Paul Larson <plars@austin.ibm.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-nn1HZrXHkqME9rsPx2CH"
X-Mailer: Evolution/1.0.2 
Date: 22 Feb 2002 16:29:48 -0600
Message-Id: <1014416988.12007.461.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nn1HZrXHkqME9rsPx2CH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcelo,

This was made against 2.4.18-rc2 but applies cleanly against
2.4.18-rc4.  This is a fix for a problem where if we run out of
available pids, get_pid will hang the system while it searches through
the tasks for an available pid forever.

Thanks,
Paul Larson











--=-nn1HZrXHkqME9rsPx2CH
Content-Disposition: attachment; filename=getpid.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -Naur linux-2.4.18-rc2/kernel/fork.c linux-getpid/kernel/fork.c
--- linux-2.4.18-rc2/kernel/fork.c	Wed Feb 20 09:54:39 2002
+++ linux-getpid/kernel/fork.c	Fri Feb 22 15:52:52 2002
@@ -20,6 +20,7 @@
 #include <linux/vmalloc.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
+#include <linux/compiler.h>
=20
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -85,12 +86,13 @@
 {
 	static int next_safe =3D PID_MAX;
 	struct task_struct *p;
-	int pid;
+	int pid, beginpid;
=20
 	if (flags & CLONE_PID)
 		return current->pid;
=20
 	spin_lock(&lastpid_lock);
+	beginpid =3D last_pid;
 	if((++last_pid) & 0xffff8000) {
 		last_pid =3D 300;		/* Skip daemons etc. */
 		goto inside;
@@ -110,12 +112,16 @@
 						last_pid =3D 300;
 					next_safe =3D PID_MAX;
 				}
+				if(unlikely(last_pid =3D=3D beginpid))
+					goto nomorepids;
 				goto repeat;
 			}
 			if(p->pid > last_pid && next_safe > p->pid)
 				next_safe =3D p->pid;
 			if(p->pgrp > last_pid && next_safe > p->pgrp)
 				next_safe =3D p->pgrp;
+			if(p->tgid > last_pid && next_safe > p->tgid)
+				next_safe =3D p->tgid;
 			if(p->session > last_pid && next_safe > p->session)
 				next_safe =3D p->session;
 		}
@@ -125,6 +131,11 @@
 	spin_unlock(&lastpid_lock);
=20
 	return pid;
+
+nomorepids:
+	read_unlock(&tasklist_lock);
+	spin_unlock(&lastpid_lock);
+	return 0;
 }
=20
 static inline int dup_mmap(struct mm_struct * mm)
@@ -620,6 +631,8 @@
=20
 	copy_flags(clone_flags, p);
 	p->pid =3D get_pid(clone_flags);
+	if (p->pid =3D=3D 0 && current->pid !=3D 0)
+		goto bad_fork_cleanup;
=20
 	p->run_list.next =3D NULL;
 	p->run_list.prev =3D NULL;

--=-nn1HZrXHkqME9rsPx2CH--

