Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132762AbRDNFw1>; Sat, 14 Apr 2001 01:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRDNFu0>; Sat, 14 Apr 2001 01:50:26 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32728 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132738AbRDNFuP>;
	Sat, 14 Apr 2001 01:50:15 -0400
Date: Fri, 13 Apr 2001 23:50:28 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Rob Landley <telomerase@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do I make a circular pipe?
Message-ID: <20010413235028.B4197@munchkin.spectacle-pond.org>
In-Reply-To: <20010414010504.2967.qmail@web5201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010414010504.2967.qmail@web5201.mail.yahoo.com>; from telomerase@yahoo.com on Fri, Apr 13, 2001 at 06:05:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 06:05:04PM -0700, Rob Landley wrote:
> How do I do the following:
> 
> #  --> pppd notty | pppoe -I eth1 | --
>    |_________________________________|
> 
> I.E. connect the stdout of a process  (or chain
> thereof) to its own stdin?
> 
> So I wrote a program to do it, along the lines of:
> 
> sixty-nine /bin/sh -c "pppd notty | pppoe -I eth1"
> 
> With an executable approximately along the lines of
> (warning, pseudo-code, the other machine isn't hooked
> up to the internet at the moment for obvious reasons):
> 
> int main(int argc, char *argv[], char *envp[])
> {
>   int fd[2];
>   pipe(fd);
>   dup2(fd[0],0);
>   dup2(fd[0],1);
>   execve(argv[1],argv+1,envp);
>   fprintf(stderr,"Bad.\n");
>   exit(1);
> }
> 
> And it didn't work.  I made a little test program that
> writes to stdout and reads from stdin and reports to
> stderr, and it gets nothing.  Apparently, the pipe
> fd's evaporate when the process does an execve.

Check out:

	#include <unistd.h>
	#include <fcntl.h>

		 /* ... */

	fcntl (fd, F_SETFD, (long) FD_CLOEXEC);

to set/reset the close on exec bit.

> What do I do?  (If anybody else knows an easier way to
> get pppoe working, that would be helpful too.

You might want to check out something like Stevens advanced UNIX programming,
though it is probably somewhat dated :-)

> Rob
> 
> (P.S.  WHY does pppd want to talk to a tty by default
> instead of stdin and stdout?  Were the people who
> wrote it at all familiar with the unix philosophy? 
> Just curious...)

At a guess I would say that the reason is you don't have as much control with
pipes as you do with devices.  Under the standard termios, you can tell the
system to not return from the read until either n characters have been read, or
a given character such as a newline has been read.  You can also switch to
alternative line disciplines that are more targeted to a given application such
as PPP, etc.

You probably want to check out pseudo tty's (pty's), which allow you to create
your own terminal.  Here is the glibc documentation, but you really should pick
up a more advanced treatment of pty's, particularly for the interaction with
signals, job control, etc.:

File: libc.info,  Node: Allocation,  Next: Pseudo-Terminal Pairs,  Up:
Pseudo-Terminals

Allocating Pseudo-Terminals
---------------------------

   This subsection describes functions for allocating a pseudo-terminal,
and for making this pseudo-terminal available for actual use.  These
functions are declared in the header file `stdlib.h'.

 - Function: int getpt (void)
     The `getpt' function returns a new file descriptor for the next
     available master pseudo-terminal.  The normal return value from
     `getpt' is a non-negative integer file descriptor.  In the case of
     an error, a value of -1 is returned instead.  The following
     `errno' conditions are defined for this function:

    `ENOENT'
          There are no free master pseudo-terminals available.

     This function is a GNU extension.

 - Function: int grantpt (int FILEDES)
     The `grantpt' function changes the ownership and access permission
     of the slave pseudo-terminal device corresponding to the master
     pseudo-terminal device associated with the file descriptor
     FILEDES.  The owner is set from the real user ID of the calling
     process (*note Process Persona::), and the group is set to a
     special group (typically "tty") or from the real group ID of the
     calling process.  The access permission is set such that the file
     is both readable and writable by the owner and only writable by
     the group.

     On some systems this function is implemented by invoking a special
     `setuid' root program (*note How Change Persona::).  As a
     consequence, installing a signal handler for the `SIGCHLD' signal
     (*note Job Control Signals::) may interfere with a call to
     `grantpt'.

     The normal return value from `grantpt' is 0; a value of -1 is
     returned in case of failure.  The following `errno' error
     conditions are defined for this function:

    `EBADF'
          The FILEDES argument is not a valid file descriptor.

    `ENINVAL'
          The FILEDES argument is not associated with a master
          pseudo-terminal device.

    `EACCESS'
          The slave pseudo-terminal device corresponding to the master
          associated with FILEDES could not be accessed.


 - Function: int unlockpt (int FILEDES)
     The `unlockpt' function unlocks the slave pseudo-terminal device
     corresponding to the master pseudo-terminal device associated with
     the file descriptor FILEDES.  On many systems, the slave can only
     be opened after unlocking, so portable applications should always
     call `unlockpt' before trying to open the slave.

     The normal return value from `unlockpt' is 0; a value of -1 is
     returned in case of failure.  The following `errno' error
     conditions are defined for this function:

    `EBADF'
          The FILEDES argument is not a valid file descriptor.

    `EINVAL'
          The FILEDES argument is not associated with a master
          pseudo-terminal device.

 - Function: char * ptsname (int FILEDES)
     If the file descriptor FILEDES is associated with a master
     pseudo-terminal device, the `ptsname' function returns a pointer
     to a statically-allocated, null-terminated string containing the
     file name of the associated slave pseudo-terminal file.  This
     string might be overwritten by subsequent calls to `ptsname'.

 - Function: int ptsname_r (int FILEDES, char *BUF, size_t LEN)
     The `ptsname_r' function is similar to the `ptsname' function
     except that it places its result into the user-specified buffer
     starting at BUF with length LEN.

     This function is a GNU extension.

   *Portability Note:* On System V derived systems, the file returned
by the `ptsname' and `ptsname_r' functions may be STREAMS-based, and
therefore require additional processing after opening before it
actually behaves as a pseudo terminal.
therefore require additional processing after opening before it
actually behaves as a pseudo terminal.

   Typical usage of these functions is illustrated by the following
example:
     int
     open_pty_pair (int *amaster, int *aslave)
     {
       int master, slave;
       char *name;
     
       master = getpt ();
       if (master < 0)
         return 0;
     
       if (grantpt (master) < 0 || unlockpt (master) < 0)
         goto close_master;
       name = ptsname (master);
       if (name == NULL)
         goto close_master;
     
       slave = open (name, O_RDWR);
       if (slave == -1)
         goto close_master;
     
       if (isastream (slave))
         {
           if (ioctl (slave, I_PUSH, "ptem") < 0
               || ioctl (slave, I_PUSH, "ldterm") < 0)
             goto close_slave;
         }
     
       *amaster = master;
       *aslave = slave;
       return 1;
     
     close_slave:
       close (slave);
     
     close_master:
       close (master);
       return 0;
     }

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
