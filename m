Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWDAAIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWDAAIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 19:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWDAAIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 19:08:17 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:48590 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751412AbWDAAIR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 19:08:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FuKF411j11BnO5GzZe3GdGuBRZdcOl+DRZkGZszjz+rgmZGW5erFWubbj7UtsGl6KqV1FlbjfgO6rcc5idanojYLvqao80xtK/dAkS5IU+WB/aWK7MP4HywBE7iCteZpALK5AYazGuvIgjYrhc0oBbOV5vnkkZIwqSwMFaYhxLQ=
Message-ID: <bda6d13a0603311608p5b74df13i259c2b9efa539330@mail.gmail.com>
Date: Fri, 31 Mar 2006 16:08:16 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: RFC replace some locking of i_sem wiht atomic_t
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This might be a way to decrease complexity of locking in vfs.

Basic idea: for local filesystems, i_sem gets taken on several objects
only to protect i_nlink.
These can be removed if i_nlink is atomic.

For network filesystems, no amount of locking would ensure atomic
operations anyway, so
probably no loss there.

inode operations would then lock:
 lookup:   parent
 create:   parent
 link:       both parents
 mknod:   parent
 symlink:  parent
 mkdir:     parent
 unlink:    parent
 rmdir:     parent
 truncate: item
 rename:  both parents

A new per-superblock semaphore vfs_link_sem would be created, to be taken
first on both link and rename, dropped as soon as all other locks are taken.
This prevents deadlocks in pathelogical cases. vfs_rename_sem is still needed
(taken after vfs_link_sem) to prevent cycles from being created.

Grabbing the target on link doesn't do much for most filesystems
because the operation
is (or should be) syncronized by the page lock for each directory
pages. If this change
is made, it is possible to remove this locking from all the filesystems.

Note that locking of source or target is no longer necessary. Except
for i_nlink, nothing
can change the source or target anyway.

Comment as you will. I am competent to write this if it is wanted. I
expect however
that I will be flamed to ashes for this suggestion.
