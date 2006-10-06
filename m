Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWJFLte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWJFLte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWJFLte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:49:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57765 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932193AbWJFLtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:49:33 -0400
Date: Fri, 6 Oct 2006 13:49:47 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jack@suse.cz
Subject: [PATCH 0/3] Fix IO error reporting on fsync()
Message-ID: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  current code in buffer.c has two pitfalls that cause problems with IO
error reporting of filesystems using mapping->private_list for their
metadata buffers (e.g. ext2).
  The first problem is that end_io_async_write() does not mark IO error
in the buffer flags, only in the page flags. Hence fsync_buffers_list()
does not find out that some IO error has occured and will not report it.
  The second problem is that buffers from private_list can be freed
(e.g. under memory pressure) and if fsync_buffer_list() is called after
that moment, IO error is lost - note that metadata buffers mark AS_EIO
on the *device mapping* not on the inode mapping.
  Following series of three patches tries to fix these problems. The
approach I took (after some discussions with Andrew) is introducing
dummy buffer_head in the mapping instead of private_list. This dummy
buffer head serves as a head of metadata buffer list and also collects
IO errors from other buffers on the list (see the third patch for more
details). This is kind of compromise between introducing a pointer to
inode's address_space into each buffer and between using list_head
instead of buffer_head and playing some dirty tricks to recognize that
one particular list_head is actually from address_space and not from
buffer_head. Any suggestions for improvements welcome.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
