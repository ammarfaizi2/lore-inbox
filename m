Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSGEQMT>; Fri, 5 Jul 2002 12:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317499AbSGEQMS>; Fri, 5 Jul 2002 12:12:18 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:5177 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S317498AbSGEQMQ>; Fri, 5 Jul 2002 12:12:16 -0400
Date: Fri, 5 Jul 2002 11:14:51 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207051614.LAA68184@tomcat.admin.navo.hpc.mil>
To: spotter@cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: prevent breaking a chroot() jail?
In-Reply-To: <1025879850.11004.75.camel@zaphod>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter <spotter@cs.columbia.edu>:
> 
> On Fri, 2002-07-05 at 10:02, Miquel van Smoorenburg wrote:
> > In article <1025877004.11004.59.camel@zaphod>,
> > Shaya Potter  <spotter@cs.columbia.edu> wrote:
> > >I'm trying to develop a way to ensure that one can't break out of a
> > >chroot() jail, even as root.  I'm willing to change the way the syscalls
> > >work (most likely only for a subset of processes, i.e. processes that
> > >are run in the jail end up getting a marker which is passed down to all
> > >their children that causes the syscalls to behave differently).
> > >What should I be aware of?  I figure devices (no need to run mknod in
> > >this jail) and chroot (as per man page), is there any other way of
> > >breaking the chroot jail (at a syscall level or otherwise)?
> > 
> > int main()
> > {
> > 	chdir("/");
> > 	mkdir("foo");
> > 	chroot("foo");
> > 	chdir("../../../../../../..");
> > 	chroot(".");
> > 	execl("/bin/sh", "sh", NULL);
> > }
> > 
> > Run as root and you're out of the chroot jail. This is because
> > chroot() doesn't chdir() to the new root, so after a chroot() in
> > the chroot jail you're suddenly out of it.

Usually, I see the above sequence more like:
	...
	chdir("/");
	mkdir("foo");
	chdir("/foo");
	chroot("/foo");
	...
Though this doesn't necessarily change the situation.

> yes, that's what the man page says.  Is that the only hole? i.e. if one
> changed the semantics of chroot() to also do a chdir() to the new root,
> would that be fixed? (not arguing on changing this for everything, just
> for something specific)

sure, but it depends on what you are trying to prevent... all of these assume
root, and are only possiblilities, not necessarily realities.

signal is one way to bring the system down (as is reboot).

swapon is a way to get to other processes memory (create a swap file, then
start swapping to it). This one is difficult to implement effectively.

ptrace may allow access to other processes (not sure - see PTRACE_ATTACH)

Modify the shared libraries (in memory) and you modify all processes that
are using it (yes it is read only, but root may be able to change the memory
tables). I havent tried this one, and it may not be possible

Use open/read/write/close to get the inode of the real parent directory,
then the program creates a new file entry (bypassing mkdir... use read/write)
to create a subdirectory link to then cd into. Yes it is an invalid entry.

mmap may allow access to devices or the IO memory mapped area.

use iopl/ioperm to gain access to the I/O ports for devices.

mount may allow a loopback nfs mount (not tested either). This would only
grant access to NFS filesystems exported globally, and would fail for those
with explicit exports (host specified in the exports). It may also allow
the mounting of /proc /devfs (or /devices) which would give access to
everything.

There is no good way to trap root. You really need to move to something
more secure.. such as a non priviledged root user (capability based, or
LSM/SELinux based) and simply remove the privileges from the process before/as
it is handed over to the chroot "jail".
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
