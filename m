Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWCBOHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWCBOHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 09:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWCBOHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 09:07:42 -0500
Received: from mail.parknet.jp ([210.171.160.80]:51210 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751252AbWCBOHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 09:07:41 -0500
X-AuthUser: hirofumi@parknet.jp
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
References: <op.s5lrw0hrj68xd1@mail.piments.com>
	<200603011023.38229.mason@suse.com>
	<87mzg9wst0.fsf@duaron.myhome.or.jp>
	<200603020845.10083.mason@suse.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 02 Mar 2006 23:07:29 +0900
In-Reply-To: <200603020845.10083.mason@suse.com> (Chris Mason's message of "Thu, 2 Mar 2006 08:45:08 -0500")
Message-ID: <87u0ahszxa.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:

> filemap_fdatawrite() won't redirty the page.  It will wait on the pending 
> writeback.

Umm... I'm looking the following code.

+	if (MSDOS_SB(sb)->options.flush) {
+		writeback_inode(dir);
+		writeback_inode(inode);
+		writeback_bdev(sb);
+	}

+void
+writeback_bdev(struct super_block *sb)
+{
+	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	filemap_flush(mapping);
+	blk_run_address_space(mapping);
+}
+EXPORT_SYMBOL_GPL(writeback_bdev);

filemap_flush() is using WB_SYNC_NONE.

in mpage_writepages()
			if (wbc->sync_mode != WB_SYNC_NONE)
				wait_on_page_writeback(page);

			if (PageWriteback(page) ||
					!clear_page_dirty_for_io(page)) {
				unlock_page(page);
				continue;
			}

Where does wait it?
--
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
