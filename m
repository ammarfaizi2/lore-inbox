Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUDWVnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUDWVnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUDWVnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:43:51 -0400
Received: from [66.98.134.69] ([66.98.134.69]:14243 "EHLO
	us7.servers.haisoft.net") by vger.kernel.org with ESMTP
	id S261500AbUDWVnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:43:49 -0400
From: Alon Ziv <alonz@nolaviz.org>
To: linux-kernel@vger.kernel.org
Subject: Question: correctly detecting erased blocks in ext2/ext3
Date: Sat, 24 Apr 2004 00:39:25 +0300
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404240039.25380.alonz@nolaviz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to correct the integration of ext2/ext3 and the various flash-based
block devices (e.g. INFTL); these currently assume that any block that's
written containing all-zeros can just be deleted from the block maps, and a
read of a non-existent block just returns all zeros. This scheme is a bit
hackish, as well as highly sub-optimal since "real" file systems just erase
the blocks' bits in the blocks bitmap and don't bother to overwrite the old
contents.

So, I'd like to have a go at solving the real problem: detect when blocks are
_really_ erased, and transmit this information to the block device.

My first intuition was to add a new address_space_operations method, and call
it from (a helper of) truncate_inode_pages.  However, this works only for in-
core pages, and completely fails to handle pages that are just on disk and
metadata pages.  So I have to strike this one off.

So my current idea is to just define a new kind of request (DELETE), and
provide a function that takes a bh and submits a DELETE operation for its
associated blocks.  I'll also probably want a wrapper that does the same
given a super_block structure.  The new operation will be ignored by existing
(non-flash) block devices, and will DTRT on flash block devices.

I'll also want to change the file-system code to correctly produce this new
request -- in ext2, I believe it's a simple change to ext2_free_blocks(); in
ext3, I'm far less certain of the correct place, as I should probably wait for
a checkpoint to occur, so the DELETE requests will have to be buffered for
jbd... Sigh, it gets _so_ complicated :-(

Not to mention that some file systems (e.g. JFS) are completely pagecache
based, and if more file systems move in this direction, I'll need a completely
new method for sending this request (and I haven't got a clue of where to put
it).

So, my question(s) to the gurus: does my idea sound right, or am I thoroughly
out?  And -- anyone got some smart idea on how to integrate this beast with
ext3?

Thanks in advance,
	-Alon Ziv
