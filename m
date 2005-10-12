Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVJLEQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVJLEQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 00:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVJLEQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 00:16:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14269 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932402AbVJLEQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 00:16:47 -0400
Date: Tue, 11 Oct 2005 21:16:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: machida@sm.sony.co.jp, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH
 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime))
Message-Id: <20051011211601.72a0f91c.akpm@osdl.org>
In-Reply-To: <87r7armlgz.fsf@ibmpc.myhome.or.jp>
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp>
	<433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
	<87r7armlgz.fsf@ibmpc.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> >>  /**
> >> + * sync_inode_wodata - sync(write and wait) inode to disk, without it's data.
> >> + * @inode: the inode to sync
> >> + *
> >> + * sync_inode_wodata() will write an inode  then wait.  It will also
> >> + * correctly update the inode on its superblock's dirty inode lists 
> >> + * and will update inode->i_state.
> >> + *
> >> + * The caller must have a ref on the inode.
> >> + */
> >> +int sync_inode_wodata(struct inode *inode)
> >> +{
> >> +	struct writeback_control wbc = {
> >> +		.sync_mode = WB_SYNC_ALL, /* wait */
> >> +		.nr_to_write = 0,/* no data to be written */
> >> +	};
> >> +	return sync_inode(inode, &wbc);
> >> +}
> >> +
> >
> > I think this function duplicates write_inode_now()?
> 
> write_inode_now() seems to write data pages, but this doesn't write
> (.nr_to_write = 0).

hm, OK.

However there's not much point in writing a brand-new function when
write_inode_now() almost does the right thing.  We can share the
implementation within fs-writeback.c.

<looks>

Isn't write_inode_now() buggy?  If !mapping_cap_writeback_dirty() we
should still write the inode itself?



diff -puN fs/fs-writeback.c~write_inode_now-write-inode-if-not-bdi_cap_no_writeback fs/fs-writeback.c
--- devel/fs/fs-writeback.c~write_inode_now-write-inode-if-not-bdi_cap_no_writeback	2005-10-11 21:13:25.000000000 -0700
+++ devel-akpm/fs/fs-writeback.c	2005-10-11 21:13:40.000000000 -0700
@@ -558,7 +558,7 @@ int write_inode_now(struct inode *inode,
 	};
 
 	if (!mapping_cap_writeback_dirty(inode->i_mapping))
-		return 0;
+		wbc.nr_to_write = 0;
 
 	might_sleep();
 	spin_lock(&inode_lock);
_

