Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTKND6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 22:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbTKND6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 22:58:49 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:64654 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262114AbTKND6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 22:58:45 -0500
Subject: Re: OT: why no file copy() libc/syscall ??
From: Albert Cahalan <albert@users.sf.net>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davide.rossetti@roma1.infn.it, filia@softhome.net, dwmw2@infradead.org,
       moje@vabo.cz, kakadu_croc@yahoo.com
In-Reply-To: <03111209195300.11900@tabby>
References: <1068512710.722.161.camel@cube>  <03111209195300.11900@tabby>
Content-Type: text/plain
Organization: 
Message-Id: <1068781364.723.288.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Nov 2003 22:42:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-12 at 10:19, Jesse Pollard wrote:
> On Monday 10 November 2003 19:05, Albert Cahalan wrote:

> > > The security context of the output depends
> > > on the user process. If it is a privileged
> > > process (ie, may change the context of the
> > > result) then the user process has to setup
> > > that context before the file is copied.
> >
> > So open the file, change context, and then:
> >
> > long copy_fd_to_file(int fd, const char *name, ...)
> 
> Easy to do in user mode.

It isn't, because the user-mode code would
need to have a full understanding of whatever
fancy (seLinux, RSBAC, lomac...) security
mechanism the kernel is using. It's not enough
to just know about switching to some named
context via a common API.

> > >> Is it? Please explain the simple steps which
> > >> cp(1) should take in order to observe that it
> > >> is being asked to duplicate a file on a file
> > >> system such as CIFS (or NFSv4?) which allows
> > >> the client to issue a 'copy file' command
> > >> over the network without actually transferring
> > >> the data twice, and to invoke such a command.
> > >
> > > Ah. That is an optimization question, not a
> > > question of kernel/user mode.
> >
> > Note that /bin/cp isn't always going to have
> > the necessary passwords and such. You're headed
> > down a path toward setuid /bin/cp.
> 
> If cp doesn't have access to the proper security credentials,
> then the file should not be copied.

You have proper credentials for access through
the mounted filesystem. That filesystem was
mounted by root, using some secret key that is
specific to the local machine. You could try
to directly contact the server over the network,
but you won't have the keys.

You're allowed to indirectly use the keys by
going through the mounted filesystem. For example,
you can call rmdir() to remove a directory but
you can not cause the same effect by sending a
message over the network directly to the server.
You have no ability to bypass the local kernel.

So you can copy that file, but you have to use
the file-oriented system calls to do it. You'll
need kernel support to invoke a remote-copy
operation. (or a setuid-root /bin/cp that looks
up the keys, determines the correct server, makes
a network connection, etc.)


> > > And since both source and destination may
> > > be remote you do get to decide based on
> > > source and destination devices: if they
> > > are the same, and one on a remote node,
> > > then BOTH will be on the remote, then you
> > > get to use the CIFS/NFS file copy. (check
> > > the doc on "stat/statfs" for additional info).
> > >
> > > I don't believe it works when source and
> > > destination are on DIFFERENT remote nodes,
> > > though.
> > >
> > > Strictly up to the implementation of cp/mv.
> > >
> > > Though you will loose portability of cp/mv.
> > > (Of course, you also loose it with a syscall
> > > for file copy too; as well as the MUCH more
> > > complicated implementation/security checks).
> >
> > Doing that in cp/mv is just insane. For one,
> > it bypasses any local security control over
> > access to the filesystem. There's not even a
> > way to be sure you're dealing with the server
> > you think you're dealing with.
> 
> It shouldn't matter - first the source file must be opened
> for read AND the destination file opened for write.
> This should give the proper local security evaluation and
> context for the copy. Once this has been approved,
> the remote copy request can be made (provided they are
> on the same "networked" device). Just making
> the request still doesn't mean that it will succeed -
> after all, the final security decisions are made by
> the remote server implementing the file copy.
> 
> Though if the copy is valid locally, then the use of
> the filesystem supported copy should work. It is an
> equivalent operation, it just all takes place on the server.
> 
> Identity of the server is irrelevent, as long as it is
> the same server (or farm) for both source and destination.
> If the remote file copy is defined, then it should work
> even when the actual source and destination are different
> physical machines - the remote filesystem CLAIMS it will
> work (identical is determined from the "device" mounted,
> one mount, one device as far as network filesystems go).
> And if they are not identical then you fall back to using
> a local copy.
> 
> All bets are off if the local pathnames are required by
> the remote server. That is silly. How would a networked
> client even know what the pathname would be? The parameters
> should be the two file handles passed to the remote filesystem.

You may need a filename relative to the root
of the exported part of the tree.

Remote side:
J:\groups\rteng\John Smith\tests\a.out
(with rteng exported as \\RTENG)

Local side:
/home/john/tests/a.out
(the mount point is "/home/john")

Path needed:
\\RTENG\John Smith\tests\a.out

You have that, since the kernel knows that a
"\\\\RTENG\\John Smith" directory was mounted
on /home/john and you're trying to deal with
a tests/a.out file.

> Personally, I don't think any changes should be made.
> It's just that this level of transfer is what the original
> poster was talking about. It just shouldn't be done in
> kernel mode.

Anywhere else would be buggy and most likely setuid.


