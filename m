Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTDGOqh (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTDGOqh (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:46:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44043 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263463AbTDGOp4 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:45:56 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new syscall: flink
Date: 7 Apr 2003 07:57:08 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6s3k4$i0i$1@cesium.transmeta.com>
References: <20030407102005.4c13ed7f.manushkinvv@desnol.ru> <200304070709.h37792815083@mozart.cs.berkeley.edu> <20030407113534.1de8dc91.agri@desnol.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030407113534.1de8dc91.agri@desnol.ru>
By author:    Vitaly <agri@desnol.ru>
In newsgroup: linux.dev.kernel
>
> On Mon, 7 Apr 2003 00:09:01 -0700 (PDT)
> David Wagner <daw@cs.berkeley.edu> wrote:
> 
> > > > >mkdir("testdir", 0700)                  = 0
> > > > >open("testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
> > > > >write(3, "Ansiktsburk\n", 12)           = 12
> > > > >close(3)                                = 0
> > > > >open("testdir/testfile", O_RDONLY)      = 3
> > > > >chmod("testdir", 0)                     = 0
> > > > >open("/proc/self/fd/3", O_RDWR)         = 4
> > > > >write(4, "Tjo fidelittan hatt!\n", 21)  = 21
> > 
> > > open("/proc/self/fd/3", O_RDWR) -- i thought, it just makes a copy for fd/3, and fd/3 should have the same permissions as it was opened.
> > 
> > 
> > It should have the same permissions, but it doesn't.  Try the sample code!
> > This looks like a security hole to me.
> 
> Yep, you are write it's a big hole but it's not a security hole. 
> 

That is what people are arguing it is.  It is certainly a *potential*
security hole.  There are two possibilities:

a) Either flink() is harmless and we should be able to add it.

b) This is a security hole, in which case /proc needs to be fixed.  In
particular, the open("/proc/self/fd/3", O_RDWR) in my example above
should return EPERM.

> It is mistake of abstraction. ls show file in /proc/self/fd as
> symbolic links and kernel tries to work with it as symbolic
> links. Because there will be a problem when program can access file
> from cwd but cannot access from absolute path, also after chroot and
> after changing cwd. Therefore it just test permissions of the file
> and don't checks any directories in the path. It works as a program
> doing smth like that: cd testdir open testfile open /proc/self/fd/3
> (in mind: open testfile again)
> 
> it was a choice of proceed, and it's a bad choice.
> I think that "open("/proc/self/fd/3", O_RDWR)" should forget anything about "testdir/testfile" and should only check permissions for proc/self/fd/3.
> using your test program i got
> open("testfile", O_RDONLY) = 3
> open("/proc/self/fd/3", O_RDWR) = 5

You've clearly changed it around; the file descriptor should be 4.
 
> and ls /proc/self/fd:
> l-wx------   3 -> /.../testfile
> lrwx------   5 -> /.../testfile
> 
> my proceed: if fd 3 have permission l-wx------ it cannot be opened for reading anyway only for writing and execution.

You'd think, but it doesn't work that way.  By the way, I
get:

lr-x------    1 hpa      eng            64 Apr  7 07:54 3 ->
/home/hpa/flink/testdir/testfile
lrwx------    1 hpa      eng            64 Apr  7 07:54 4 ->
/home/hpa/flink/testdir/testfile

... not l-wx------ which would be an O_WRONLY file descriptor.

Personally I would prefer if open() on
/proc/*/fd would actually operate as if a dup() on the relevant file
descriptor, which would be a significant change of semantics; however,
one could argue those are the saner semantics.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
