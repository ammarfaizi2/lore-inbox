Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWCBRBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWCBRBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWCBRBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:01:42 -0500
Received: from mail.suse.de ([195.135.220.2]:1171 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751605AbWCBRBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:01:41 -0500
From: Chris Mason <mason@suse.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: o_sync in vfat driver
Date: Thu, 2 Mar 2006 12:01:31 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
References: <op.s5lrw0hrj68xd1@mail.piments.com> <200603020845.10083.mason@suse.com> <87u0ahszxa.fsf@duaron.myhome.or.jp>
In-Reply-To: <87u0ahszxa.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021201.32653.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 09:07, OGAWA Hirofumi wrote:
> Chris Mason <mason@suse.com> writes:
> > filemap_fdatawrite() won't redirty the page.  It will wait on the pending
> > writeback.
>
> Umm... I'm looking the following code.
>
> +void
> +writeback_bdev(struct super_block *sb)
> +{
> +	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
> +	filemap_flush(mapping);
> +	blk_run_address_space(mapping);
> +}
> +EXPORT_SYMBOL_GPL(writeback_bdev);
>
> filemap_flush() is using WB_SYNC_NONE.
>
Ok, I thought you were asking about the code that called filemap_fdatawrite, 
which does wait.  filemap_flush is used on the underlying block device.  In 
the case of a page that is already under IO, the io is not cancelled but 
allowed to continue.

This is the desired result.  When you're doing a number of operations in 
sequence, each operation will start io on the block device.  If they used 
filemap_fdatawrite instead of filemap_flush, they would end up being 
synchronous.

-chris

