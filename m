Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUIVXeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUIVXeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIVXeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:34:13 -0400
Received: from reptilian.maxnet.nu ([212.209.142.131]:62215 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S268085AbUIVXd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:33:58 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] oom_pardon, aka don't kill my xlock
Date: Thu, 23 Sep 2004 01:23:08 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Message-Id: <200409230123.30858.thomas@habets.pp.se>
Content-Type: multipart/signed;
  boundary="nextPart12749564.y3HuISeQds";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12749564.y3HuISeQds
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Hello.

How about a sysctl that does "for the love of kbaek, don't ever kill these=
=20
processes when OOM. If nothing else can be killed, I'd rather you panic"?

Examples for this list would be /usr/bin/vlock and /usr/X11R6/bin/xlock.=20
I just got a very uncomfortable surprise when found my box unlocked thanks =
to=20
this.

After playing around a bit, I made the patch below, but it's almost complet=
ely=20
untested. I'm not even sure I take the binaries name from the right place.=
=20
And I don't know if the locking can race. If it's too ugly then it'd be gre=
at=20
if someone implemented it the right way. (iow: huge fucking disclaimer)

echo "/usr/bin/vlock /usr/X11R6/bin/xlock" > /proc/sys/vm/oom_pardon

=2D--------
typedef struct me_s {
  char name[]      =3D { "Thomas Habets" };
  char email[]     =3D { "thomas@habets.pp.se" };
  char kernel[]    =3D { "Linux" };
  char *pgpKey[]   =3D { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   =3D { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

diff -Nur linux-2.6.7.orig/CREDITS linux-2.6.7/CREDITS
=2D-- linux-2.6.7.orig/CREDITS 2004-06-16 07:19:43.000000000 +0200
+++ linux-2.6.7/CREDITS 2004-09-23 00:02:44.000000000 +0200
@@ -1210,6 +1210,14 @@
 W: http://www.inf.fu-berlin.de/~ehaase
 D: Driver for the Commodore A2232 serial board
=20
+N: Thomas Habets
+E: thomas@habets.pp.se
+D: random Linux hacker
+P: 1024D/AD48E854 A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854
+S: Tunnlandsv=E4gen 40
+S: 168 36 Bromma
+S: Sweden
+
 N: Bruno Haible
 E: haible@ma2s2.mathematik.uni-karlsruhe.de
 D: SysV FS, shm swapping, memory management fixes
diff -Nur linux-2.6.7.orig/include/linux/mm.h linux-2.6.7/include/linux/mm.h
=2D-- linux-2.6.7.orig/include/linux/mm.h 2004-06-16 07:18:56.000000000 +02=
00
+++ linux-2.6.7/include/linux/mm.h 2004-09-23 00:28:53.000000000 +0200
@@ -21,6 +21,8 @@
 extern unsigned long max_mapnr;
 #endif
=20
+#define VM_OOM_PARDON_LEN 256
+extern char vm_oom_pardon[VM_OOM_PARDON_LEN];
 extern unsigned long num_physpages;
 extern void * high_memory;
 extern int page_cluster;
diff -Nur linux-2.6.7.orig/include/linux/sysctl.h=20
linux-2.6.7/include/linux/sysctl.h
=2D-- linux-2.6.7.orig/include/linux/sysctl.h 2004-06-16 07:19:35.000000000=
=20
+0200
+++ linux-2.6.7/include/linux/sysctl.h 2004-09-23 00:20:37.000000000 +0200
@@ -164,6 +164,7 @@
  VM_LAPTOP_MODE=3D23, /* vm laptop mode */
  VM_BLOCK_DUMP=3D24, /* block dump mode */
  VM_HUGETLB_GROUP=3D25, /* permitted hugetlb group */
+ VM_OOM_PARDON=3D26,       /* don't oom-kill these processes */
 };
=20
=20
diff -Nur linux-2.6.7.orig/kernel/sysctl.c linux-2.6.7/kernel/sysctl.c
=2D-- linux-2.6.7.orig/kernel/sysctl.c 2004-06-16 07:18:58.000000000 +0200
+++ linux-2.6.7/kernel/sysctl.c 2004-09-23 00:28:51.000000000 +0200
@@ -795,6 +795,15 @@
   .strategy =3D &sysctl_intvec,
   .extra1  =3D &zero,
  },
+        {
+                .ctl_name       =3D VM_OOM_PARDON,
+                .procname       =3D "oom_pardon",
+                .data           =3D &vm_oom_pardon,
+                .maxlen         =3D sizeof(vm_oom_pardon),
+                .mode           =3D 0644,
+                .proc_handler   =3D &proc_doutsstring,
+                .strategy       =3D &sysctl_string,
+        },
  { .ctl_name =3D 0 }
 };
=20
diff -Nur linux-2.6.7.orig/mm/oom_kill.c linux-2.6.7/mm/oom_kill.c
=2D-- linux-2.6.7.orig/mm/oom_kill.c 2004-06-16 07:19:29.000000000 +0200
+++ linux-2.6.7/mm/oom_kill.c 2004-09-23 00:31:12.000000000 +0200
@@ -16,14 +16,56 @@
  */
=20
 #include <linux/mm.h>
+#include <linux/utsname.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
=20
+char vm_oom_pardon[VM_OOM_PARDON_LEN];
 /* #define DEBUG */
=20
 /**
+ * For the love of kbaek, don't kill processes in /proc/sys/vm/oom_pardon
+ */
+static int pardon(struct task_struct *task)
+{
+       static char buf[256];
+       const struct qstr *exe;
+       const char *p;
+       int len;
+
+       exe =3D &task->proc_dentry->d_name;
+       len =3D min((int)exe->len, (int)(sizeof(buf) - 2));
+
+       memcpy(buf, exe->name, len);
+       buf[len] =3D 0;
+       buf[len+1] =3D 0;
+
+       if (strchr(buf, ' ')) {
+               return 0;
+       }
+
+       down_read(&uts_sem);
+       p =3D vm_oom_pardon;
+       do {
+               buf[len] =3D ' ';
+               if (!strncmp(p, buf, len)) {
+                       return 1;
+               }
+
+               buf[len] =3D 0;
+               if (!strcmp(p, buf)) {
+                       return 1;
+               }
+               p =3D strchr(p, ' ');
+       } while(p++);
+       up_read(&uts_sem);
+
+       return 0;
+}
+
+/**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
  *
@@ -50,6 +92,10 @@
=20
  if (p->flags & PF_MEMDIE)
   return 0;
+
+ if (pardon(p))
+  return 0;
+
  /*
   * The memory size of the process is the basis for the badness.
   */

--nextPart12749564.y3HuISeQds
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUglyKGrpCq1I6FQRAoJ0AJ9xSiEYAro+pUXjibSOIPMVDn2N5wCg4c9a
Y33f8zf0Z0JJ79lbLzAljmY=
=7i5Y
-----END PGP SIGNATURE-----

--nextPart12749564.y3HuISeQds--

