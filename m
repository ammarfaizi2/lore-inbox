Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUA3SPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUA3SPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:15:43 -0500
Received: from intra.cyclades.com ([64.186.161.6]:60852 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263101AbUA3SPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:15:15 -0500
Date: Fri, 30 Jan 2004 16:13:27 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, sct@redhat.com
Subject: Re: [PATCH/BUGFIX] ext2: update inode ctime on rename()
In-Reply-To: <04Jan21.180629est.3970@ugw.utcc.utoronto.ca>
Message-ID: <Pine.LNX.4.58L.0401301609480.1840@logos.cnet>
References: <04Jan21.180629est.3970@ugw.utcc.utoronto.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

It seems correct to update the "old_inode" inode ctime on rename().

The "mark_inode_dirty(old_inode)" in your patch does not seem to be
necessary because ext2_dec_count() will do it.

2.6 also does not update the ctime on rename() AFAICS. Lets get it fixed
there first.

Andrew, viro, anyone?

On Wed, 21 Jan 2004, Chris Siebenmann wrote:

>  Ext2 in 2.2.13+ updates the ctime of an inode on rename(), but this fix
> didn't make it into 2.4. Other filesystems (including ext3) do update
> inode ctime on rename in 2.4, and failure to do so makes various backup
> tools skip backing up renamed files during incremental backups. Here is
> the very simple patch to fix this.
>
>  My earlier message to linux-kernel and ext2-devel has a longer
> discussion of the situation; you can find it at
> 	http://www.ussg.iu.edu/hypermail/linux/kernel/0401.1/0594.html
> (Or with the original subject in a local archive of linux-kernel).
> It hasn't gotten any replies, which may or may not be a good sign.
>
>  Because I feel that not capturing renamed files in incremental
> backups is a fairly severe issue, I urge you to apply this patch
> to 2.4. It's run here on several systems for quite a while without
> apparent problems.
>
> ===== fs/ext2/namei.c 1.3 vs edited =====
> --- 1.3/fs/ext2/namei.c	Tue Feb  5 02:41:03 2002
> +++ edited/fs/ext2/namei.c	Wed Dec 10 17:13:30 2003
> @@ -313,6 +313,13 @@
>  			ext2_inc_count(new_dir);
>  	}
>
> +	/*
> +	 * Like most other Unix systems, set the ctime for inodes on a
> +	 * rename.
> +	 */
> +	old_inode->i_ctime = CURRENT_TIME;
> +	mark_inode_dirty(old_inode);		/* still necessary? */
> +
>  	ext2_delete_entry (old_de, old_page);
>  	ext2_dec_count(old_inode);
>
