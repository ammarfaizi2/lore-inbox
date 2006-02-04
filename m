Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945969AbWBDBAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945969AbWBDBAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946223AbWBDBAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:00:09 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:25797 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946106AbWBDBAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:00:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TBIfdg7cNO+NyF98+2hUi44TYyXeuGetlW+uH44M0O3ApHUuEvYUDJFa/6GLFmKkkJ4qoQ2MgZ4h/LOy3zsf0ySoMbz5K1ddgBhYyx+58Ez95fGKPkZOioFaztBulz+NqRC9EJuVw+85SFqshNuREWjtbvnGBgpKRggNjJCQMMc=
Date: Sat, 4 Feb 2006 04:18:15 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH] ufs: fill i_size at directory creation
Message-ID: <20060204011815.GA7837@mipter.zuzino.mipt.ru>
References: <20060131234634.GA13773@mipter.zuzino.mipt.ru> <20060201200410.GA11747@rain.homenetwork> <20060203174613.GA7823@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203174613.GA7823@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 08:46:13PM +0300, Alexey Dobriyan wrote:
> Thanks, these two patches makes things better but not much better.
> 
> 1.
> 
>         inode->i_blocks = sb->s_blocksize / UFS_SECTOR_SIZE;
> +       inode->i_size = sb->s_blocksize;
>         de = (struct ufs_dir_entry *) dir_block->b_data;
> 
> This creates directories which are 2048 bytes in size. Native ones are
> 512 bytes.
> 
> 	inode->i_size = 512;
> 
> makes mkdir and rm reliable for me both on linux and OpenBSD.

I take "reliably" back.

	for i in $(seq 1 100); do mkdir $i; done

barfs after 42-nd.

How about this as a first small step?

[PATCH] ufs: fill i_size at directory creation

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -539,6 +539,7 @@ int ufs_make_empty(struct inode * inode,
 		return err;
 
 	inode->i_blocks = sb->s_blocksize / UFS_SECTOR_SIZE;
+	inode->i_size = UFS_SB(sb)->s_uspi->s_fsize;
 	de = (struct ufs_dir_entry *) dir_block->b_data;
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);

