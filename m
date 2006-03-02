Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751958AbWCBDbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbWCBDbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWCBDbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:31:05 -0500
Received: from mail.gmx.de ([213.165.64.20]:20967 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751958AbWCBDbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:31:04 -0500
Date: Thu, 2 Mar 2006 04:31:01 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Janak Desai <janak@us.ibm.com>
Cc: torvalds@osdl.org, akpm@osdl.org, ak@muc.de, hch@lst.de, paulus@samba.org,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <43F8B05B.4090707@us.ibm.com>
Subject: Re: unhare() interface design questions and man page
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <19847.1141270261@www008.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janak,

> >>>>>3. The naming of the 'flags' bits is inconsistent.  In your
> >>>>> documentation you note:
> >>>>>
> >>>>>      unshare reverses sharing that was done using clone(2) system 
> >>>>>      call, so unshare should have a similar interface as clone(2). 
> >>>>>      That is, since flags in clone(int flags, void *stack) 
> >>>>>      specifies what should be shared, similar flags in 
> >>>>>      unshare(int flags) should specify what should be unshared. 
> >>>>>      Unfortunately, this may appear to invert the meaning of the 
> >>>>>      flags from the way they are used in clone(2).  However, 
> >>>>>      there was no easy solution that was less confusing and that 
> >>>>>      allowed incremental context unsharing in future without an 
> >>>>>      ABI change.
> >>>>> 
> >>>>> The problem is that the flags don't simply reverse the meanings
> >>>>> of the clone() flags of the same name: they do it inconsistently.
> >>>>>
> >>>>> That is, CLONE_FS, CLONE_FILES, and CLONE_VM *reverse* the 
> >>>>> effects of the clone() flags of the same name, but CLONE_NEWNS 
> >>>>> *has the same meaning* as the clone() flag of the same name.
> >>>>> If *all* of the flags were simply reversed, that would be 
> >>>>> a little strange, but comprehensible; but the fact that one of 
> >>>>> them is not reversed is very confusing for users of the 
> >>>>> interface.
> >>>>>
> >>>>> An idea: why not define a new set of flags for unshare()
> >>>>> which are synonyms of the clone() flags, but make their
> >>>>> purpose more obvious to the user, i.e., something like
> >>>>> the following:
> >>>>>  
> >>>>>       #define UNSHARE_VM     CLONE_VM
> >>>>>       #define UNSHARE_FS     CLONE_FS
> >>>>>       #define UNSHARE_FILES  CLONE_FILES
> >>>>>       #define UNSHARE_NS     CLONE_NEWNS
> >>>>>       etc.
> >>>>>       
> >>>>> This would avoid confusion for the interface user.  
> >>>>> (Yes, I realize that this could be done in glibc, but why 
> >>>>> make the kernel and glibc definitions differ?)
> >>>>>
> >>>>>          
> >>>>>
> >>>>I agree that use of clone flags can be confusing. At least a couple 
> >>>>of
> >>>>folks pointed that out when I posted the patch. The issues was even
> >>>>raised when unshare was proposed few years back on lkml. Some
> >>>>source of confusion is the special status of CLONE_NEWNS. Because
> >>>>namespaces are shared by default with fork/clone, it is different 
> >>>>>than
> >>>>other CLONE_* flags. That's probably why it was called CLONE_NEWNS
> >>>>and not CLONE_NS. 
> >>>>        
> >>>>
> >>>Yes, most likely.
> >>>
> >>>>In the original discussion in Aug'00, Linus
> >>>>said that "it makes sense that a unshare(CLONE_FILES) basically
> >>>>_undoes_ the sharing of clone(CLONE_FILES)"
> >>>>
> >>>>http://www.ussg.iu.edu/hypermail/linux/kernel/0008.3/0662.html
> >>>>
> >>>>So I decided to follow that as a guidance for unshare interface.
> >>>>        
> >>>>
> >>>Yes, but when Linus made that statement (Aug 2000), there 
> >>>was no CLONE_NEWNS (it arrived in 2.4.19, Aug 2002).  So
> >>>the inconsistency that I'm highlighting didn't exist back 
> >>>then.  As I said above: if *all* of the flags were simply 
> >>>reversed, that would be comprehensible; but the fact that 
> >>>one of them is not reversed is inconsistent.  This &will*
> >>>confuse people in userland, and it seems quite 
> >>>unnecessary to do that.  Please consider this point further.
> >>>
> >>>      
> >>>
> >>Thanks for clarification. I didn't check that namespaces cames after
> >>that original discussion. I still think that the confusion is not acute
> >>enough to warrent addition of more flags, but will run it by some
> >>folks to see what they think.
> >>    
> >>
> >
> >Let me put it this way: if you change things in the manner
> >I suggest, then it will cause a few kernel developers
> >to have to stop and think for a moment.  If you leave things 
> >as they are, then a multitude of userland programmers will be
> >condemned to stumble over this confusion for many years to
> >come.  
> >
> >(And yes, I appreciate that the original problem arose 
> >with clone(), really there should have been a CLONE_NS 
> >flag which was used as the default for fork() and exec(), 
> >and omitted to get the CLONE_NEWNS behaviour we now have.
> >But extended this problem into unshare() is even
> >more confusing, IMHO.)
> >
> >Just to emphasize this point: while testing the
> >various unshare() flags, I found I was myself runnng 
> >into confusion when I tested unshare(CLONE_NEWNS).
> >That confusion arose precisely because CLONE_NEWNS
> >has the same effect in clone() and unshare().  And
> >I was still getting confused even though I 
> >understood that!
> >
> >Please consider changing these names.  (I'm a little
> >surprised that no-one else has offered an opinion for
> >or against this point so far...)

Do you have any further response on this point?
(There was none in your last message?)

> >>>>>4. Would it not be wise to include a check of the following form
> >>>>> at the entry to sys_unshare():
> >>>>>
> >>>>>      if (flags & ~(CLONE_FS | CLONE_FILES | CLONE_VM | 
> >>>>>              CLONE_NEWNS | CLONE_SYSVSEM | CLONE_THREAD))
> >>>>>          return -EINVAL;
> >>>>>
> >>>>> This future-proofs the interface against applications
> >>>>> that try to specify extraneous bits in 'flags': if those
> >>>>> bits happen to become meaningful in the future, then the
> >>>>> application behavior would silently change.  Adding this 
> >>>>> check now prevents applications trying to use those bits 
> >>>>> until such a time as they have meaning.
> >>>>>
> >>>>I did have a similar check in the first incarnation of the patch. It 
> >>>>was
> >>>>pointed out, correctly, that it is better to allow all flags so we 
> >>>>can
> >>>>incrementally add new unshare functionality while not making
> >>>>any ABI changes. unshare follows clone here, which also does not
> >>>>check for extraneous bits in flags.
> >>>>        
> >>>I guess I need educating here.  Several other system calls 
> >>>do include such checks:
> >>>
> >>>mm/mlock.c: mlockall(2):
> >>>if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
> >>>mm/mprotect.c: mprotect(2):
> >>>if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
> >>>mm/msync.c: msync(2):
> >>>if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
> >>>mm/mremap.c: mremap(2):
> >>>if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
> >>>mm/mempolicy.c:	mbind(2):
> >>>if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
> >>>mm/mempolicy.c:	get_mempolicy(2):
> >>>if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
> >>>
> >>>What distinguishes unshare() (and clone()) from these?
> >>>
> >>I haven't looked at your examples in detail, but basically clone and
> >>unshare work on pieces of process context. It is quite possible that
> >>in future there may be new pieces added to the process context
> >>resulting in new flags. You want to make sure that you can
> >>incrementally add functionality for sharing and unsharing of
> >>new flags.
> >
> >Sure -- and I do not see how my suggestion preclused 
> >that possibility.
> >
> >>>I guess I'm unclear too about this (requoted) text
> >>>
> >>>>It was
> >>>>pointed out, correctly, that it is better to allow all flags so we 
> >>>>can
> >>>>incrementally add new unshare functionality while not making
> >>>>any ABI changes. 
> >>>>        
> >>>>
> >>>If one restricts the range of flags that are available now
> >>>(prevents userland from trying to use them), and then
> >>>permits additional flags later, then from the point of
> >>>view of the old userland apps, there has been no ABI change.
> >>>What am I missing here?
> >>>
> >>I think the ABI change may occur if the new flag that gets added,
> >>somehow interacts with an existing flag (just like signal handlers and
> >>vm) or has a different default behavior (like namespace). I think
> >>that's why clone and unshare (which mimics the clone interface)
> >>do not check for unimplmented flags.
> >
> >What you are saying here doesn't make sense to me.  Here is how 
> >I see that an ABI change can occur, and it seems to me
> >that it is highly undesirable:
> >
> >1. Under the the current implementation, useland calls 
> >   unshare() *accidentally* specifying some additional 
> >   bits that currently have no meaning, and do not 
> >   cause an EINVAL error.
> >
> >2. Later, those bits acquire meaning in unshare().
> >
> >3. As a consequence, the behaviour of the old
> >   binary application changes (perhaps crashes,
> >   perhaps just does something new and strange)
> >
> >Does this scenario not seem to be a problem to you?
> >If not, why not?
> >
> To me, instead of an application accidently passing extra bits/flags, a
> more
> likely scenario is the incremental addition of new and valid flags. What
> I was trying to cover is the possibility that new context flags may get
> added to the kernel, but their unsharing may not get added at the same
> time. An application developer can appropriately add new flags to their
> unshare call and would not have to port their application everytime an
> unsharing of a new context flag was supported. A context flag, for
> which unsharing is not yet implemented, will result in a no-op. I
> understand
> your concerns and I will run them by a couple of senior kernel developers
> to see what they think.

And what did they think?

Janak, I think these points should be conclusively resolved 
(as in: I'm definitely wrong, and I should shut up; or fixes
should be made) before 2.6.16 goes out.  After that things get 
much more difficult.

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
