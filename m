Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTEDUnU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTEDUnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:43:19 -0400
Received: from mail.webmaster.com ([216.152.64.131]:52147 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261670AbTEDUnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:43:18 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mikhail Kruk" <meshko@cs.brandeis.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: fcntl file locking and pthreads
Date: Sun, 4 May 2003 13:55:47 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEIFCLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0305041518530.14517-100000@calliope.cs.brandeis.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > CLONE_FILES is an argument to clone(), I'm using pthreads and I don't
> > > know if LinuxThreads implementation of pthreads gives me control of
> > > how clone is called. Anyway, if I understand what CLONE_FILES does,
> > > it should be given to clone, because threads do have to be able
> > > to share file
> > > descriptors, probably. But not the locks!

> > 	What if I have an application where requests are written to
> > files. Thread A
> > comes along and notices a job in a file, so it locks the file
> > and reads the
> > job. The job will require some network I/O, so the thread goes on to do
> > other things. Later on, thread B notices the network I/O has
> > completed, so
> > it needs to write to the file, release the lock, and close the file.

> I am not persuaded by this example. Why didn't thread A close the file
> when it finished the network I/O? That would be logical time to do it.

	That would release the process' lock on the file descriptor, but the
process is not done with the file descriptor. Surely you're not seriously
suggesting that, say, a multithreaded web server should open/close every
file each time it needs to read some data from it rather than holding the
descriptor open until it's done with it.

> If
> it wasn't a file descriptor, but a shared memory region, would you argue
> the same about a mutex protecting that memory region?

	Mutexes *are* thread resources. They're specifically used to provide
synchronization between threads. However, file descriptors are process
resources.

> I think this should not be a question of personal opinions or specific
> examples. It should just be consistent.

	Yes. File descriptors are process resources, thus everything about them
should be a process resource. The locks on a file are no different from the
file pointer.

> Two reference platforms for
> threads are Solaris and Windows. I don't know how Solaris handles this,
> but on Windows file locks are per thread, not per process.

	Surely your argument isn't that UNIX should do things a certain way because
that's how Windows does it? We can talk about two things, how things are and
how they should be. This discussion seemed to be about how things should be.
And file descriptors and the stuff associated with them should be process
resources.

	However, I think there's a simple fix to this problem. Associate the file
locks with the particular file descriptor. One can argue that the current
scheme (where closing a file descriptor releases locks associated with
another file descriptor for the same file) is as crazy as having two threads
each open the same file and wind up sharing a file pointer.

	This will allow threads to share file locks by sharing file descriptors.
However, it will not create subtle dependencies between code blocks that
happen to open/lock the same file because they'll use their own file
descriptors.

	Share a file descriptor, share locks. Open the file yourself, you have your
own locks.

	That's what makes sense.

	DS


