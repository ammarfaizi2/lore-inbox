Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSGOMky>; Mon, 15 Jul 2002 08:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSGOMkx>; Mon, 15 Jul 2002 08:40:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46210 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317473AbSGOMko>; Mon, 15 Jul 2002 08:40:44 -0400
Date: Mon, 15 Jul 2002 08:45:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sean Hunter <sean@uncarved.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
In-Reply-To: <20020715075221.GC21470@uncarved.com>
Message-ID: <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Sean Hunter wrote:

> On Tue, Jul 09, 2002 at 03:50:17PM -0400, Richard B. Johnson wrote:
> > On Tue, 9 Jul 2002, Alan Cox wrote:
> > 
> > > > That is what it's supposed to do with files. The attached code clearly
> > > > shows that it doesn't work with directories. The fsync() instantly
> > > > returns, even though there is buffered data still to be written.
> > > 
> > > Your understanding or code is wrong. Its hard to tell which.
> > > 
> > > fsync on the directory syncs the directory metadata not the file metadata
> > > 
> > 
> > Well the original complaint was that Linux NFS didn't allow a directory to
> > be fsync()ed. I showed that POSIX.4 doesn't provide for fsync()ing
> > directories, only files, that you have to fsync() individual files, not
> > the directories that contain them. Others said that fsync()ing individual
> > files was not necessary, that you only have to fsync() the directory. I
> > explained that you have to cheat to even get a fd that can be used
> > to fsync() a directory. Then I showed that fsync()ing a directory in this
> > manner doesn't work so, we are actually in violent agreement.
> 
> I'm not sure whether or not you've got the gist with all the flamage and
> shrapnel flying about, however as I understand it, fsync on a directory fd
> ensures that all directory ops such as rename()s unlinks(), links() etc are
> committed, not that all data pending to all files in that dir are flushed.
> 
> To get all changes you need to fsync the dirfd and all the fds of the files as
> well.
> 
> Because directory changes (such as renames, unlinks etc) are synchronous on NFS
> any way, fsync() on a dir fd on an NFS mount can simply return.  There will
> never be any outstanding dir ops to flush.  ergo: no bug.
> 
> Hope that's clear.
> 
> Sean
> 


NFS has characteristics that seem to make it 'special'.
For instance, you have a server that performs local actions
on behalf of a remote client. As long as the local server
doesn't crash, everything it did for the remote client is
safe even if the remote client crashes and burns. From
the perspective of the remote client, it really doesn't make
much difference if it ever calls fsync() on anything as long
as the server doesn't crash. Therefore, for discussion I
will ignore NFS and other Client Server file access systems.
But just because they are special, it doesn't mean that they
should be treated specially.

Given the following:

		/1/2/3/4/5/6/7/8/9/file

... I suggest that it MUST be sufficient to fsync() 'file' to
assure that file data can be recovered. That's what POSIX.4 states.
If the implementation doesn't allow this, i.e., 'file' will end up
in 'lost+found', then there is a problem that should be addressed.
This is because a local file user's program may not know the entire
directory tree. For example, in a chrooted environment. Also,
the task has no way of knowing what, if any, of these directory
entries have already been flushed to disk. A directory tree could,
in principle, be up to _POSIX_PATH_MAX  entries in length.

In the beginning, when God created Unix, files and directories
were all the same. I could fix a bad directory entry with an
editor. Over the years, certain rules were established to prevent
users from accessing directories as files. They still are files,
but the Operating System(s) try their best to make sure you don't
muck with directories as files.

So now you have to read a directory with getdents(), actually that's
not even POSIX, you need to use readdir(). Also, the directory will
fail to be opened in other than read-only. These are all artificial
constraints, imposed to make sure you follow the rules.

So, you get a read-only file-descriptor and fsync() it! What does
that mean? Obviously, the file must have existed previously to open
it read-only. Since I can't change its contents, because I opened
it read-only, fsync() can't do anything because I could not have
altered its contents.

So, lets say two tasks open the same file.  One opens it read-only
and the other read-write. The read-write task is happily writing
to the file. The read-only task executes fsync(). Does this cause
the writer to wait until the file has been flushed to disk? I don't
know, but if it does, we have a very broken system where an
unprivileged reader can severely affect the performance of a
file-server with a denial-of-service attack. So, I suggest that
a read-only file-descriptor CANNOT cause the contents of a file
to be written. If it does, it's broken. Given this, fsync() on
a directory entry, accessed by a read-only file-descriptor, can't
do anything.

These are things that should be addressed rather than flamed-
away. I think that the intent of fsync() on a file is to make
certain that it is on the physical media in a state from which
it can be accessed after a crash. If this is the intent, then
playing games with individual directories is not useful and
fsync() on the read/write file-descriptor actually updating the
file should be sufficient.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

