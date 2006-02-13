Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWBMWKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWBMWKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWBMWKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:10:08 -0500
Received: from mail.gmx.de ([213.165.64.21]:44203 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030204AbWBMWKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:10:06 -0500
Date: Mon, 13 Feb 2006 23:10:05 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: janak@us.ibm.com
Cc: torvalds@osdl.org, akpm@osdl.org, ak@muc.de, hch@lst.de, paulus@samba.org,
       viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, mtk-manpages@gmx.net
MIME-Version: 1.0
References: <200602072059.k17KxJUI016348@shell0.pdx.osdl.net>
Subject: unhare() interface design questions and man page
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <13469.1139868605@www055.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Janak,

I've been working on a man page for the upcoming 2.6.16 unshare()
syscall, using the documentation that you provided (thank you!)
in your Documentation/unshare.txt patch as a base.

Perhaps you would care to review that page (below), and make
corrections, if needed.

While writing this page, I came up with a number of 
questions about the design of this interface:

1. Your original documentation said:

        The flags argument specifies one or bitwise-or'ed of
        several of the following constants.

   However, my reading of the code (I have not yet tested the 
   syscall) is that 'flags' can be zero.  I don't see any problem
   with that, but it is in conflict with the statement above,
   so it may be worth confirming: what is intended behaviour?
   is 'flags' allowed to be zero?

2. Reading the code and your documentation, I see that CLONE_VM
   implies CLONE_SIGHAND.  Since CLONE_SIGHAND is not implemented
   (i.e., results in an EINVAL error), I take it that this means
   that at the moment CLONE_VM will not work (i.e., will result 
   in EINVAL).  Is this correct?  If so, I will note this in 
   the man page.

3. The naming of the 'flags' bits is inconsistent.  In your
   documentation you note:

        unshare reverses sharing that was done using clone(2) system 
        call, so unshare should have a similar interface as clone(2). 
        That is, since flags in clone(int flags, void *stack) 
        specifies what should be shared, similar flags in 
        unshare(int flags) should specify what should be unshared. 
        Unfortunately, this may appear to invert the meaning of the 
        flags from the way they are used in clone(2).  However, 
        there was no easy solution that was less confusing and that 
        allowed incremental context unsharing in future without an 
        ABI change.
   
   The problem is that the flags don't simply reverse the meanings
   of the clone() flags of the same name: they do it inconsistently.

   That is, CLONE_FS, CLONE_FILES, and CLONE_VM *reverse* the 
   effects of the clone() flags of the same name, but CLONE_NEWNS 
   *has the same meaning* as the clone() flag of the same name.
   If *all* of the flags were simply reversed, that would be 
   a little strange, but comprehensible; but the fact that one of 
   them is not reversed is very confusing for users of the 
   interface.

   An idea: why not define a new set of flags for unshare()
   which are synonyms of the clone() flags, but make their
   purpose more obvious to the user, i.e., something like
   the following:
    
         #define UNSHARE_VM     CLONE_VM
         #define UNSHARE_FS     CLONE_FS
         #define UNSHARE_FILES  CLONE_FILES
         #define UNSHARE_NS     CLONE_NEWNS
         etc.
         
   This would avoid confusion for the interface user.  
   (Yes, I realize that this could be done in glibc, but why 
   make the kernel and glibc definitions differ?)

4. Would it not be wise to include a check of the following form
   at the entry to sys_unshare():

        if (flags & ~(CLONE_FS | CLONE_FILES | CLONE_VM | 
                CLONE_NEWNS | CLONE_SYSVSEM | CLONE_THREAD))
            return -EINVAL;

   This future-proofs the interface against applications
   that try to specify extraneous bits in 'flags': if those
   bits happen to become meaningful in the future, then the
   application behavior would silently change.  Adding this 
   check now prevents applications trying to use those bits 
   until such a time as they have meaning.

Cheers,

Michael


unshare.2 draft man page:

.\" (C) 2006, Janak Desai <janak@us.ibm.com>
.\" (C) 2006, Michael Kerrisk <mtk-manpages@gmx.ne>
.\" Licensed under the GPL
.\"
.TH UNSHARE 2 2005-03-10 "Linux 2.6.16" "Linux Programmer's Manual"
.SH NAME
unshare \- disassociate parts of the process execution context
.SH SYNOPSIS
.nf
.B #include <sched.h>
.sp
.BI "int unshare(int " flags );
.fi
.SH DESCRIPTION
.BR unshare () 
allows a process to disassociate parts of its execution
context that are currently being shared with other processes. 
Part of the execution context, such as the namespace, is shared 
implicitly when a new process is created using 
.BR fork (2)
or
.BR vfork (2), 
while other parts, such as virtual memory, may be
shared by explicit request when creating a process using 
.BR clone (2).

The main use of 
.BR unshare (2)
is to allow a process to control its
shared execution context without creating a new process.

The 
.I flags 
argument is a bit mask that specifies which parts of 
the execution context should be unshared.  
This argument is specified by ORing together one or more
.\" FIXME according to the code, it looks as though 
.\" flags can actually be zero.
of the following constants:
.TP
.B CLONE_FILES
Reverse the effect of the
.BR clone (2)
.B CLONE_FILES
flag.
Unshare the file descriptor table, so that the calling process 
no longer shares its file descriptors with any other process.
.TP
.B CLONE_FS
Reverse the effect of the
.BR clone (2)
.B CLONE_FS 
flag.
Unshare file system attributes, so that the calling process 
no longer shares its root directory, current directory, 
or umask attributes with any other process.
.BR chroot (2),
.BR chdir (2),
or
.BR umask (2)
.TP
.B CLONE_NEWNS
This flag has the same effect as the
.BR clone (2)
.B CLONE_NEWNS
flag.
Unshare the namespace, so that the calling process has a private 
copy of its namespace which is not shared with any other process.
Specifying this flag automatically implies
.B CLONE_FS
as well.
.TP
.B CLONE_VM
Reverse the effect of the
.BR clone (2)
.B CLONE_VM
flag.
.RB ( CLONE_VM
is also implicitly set by
.BR vfork (2),
and can be reversed using this
.BR unshare ()
flag.)
Unshare virtual memory, so that the calling process no 
longer shares its virtual address space with any other process.
.SH RETURN VALUE
On success, zero returned. On failure, \-1 is returned and 
.I errno 
is set to indicate the error.
.SH ERRORS
.TP
.B EPERM
.I flags
specified
.B CLONE_NEWNS 
but the calling process was not privileged (did not have the
.B CAP_SYS_ADMIN
capability).
.TP
.B ENOMEM
Cannot allocate sufficient memory to copy parts of caller's
context that need to be unshared.
.TP
.B EINVAL
An invalid but was specified in
.IR flags .
.SH CONFORMING TO
The
.BR unshare (2)
system call is Linux-specific.
.SH NOTES
Not all of the process attributes that can be shared when 
a new process is created using
.BR clone (2)
can be unshared using
.BR unshare ().
In particular, as at kernel 2.6.16,
.BR unshare () 
does not implement
.BR CLONE_SIGHAND ,
.BR CLONE_SYSVSEM ,
or 
.BR CLONE_THREAD .
.SH SEE ALSO
.BR clone (2), 
.BR fork (2), 
.BR vfork (2), 
Documentation/unshare.txt

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
