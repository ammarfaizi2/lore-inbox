Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSI0MFS>; Fri, 27 Sep 2002 08:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261603AbSI0MFS>; Fri, 27 Sep 2002 08:05:18 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:58779 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S261557AbSI0MFR>; Fri, 27 Sep 2002 08:05:17 -0400
Date: Fri, 27 Sep 2002 08:09:50 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: Christoph Hellwig <hch@infradead.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [RFC] LSM changes for 2.5.38
In-Reply-To: <20020927003210.A2476@sgi.com>
Message-ID: <Pine.GSO.4.33.0209270743170.22771-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Christoph Hellwig wrote:

> Sorry, but this is bullshit (like most of the lsm changes).  Either you
> leave the capable in and say it's enough or you add your random hook
> and remove that one.  Just adding more and more hooks without thinking
> gets us exactly nowhere except to an unmaintainable codebase.

The LSM hooks are primarily restrictive, i.e. a security module can deny
access that would normally be granted by the existing Linux access checks.
Hence, the LSM patch does not remove existing access checks.  Minimal
support for permissive behavior (granting what would normally be denied)
is provided to support modularization of the capabilities logic, but this
does not require removing the capable() calls from kernel functions.  This
approach reduces the invasiveness of the patch and the likelihood of
introducing bugs into the base kernel access checking.  See the LSM papers
from Usenix Security and OLS, which should be available from
lsm.immunix.org.

> Also is there a _real_ need to pass in all the arguments?

Define _real_.  It is true that none of the existing open source security
modules presently use this particular hook.  SELinux doesn't presently use
it, but it seems reasonable to support finer-grained control over ioperm()
than the all-or-nothing CAP_SYS_RAWIO.  Is the criteria that every hook
and every parameter to every hook must be used by an existing open source
security module?  If so, then yes, this hook can be dropped.

> Umm, you can't tell me you deny someone to initialize a module he has
> just created?

In sys_create_module, you only know the name and size of the module and
who is performing the operation.  In sys_init_module, you actually have
information about the module available.  Hence, you can make a
finer-grained decision in the module_initialize hook, and possibly deny
even after a successful module_create.  As above, SELinux doesn't use
these hooks presently.

> You don't think this should maybe be just one hook?

They are different operations, with different interpretations of the
string parameter.  If your security module is enforcing any kind of
restriction based on the parameter, then you need to distinguish them.
Again, not used by SELinux at present.

> Aha.  So every LS module knows about every single sysctl in the
> kernel.  Common, this is silly guys (and girls if there any)!

SELinux does use the sysctl hook.  It assigns security labels to sysctl
variables and enforces a consistent control whether accessed via the
sysctl() call or the /proc/sys interface.  The granularity at which you
distinguish the sysctl variables is configurable.  For example, we assign
an individual security label to /proc/sys/kernel/modprobe to suport
fine-grained control over access to it.  Most sysctl variables are grouped
into equivalence classes based on the hierarchy, but it is entirely
configurable in the security policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



