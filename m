Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVHaMrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVHaMrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVHaMrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:47:12 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:26075
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S964781AbVHaMrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:47:10 -0400
Subject: [PATCH 2.6.13 0/2] New Syscall: get/set rlimits of any process
	(udate)
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1125027277.6394.8.camel@w2>
References: <1125027277.6394.8.camel@w2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Aug 2005 14:46:45 +0200
Message-Id: <1125492405.5810.5.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Just for the logs, the getprlimit/setprlimit system call for the
2.6.13 plus a man page in case sombody cares.

Again my request to those who reviewed my first try, maybe you could
have a look at this if locking is better now, I do not break SELinux
anymore etc. so I can shift to the 64 Bit reimplementation Alan
suggested without introducing the same bugs again.

Thanks,
Wieland


The man page for this version of get/setprlimit():

Signed-off-by: Wieland Gmeiner <e8607062@student.tuwien.ac.at>

---------------------------------------------------------------------
.\" Hey Emacs! This file is -*- nroff -*- source.
.\"
.\" Copyright (c) 1992 Drew Eckhardt, March 28, 1992
.\" Copyright (c) 2002 Michael Kerrisk
.\"
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.\"
.\" Modified by Michael Haardt <michael@moria.de>
.\" Modified 1993-07-23 by Rik Faith <faith@cs.unc.edu>
.\" Modified 1996-01-13 by Arnt Gulbrandsen <agulbra@troll.no>
.\" Modified 1996-01-22 by aeb, following a remark by
.\"          Tigran Aivazian <tigran@sco.com>
.\" Modified 1996-04-14 by aeb, following a remark by
.\"          Robert Bihlmeyer <robbe@orcus.ping.at>
.\" Modified 1996-10-22 by Eric S. Raymond <esr@thyrsus.com>
.\" Modified 2001-05-04 by aeb, following a remark by
.\"          Havard Lygre <hklygre@online.no>
.\" Modified 2001-04-17 by Michael Kerrisk <mtk-manpages@gmx.net>
.\" Modified 2002-06-13 by Michael Kerrisk <mtk-manpages@gmx.net>
.\"     Added note on non-standard behaviour when SIGCHLD is ignored.
.\" Modified 2002-07-09 by Michael Kerrisk <mtk-manpages@gmx.net>
.\"	Enhanced descriptions of 'resource' values for [gs]etrlimit()
.\" Modified 2003-11-28 by aeb, added RLIMIT_CORE
.\" Modified 2004-03-26 by aeb, added RLIMIT_AS
.\" Modified 2004-06-16 by Michael Kerrisk <mtk-manpages@gmx.net>
.\"     Added notes on CAP_SYS_RESOURCE
.\"
.\" 2004-11-16 -- mtk: the getrlimit.2 page, which formally included
.\" coverage of getrusage(2), has been split, so that the latter
.\" is now covered in its own getrusage.2.
.\"
.\" Modified 2004-11-16, mtk: A few other minor changes
.\" Modified 2004-11-23, mtk
.\"	Added notes on RLIMIT_MEMLOCK, RLIMIT_NPROC, and RLIMIT_RSS
.\"		to "CONFORMING TO"
.\" Modified 2004-11-25, mtk
.\"	Rewrote discussion on RLIMIT_MEMLOCK to incorporate kernel
.\"		2.6.9 changes.
.\"	Added note on RLIMIT_CPU error in older kernels
.\" 2004-11-03, mtk
.\"	Added RLIMIT_SIGPENDING
.\" 2005-07-13, mtk, documented RLIMIT_MSGQUEUE limit.
.\"
.\" Modified 2005-08-30 by Wieland Gmeiner <e8607062@student.tuwien.ac.at>
.\"	Adapted to describe getprlimit() and setprlimit().
.\"
.TH GETPRLIMIT 2 2005-08-30 "Linux" "Linux Programmer's Manual"
.SH NAME
getprlimit, setprlimit \- get/set resource limits of a process
.SH SYNOPSIS
.B #include <sys/time.h>
.br
.B #include <sys/resource.h>
.sp
.BI "int getprlimit(pid_t " pid ", int " resource ", struct rlimit *" rlim );
.br
.BI "int setprlimit(pid_t " pid ", int " resource ", const struct rlimit *" rlim );
.SH DESCRIPTION
.BR getprlimit ()
and
.BR setprlimit ()
respectively get and set resource limits of the process specified by
.IR pid .
If
.I pid
is zero, the process ID of the current process is used. Otherwise the
user IDs and group IDs of the calling process must match user IDs and group IDs
of the process with process ID
.I pid
or the calling process must hold the
.B CAP_SYS_PTRACE
capability.
Each resource has an associated soft and hard limit, as defined by the
.B rlimit
structure (the
.I rlim
argument to both
.BR getprlimit "() and " setprlimit ()):
.PP
.in +0.5i
.nf
struct rlimit {
    rlim_t rlim_cur;  /* Soft limit */
    rlim_t rlim_max;  /* Hard limit (ceiling for rlim_cur) */
};

.fi
.in -0.5i
The soft limit is the value that the kernel enforces for the
corresponding resource.
The hard limit acts as a ceiling for the soft limit:
an unprivileged process may only set the soft limit to a value in the
range from 0 up to the hard limit, and (irreversibly) lower its hard limit.
A privileged process (under Linux: one with the
.B CAP_SYS_RESOURCE
capability) may make arbitrary changes to either limit value.
.PP
The value
.B RLIM_INFINITY
denotes no limit on a resource (both in the structure returned by
.BR getprlimit ()
and in the structure passed to
.BR setprlimit ()).
.PP
.I resource
must be one of:
.TP
.B RLIMIT_AS
The maximum size of the process's virtual memory (address space) in bytes.
.\" since 2.0.27 / 2.1.12
This limit affects calls to
.BR brk (2),
.BR mmap (2)
and
.BR mremap (2),
which fail with the error
.B ENOMEM
upon exceeding this limit. Also automatic stack expansion will fail
(and generate a
.B SIGSEGV
that kills the process if no alternate stack
has been made available via
.BR sigaltstack (2)).
Since the value is a \fIlong\fP, on machines with a 32-bit \fIlong\fP
either this limit is at most 2 GiB, or this resource is unlimited.
.TP
.B RLIMIT_CORE
Maximum size of
.I core
file. When 0 no core dump files are created.
When non-zero, larger dumps are truncated to this size.
.TP
.B RLIMIT_CPU
CPU time limit in seconds.
When the process reaches the soft limit, it is sent a
.B SIGXCPU
signal.
The default action for this signal is to terminate the process.
However, the signal can be caught, and the handler can return control to
the main program.
If the process continues to consume CPU time, it will be sent
.B SIGXCPU
once per second until the hard limit is reached, at which time
it is sent
.BR SIGKILL .
(This latter point describes Linux 2.2 through 2.6 behaviour.
Implementations vary in how they treat processes which continue to
consume CPU time after reaching the soft limit.
Portable applications that need to catch this signal should
perform an orderly termination upon first receipt of
.BR SIGXCPU .)
.TP
.B RLIMIT_DATA
The maximum size of the process's data segment (initialized data,
uninitialized data, and heap).
This limit affects calls to
.BR brk "() and " sbrk (),
which fail with the error
.B ENOMEM
upon encountering the soft limit of this resource.
.TP
.B RLIMIT_FSIZE
The maximum size of files that the process may create.
Attempts to extend a file beyond this limit result in delivery of a
.B SIGXFSZ
signal.
By default, this signal terminates a process, but a process can
catch this signal instead, in which case the relevant system call (e.g.,
.BR write "(), " truncate ())
fails with the error
.BR EFBIG .
.TP
.BR RLIMIT_LOCKS " (Early Linux 2.4 only)"
.\" to be precise: Linux 2.4.0-test9; no longer in 2.4.25 / 2.5.65
A limit on the combined number of
.BR flock ()
locks and
.BR fcntl()
leases that this process may establish.
.TP
.B RLIMIT_MEMLOCK
The maximum number of bytes of memory that may be locked
into RAM.
In effect this limit is rounded down to the nearest multiple
of the system page size.
This limit affects
.BR mlock "(2) and " mlockall (2)
and the
.BR mmap (2)
.B MAP_LOCKED
operation.
Since Linux 2.6.9 it also affects the
.BR shmctl (2)
.B SHM_LOCK
operation, where it sets a maximum on the total bytes in
shared memory segments (see
.BR shmget (2))
that may be locked by the real user ID of the calling process.
The
.BR shmctl (2)
.B SHM_LOCK
locks are accounted for separately from the per-process memory
locks established by
.BR mlock "(2), " mlockall (2),
and
.BR mmap (2)
.BR MAP_LOCKED ;
a process can lock bytes up to this limit in each of these
two categories.
In Linux kernels before 2.6.9, this limit controlled the amount of
memory that could be locked by a privileged process.
Since Linux 2.6.9, no limits are placed on the amount of memory
that a privileged process may lock, and this limit instead governs
the amount of memory that an unprivileged process may lock.
.TP
.BR RLIMIT_MSGQUEUE " (Since Linux 2.6.8)"
Specifies the limit on the number of bytes that can be allocated
for POSIX message queues for the real user ID of the calling process.
This limit is enforced for
.BR mq_open (3).
.\" FIXME there is no mq_open.3 page yet
Each message queue that the user creates counts (until it is removed)
against this limit according to the formula:
.nf

    bytes = attr.mq_maxmsg * sizeof(struct msg_msg *) +
            attr.mq_maxmsg * attr.mq_msgsize)

.fi
where
.I attr
is the
.I mq_attr
structure specified as the fourth argument to
.BR mq_open ().

The first addend in the formula, which includes
.I "sizeof(struct msg_msg *)"
(4 bytes on Linux/x86), ensures that the user cannot
create an unlimited number of zero-length messages (such messages
nevertheless each consume some system memory for bookkeeping overhead).
.TP
.B RLIMIT_NOFILE
Specifies a value one greater than the maximum file descriptor number
that can be opened by this process.
Attempts
.RB ( open "(), " pipe "(), " dup "(), etc.)"
to exceed this limit yield the error
.BR EMFILE .
.TP
.B RLIMIT_NPROC
The maximum number of processes that can be created for the real user
ID of the calling process.
Upon encountering this limit,
.BR fork ()
fails with the error
.BR EAGAIN .
.TP
.B RLIMIT_RSS
Specifies the limit (in pages) of the process's resident set
(the number of virtual pages resident in RAM).
This limit only has effect in Linux 2.4.x, x < 30, and there only
affects calls to
.BR madvise ()
specifying
.BR MADV_WILLNEED .
.\" As at kernel 2.6.12, this limit still does nothing in 2.6 though
.\" talk of making it do something has surfaced from time to time in LKML
.\"       -- MTK, Jul 05
.TP
.BR RLIMIT_SIGPENDING " (Since Linux 2.6.8)"
Specifies the limit on the number of signals
that may be queued for the real user ID of the calling process.
Both standard and real-time signals are counted for the purpose of
checking this limit.
However, the limit is only enforced for
.BR sigqueue (2);
it is always possible to use
.BR kill (2)
to queue one instance of any of the signals that are not already
queued to the process.
.\" This replaces the /proc/sys/kernel/rtsig-max system-wide limit
.\" that was present in kernels <= 2.6.7.  MTK Dec 04
.TP
.B RLIMIT_STACK
The maximum size of the process stack, in bytes.
Upon reaching this limit, a
.B SIGSEGV
signal is generated.
To handle this signal, a process must employ an alternate signal stack
.RB ( sigaltstack (2)).
.PP
.B RLIMIT_OFILE
is the BSD name for
.BR RLIMIT_NOFILE .
.SH "RETURN VALUE"
On success, zero is returned.  On error, \-1 is returned, and
.I errno
is set appropriately.
.SH ERRORS
.TP
.B ESRCH
.I pid
is not valid.
.TP
.B EFAULT
.I rlim
points outside the accessible address space.
.TP
.B EINVAL
.I resource
is not valid.
.TP
.B EPERM
An unprivileged process tried to use \fBsetprlimit()\fP to
increase a soft or hard limit above the current hard limit; the
.B CAP_SYS_RESOURCE
capability is required to do this.
Or, the process tried to use \fBsetprlimit()\fP to increase
the soft or hard RLIMIT_NOFILE limit above the current kernel
maximum (NR_OPEN). Or, the process tried to read or alter a
resource limit of a process he is not privileged to access: User IDs
and group IDs must match or the
.B CAP_SYS_PTRACE
capability is required to do this.
.SH BUGS
In older Linux kernels, the
.B SIGXCPU
and
.B SIGKILL
signals delivered when a process encountered the soft and hard
.B RLIMIT_CPU
limits were delivered one (CPU) second later than they should have been.
This was fixed in kernel 2.6.8.
.SH "CONFORMING TO"
.BR getprlimit ()
and
.BR setprlimit ()
are Linux specific.
.BR RLIMIT_MEMLOCK
and
.BR RLIMIT_NPROC
derive from BSD and are not specified in POSIX.1-2001;
they are present on the BSDs and Linux, but on few other implementations.
.BR RLIMIT_RSS
derives from BSD and is not specified in POSIX.1-2001;
it is nevertheless present on most implementations.
.B RLIMIT_SIGPENDING
and
.B RLIMIT_MSGQUEUE
are Linux specific.
.SH "SEE ALSO"
.BR getrlimit (2),
.BR setrlimit (2),
.BR dup (2),
.BR fcntl (2),
.BR fork (2),
.BR getrusage (2),
.BR mlock (2),
.BR mmap (2),
.BR open (2),
.BR quotactl (2),
.BR sbrk (2),
.BR shmctl (2),
.BR sigqueue (2),
.BR malloc (3),
.BR ulimit (3),
.BR capabilities (7),
.BR signal (7)
---------------------------------------------------------------------

and for setprlimit():

---------------------------------------------------------------------
.so man2/getprlimit.2
---------------------------------------------------------------------


