Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317672AbSHHSCl>; Thu, 8 Aug 2002 14:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSHHSCl>; Thu, 8 Aug 2002 14:02:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45489 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317672AbSHHSCk>;
	Thu, 8 Aug 2002 14:02:40 -0400
Date: Thu, 08 Aug 2002 13:05:02 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: trond.myklebust@fys.uio.no
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Second attempt at a shared credentials patch
Message-ID: <52960000.1028829902@baldur.austin.ibm.com>
In-Reply-To: <15698.41542.250846.334946@charged.uio.no>
References: <23130000.1028818693@baldur.austin.ibm.com>
 <shsofcdfjt6.fsf@charged.uio.no><44050000.1028823650@baldur.austin.ibm.com>
 <15698.41542.250846.334946@charged.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, August 08, 2002 06:54:30 PM +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> Why? Macros (and inlined functions) have the advantage that they
> enforce good policy. Doing 'task->cred->uid = a' on tasks other than
> 'current' is in general not a very safe thing to do. This sort of
> issue w.r.t. safe policies should in particular be worrying you when
> you start adding CRED_CLONE...
> There are good precedents for this sort of argument: see
> 'set_current_state()' & friends.

I don't really see the benefit.  The macros you're talking about are only
there to provide different behavior for MP and UP.  There aren't macros for
any of the other shareable structures hanging off the task struct.

> In addition, those macros would allow you to set up compatibility with
> 2.4.x and simplify patch backports.

I don't see this one either.  A patch to change everything to macros + a
patch for my changes is no smaller than my current patch, and I don't see
this as something that'll need changing again, or at least not any more
likely than any of the other structures.  Having macros for elements of a
structure should have more reason than to hide a dereference, in my opinion.
 
> As for changing the structure: As I said previously I'd like to unify
> all those { fsuid, fsgid, group } things into a proper ucred, so that
> we can share these objects around the VFS, and cache them...
> Your 'struct cred' as it stands will not suffice to do all that since
> it does not provide the necessary Copy On Write protection. (For
> instance if some thread temporarily raises my process privileges, I
> will *not* want all my already opened 'struct file's to suddenly gain
> root access).

I'm not opposed to enhancing the cred structure so it can be used like you
describe.  It's not a job I want to tackle, but I'd think my change would
be a step in the right direction.

I'm confused by your example, though.  If a thread makes a system call to
change its credentials, all other threads should see it.  That's POSIX
behavior, and the whole point of the patch.  If you're talking about kernel
code that assumes another identity under the covers, then yes, that's
interesting.  And could be achieved by allocating a temporary cred
structure and attaching it to the task for the duration of the operation.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

