Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVGFQum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVGFQum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGFQum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:50:42 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:5348 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S262254AbVGFMat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:30:49 -0400
Subject: Re: [PATCH] securityfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Greg KH <greg@kroah.com>, Tony Jones <tonyj@suse.de>, serge@hallyn.com,
       serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
In-Reply-To: <Xine.LNX.4.44.0507060243500.6302-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0507060243500.6302-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 06 Jul 2005 08:29:01 -0400
Message-Id: <1120652941.18855.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 02:52 -0400, James Morris wrote:
> On Sun, 3 Jul 2005, Greg KH wrote:
> 
> > Good idea.  Here's a patch to do just that (compile tested only...)
> > 
> > Comments?
> 
> Looks promising so far.
> 
> I'm currently porting selinuxfs funtionality to securityfs, although I'm
> not sure if we'll be ok during early initialization.  selinuxfs is
> currently kern_mounted via an initcall.  We may need an initcall
> kern_mount() of securityfs before SELinux kicks in.
> 
> Stephen: opinions on this?

The reason for creating a kernel mount of selinuxfs at that point is so
that the selinuxfs_mount vfsmount and selinux_null dentry are available
for flush_unauthorized_files to use.

> Otherwise, it looks like it'll allow SELinux to drop some code.  Generally 
> it will mean that other LSM components won't have to create their own 
> filesystems, and their subdirectories will be hanging off /security (or 
> wherever selinuxfs is mounted), rather than scattered across /
> 
> Some of the SELinux code may be useful as part of securityfs later, as 
> well.

We need to be able to assign specific security labels to specific inodes
in selinuxfs, particularly for the booleans, but ideally for any of
them.

Userspace compatibility is obviously a concern for such a change.
libselinux determines where selinuxfs is mounted during library
initialization by checking /proc/mounts for selinuxfs, and rc.sysinit
does likewise.  /sbin/init performs the initial mount of selinuxfs prior
to initial policy load.  Further, the existence of selinuxfs
in /proc/filesystems is used as a test of whether SELinux was enabled in
the kernel (e.g. is_selinux_enabled in libselinux).

I'm not sure such a change is worthwhile for SELinux; large amount of
disruption for little real gain.

-- 
Stephen Smalley
National Security Agency

