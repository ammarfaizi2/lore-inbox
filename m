Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbSJARI1>; Tue, 1 Oct 2002 13:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbSJARI1>; Tue, 1 Oct 2002 13:08:27 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:15119 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262202AbSJARAt>; Tue, 1 Oct 2002 13:00:49 -0400
Date: Tue, 1 Oct 2002 18:06:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@tislabs.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20021001180611.B26635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@tislabs.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <20020927175510.B32207@infradead.org> <Pine.GSO.4.33.0209271432120.11942-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.33.0209271432120.11942-100000@raven>; from sds@tislabs.com on Fri, Sep 27, 2002 at 03:00:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 03:00:03PM -0400, Stephen Smalley wrote:
> So you want to move the 'if (turn_on && !capable(CAP_SYS_RAWIO)) return
> -EPERM;' from the base kernel into the security module's ioperm() hook
> function, in addition to whatever additional logic the module may
> implement?  [Assuming for the moment that we kept the ioperm() hook, even
> though that isn't likely given its current lack of use and
> architecture-specific nature].

Exactly.
> 
> If so, what about the rest of the kernel access checking logic?  Do you
> want all of the permission() logic pushed into the security module's
> inode_permission() hook function?

permission() switches into per-fs code.

> Do you want the bad_signal() logic
> pushed into the security module's task_kill() hook function?

Only the capable() check.  Unless of course we make uid/gid checking optional.
Which seems like a very bad idea given the mess even with just the current LSM
hooks.

> That kind of
> change was considered and discussed on linux-security-module long ago, but
> it will yield a very invasive patch for very little gain.  It also
> requires cleanly separating all access checking logic from functional
> logic (it is sometimes fairly intertwined) and determining exactly which
> is which

Umm.  Clean and nicely separated code is a lot of gain.  Making Linux's
access clean instead of a lot more messy is a good think.  Much better than
any feature addition.  (Unless, of course, you get paid for adding
features..)


> (e.g. is enforcing a read-only mount a security behavior or a
> functional behavior?).

For the kernel it's a functional behavior.  The administrator can chose
to apply it for security reasons, but that's policy and thus not the
kernel's issue.

> 
> > Show me a useful example that needs this argument.
> 
> Do you want every process that can use ioperm() to be able to access the
> full range of ports accessible by that call?  If not, then you need
> something finer-grained than CAP_SYS_RAWIO.  But as I said, we don't
> presently use this hook, and it is architecture-dependent.

Okay, this does actually makes sense.  Point taken.

> 
> > And WTF is the use a security policy that checks module arguments?  Do
> > you want to disallow options that are quotes from books on the index
> > or not political correct enough for a US state agency?
> 
> The LSM module_initialize hook is called with a pointer to the kernel's
> copy of the relocated module image with the struct module header.  Hence,
> the security module is free to perform whatever validation it wants on
> that image prior to the execution of the init function.  But if the
> criteria is that there must be a specific existing security module that
> uses the hook, then this one will go away too.

Yes, a hook without a intree user or at least a properly defined and
available out-of-tree user is pointless.
