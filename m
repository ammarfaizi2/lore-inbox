Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTDMWp5 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbTDMWp4 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:45:56 -0400
Received: from muriel.parsec.at ([80.120.166.1]:7692 "EHLO muriel.parsec.at")
	by vger.kernel.org with ESMTP id S262652AbTDMWpx (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 18:45:53 -0400
Date: Mon, 14 Apr 2003 00:57:16 +0200 (CEST)
From: Andreas Gruenbacher <ag@bestbits.at>
X-X-Sender: <ag@muriel.parsec.at>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
In-Reply-To: <1049976394.2551.14.camel@moss-huskers.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 10 Apr 2003, Stephen Smalley wrote:

> Andreas Gruenbacher wrote:
> > Could you please try to priefly summarize the intended use of these
> > security labels? Is this for MAC? Also it would be interesting to know
> > what the required privileges would be to access the labels. There are
> > probably some accesses that are allowed in the user's security context,
> > and some others that are performed on behalf of a user process, but within
> > the kernel's security context.
> >
> > There may be some overlap with trusted extended attributes (see
> > http://oss.sgi.com/cgi-bin/cvsweb.cgi/xfs-cmds/attr/man/man5/attr.5 for a
> > manual page that contains a minimal description).
>
> SELinux implements a flexible MAC architecture that can support many different
> kinds of MAC security models and includes Type Enforcement, Role-Based Access
> Control, and optionally Multi-Level Security in the example security server
> (policy engine).  It is not based on POSIX.1e MAC, and POSIX.1e MAC doesn't work
> so well for non-traditional MAC models like Type Enforcement and Role-Based
> Access Control.  We define a set of permissions that control the ability
> of a user process to get and set the security label of a file, and the
> kernel module internally performs get and set operations as appropriate
> when files are looked up and when new files are created.  We originally
> implemented our own persistent label mapping using some meta-files, but
> have reworked the SELinux implementation to use xattr if they are available,
> as you can see in the patch on the NSA site.
>
> However, SELinux is merely one of the possible security modules that
> might be implemented via LSM, so we didn't want to limit this to just
> SELinux.  It seems preferable to reserve a single index and attribute
> name that can be used by any security module, and use the first few
> bytes of the attribute value to indicate the particular security
> module.  Most security modules seems to be implementing some form
> of non-discretionary access control, but the LSM framework isn't specifically
> limited to that.
>
> The xattr_security.c code is actually derived from xattr_trusted.c, but I
> thought that we should have a separate index and name for an attribute that
> will be used by MAC schemes like SELinux.  Also, the xattr_security.c code
> differs from xattr_trusted.c in the following important respects:
>
> 1) We use a fixed attribute name (system.security) that is not
> extensible.  Every security module would use that name for its
> attributes (LSM only allows one security module at a time, and any
> stacking has to be handled by the "principal" security module),
> and would sanity check the value by checking the first few bytes
> against some module identifier.  Using the "system" prefix seemed
> appropriate given that this attribute is used internally by the security
> module and not just by userspace.

LSM only allows one principal security module at a time, but it allows to
switch between security modules. I am wondering what will happen if a user
switches between multiple security modules that label files. The new
module will see labels from the old module. It's a question of policy how
to deal with that case. Probably the policy restrictions the old module
was implementing should be considered invalid after another module was
used, and so the old labels should be ignored/removed.

Another case is stacked modules where more than one module needs file
labels. Your proposed API does not support that. I would rather use
individual attribute names for each module (e.g., "security.selinux",
etc.).

The design of filesystem EAs differentiates rough access policies by
attribute namespace ("system.*", "user.*", "trusted.*"). The system
namespace is special in that each "system.*" attribute may have different
access restrictions. Attributes in the "user.*" namespace are subject to
the same restrictions as the contents of the file the attributes are
attached to. Attributes in the "trusted.*" namespace are accessible only
to users capable of CAP_SYS_ADMIN.

The "security" namespace/attribute you are proposing is quite similar to
the "trusted.*" namespace, except that CAP_SYS_ADMIN does not grant any
rights there. It is unlikely that security modules will/can remove the
powers of the CAP_SYS_ADMIN capability; many areas in the kernel depend on
it. I would expect that these modules make sure that no process will be
able to attain that capability in the first place. In that light, wouldn't
it be possible to use the "trusted.*" namespace for storing LSM file
labels instead (e.g., "trusted.selinux")? There's nothing wrong with
introducing another namespace if necessary, but we might be able to avoid
that.


Cheers,
Andreas.

