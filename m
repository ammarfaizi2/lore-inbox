Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTDJLzC (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 07:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTDJLzC (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 07:55:02 -0400
Received: from [144.51.25.10] ([144.51.25.10]:9936 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S264029AbTDJLzB (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 07:55:01 -0400
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Gruenbacher <a.gruenbacher@computer.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1049976394.2551.14.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Apr 2003 08:06:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> Could you please try to priefly summarize the intended use of these
> security labels? Is this for MAC? Also it would be interesting to know
> what the required privileges would be to access the labels. There are
> probably some accesses that are allowed in the user's security context,
> and some others that are performed on behalf of a user process, but within
> the kernel's security context.
> 
> There may be some overlap with trusted extended attributes (see
> http://oss.sgi.com/cgi-bin/cvsweb.cgi/xfs-cmds/attr/man/man5/attr.5 for a
> manual page that contains a minimal description).

SELinux implements a flexible MAC architecture that can support many different 
kinds of MAC security models and includes Type Enforcement, Role-Based Access 
Control, and optionally Multi-Level Security in the example security server 
(policy engine).  It is not based on POSIX.1e MAC, and POSIX.1e MAC doesn't work 
so well for non-traditional MAC models like Type Enforcement and Role-Based 
Access Control.  We define a set of permissions that control the ability
of a user process to get and set the security label of a file, and the
kernel module internally performs get and set operations as appropriate 
when files are looked up and when new files are created.  We originally
implemented our own persistent label mapping using some meta-files, but
have reworked the SELinux implementation to use xattr if they are available,
as you can see in the patch on the NSA site.

However, SELinux is merely one of the possible security modules that
might be implemented via LSM, so we didn't want to limit this to just
SELinux.  It seems preferable to reserve a single index and attribute
name that can be used by any security module, and use the first few
bytes of the attribute value to indicate the particular security
module.  Most security modules seems to be implementing some form
of non-discretionary access control, but the LSM framework isn't specifically
limited to that.

The xattr_security.c code is actually derived from xattr_trusted.c, but I
thought that we should have a separate index and name for an attribute that
will be used by MAC schemes like SELinux.  Also, the xattr_security.c code 
differs from xattr_trusted.c in the following important respects:

1) We use a fixed attribute name (system.security) that is not
extensible.  Every security module would use that name for its
attributes (LSM only allows one security module at a time, and any
stacking has to be handled by the "principal" security module),
and would sanity check the value by checking the first few bytes
against some module identifier.  Using the "system" prefix seemed
appropriate given that this attribute is used internally by the security
module and not just by userspace.

2) Permission checking is handled via the security_inode_setxattr hook
in fs/xattr.c:setxattr, and updating of the inode's security field to
reflect changes to the attribute is handled by a new
security_inode_post_setxattr hook added by the patch.  The inode
semaphore ensures atomicity for the check and update (note that the down
is moved by the patch).  There is no permission check embedded in the
handler itself, since it will vary depending on the security module and
depending on whether the call is made from userspace or from the
security module itself.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

