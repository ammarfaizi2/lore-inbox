Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261546AbTCOUw3>; Sat, 15 Mar 2003 15:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbTCOUw3>; Sat, 15 Mar 2003 15:52:29 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:7863 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261546AbTCOUw1>; Sat, 15 Mar 2003 15:52:27 -0500
Message-ID: <3E739514.8010300@redhat.com>
Date: Sat, 15 Mar 2003 13:03:16 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Hammer thread fixes
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBAE649BB991A4E73203C5872"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBAE649BB991A4E73203C5872
Content-Type: multipart/mixed;
 boundary="------------030203030303060605030906"

This is a multi-part message in MIME format.
--------------030203030303060605030906
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The appended two fixes are necessary to get NPTL threads running on
hammer.  The changes should be obvious.  The exit_group syscall isn't
present at all so far and the r10 -> r8 register use is necessary
because syscall parameter #4 (in r10) is already used for the child_tid
parameter.

Linus, please apply.


-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------030203030303060605030906
Content-Type: text/plain;
 name="d-hammer-kernel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-hammer-kernel"

--- ./arch/x86_64/kernel/process.c.ud	2003-03-10 19:00:56.000000000 -0800
+++ ./arch/x86_64/kernel/process.c	2003-03-15 12:52:17.000000000 -0800
@@ -314,7 +314,7 @@
 			err = ia32_child_tls(p, childregs); 
 		else 			
 #endif	 
-			err = do_arch_prctl(p, ARCH_SET_FS, childregs->r10); 
+			err = do_arch_prctl(p, ARCH_SET_FS, childregs->r8); 
 		if (err) 
 			goto out;
 	}
--- ./include/asm-x86_64/unistd.h.ud	2003-03-10 19:00:56.000000000 -0800
+++ ./include/asm-x86_64/unistd.h	2003-03-15 12:59:09.000000000 -0800
@@ -520,8 +520,10 @@
 __SYSCALL(__NR_clock_getres, sys_clock_getres)
 #define __NR_clock_nanosleep	230
 __SYSCALL(__NR_clock_nanosleep, sys_clock_nanosleep)
+#define __NR_exit_group		231
+__SYSCALL(__NR_exit_group, sys_exit_group)
 
-#define __NR_syscall_max __NR_clock_nanosleep
+#define __NR_syscall_max __NR_exit_group
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */

--------------030203030303060605030906--

--------------enigBAE649BB991A4E73203C5872
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+c5UU2ijCOnn/RHQRAvXHAJoCK/p3qLqNPXbXh+BcEVhPw0fQcQCfXbtk
OcCJZFSUpf7SL1c9mqWuHM8=
=DZ/r
-----END PGP SIGNATURE-----

--------------enigBAE649BB991A4E73203C5872--

