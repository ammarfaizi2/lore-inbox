Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWJJMNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWJJMNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWJJMNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:13:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59032 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965146AbWJJMNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:13:10 -0400
Date: Tue, 10 Oct 2006 14:12:50 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jack@suse.cz
Subject: [PATCH 0/2] Fix IO error reporting on fsync() (2nd try)
Message-ID: <20061010121250.GG23622@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  Andrew felt the changes were too complex and increasing the size of
inodes too much. Here comes a new version of the patches

Current code in buffer.c has two pitfalls that cause problems with IO
error reporting of filesystems using mapping->private_list for their
metadata buffers (e.g. ext2).
  The first problem is that end_io_async_write() does not mark IO error
in the buffer flags, only in the page flags. Hence fsync_buffers_list()
does not find out that some IO error has occured and will not report it.
  The second problem is that buffers from private_list can be freed
(e.g. under memory pressure) and if fsync_buffer_list() is called after
that moment, IO error is lost - note that metadata buffers mark AS_EIO
on the *device mapping* not on the inode mapping.
  Following series of two patches tries to fix these problems. It adds a
pointer to each buffer head that point to the associated mapping in case
the buffer head is in the private_list. If a buffer is removed from
private_list, the IO error is transferred from a buffer to the
corresponding associated mapping.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
