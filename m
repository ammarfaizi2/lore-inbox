Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262589AbSI0Szp>; Fri, 27 Sep 2002 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262591AbSI0Szp>; Fri, 27 Sep 2002 14:55:45 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:47612 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S262589AbSI0Szl>; Fri, 27 Sep 2002 14:55:41 -0400
Date: Fri, 27 Sep 2002 15:00:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: Christoph Hellwig <hch@infradead.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [RFC] LSM changes for 2.5.38
In-Reply-To: <20020927175510.B32207@infradead.org>
Message-ID: <Pine.GSO.4.33.0209271432120.11942-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Christoph Hellwig wrote:

> In 2.5 LSM hooks are part of the Linux access checks, and any reason to
> make your patch less intrusive inb 2.4 doesn't apply anymore.  Having
> two checks for the same thing is indeed very bad in will cause harm
> and maintaince burden in the long term.  Don't do it.

So you want to move the 'if (turn_on && !capable(CAP_SYS_RAWIO)) return
-EPERM;' from the base kernel into the security module's ioperm() hook
function, in addition to whatever additional logic the module may
implement?  [Assuming for the moment that we kept the ioperm() hook, even
though that isn't likely given its current lack of use and
architecture-specific nature].

If so, what about the rest of the kernel access checking logic?  Do you
want all of the permission() logic pushed into the security module's
inode_permission() hook function?  Do you want the bad_signal() logic
pushed into the security module's task_kill() hook function?  That kind of
change was considered and discussed on linux-security-module long ago, but
it will yield a very invasive patch for very little gain.  It also
requires cleanly separating all access checking logic from functional
logic (it is sometimes fairly intertwined) and determining exactly which
is which (e.g. is enforcing a read-only mount a security behavior or a
functional behavior?).

> Show me a useful example that needs this argument.

Do you want every process that can use ioperm() to be able to access the
full range of ports accessible by that call?  If not, then you need
something finer-grained than CAP_SYS_RAWIO.  But as I said, we don't
presently use this hook, and it is architecture-dependent.

> And WTF is the use a security policy that checks module arguments?  Do
> you want to disallow options that are quotes from books on the index
> or not political correct enough for a US state agency?

The LSM module_initialize hook is called with a pointer to the kernel's
copy of the relocated module image with the struct module header.  Hence,
the security module is free to perform whatever validation it wants on
that image prior to the execution of the init function.  But if the
criteria is that there must be a specific existing security module that
uses the hook, then this one will go away too.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



