Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWDSRxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWDSRxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWDSRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:53:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:3793 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751012AbWDSRxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:53:30 -0400
From: Tony Jones <tonyj@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@sous-sol.org, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org
Date: Wed, 19 Apr 2006 10:49:05 -0700
Message-Id: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Subject: [RFC][PATCH 0/11] security: AppArmor - Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached patches to include the AppArmor application security module in
the linux kernel.

An overview of AppArmor is available here
http://en.opensuse.org/Apparmor and a more detailed view here
http://en.opensuse.org/AppArmor_Detail A video of an overview and demo
of AppArmor is available here
ftp://ftp.belnet.be/pub/mirror/FOSDEM/FOSDEM2006-apparmor.avi

Overview
-----------
AppArmor is an LSM security enhancement for the Linux kernel. The
primary goal of AppArmor is to make it easy for a system administrator
to control application behavior, enforcing that the application has
access to only the files and POSIX.1e draft capabilities it requires to
do its job. AppArmor deliberately uses this simple access control model
to make it as easy as possible for the administrator to manage the
policy, because the worst security of all is that which is never
deployed because it was too hard.

AppArmor chooses which security policy to enforce for a process at
exec() time by the executable image's pathname, in conjunction with any
policy enforced for the currently running executable.

AppArmor mediates access to the file system using absolute path names
with shell-syntax wildcards, so that "/srv/htdocs/** r" grants read
access to all files in /srv/htdocs. AppArmor mediates access to POSIX.1e
Capabilities in that the process must both have e.g. "capability
net_bind_service" and intrinsically have that capability (usually by
being root) to be able to bind to privileged network ports. Thus a
confined process can not subvert AppArmor except as permitted by policy,
and can not access the file system except as permitted by the profile.

AppArmor is strictly monotonic to security: it only restricts privilege,
never enhancing privilege. So if you add AppArmor to a system, it only
becomes more secure or stays the same, the security policy will not add
vulnerabilities. Similarly, AppArmor is designed to be highly
transparent to applications: If you add AppArmor to a working system,
you have to develop AppArmor profiles, but you do not have to change
your applications. If you remove AppArmor from a running system, the
system continues to operate exactly as before, but without the AppArmor
security protections.

AppArmor is *not* intended to protect every aspect of the system from
every other aspect of the system: the intended usage is that only a
small fraction of all programs on a Linux system will have AppArmor
profiles. Rather, AppArmor is intended to protect the system against a
particular threat.

For instance, to secure a machine against network attack, all programs
that face the network should be profiled. If all open network ports lead
to AppArmor profiles, then there is no way for the network attacker to
attack the machine, except as controlled by AppArmor policy. As a
convenience, AppArmor includes a netstat wrapper that reports all
programs with open network ports and their AppArmor profile status.

AppArmor includes a training system so that a profile can be built by
exercising a program in "complain" mode where rules are not enforced but
violations are logged. User-level tools can then transform this log of
events into application security profiles by asking the user questions.
The profile generator is intelligent about not asking duplicate
questions, incrementally improving existing profiles, and suggesting
generalized alternatives to specific events, such as inserting * into
path names that appear to be library version numbers.

AppArmor has been split into two modules, the primary apparmor module
and a submodule that implements the necessary pathname matching
functions. The SuSE release of AppArmor uses a sub-module which supports
full shell pathname expansion syntax. This is achieved using a subset of
PCRE and limits on expression complexity at the userside compiler. It is
understood that this approach is not acceptable for mainline inclusion.
The version submitted here uses a simpler matching submodule that
implements literal and tailglob matches only. We plan on developing a
new submodule that will implement the missing functionality of the SuSE
release using the textsearch framework and a new bounded textsearch
algorithm acceptable for subsequent inclusion into the mainline kernel.

The features supported by the matching sub module are exposed into the
apparmor filesystem and read by the userspace parser which will prevent
unsupported policy from being loaded.

Without the use of this extended globbing module, AppArmor supports only
globs in the following form:

/path/to/files**

or:

/path/to/directory/**

Who Needs This?
-------------------
AppArmor is a core part of SUSE Linux. It has also been ported to
Slackware, Ubuntu, Gentoo, Red Hat, and Pardus Linux. AppArmor is not
"needed" but is desirable where ever an application hosted on Linux is
exposed to attack.

Patches
--------
The implementation has been broken down into 11 patches, with brief
descriptions here, and longer descriptions in each of the patch posts
that follow

   1. apparmor_build.patch. Integrate into kbuild.
   2. apparmor_headers.patch. Core headers.
   3. apparmor_lsm.patch. LSM interface implementation.
   4. apparmor_mediation.patch. Core access controls.
   5. apparmor_fs.patch. AppArmor filesystem.
   6. apparmor_interface.patch. Usersapce/kernelspace interface.
   7. apparmor_misc.patch. Misc., including Capabilities and data
      structure management.
   8. apparmor_match.patch. Pathname matching submodule.
   9. audit.patch. Integrate into audit subsystem.
  10. dpath_flags.patch. Generate absolute path names.
  11. namespace_sem.patch. Exports the namespace_sem semaphore.

The patches apply cleanly to 2.6.17-rc1 and -rc2.


Tests
------
The AppArmor team has a suite of functionality and stress tests
http://www.apparmor.org/

Bugs
----

   1. The simple tail-glob pattern matching sub-module described above
      needs to be replaced with a fully functional pattern matching
      module that uses textsearch facilities as soon as possible.
   2. AppArmor needs to re-construct the full path name of files to
      perform initial validation. Some of the LSM hooks that we mediate
      do not have vfsmount/nameidata passed. Our temporary workaround is
      to export the namespace_sem semaphore so we can safely walk the
      process's namespace to find a vfsmount with a root dentry matching
      the dentry we are trying to mediate. We believe a cleaner solution
      (such as passing a vfsmount or nameidata to all LSM hooks throughout
      the VFS layer) would be useful for audit, other LSMs, and
      potentially FUSE. As it is a fair amount of work to pass vfsmount or
      nameidata structures throughout the VFS, alternative suggestions
      and ideas are welcomed.

Thanks and Acknowledgment:
----------------------------------

   1. AppArmor started life as Steve Beattie's thesis topic in 1996 and
      has been in continuous development since.
   2. Professors Virgil Gligor and Heather Hinton contributed
      substantially to the initial design of AppArmor.
   3. LSM was built with cooperation from a great many people; the LSM
      interface reduced our long-term maintenance costs and helped raise
      the visibility of mandatory access control systems among many
      users. We wish to thank Stephen Smalley, James Morris, Chris
      Wright, and Greg Kroah-Hartman in particular for their work on LSM.
   4. The users of Immunix Linux and AppArmor on various Linuxes helped
      a lot to improve the system.
   5. The SUSE Security Team and the SUSE Kernel Team reviewed the
      AppArmor code to help make it more ready for LKML inclusion. Of
      course as usual, bugs are our own.
