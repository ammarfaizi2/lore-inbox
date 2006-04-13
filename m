Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWDMIWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWDMIWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 04:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWDMIWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 04:22:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32911 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751152AbWDMIWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 04:22:04 -0400
Date: Thu, 13 Apr 2006 18:22:10 +1000
From: David Chinner <dgc@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: shrink_dcache_sb scalability problem.
Message-ID: <20060413082210.GM1484909@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

After recently upgrading a build machine to 2.6.16, we started
seeing 10-50s pauses where the machine would appear to hang.
Profiles showed that we were spending a substantial amount of time
in shrink_dcache_sb, and several CPUs were spinning on the
dcache_lock.

This is happening quite frequently - we recorded a 10 minute period
where there were 13 incidents where a touch/rm of a single file was
taking longer than 10s. The machine was close to unusable when this
happened.

At the time of the problem the machine had several million unused
cached dentries in memory (often > 10million), and the builds use
chroot environments with internally mounted filesystems like /proc
and /sys.

The problem is that whenever we mount /proc, /sys, /dev/pts, etc, we
call shrink_dcache_sb() which does multiple traversals across the
unused dentry list with the dcache_lock held.

It is trivial to reduce this to one traversal for the case of a new
mount. However, that doesn't solve the issue that we are walking a
linked list of many million entries with a global lock held and
holding out everyone else.

We're open to any suggestions on how to go about fixing this problem
as it's not obvious what the correct way to approach this problem
is. Any advice, patches, etc is more than welcome.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
