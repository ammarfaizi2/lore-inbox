Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVCQRkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVCQRkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 12:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVCQRkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 12:40:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45466 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261844AbVCQRkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 12:40:11 -0500
Subject: e2fsprogs bug [was Re: ext2/3 file limits to avoid overflowing
	i_blocks]
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1111080221.2684.122.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1111080221.2684.122.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111081190.2684.135.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 17 Mar 2005 17:39:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-03-17 at 17:23, Stephen C. Tweedie wrote:

> I wrote a small program to calculate the total indirect tree overhead
> for any given file size, and 0x1ff7fffe000 turned out to be the largest
> file we can get without the total i_blocks overflowing 2^32.
> 
> But in testing, that *just* wrapped --- we need to limit the file to be
> one page smaller than that to deal with the possibility of an EA/ACL
> block being accounted against i_blocks.

On a side, issue, e2fsck was unable to find any problem on that
filesystem after the i_blocks had wrapped exactly to zero.

The bug seems to be in e2fsck/pass1.c: we do the numblocks checking
inside process_block(), which is called as an inode block iteration
function in check_blocks().  Then, later, check_blocks() does

	if (inode->i_file_acl && check_ext_attr(ctx, pctx, block_buf))
		pb.num_blocks++;

	pb.num_blocks *= (fs->blocksize / 512);

but without any further testing to see if pb.num_blocks has exceeded the
max_blocks.  So by the time we've got to the end of check_blocks(),
we're testing the wrapped i_blocks on disk against the wrapped
num_blocks in memory, and so e2fsck fails to notice anything wrong.

The fix may be as simple as just moving the

	if (inode->i_file_acl && check_ext_attr(ctx, pctx, block_buf))
		pb.num_blocks++;

earlier in the function; Ted, do you see any problems with that?

--Stephen

