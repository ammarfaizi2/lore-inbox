Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWDTNM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWDTNM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDTNM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:12:29 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:45216 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750811AbWDTNM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:12:28 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tony Jones <tonyj@suse.de>
Cc: linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 08:17:03 -0400
Message-Id: <1145535423.3313.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote: 
> AppArmor is an LSM security enhancement for the Linux kernel. The
> primary goal of AppArmor is to make it easy for a system administrator
> to control application behavior, enforcing that the application has
> access to only the files and POSIX.1e draft capabilities it requires to
> do its job. AppArmor deliberately uses this simple access control model
> to make it as easy as possible for the administrator to manage the
> policy, because the worst security of all is that which is never
> deployed because it was too hard.

The worst security is that which doesn't do what it claims to do, giving
a false sense of security.  Which is precisely the problem with
path-based access control; it makes the user think that he is protecting
a given object, when in fact the object may be accessible by another
means.

> AppArmor chooses which security policy to enforce for a process at
> exec() time by the executable image's pathname, in conjunction with any
> policy enforced for the currently running executable.

Multiple instances of the same program can't be distinguished? 

> AppArmor mediates access to the file system using absolute path names
> with shell-syntax wildcards, so that "/srv/htdocs/** r" grants read
> access to all files in /srv/htdocs.

So you have an unbounded number of policies that can govern access to
any given file object and the enforcement of the system policy is
entirely dependent on the file tree structure and any process that can
manipulate that structure.  Further, what about runtime files generated
in shared directories like /tmp, /var/run, ...  And let's please
separate user interface from kernel mechanism.  If you want to specify
pathnames for fixed resources in a user-level config file, that is fine,
but pathnames have historically been rejected as a suitable basis for
the kernel for a reason, not just in the security space.  Why should
this change?  Isn't this a fundamental design change to Linux?  

>  AppArmor mediates access to POSIX.1e
> Capabilities in that the process must both have e.g. "capability
> net_bind_service" and intrinsically have that capability (usually by
> being root) to be able to bind to privileged network ports. Thus a
> confined process can not subvert AppArmor except as permitted by policy,

Not sure what is meant by "subvert AppArmor" here.  Bypass is certainly
possible.

> AppArmor is *not* intended to protect every aspect of the system from
> every other aspect of the system: the intended usage is that only a
> small fraction of all programs on a Linux system will have AppArmor
> profiles. Rather, AppArmor is intended to protect the system against a
> particular threat.

So the attacker knows precisely how to bypass it.  The attacker (beyond
the script kiddies) isn't going to attack you at the point of strength;
he will attack you where you are known to be weak.

> For instance, to secure a machine against network attack, all programs
> that face the network should be profiled. If all open network ports lead
> to AppArmor profiles, then there is no way for the network attacker to
> attack the machine, except as controlled by AppArmor policy. As a
> convenience, AppArmor includes a netstat wrapper that reports all
> programs with open network ports and their AppArmor profile status.

Except that your internal unconfined programs/processes may nonetheless
be subverted via the confined program, because:
a) you aren't controlling all objects and operations, and
b) you aren't controlling those internal programs/processes at all, so
they are at risk of taking untrustworthy inputs from the "confined"
ones, and
c) there is a high likelihood of interactions between those
processes/programs in any real system, particularly in shared
directories where paths aren't very useful as a distinguisher.

>    2. AppArmor needs to re-construct the full path name of files to
>       perform initial validation. Some of the LSM hooks that we mediate
>       do not have vfsmount/nameidata passed. Our temporary workaround is
>       to export the namespace_sem semaphore so we can safely walk the
>       process's namespace to find a vfsmount with a root dentry matching
>       the dentry we are trying to mediate. We believe a cleaner solution
>       (such as passing a vfsmount or nameidata to all LSM hooks throughout
>       the VFS layer) would be useful for audit, other LSMs, and
>       potentially FUSE. As it is a fair amount of work to pass vfsmount or
>       nameidata structures throughout the VFS, alternative suggestions
>       and ideas are welcomed.

Introduce new hooks at the proper location where the information is available.

-- 
Stephen Smalley
National Security Agency

