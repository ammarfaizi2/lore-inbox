Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131101AbQKPQhw>; Thu, 16 Nov 2000 11:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131103AbQKPQhm>; Thu, 16 Nov 2000 11:37:42 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:53869 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131101AbQKPQhX>; Thu, 16 Nov 2000 11:37:23 -0500
Date: Thu, 16 Nov 2000 10:07:22 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011161607.KAA439649@tomcat.admin.navo.hpc.mil>
To: saffroy@ri.silicomp.fr, torvalds@transmeta.com, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] Inconsistent behaviour of rmdir
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Saffroy <saffroy@ri.silicomp.fr>:
> 
> It looks like the rmdir syscall behaves strangely in 2.4 kernels :
> 
> saffroy@sisley:~> uname -a
> Linux sisley 2.2.14-5.0smp #1 SMP Tue Mar 7 21:01:40 EST 2000 i686 unknown
> saffroy@sisley:/tmp> mkdir foo
> saffroy@sisley:/tmp> rmdir foo/.
> saffroy@sisley:/tmp> mkdir foo
> saffroy@sisley:/tmp> cd foo/
> saffroy@sisley:/tmp/foo> rmdir .
> saffroy@sisley:/tmp/foo> cd ..
> saffroy@sisley:/tmp> 
> 
> [root@picasso /tmp]# uname -a
> Linux picasso 2.4.0-test10 #1 SMP Thu Nov 9 14:30:23 GMT+2 2000 i586 unknown
> [root@picasso /tmp]# mkdir foo
> [root@picasso /tmp]# rmdir foo/.
> rmdir: foo/.: Device or resource busy
> [root@picasso /tmp]# rmdir foo/ 
> [root@picasso /tmp]# mkdir foo
> [root@picasso /tmp]# cd foo
> [root@picasso foo]# rmdir .
> rmdir: .: Device or resource busy
> [root@picasso foo]# rmdir ../foo/
> [root@picasso foo]#
> 
> As you see, it looks like the rmdir fails simply because the dir name ends
> with a dot !! This is confirmed by sys_rmdir in fs/namei.c, around line
> 1384 :
> 
>         switch(nd.last_type) {
>                 case LAST_DOTDOT:
>                         error = -ENOTEMPTY;
>                         goto exit1;
>                 case LAST_ROOT: case LAST_DOT:
>                         error = -EBUSY;
>                         goto exit1;
>         }
> 
> Should we rip off the offending "case LAST_DOT" ? Or do we need a smarter
> patch ? Is it really a problem that a process has its current directory
> deleted ? How about the root ?
> 
> The man page for rmdir(2) should be updated as well, the current one
> states :
>        EBUSY  pathname is the current working directory  or  root
>               directory of some process.
> 
> Maybe rmdir should return EBUSY only when trying to remove a mount point ?

This may not be relevent, but it actually is busy - consider that the
namei lookup must open the directory named "foo" (during the unlink
processing. While that directory is open it is searched for the name ".".

Now that the path is recognized, the unlink attempts to remove the directory
"." from the directory. This is a loop, which is held busy by the lookup of
the name "foo/.".  Since this REALLY is a hard link between "." and "foo",
there is no way to know what is causing it to be busy - another process, or
a different open on the directory (foo is open for modification after all).

I admit that some special case handling such as verifying that the use
count of . equals 1 AND that the inode of "." equals the inode of "foo"
before allowing it (and foo) to be removed would work.

But why bother. It is busy, even if only by the process attempting the
unlink, and then only during the unlink system call. This becomes a
sort of recursive use of the unlink system call, that must also unlink
the name "foo" from the parent directory (.., or the directory containing foo).
If the parent directory is NOT handled then you get a corrupted directory
named foo, that doesn't have "." in it.

It would be simpler to just say "don't do that".

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
