Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTDGITv (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTDGITv (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:19:51 -0400
Received: from desnol.ru ([217.150.58.11]:62985 "EHLO desnol.ru")
	by vger.kernel.org with ESMTP id S263320AbTDGITu (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:19:50 -0400
Date: Mon, 7 Apr 2003 11:35:34 +0400
From: Vitaly <agri@desnol.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-Id: <20030407113534.1de8dc91.agri@desnol.ru>
In-Reply-To: <200304070709.h37792815083@mozart.cs.berkeley.edu>
References: <20030407102005.4c13ed7f.manushkinvv@desnol.ru>
	<200304070709.h37792815083@mozart.cs.berkeley.edu>
Organization: Desnol, grp
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.9; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003 00:09:01 -0700 (PDT)
David Wagner <daw@cs.berkeley.edu> wrote:

> > > >mkdir("testdir", 0700)                  = 0
> > > >open("testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
> > > >write(3, "Ansiktsburk\n", 12)           = 12
> > > >close(3)                                = 0
> > > >open("testdir/testfile", O_RDONLY)      = 3
> > > >chmod("testdir", 0)                     = 0
> > > >open("/proc/self/fd/3", O_RDWR)         = 4
> > > >write(4, "Tjo fidelittan hatt!\n", 21)  = 21
> 
> > open("/proc/self/fd/3", O_RDWR) -- i thought, it just makes a copy for fd/3, and fd/3 should have the same permissions as it was opened.
> 
> 
> It should have the same permissions, but it doesn't.  Try the sample code!
> This looks like a security hole to me.

Yep, you are write it's a big hole but it's not a security hole.
It is mistake of abstraction. ls show file in /proc/self/fd as symbolic links and kernel tries to work with it as symbolic links. Because there will be a problem when program can access file from cwd but cannot access from absolute path, also after chroot and after changing cwd. Therefore it just test permissions of the file and don't checks any directories in the path. It works as a program doing smth like that:
cd testdir
open testfile
open /proc/self/fd/3 (in mind: open testfile again)

it was a choice of proceed, and it's a bad choice.
I think that "open("/proc/self/fd/3", O_RDWR)" should forget anything about "testdir/testfile" and should only check permissions for proc/self/fd/3.
using your test program i got
open("testfile", O_RDONLY) = 3
open("/proc/self/fd/3", O_RDWR) = 5

and ls /proc/self/fd:
l-wx------   3 -> /.../testfile
lrwx------   5 -> /.../testfile

my proceed: if fd 3 have permission l-wx------ it cannot be opened for reading anyway only for writing and execution.

Agri

> -- David
> 
