Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVGMSwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVGMSwC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVGMStw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:49:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:9353 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262370AbVGMSra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:47:30 -0400
Subject: supporting functions missing from inotify patch
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org, rml@novell.com
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1121280212.5544.46.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Jul 2005 13:43:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like a couple of exports and a key supporting function are
missing from the inotify patch that went into mainline yesterday.

I don't see an inode operation for registering inotify events in the fs
(there is a file operation for dir_notify to register its events).  In
create_watch in fs/inotify.c I expected to see something like:

if(inode->inotify_create)
	ret = inode->inotify_create(inode, mask);

(a similar change would be needed in the INOTIFY_IGNORE path)

Without this, inotify will be broken except on local filesystems.
Cluster and network filesystems (nfs, cifs etc.) won't know when they
need to start calling back on remote directory change notifications if
they aren't called at the time of the ioctl(INOTIFY_WATCH)

I also don't see exports for 
	fsnotify_access
	fsnotify_modify

Without these exports, network and cluster filesystems can't notify the
local system about changes.

Tracking local changes to files/directories is somewhat useful by itself
on non-networked systems.  But if directory and file change notification
for remote/cluster filesystems is broken that limits its usefullness a
lot.

