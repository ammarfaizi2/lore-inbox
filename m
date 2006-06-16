Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWFPXMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWFPXMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWFPXMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:12:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:6047 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751552AbWFPXMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:20 -0400
Subject: [RFC][PATCH 00/20] Mount writer count and read-only bind mounts (v2)
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:13 -0700
Message-Id: <20060616231213.D4C5D6AF@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

If this set goes OK, I think it is time for a trip through -mm.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
