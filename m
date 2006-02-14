Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWBNSt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWBNSt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWBNSt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:49:56 -0500
Received: from mail.gmx.de ([213.165.64.21]:63963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030353AbWBNStz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:49:55 -0500
Date: Tue, 14 Feb 2006 19:49:53 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: JANAK DESAI <janak@us.ibm.com>
Cc: torvalds@osdl.org, akpm@osdl.org, ak@muc.de, hch@lst.de, paulus@samba.org,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <43F1DEB1.7030601@us.ibm.com>
Subject: Re: unhare() interface design questions and man page
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <14142.1139942993@www087.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helllo Janak,

[...]

> >While writing this page, I came up with a number of 
> >questions about the design of this interface:
> >
> >1. Your original documentation said:
> >
> >        The flags argument specifies one or bitwise-or'ed of
> >        several of the following constants.
> >
> >   However, my reading of the code (I have not yet tested the 
> >   syscall) is that 'flags' can be zero.  I don't see any problem
> >   with that, but it is in conflict with the statement above,
> >   so it may be worth confirming: what is intended behaviour?
> >   is 'flags' allowed to be zero?
> >
> >  
> >
> Yes, I agree that the intended behavior of flags == 0 should be 
> clarified. If flags is zero, then the system call is basically 
> a no-op. 
[...]

Good.  I assumed that was the case.

> >2. Reading the code and your documentation, I see that CLONE_VM
> >   implies CLONE_SIGHAND.  Since CLONE_SIGHAND is not implemented
> >   (i.e., results in an EINVAL error), I take it that this means
> >   that at the moment CLONE_VM will not work (i.e., will result 
> >   in EINVAL).  Is this correct?  If so, I will note this in 
> >   the man page.
> >
> Actually, CLONE_SIGHAND implies CLONE_VM and not the
> otherway around. Currently CLONE_VM is supported, as long as
> singnal handlers are not being shared. That is, if you created the
> process using clone(CLONE_VM), which kept signal handlers
> different, then you can unshare VM using unshare(CLONE_VM).

Maybe I'm being dense, and as I said I haven't actually
tested the interface, but your Documentation/unshare.txt 
(7.2) says the opposite:

    If CLONE_VM is set, force CLONE_SIGHAND.

and the code in check_unshare_flags() seems to agree:

        /*
         * If unsharing vm, we must also unshare signal handlers 
         */
        if (*flags_ptr & CLONE_VM)
                 *flags_ptr |= CLONE)SIGHAND;

What am I missing?

> >3. The naming of the 'flags' bits is inconsistent.  In your
> >   documentation you note:
> >
> >        unshare reverses sharing that was done using clone(2) system 
> >        call, so unshare should have a similar interface as clone(2). 
> >        That is, since flags in clone(int flags, void *stack) 
> >        specifies what should be shared, similar flags in 
> >        unshare(int flags) should specify what should be unshared. 
> >        Unfortunately, this may appear to invert the meaning of the 
> >        flags from the way they are used in clone(2).  However, 
> >        there was no easy solution that was less confusing and that 
> >        allowed incremental context unsharing in future without an 
> >        ABI change.
> >   
> >   The problem is that the flags don't simply reverse the meanings
> >   of the clone() flags of the same name: they do it inconsistently.
> >
> >   That is, CLONE_FS, CLONE_FILES, and CLONE_VM *reverse* the 
> >   effects of the clone() flags of the same name, but CLONE_NEWNS 
> >   *has the same meaning* as the clone() flag of the same name.
> >   If *all* of the flags were simply reversed, that would be 
> >   a little strange, but comprehensible; but the fact that one of 
> >   them is not reversed is very confusing for users of the 
> >   interface.
> >
> >   An idea: why not define a new set of flags for unshare()
> >   which are synonyms of the clone() flags, but make their
> >   purpose more obvious to the user, i.e., something like
> >   the following:
> >    
> >         #define UNSHARE_VM     CLONE_VM
> >         #define UNSHARE_FS     CLONE_FS
> >         #define UNSHARE_FILES  CLONE_FILES
> >         #define UNSHARE_NS     CLONE_NEWNS
> >         etc.
> >         
> >   This would avoid confusion for the interface user.  
> >   (Yes, I realize that this could be done in glibc, but why 
> >   make the kernel and glibc definitions differ?)
> >
> >  
> >
> I agree that use of clone flags can be confusing. At least a couple of
> folks pointed that out when I posted the patch. The issues was even
> raised when unshare was proposed few years back on lkml. Some
> source of confusion is the special status of CLONE_NEWNS. Because
> namespaces are shared by default with fork/clone, it is different than
> other CLONE_* flags. That's probably why it was called CLONE_NEWNS
> and not CLONE_NS. 

Yes, most likely.

> In the original discussion in Aug'00, Linus
> said that "it makes sense that a unshare(CLONE_FILES) basically
> _undoes_ the sharing of clone(CLONE_FILES)"
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0008.3/0662.html
>
> So I decided to follow that as a guidance for unshare interface.

Yes, but when Linus made that statement (Aug 2000), there 
was no CLONE_NEWNS (it arrived in 2.4.19, Aug 2002).  So
the inconsistency that I'm highlighting didn't exist back 
then.  As I said above: if *all* of the flags were simply 
reversed, that would be comprehensible; but the fact that 
one of them is not reversed is inconsistent.  This &will*
confuse people in userland, and it seems quite 
unnecessary to do that.  Please consider this point further.

> >4. Would it not be wise to include a check of the following form
> >   at the entry to sys_unshare():
> >
> >        if (flags & ~(CLONE_FS | CLONE_FILES | CLONE_VM | 
> >                CLONE_NEWNS | CLONE_SYSVSEM | CLONE_THREAD))
> >            return -EINVAL;
> >
> >   This future-proofs the interface against applications
> >   that try to specify extraneous bits in 'flags': if those
> >   bits happen to become meaningful in the future, then the
> >   application behavior would silently change.  Adding this 
> >   check now prevents applications trying to use those bits 
> >   until such a time as they have meaning.
> >
> I did have a similar check in the first incarnation of the patch. It was
> pointed out, correctly, that it is better to allow all flags so we can
> incrementally add new unshare functionality while not making
> any ABI changes. unshare follows clone here, which also does not
> check for extraneous bits in flags.

I guess I need educating here.  Several other system calls 
do include such checks:

mm/mlock.c: mlockall(2):
if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
mm/mprotect.c: mprotect(2):
if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
mm/msync.c: msync(2):
if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
mm/mremap.c: mremap(2):
if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
mm/mempolicy.c:	mbind(2):
if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
mm/mempolicy.c:	get_mempolicy(2):
if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))

What distinguishes unshare() (and clone()) from these?

I guess I'm unclear too about this (requoted) text

> It was
> pointed out, correctly, that it is better to allow all flags so we can
> incrementally add new unshare functionality while not making
> any ABI changes. 

If one restricts the range of flags that are available now
(prevents userland from trying to use them), and then
permits additional flags later, then from the point of
view of the old userland apps, there has been no ABI change.
What am I missing here?

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
