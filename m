Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317906AbSHHTwr>; Thu, 8 Aug 2002 15:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317917AbSHHTwr>; Thu, 8 Aug 2002 15:52:47 -0400
Received: from pat.uio.no ([129.240.130.16]:7138 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317906AbSHHTwp>;
	Thu, 8 Aug 2002 15:52:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15698.52455.437254.428402@charged.uio.no>
Date: Thu, 8 Aug 2002 21:56:23 +0200
To: Dave McCracken <dmccr@us.ibm.com>
Cc: trond.myklebust@fys.uio.no, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Second attempt at a shared credentials patch
In-Reply-To: <52960000.1028829902@baldur.austin.ibm.com>
References: <23130000.1028818693@baldur.austin.ibm.com>
	<shsofcdfjt6.fsf@charged.uio.no>
	<44050000.1028823650@baldur.austin.ibm.com>
	<15698.41542.250846.334946@charged.uio.no>
	<52960000.1028829902@baldur.austin.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

    >> There are good precedents for this sort of argument: see
    >> 'set_current_state()' & friends.

     > I don't really see the benefit.  The macros you're talking
     > about are only there to provide different behavior for MP and
     > UP.

... which begs the question: are you saying that there are no SMP
issues with CLONE_CRED and setting/reading the 'struct cred' members?

     > There aren't macros for any of the other shareable structures
     > hanging off the task struct.

Which other shareable structures? Are there other any that can get
changed at random places in the code?
Please read what I said. The macros help to enforce the idea that you
should not change ->state for anything other than the current task.

     > I'm not opposed to enhancing the cred structure so it can be
     > used like you describe.  It's not a job I want to tackle, but
     > I'd think my change would be a step in the right direction.

     > I'm confused by your example, though.  If a thread makes a
     > system call to change its credentials, all other threads should
     > see it.  That's POSIX behavior, and the whole point of the
     > patch.  If you're talking about kernel code that assumes
     > another identity under the covers, then yes, that's
     > interesting.  And could be achieved by allocating a temporary
     > cred structure and attaching it to the task for the duration of
     > the operation.

Authentication under UNIX usually requires you to check the process'
uid/gid/groups affiliation. As such, it is useful to be able to pass
that information around the kernel. Most OSes use some variation of
the BSD 'ucred' structure which is reference counted and obeys COW
(copy on write).

struct ucred {
  atomic_t count;
  uid_t	   uid;      /* == fsuid if you like */
  gid_t	   gid;      /* == fsgid  "  "   "   */
  int	   ngroups;
  gid_t	   *groups;
};

This means that 'struct file', the underlying filesystems, whoever
else... can hold a reference to the above structure and be assured
that it will never change. Changing the fsuid etc. are extremely rare
operations compared to opening/closing a file, so the whole idea is
precisely to *avoid* having to copy the above information all the time
(which, given all the races that CLONE_CRED introduces, is a good
thing).

As for POSIX behaviour: it is quite compatible with the above. The
only change would be that your shared 'struct cred' would require a
reference to a struct ucred rather than including fsuid, fsgid, groups
as cred structure members.

Note: Given that Linux has adopted the 'capability' model on top of
the standard UNIX authentication model, it might perhaps be necessary
to move the capabilities into the ucred in order to make them COW too?

Cheers,
  Trond
