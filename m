Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWJFLyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWJFLyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWJFLyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:54:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56998 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932204AbWJFLyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:54:53 -0400
Date: Fri, 6 Oct 2006 13:55:07 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 1/3] Fix IO error reporting on fsync()
Message-ID: <20061006115507.GD14533@atrey.karlin.mff.cuni.cz>
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When IO error happens during async write, we have to mark buffer as having IO
error too. Otherwise IO error reporting for filesystems like ext2 does not
work.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.18/fs/buffer.c linux-2.6.18-1-mark_error_buffer/fs/buffer.c
--- linux-2.6.18/fs/buffer.c	2006-09-27 13:08:34.000000000 +0200
+++ linux-2.6.18-1-mark_error_buffer/fs/buffer.c	2006-10-06 13:05:29.000000000 +0200
@@ -589,6 +589,7 @@ static void end_buffer_async_write(struc
 			       bdevname(bh->b_bdev, b));
 		}
 		set_bit(AS_EIO, &page->mapping->flags);
+		set_buffer_write_io_error(bh);
 		clear_buffer_uptodate(bh);
 		SetPageError(page);
 	}
