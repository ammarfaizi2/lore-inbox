Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTK0KNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 05:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTK0KNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 05:13:47 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:42683 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S264469AbTK0KNp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 05:13:45 -0500
From: David Lang <david.lang@digitalinsight.com>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Robert White <rwhite@casabyte.com>,
       "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Florian Weimer'" <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
       "'Daniel Gryniewicz'" <dang@fprintf.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
Date: Thu, 27 Nov 2003 02:58:13 -0800 (PST)
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <20031127100217.GA9199@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0311270253130.6400@dlang.diginsite.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com>
 <3FC5A7F0.8080507@cyberone.com.au> <Pine.LNX.4.58.0311270106430.6400@dlang.diginsite.com>
 <3FC5BC43.8030209@cyberone.com.au> <Pine.LNX.4.58.0311270143060.6400@dlang.diginsite.com>
 <20031127100217.GA9199@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003, Jörn Engel wrote:

> On Thu, 27 November 2003 01:50:46 -0800, David Lang wrote:
> > >
> > > I don't think it should do any linking / unlinking it should just work
> > > with file descriptors. Concurrent writes to a file don't have many
> > > guarantees. sys_copy shouldn't have to be any stronger (read weaker).
> >
> > I'm thinking that it may actually be easier to do this via file paths
> > instead of file descripters. with file paths something like COW or
> > zero-copy copy can be done trivially (and the kernel knows the user
> > credentials of the program issuing the command and can pass them on to the
> > filesystem to see if it's allowed). I don't see how this can be done with
> > file descripters (if all you have is a file descripter you can truncate
> > and write a file, but you don't know all the links to that file so you
> > can't reposition that first inode for example).
>
> And how is userspace supposed to protect itself from race conditions?
> Just compare:
>
> fd1 = open(path1);
> if (stat(fd1) looks fishy)
> 	abort();
> fd2 = open(path2);
> if (stat(fd2) looks fishy)
> 	abort();
> copy(fd1, fd2);
>
> and:
>
> fd1 = open(path1);
> if (stat(fd1) looks fishy)
> 	abort();
> fd2 = open(path2);
> if (stat(fd2) looks fishy)
> 	abort();
> copy(path1, path2);
>
> Jörn
>

Ok, good point. my first reaction is to make copy refuse to function
unless the target doesn't exist (protect the output), but that doesn't
solve the problem of protecting the input or preventing someone else from
tampering with the output (unless you have copy return the FD to use to
access the output)

actually thinking about it a bit more, did I make a stupid mistake and
think that the FD points at the beginning of the file when it really
points at the inode? if it points at the inode then the problems I was
refering to don't exist.

David Lang
