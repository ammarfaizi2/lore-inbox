Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWBVNnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWBVNnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWBVNnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:43:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:20909 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751281AbWBVNnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:43:15 -0500
Date: Wed, 22 Feb 2006 07:42:50 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: rml@novell.com, arnd@arndb.de, ttb@tentacle.dhs.org, hch@lst.de,
       akpm@osdl.org
Subject: udevd is killing file write performance.
Message-ID: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a customer application which sees a significant performance
degradation when run with udevd running.  This appears to be due to:


void inotify_dentry_parent_queue_event(struct dentry *dentry, u32 mask,
                                       u32 cookie, const char *name)
{
...
        if (!atomic_read (&inotify_watches))
                return;

        spin_lock(&dentry->d_lock);

The particular application is a 512 thread application.  When run with
udevd turned off the application finishes in about 6 seconds.  With it
turned on, the appliction takes minutes (I think we timed it to around
22 minutes, but we have not been patient enough to wait it through to
the end in some time).  This is being run on a 512cpu system, but there
is a noticable performance hit on smaller systems as well.

As far as I can tell, the application has multiple threads writing
different portions of the same file, but the customer is still working
on providing a simplified test case.

I know _VERY_ little about filesystems.  udevd appears to be looking
at /etc/udev/rules.d.  This bumps inotify_watches to 1.  The file
being written is on an xfs filesystem mounted at a different mountpoint.
Could the inotify flag be moved from a global to a sb (or something
finer) point and therefore avoid taking the dentry->d_lock when there
is no possibility of a watch event being queued.

Thanks,
Robin Holt
