Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUDSUjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUDSUjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:39:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262031AbUDSUjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:39:07 -0400
Subject: [RFT] Ext3 online resize for 2.6.6-rc1
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1082407133.2237.87.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2004 21:38:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just to add to the recent storm of ext3 patches: the patch below is
essentially just Arjan's last port of Andreas's last ext3-online-resize
patch to 2.6.6-rc1.  I've cleaned up only a couple of error cases
(brelse in the wrong place on an error path, EPERM instead of EACCES on
!capable(CAP_SYS_RESOURCE).)

The bigger job was e2fsprogs --- the resize diffs conflict with the
recent metadata-group work, but there's a merged patch against
e2fsprogs-1.35 now under "patches" at
http://sourceforge.net/projects/ext2resize/

direct link:
http://sourceforge.net/tracker/download.php?group_id=3834&atid=303834&file_id=84253&aid=937934

Note that ext2prepare still doesn't deal with the new reserved-space
format: you need to create a new filesystem with "mke2fs -O
resize_inode" in order to test the patch.  Getting the ext2resize user
space tools updated for that is the next job.

I'll do a proper 1.1.19 release of sourceforge ext2resize once I work
out just how the sourceforge CVS tree needs to be put together. 
Andreas, is it really deliberate that you've got both the input and
output autoconf files (eg. Makefile and Makefile.in) under CVS control
for ext2resize?

I've been giving this moderate testing so far and it has been surviving
fine doing resizes under load and fscking after.  The patched e2fsprogs
knows enough about the EXT2_RESIZE_INO reserved growth inode to avoid
complaining about it during a fsck, but doesn't yet know enough to fully
verify the contents of that inode or to repair it.  Other than that, the
only problem I've seen so far under testing is that occasionally a fsck
shows a minor refcount/block-bitmap inconsistency after a resize if we
encountered ENOSPC during the test, but I can reproduce that even
without resize so it seems like a core error-handling problem --- I'm
currently chasing that.  (Seems to be related either to xattr or 1k
blocksize.)

Cheers,
 Stephen
