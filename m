Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTKVS3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 13:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTKVS3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 13:29:12 -0500
Received: from cpc5-oxfd3-5-0-cust159.oxfd.cable.ntl.com ([81.103.199.159]:20747
	"EHLO noetbook.telent.net") by vger.kernel.org with ESMTP
	id S262601AbTKVS3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 13:29:08 -0500
To: linux-kernel@vger.kernel.org
Subject: x86: SIGTRAP handling differences from 2.4 to 2.6
From: Daniel Barlow <dan@telent.net>
Date: Sat, 22 Nov 2003 18:29:00 +0000
Message-ID: <87k75ss1eb.fsf@noetbook.telent.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


There is a difference between 2.4 (tested in 2.4.23-rc2) and 2.6
(tested in 2.6.0-pre9) in the handling of "int 3" inside a SIGTRAP 
handler.

In 2.4, the handler appears to be recursively re-entered.  In 2.6 the
task is killed, along with any other tasks that share the same VM (I'm
not talking about thread groups; I have CLONE_PARENT and CLONE_VM set
but not CLONE_THREAD).

I'm not sure what the correct answer is, if indeed it's specified.
For contrast, in FreeBSD 5.1 I'm told that the signal handler runs to
completion and only on exit is it called again.  I would suggest that
this behaviour is probably more in keeping with the principle of least
astonishment, but maybe I astonish in atypical ways.

Nasty short brutish test program appended.  Change the #if 0 s to #if 1
if you want to see it lay waste to the other threads as well.

I'm reading linux-kernel through the archives, so a CC would be
appreciated if you want me to see answers fast.

---cut here---
#include <signal.h>
#if 0
#include <sched.h>
#include <linux/unistd.h>
#endif

void sigtrap_handler(int sig, struct siginfo *si, void * sc)
{
    printf("entered sigtrap handler, %d %x %x\n", sig,si,sc);
    sleep(2);
    asm("int3" : :);
    printf("leaving sigtrap handler, %d %x %x\n", sig,si,sc);
}

void do_stuff()
{
    pause();
}

main()
{
    struct sigaction sa;
    int i,j;
#if 0    
    i=clone(do_stuff,malloc(1024*1024)+1024*1024,
	    CLONE_VM|SIGCHLD|CLONE_PARENT,0);
    j=clone(do_stuff,malloc(1024*1024)+1024*1024,
	    CLONE_VM|SIGCHLD|CLONE_PARENT,0);
#endif
    sigemptyset(&sa.sa_mask);
    sa.sa_sigaction=sigtrap_handler;
    sa.sa_flags=SA_SIGINFO|SA_RESTART;
    sigaction(SIGTRAP,&sa,0);
    printf("go\n");
    sleep(2);
    asm("int3" : :);
    sleep(3600);
}
---cut here---


-dan

-- 

   http://web.metacircles.com/cirCLe_CD - Free Software Lisp/Linux distro

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/v6ryHDK5ZnWQiRMRAvrrAJ0S8BhXA7KhSjetN/cl5lHALquQoQCgiVTy
WnUgwWEO9QBXGTOp3RL5aHw=
=1ZRI
-----END PGP SIGNATURE-----
--=-=-=--
