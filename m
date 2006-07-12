Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWGLSRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWGLSRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWGLSRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:58029 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932306AbWGLSRP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:15 -0400
Subject: [RFC][PATCH 00/27] Mount writer count and read-only bind mounts (v4)
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:09 -0700
Message-Id: <20060712181709.5C1A4353@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tries to incorporate comments from Al:
http://article.gmane.org/gmane.linux.kernel/421029

Al wrote:
>  b) figuring out what (if anything) should be done with
>  propagation when we have shared subtrees... (not trivial at all)

Talked with Ram:  Shared subtrees are about having identical views
into the filesystem.  Changing the mount permissions doesn't affect
the view of the filesystem, so it should not be propagated.  

The things that probably need the heaviest review in here are the
i_nlink monitoring patch (including the inode state flag patches 03
and 06) and the new MNT_SB_WRITABLE flag (patch 05).  

---

The following series implements read-only bind mounts.  This feature
allows a read-only view into a read-write filesystem.  In the process
of doing that, it also provides infrastructure for keeping track of
the number of writers to any given mount.  In this version, if there
are writers on a superblock, the filesystem may not be remounted 
r/o.  The same goes for MS_BIND mounts, and writers on a vfsmount.

This has a number of uses.  It allows chroots to have parts of
filesystems writable.  It will be useful for containers in the future
and is intended to replace patches that vserver has had out of the
tree for several years.  It allows security enhancement by making
sure that parts of your filesystem read-only, when you don't want
to have entire new filesystems mounted, or when you want atime
selectively updated.

This set makes no attempt to keep the return codes for these
r/o bind mounts the same as for a real r/o filesystem or device.
It would require significantly more code and be quite a bit more
invasive.

Using this feature requires two steps:

	mount --bind /source /dest
	mount -o remount,ro  /dest

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
