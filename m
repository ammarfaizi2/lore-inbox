Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbQKPOSY>; Thu, 16 Nov 2000 09:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbQKPOSO>; Thu, 16 Nov 2000 09:18:14 -0500
Received: from sisley.ri.silicomp.fr ([62.160.165.44]:44301 "EHLO
	sisley.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S129982AbQKPOSH>; Thu, 16 Nov 2000 09:18:07 -0500
Date: Thu, 16 Nov 2000 14:47:35 +0100 (CET)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
cc: Eric Paire <paire@ri.silicomp.fr>,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
Subject: [BUG] Inconsistent behaviour of rmdir
Message-ID: <Pine.LNX.4.21.0011161400290.24271-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


It looks like the rmdir syscall behaves strangely in 2.4 kernels :

saffroy@sisley:~> uname -a
Linux sisley 2.2.14-5.0smp #1 SMP Tue Mar 7 21:01:40 EST 2000 i686 unknown
saffroy@sisley:/tmp> mkdir foo
saffroy@sisley:/tmp> rmdir foo/.
saffroy@sisley:/tmp> mkdir foo
saffroy@sisley:/tmp> cd foo/
saffroy@sisley:/tmp/foo> rmdir .
saffroy@sisley:/tmp/foo> cd ..
saffroy@sisley:/tmp> 

[root@picasso /tmp]# uname -a
Linux picasso 2.4.0-test10 #1 SMP Thu Nov 9 14:30:23 GMT+2 2000 i586 unknown
[root@picasso /tmp]# mkdir foo
[root@picasso /tmp]# rmdir foo/.
rmdir: foo/.: Device or resource busy
[root@picasso /tmp]# rmdir foo/ 
[root@picasso /tmp]# mkdir foo
[root@picasso /tmp]# cd foo
[root@picasso foo]# rmdir .
rmdir: .: Device or resource busy
[root@picasso foo]# rmdir ../foo/
[root@picasso foo]#

As you see, it looks like the rmdir fails simply because the dir name ends
with a dot !! This is confirmed by sys_rmdir in fs/namei.c, around line
1384 :

        switch(nd.last_type) {
                case LAST_DOTDOT:
                        error = -ENOTEMPTY;
                        goto exit1;
                case LAST_ROOT: case LAST_DOT:
                        error = -EBUSY;
                        goto exit1;
        }

Should we rip off the offending "case LAST_DOT" ? Or do we need a smarter
patch ? Is it really a problem that a process has its current directory
deleted ? How about the root ?

The man page for rmdir(2) should be updated as well, the current one
states :
       EBUSY  pathname is the current working directory  or  root
              directory of some process.

Maybe rmdir should return EBUSY only when trying to remove a mount point ?


Regards,

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:jms@migrantprogrammer.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
