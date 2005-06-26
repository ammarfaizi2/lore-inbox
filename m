Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFZMXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFZMXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 08:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFZMXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 08:23:38 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:7369 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261184AbVFZMXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 08:23:00 -0400
Date: Sun, 26 Jun 2005 13:22:56 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [git patch] DRM 32/64 ioctl patch..
Message-ID: <Pine.LNX.4.58.0506261313390.3269@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Please pull the 'drm-3264' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

This contains the initial patch from Paul Mackerras, for supporting
radeons on 32/64 systems, I'll try and submit patches for other chips
later as people get them working.

The patch is at
http://www.skynet.ie/~airlied/patches/lk_drm/drm_3264_git.diff
for anyone else interested.


 Makefile       |    5
 drmP.h         |    5
 drm_bufs.c     |   25 -
 drm_context.c  |    6
 drm_ioc32.c    | 1069 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 radeon_drv.c   |    3
 radeon_drv.h   |    3
 radeon_ioc32.c |  395 +++++++++++++++++++++
 8 files changed, 1501 insertions(+), 10 deletions(-)

commit 9a18664506dbce5e23f3c5de7b1c5a042dd26520
tree 8f047c14a507b3f925e50f797650b15e23058a77
parent ee98689be1b054897ff17655008c3048fe88be94
author Dave Airlie <airlied@starflyer.(none)> Thu, 23 Jun 2005 21:29:18 +1000
committer Dave Airlie <airlied@linux.ie> Thu, 23 Jun 2005 21:29:18 +1000

drm: 32/64-bit DRM ioctl compatibility patch

The patch is against a 2.6.11 kernel tree.  I am running this with a
32-bit X server (compiled up from X.org CVS as of a couple of weeks
ago) and 32-bit DRI libraries and clients.  All the userland stuff is
identical to what I am using under a 32-bit kernel on my G4 powerbook
(which is a 32-bit machine of course).  I haven't tried compiling up a
64-bit X server or clients yet.

In the compatibility routines I have assumed that the kernel can
safely access user addresses after set_fs(KERNEL_DS).  That is, where
an ioctl argument structure contains pointers to other structures, and
those other structures are already compatible between the 32-bit and
64-bit ABIs (i.e. they only contain things like chars, shorts or
ints), I just check the address with access_ok() and then pass it
through to the 64-bit ioctl code.  I believe this approach may not
work on sparc64, but it does work on ppc64 and x86_64 at least.

One tricky area which may need to be revisited is the question of how
to handle the handles which we pass back to userspace to identify
mappings.  These handles are generated in the ADDMAP ioctl and then
passed in as the offset value to mmap.  However, offset values for
mmap seem to be generated in other ways as well, particularly for AGP
mappings.

The approach I have ended up with is to generate a fake 32-bit handle
only for _DRM_SHM mappings.  The handles for other mappings (AGP, REG,
FB) are physical addresses which are already limited to 32 bits, and
generating fake handles for them created all sorts of problems in the
mmap/nopage code.

This patch has been updated to use the new compatibility ioctls.

From: Paul Mackerras <paulus@samba.org>
Signed-off-by: Dave Airlie <airlied@linux.ie>

