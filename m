Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTDXMdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTDXMdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:33:07 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:46048 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263645AbTDXMdF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:33:05 -0400
Subject: Re: [RFC][PATCH] Process Attribute API for Security Modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: lkml <linux-kernel@vger.kernel.org>, lsm <linux-security-module@wirex.com>
In-Reply-To: <20030423204409.GB9609@delft.aura.cs.cmu.edu>
References: <1049833073.1018.9.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423204409.GB9609@delft.aura.cs.cmu.edu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051188303.14761.272.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 08:45:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 16:44, Jan Harkes wrote:
> The generic API seems to allow any one to read attr/current and exec
> labels and you are not making any special mention of it. It would be
> possible for any process to obtain someone elses 'security context' by
> simply reading the label, writing it to attr/exec and then execing
> itself into the existing security context.

The security module can implement whatever permission checking it
desires in the [gs]etprocattr hook functions, as well as in the hooks
within execve (the bprm hooks).  As far as the DAC permission checking
is concerned, the patch sets the mode to 0644 for the nodes in
/proc/pid/attr, so a modified ps might be able to get and display the
attributes of other processes (subject to any permission checks
implemented by the module in getprocattr), and processes with the same
uid might be able to set the attributes (subject to any permission
checks implemented by the module in setprocattr, always disallowed by
SELinux for any process other than the associated one).  SELinux
performs the checking of the particular security context via the hooks
in execve (the bprm hooks), when the full context of the operation is
known (e.g. the current process attributes, the entrypoint executable
attributes, any shared state between the current process and other
processes, any process tracing active, etc.).

> > 3) /proc/PID/attr/fscreate represents the attributes to assign to files
> > created by subsequent calls to open, mkdir, symlink, and mknod. A write
> 
> So is this equivalent to fsuid? i.e. when it isn't initialized is the
> current context passed during open/mkdir/symlink/mknod?

It isn't quite the same.  fscreate only specifies the attributes to
assign to newly created files, not the process attributes to use for
permission checks on file accesses.  These need to be kept separate in
SELinux, as a file security context is not the same as the context of
the creating process (there is a relationship between the two, but they
are not identical).  When it isn't initialized, SELinux determines a
default file security label based on the security context of the
creating process and the security context of the parent directory, based
on rules in the policy configuration.  I suppose we could add a fsaccess
attribute to cover the other aspect, i.e. the process attributes to use
for permission checks on file accesses.  This would likely prove useful
when we integrate SELinux support into NFS.

> There are filesystems that are eager to get per-process hooks to store
> their own security labels or tokens. But with this API it won't be
> possible to run both SE-Linux or other security module and have an
> appropriately secure paritioning of AFS or Coda identities at the same
> time.

You might want to look at the discussion of security module stacking
during the thread on my RFC for extended attributes for security
modules.  In short, if you want your filesystem code to attach security
data to processes and use them in combination with a security module
(similar to stacking multiple security modules), you also have to deal
with shared use of the task security field, so your security module and
filesystem code need to be aware of each other anyway.  I don't think we
want to add support for multiple namespaces under /proc/pid/attr;
/proc/pid doesn't seem to encourage dynamic extension by modules.  If we
were to go this route, it might be easier to have [gs]etprocattr system
calls akin to [gs]etxattr; these would map easily to the [gs]etprocattr
hooks and make it simpler to use more complex attribute names.

> And to reduce some of the code-bloat. How about dropping all those
> #define ATTR_GET/ATTR_READ and such by doing something like the
> following,

Thanks, I'll take a look at your revised code and try it out.  Looks
like it might be a nice cleanup.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

