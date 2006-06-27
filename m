Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWF0WOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWF0WOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWF0WOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:14:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:29644 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030431AbWF0WOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:42 -0400
Subject: [PATCH 00/20] Mount writer count and read-only bind mounts (v3)
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:36 -0700
Message-Id: <20060627221436.77CCB048@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think these are ready for -mm.  They've gone through a few revisions
and a week or two of normal burn-in testing.  

---

The following series implements read-only bind mounts.  This feature
allows a read-only view into a read-write filesystem.  In the process
of doing that, it also provides infrastructure for keeping track of
the number of writers to any given mount.  New in this version is that
if that number is non-zero, remounts from r/w to r/o are not allowed.  

This set does not take the previously tried approach of pushing down
the vfsmount structure deeply into call paths, such that it might be
checked in functions like permission(), may_create() and may_open().
Instead, it does checks near the entry points in the kernel, bumping
a reference count in the vfsmount structure.  I've also eliminated
the use of the MNT_RDONLY flag.  It was redundant since we have the
reference count.

This set also makes no attempt to keep the return codes for these
r/o bind mounts the same as for a real r/o filesystem or device.
It would require significantly more code and be quite a bit more
invasive.  Unless there is a very strong reason to do so, I believe
it isn't worth the trouble.

One note: the previous patches all worked this way:

	mount --bind -o ro /source /dest

These patches have changed that behavior.  It now requires two steps:

	mount --bind /source /dest
	mount -o remount,ro  /dest

Since the last revision, the locking in faccessat() and
mnt_is_readonly() has been changed to fix a race which might have
caused a false-negative mount-is-readonly return when faccessat()
is called while another two processes are racing to make a mount
readonly.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
