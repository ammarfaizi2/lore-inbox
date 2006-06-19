Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWFSPbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWFSPbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWFSPbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:31:09 -0400
Received: from thunk.org ([69.25.196.29]:6026 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932363AbWFSPbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:31:08 -0400
Message-Id: <20060619152003.830437000@candygram.thunk.org>
Date: Mon, 19 Jun 2006 11:20:03 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 0/8] Inode slimming
From: Theodore Tso <tytso@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches reduce the size of struct inode.  Unfortunately,
since these structures are used by a large amount of kernel code, some
of the patches are quite involved, and/or will require a lot of
auditing and code review, for "only" 4 or 8 bytes at a time (maybe
more on 64-bit platforms).  However, since there are many, many copies
of struct inode all over the kernel, even a small reduction in size
can have a large beneficial result, and as the old Chinese saying
goes, a journey of thousand miles begins with a single step....

What else remains to be done?  There are a large number of fields in
struct inode which are never populated unless the inode is open, and
those should get moved into another structure which is populated only
when needed.  There are a large number of inodes which are read into
memory only because stat(2) was called on them (thanks to things like
color ls, et. al).  

Linus has suggested moving the i_data structure out to a separate
structure, again because there are many inodes which do not have any
pages cached in the page cache.  The challenge with this a huge number
of codepaths assume that i_mapping is always non-NULL.  But, i_data is
*huge* so the benefits of not having it taking up memory would make
this a high-return activity.

Another possibility is moving i_size into the file-specific area of
the union, which would save 8 bytes.  However there are a largish
number block device drivers that seem to have hijacked i_size to store
the blocksize(!?!) of the device, and that should really be done in a
bdev-specific structure.  Untangling this will be somewhat
challenging, but should be doable.

--
