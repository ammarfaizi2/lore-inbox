Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVANAC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVANAC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVAMX7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:59:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25236 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261821AbVAMX4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:56:47 -0500
Date: Thu, 13 Jan 2005 15:56:45 -0800
From: John Hawkes <hawkes@tomahawk.engr.sgi.com>
Message-Id: <200501132356.j0DNujUY016224@tomahawk.engr.sgi.com>
To: linux-kernel@vger.kernel.org, rml@novell.com
Subject: 2.6.10-mm3 scaling problem with inotify
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I've encountered a scaling problem with the inotify code in
2.6.10-mm3.

vfs_read() and vfs_write() (for example) do:
    dnotify_parent(dentry, DN_ACCESS);
    inotify_dentry_parent_queue_event(dentry,
                           IN_ACCESS, 0, dentry->d_name.name);
    inotify_inode_queue_event(inode, IN_ACCESS, 0, NULL);
for the optional "notify" functionality.

dnotify_parent() knows how to exit quickly:
       if (!dir_notify_enable)
                return;
looking at a global flag, and inotify_inode_queue_event() also knows a quick
exit:
        if (!inode->inotify_data)
                return;
However, inotify_dentry_parent_queue_event() first has to get the parent 
dentry:
        parent = dget_parent(dentry);
        inotify_inode_queue_event(parent->d_inode, mask, cookie, filename);
        dput(parent);
and, sadly, dget_parent(dentry) grabs a spinlock (dentry->d_lock) and dirties a cacheline (dentry->dcount).  I have an AIM7-like workload that does numerous
concurrent reads and suffers a 40% drop in performance because of this,
primarily due to spinlock contention.

Is it possible for a parent's inode->inotify_data to be enabled when none of 
its children's inotify_data are enabled?  That would make it easy - just look 
at the current inode's inotify_data before walking back to the parent.

John Hawkes
