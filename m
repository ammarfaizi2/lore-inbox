Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSHHVqF>; Thu, 8 Aug 2002 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHHVqF>; Thu, 8 Aug 2002 17:46:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:971 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318031AbSHHVqE>;
	Thu, 8 Aug 2002 17:46:04 -0400
Date: Thu, 08 Aug 2002 15:11:04 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: trond.myklebust@fys.uio.no
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Second attempt at a shared credentials patch
Message-ID: <81390000.1028837464@baldur.austin.ibm.com>
In-Reply-To: <15698.52455.437254.428402@charged.uio.no>
References: <23130000.1028818693@baldur.austin.ibm.com>
 <shsofcdfjt6.fsf@charged.uio.no><44050000.1028823650@baldur.austin.ibm.com>
 <15698.41542.250846.334946@charged.uio.no>
 <52960000.1028829902@baldur.austin.ibm.com>
 <15698.52455.437254.428402@charged.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, August 08, 2002 09:56:23 PM +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> ... which begs the question: are you saying that there are no SMP
> issues with CLONE_CRED and setting/reading the 'struct cred' members?

Yes, I'm saying there are no SMP issues with the shared cred structure.  I
looked for them and failed to find any.  Credentials are not set
cross-task, and are always done via atomic ops.  I also failed to find any
broader race conditions that would require a lock.

> Which other shareable structures? Are there other any that can get
> changed at random places in the code?
> Please read what I said. The macros help to enforce the idea that you
> should not change ->state for anything other than the current task.

Ahh, hmm.  That might possibly be useful, though I'm not convinced it's
necessary.  The benefit would have to outweigh the added obscurity of using
a macro, and I don't think it does.

> Authentication under UNIX usually requires you to check the process'
> uid/gid/groups affiliation. As such, it is useful to be able to pass
> that information around the kernel. Most OSes use some variation of
> the BSD 'ucred' structure which is reference counted and obeys COW
> (copy on write).
> 
> struct ucred {
>   atomic_t count;
>   uid_t	   uid;      /* == fsuid if you like */
>   gid_t	   gid;      /* == fsgid  "  "   "   */
>   int	   ngroups;
>   gid_t	   *groups;
> };
> 
> This means that 'struct file', the underlying filesystems, whoever
> else... can hold a reference to the above structure and be assured
> that it will never change. Changing the fsuid etc. are extremely rare
> operations compared to opening/closing a file, so the whole idea is
> precisely to *avoid* having to copy the above information all the time
> (which, given all the races that CLONE_CRED introduces, is a good
> thing).
> 
> As for POSIX behaviour: it is quite compatible with the above. The
> only change would be that your shared 'struct cred' would require a
> reference to a struct ucred rather than including fsuid, fsgid, groups
> as cred structure members.
> 
> Note: Given that Linux has adopted the 'capability' model on top of
> the standard UNIX authentication model, it might perhaps be necessary
> to move the capabilities into the ucred in order to make them COW too?

Ahh, ok.  I see what you're getting at now.  It's an interesting idea, and
I think a good one.  But it's not really related to the patch I did, and I
don't want to tie one to the other.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

