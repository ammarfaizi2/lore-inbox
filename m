Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUFMW5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUFMW5W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 18:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUFMW5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 18:57:22 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:384 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261321AbUFMW5S (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 18:57:18 -0400
Message-Id: <200406121959.i5CJxLAm008168@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Coding style questions for patches..
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-62086184P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Jun 2004 15:59:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-62086184P
Content-Type: text/plain; charset=us-ascii

I'm currently updating the security patches I posted a while ago, and have a
few questions (a *partial* sample patch is appended - the dangling parts not
shown are why I'm posting this.. ;)

1) Is the patch below more acceptable than the original, where I had the #ifdef
in the middle of the kernel/pid.c code?

Currently, the #ifdef is done via security/Kconfig (this part ISN'T included
below).  The problem is that currently, the variable security_enable_randpid
lives in a new security/*.o file that gets built.  It's easy enough to make
this all work as part of a large patch that provides an LSM as well, but the
problem is that I'd like to push this one (and several other things that
similarly can't be done via LSM) for inclusion.

2) Where should the 'extern int' actually be if this is a separate patch?
security/Kconfig makes sense to me for the CONFIG variables, but I suspect that
the various flags need to live someplace (I'm currently looking at 1 for PIDs
below, and on the order of 4 to 5 'int' flags in the TCP/UDP code, and one in
the RPC code....)

3) Currently, the LSM file does all the sysctl setup - should I break that into
a part that has the variables used by the LSM, and another patch against kernel/
sysctl.c that does the non-LSM flags?

3a) Alternatively, do people think I should just punt the sysctl support, in
which case I can just lose the variable and all the associated worry?

3b) If no sysctl support, should I have support for setting it at boot time?

4) I have a series of 4 or 5 similar patches which are *logically* independent
(for instance, randomizing the TCP ephemeral source port doesn't depend on the
below patch for randomizing process IDs).  However, for things like sysctl.c,
the code for the patches will end up close enough to cause merging problems.

Should I submit 2 patches, both against a clean source tree, knowing that the
second won't apply if the first is applied?  Or should I submit the first patch
against the clean tree, and a second that deltas off that, knowing that it
won't apply if the first one *isn't* accepted?

Straw-man sample code for illustration:

--- include/linux/pid.h.vt	2003-09-27 20:50:13.000000000 -0400
+++ include/linux/pid.h	2004-06-12 15:29:02.507247676 -0400
@@ -61,4 +61,22 @@ extern void switch_exec_pids(struct task
 			elem = elem->next, prefetch(elem->next), 	\
 			task = pid_task(elem, type))
 
+#ifdef CONFIG_SECURITY_RANDPID
+#include <linux/random.h>
+extern int security_enable_randpid;
+
+static inline int alloc_next_pid(int last_pid) {
+	int next;
+	if (security_enable_randpid && (last_pid >= RESERVED_PIDS)) {
+		pid = (get_random_long() % (pid_max - RESERVED_PIDS)) + RESERVED_PIDS + 1;
+	}
+	else next = last_pid + 1;
+	return next;
+}
+#else
+static inline int alloc_next_pid(int last_pid) {
+	return last_pid + 1;
+}
+#endif
+
 #endif /* _LINUX_PID_H */
--- kernel/pid.c.vt	2004-06-10 00:37:49.000000000 -0400
+++ kernel/pid.c	2004-06-12 15:26:24.148058356 -0400
@@ -102,7 +102,7 @@ int alloc_pidmap(void)
 	int pid, offset, max_steps = PIDMAP_ENTRIES + 1;
 	pidmap_t *map;
 
-	pid = last_pid + 1;
+	pid = alloc_next_pid(last_pid);
 	if (pid >= pid_max)
 		pid = RESERVED_PIDS;
 


--==_Exmh_-62086184P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAy2CZcC3lWbTT17ARAlO9AKCwKymv4gO2gPvjRq9S/uVUqv6cQgCg/a9T
l4hVeXOtBWSe6aAMsLkXaBw=
=V8Zk
-----END PGP SIGNATURE-----

--==_Exmh_-62086184P--
