Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293029AbSBVWoB>; Fri, 22 Feb 2002 17:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293032AbSBVWnw>; Fri, 22 Feb 2002 17:43:52 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:26800 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293029AbSBVWnj>;
	Fri, 22 Feb 2002 17:43:39 -0500
Subject: [PATCH] 2.5.5 Fix for get_pid hang
From: Paul Larson <plars@austin.ibm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-NdBfNCEm4tq+wTB/cjXE"
X-Mailer: Evolution/1.0.2 
Date: 22 Feb 2002 16:32:32 -0600
Message-Id: <1014417153.12007.466.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NdBfNCEm4tq+wTB/cjXE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


This is a fix for a problem where if we run out of available pids,
get_pid will hang the system while it searches through the tasks for an
available pid forever.

Thanks,
Paul Larson



--=-NdBfNCEm4tq+wTB/cjXE
Content-Disposition: attachment; filename=getpid25.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -Naur linux-2.5.5/kernel/fork.c linux-2.5.5-getpid/kernel/fork.c
--- linux-2.5.5/kernel/fork.c	Tue Feb 19 20:10:55 2002
+++ linux-2.5.5-getpid/kernel/fork.c	Fri Feb 22 17:29:38 2002
@@ -24,6 +24,7 @@
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/fs.h>
+#include <linux/compiler.h>
=20
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -129,12 +130,13 @@
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
@@ -154,12 +156,16 @@
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
@@ -169,6 +175,11 @@
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
@@ -667,6 +678,8 @@
=20
 	copy_flags(clone_flags, p);
 	p->pid =3D get_pid(clone_flags);
+	if (p->pid =3D=3D 0 && current->pid !=3D 0)
+		goto bad_fork_cleanup;
=20
 	INIT_LIST_HEAD(&p->run_list);
=20

--=-NdBfNCEm4tq+wTB/cjXE--

