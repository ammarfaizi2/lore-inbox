Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVGGD32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVGGD32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 23:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVGFT5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:57:52 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:30359 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S262154AbVGFQIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:08:21 -0400
Subject: Re: [PATCH] securityfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Greg KH <greg@kroah.com>, Tony Jones <tonyj@suse.de>, serge@hallyn.com,
       serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
In-Reply-To: <Xine.LNX.4.44.0507061125530.7680-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0507061125530.7680-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 06 Jul 2005 12:06:40 -0400
Message-Id: <1120666000.21423.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 11:35 -0400, James Morris wrote:
> When exactly is this needed?  The securityfs mountpoint will be available 
> via a core_initcall, after which we can initialize the selinux subtree.

As long as it occurs prior to initial policy load, so that should be
fine.

> With securityfs, we'd have /sys/kernel/security/selinux configured during 
> kernel initialization.

It still has to be mounted by userspace, right?  So /sbin/init still
needs to know to mount securityfs, and where the selinux nodes live
under it, so you are still talking about changing it (and libselinux and
rc.sysinit), and risking compatibility breakage for existing systems
when they update their kernels.

> Could be a simple change to look for the presence of
> /sys/kernel/security/selinux

Slightly different.  That would correspond to checking for the presence
of selinuxfs in /proc/mounts (i.e. has it been mounted), vs. the current
check of selinuxfs in /proc/filesystems (i.e. has it been registered).
The latter allows testing whether SELinux is enabled at all in the
kernel, regardless of whether selinuxfs has been mounted in the process'
namespace.  In practice, the difference likely only matters for init and
you can deal with distinction there.  But again, this requires code
change to libselinux, /sbin/init, and rc.sysinit at least, with
coordinated update with the kernel.  Certainly possible, but experience
suggests it isn't likely to go smoothly.

> I think it should reduce and simplify the SELinux kernel code, with less
> filesystems in the kernel, consolidating several potential projects into
> the same security filesystem.

If there are several such projects in the first place...

-- 
Stephen Smalley
National Security Agency

