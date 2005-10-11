Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVJKV0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVJKV0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVJKV0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:26:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750952AbVJKV0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:26:45 -0400
Date: Tue, 11 Oct 2005 14:26:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH
 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime))
Message-Id: <20051011142608.6ff3ca58.akpm@osdl.org>
In-Reply-To: <433C25D9.9090602@sm.sony.co.jp>
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp>
	<433C25D9.9090602@sm.sony.co.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Machida, Hiroyuki" <machida@sm.sony.co.jp> wrote:
>
> This patch adds inode-sync after attribute changes, if needed.
> 
> * fs-sync-attr.patch for 2.6.13
> 
>  fs/fs-writeback.c      |   19 +++++++++++++++++++
>  fs/open.c              |   12 ++++++++++++
>  include/linux/fs.h     |    1 +
>  4 files changed, 32 insertions(+)
> 
> Signed-off-by: Hiroyuki Machida <machdia@sm.sony.co.jp>
> 
> --- linux-2.6.13/fs/fs-writeback.c	2005-08-29 08:41:01.000000000 +0900
> +++ linux-2.6.13-sync-attr/fs/fs-writeback.c	2005-09-29 12:56:21.052335295 +0900
> @@ -593,6 +593,25 @@ int sync_inode(struct inode *inode, stru
>  EXPORT_SYMBOL(sync_inode);
>  
>  /**
> + * sync_inode_wodata - sync(write and wait) inode to disk, without it's data.
> + * @inode: the inode to sync
> + *
> + * sync_inode_wodata() will write an inode  then wait.  It will also
> + * correctly update the inode on its superblock's dirty inode lists 
> + * and will update inode->i_state.
> + *
> + * The caller must have a ref on the inode.
> + */
> +int sync_inode_wodata(struct inode *inode)
> +{
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL, /* wait */
> +		.nr_to_write = 0,/* no data to be written */
> +	};
> +	return sync_inode(inode, &wbc);
> +}
> +

I think this function duplicates write_inode_now()?
