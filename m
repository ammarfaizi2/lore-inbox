Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTDONaM (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTDONaM 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:30:12 -0400
Received: from [144.51.25.10] ([144.51.25.10]:35744 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S261404AbTDONaI 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:30:08 -0400
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Gruenbacher <ag@bestbits.at>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 09:41:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-13 at 18:57, Andreas Gruenbacher wrote:
> LSM only allows one principal security module at a time, but it allows to
> switch between security modules. I am wondering what will happen if a user
> switches between multiple security modules that label files. The new
> module will see labels from the old module. It's a question of policy how
> to deal with that case. Probably the policy restrictions the old module
> was implementing should be considered invalid after another module was
> used, and so the old labels should be ignored/removed.

Thanks for your reply.  However, I don't see the above scenario as
compelling.  I would expect most real security "modules" to be built
into the kernel or inserted at a very early point during initialization
and _never_ removed.  Dynamic switching among multiple security modules
that use the extended attributes seems even less likely.  The typical
"switching" that occurs in LSM is simply the transition from the dummy
module to the real security module when the real security module
initializes, and this poses no problem for xattr.

> Another case is stacked modules where more than one module needs file
> labels. Your proposed API does not support that. I would rather use
> individual attribute names for each module (e.g., "security.selinux",
> etc.).

Note that LSM intentionally does not provide any mechanism itself for
sharing the security fields of the kernel data structures.  Stacking has
to be handled by the principal security module.  In practice, I would
expect that any "stacking" of multiple security modules that use
security fields and xattr will actually involve creation of a new module
that integrates the logic of the individual modules.  This is preferable
anyway to ensure that the interactions among the security modules are
well understood, that the logic is combined in a sensible manner, and
that the individual logics can not subvert one another.  Given this
view, using an individual attribute name for each module would seem to
serve no purpose.  An integrated module that combines logic of several
modules can store all of the necessary security data as a single
attribute value.  Note that SELinux already does this for the set of
security models implemented by its policy engine.

> The design of filesystem EAs differentiates rough access policies by
> attribute namespace ("system.*", "user.*", "trusted.*"). The system
> namespace is special in that each "system.*" attribute may have different
> access restrictions. Attributes in the "user.*" namespace are subject to
> the same restrictions as the contents of the file the attributes are
> attached to. Attributes in the "trusted.*" namespace are accessible only
> to users capable of CAP_SYS_ADMIN.
> 
> The "security" namespace/attribute you are proposing is quite similar to
> the "trusted.*" namespace, except that CAP_SYS_ADMIN does not grant any
> rights there. It is unlikely that security modules will/can remove the
> powers of the CAP_SYS_ADMIN capability; many areas in the kernel depend on
> it. I would expect that these modules make sure that no process will be
> able to attain that capability in the first place. In that light, wouldn't
> it be possible to use the "trusted.*" namespace for storing LSM file
> labels instead (e.g., "trusted.selinux")? There's nothing wrong with
> introducing another namespace if necessary, but we might be able to avoid
> that.

SELinux defines its own set of permission checks for getxattr and
setxattr that are implemented via the security_inode_getxattr and
security_inode_setxattr hooks in the getxattr and setxattr calls.  These
permission checks are performed between the process security context and
the relevant file security contexts (in the case of setxattr, we check
permissions to the existing file security context and to the new file
security context).  The CAP_SYS_ADMIN check isn't suitable at all; it is
more restrictive than we would like for getxattr (e.g. ordinary users
seeing security labels on their files via a patched ls) and more
coarse-grained than we would like for setxattr (e.g. letting an
application that manages multiple types of security data transition one
type to another while still preventing it from arbitrary relabels). 
Since it is implemented in the xattr handler, the CAP_SYS_ADMIN check
would be applied both to operations invoked from userspace and from the
security module, which is undesirable.  CAP_SYS_ADMIN will still need to
be granted to some processes with administrative function at least until
all such operations are covered by finer-grained security hooks or
finer-grained capabilities.   Granting it to processes that merely want
to perform getxattr or setxattr would pose a definite risk. 
Consequently, I think that a separate attribute is necessary.  Thanks
again for your reply.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

