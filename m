Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751905AbWAOLpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbWAOLpl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 06:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWAOLpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 06:45:41 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:40142 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751905AbWAOLpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 06:45:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=HtWYp41Pc8se2NwmCyRKFkvHGQB4pF82BKqckjDH/FnxYSnzfDO/+dkF/WnZ+XztIal6oJUD8hzS56RYMrh5TLfvXYgJhPb7+SanLbYJ+66qDnlHXryNtTTMQ2oVSDEt+F9RuoBX+fbAt+Ykrzp6JskukonsFW7W2Ui+Pf3XtuU=
Date: Sun, 15 Jan 2006 15:02:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: stable@kernel.org
Cc: Evgeniy <dushistov@mail.ru>, linux-kernel@vger.kernel.org
Subject: [STABLE] Fix oops in ufs_fill_super at mount time
Message-ID: <20060115120252.GA13135@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy <dushistov@mail.ru>

There's a lack of parenthesis in fs/ufs/utils.h, so instead of the 512th
byte of buffer, the usb2 pointer will point to the nth structure of type
ufs_super_block_second.

This can cause a mount-time oops if you're unlucky (especially with
DEBUG_PAGEALLOC, which is how Alexey Dobriyan saw this problem)

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>
Acked-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -255,8 +255,8 @@ extern void _ubh_memcpyubh_(struct ufs_s
 	((struct ufs_super_block_first *)((ubh)->bh[0]->b_data))
 
 #define ubh_get_usb_second(ubh) \
-	((struct ufs_super_block_second *)(ubh)-> \
-	bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask))
+	((struct ufs_super_block_second *)((ubh)->\
+	bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask)))
 
 #define ubh_get_usb_third(ubh) \
 	((struct ufs_super_block_third *)((ubh)-> \

