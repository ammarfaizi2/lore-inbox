Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVKNV6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVKNV6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVKNVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:55:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751282AbVKNVzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:16 -0500
Date: Mon, 14 Nov 2005 21:54:37 GMT
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-Id: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches does four things:

 (1) Adds a generic intermediary (FS-Cache) by which filesystems may call on
     local caching capabilities, and by which local caching backends may make
     caches available:

	+---------+
	|         |                        +-----------+
	|   NFS   |--+                     |           |
	|         |  |                 +-->|  CacheFS  |
	+---------+  |   +----------+  |   | /dev/hda5 |
	             |   |          |  |   +-----------+
	+---------+  +-->|          |  |
	|         |      |          |--+   +-------------+
	|   AFS   |----->| FS-Cache |      |             |
	|         |      |          |----->| Cache Files |
	+---------+  +-->|          |      | /var/cache  |
	             |   |          |--+   +-------------+
	+---------+  |   +----------+  |
	|         |  |                 |   +-------------+
	|  ISOFS  |--+                 |   |             |
	|         |                    +-->| ReiserCache |
	+---------+                        | /           |
	                                   +-------------+

 (2) Adds a quasi-filesystem (CacheFS) that can turn block devices into a
     local caches.

 (3) Modifies the kAFS network filesystem to be able to read through this
     cache.

 (4) Documents the netfs interface and the cache backend interface.

Other backends may be added to the system, and other netfs's may be modified
to use caching.

There are a number of reasons why I'm not using i_mapping to do this. These
have been discussed a lot on the LKML and CacheFS mailing lists, but to
summarise the basics:

 (1) Most filesystems don't do hole reportage. Holes in files are treated as
     blocks of zeros and can't be distinguished otherwise, making it difficult
     to distinguish blocks that have been read from the network and cached from
     those that haven't.

 (2) The backing inode must be fully populated before being exposed
     to userspace through the main inode because the VM/VFS goes directly to
     the backing inode and does not interrogate the front inode on VM ops.

     Therefore:

     (a) The backing inode must fit entirely within the cache.

     (b) All backed files currently open must fit entirely within the cache at
     	 the same time.

     (c) A working set of files in total larger than the cache may not be
     	 cached.

     (d) A file may not grow larger than the available space in the cache.

     (e) A file that's open and cached, and remotely grows larger than the
     	 cache is potentially stuffed.

 (3) Writes go to the backing filesystem, and can only be transferred to the
     network when the file is closed.

 (4) There's no record of what changes have been made, so the whole file must
     be written back.

 (5) The pages belong to the backing filesystem, and all metadata associated
     with that page are relevant only to the backing filesystem, and not
     anything stacked atop it.

David
