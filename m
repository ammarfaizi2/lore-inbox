Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWBAPwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWBAPwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWBAPwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:52:20 -0500
Received: from mx1.mail.ru ([194.67.23.121]:44895 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1422647AbWBAPwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:52:18 -0500
Date: Wed, 1 Feb 2006 18:40:20 +0300
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Mark CONFIG_UFS_FS_WRITE as BROKEN
Message-ID: <20060201154020.GA593@rain.homenetwork>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060131234634.GA13773@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131234634.GA13773@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 02:46:34AM +0300, Alexey Dobriyan wrote:
> OpenBSD doesn't see "." correctly in directories created by Linux.
The problem is in dir.c:ufs_make_empty, which create "." and ".."
entires, in this function i_size isn't updated, 
so result directory has zero size.
This patch should solve the problem, can you try it?

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

--- linux-2.6.16-rc1-mm4/fs/ufs/dir.c.orig	2006-02-01 18:29:28.943878250 +0300
+++ linux-2.6.16-rc1-mm4/fs/ufs/dir.c	2006-02-01 18:12:24.043826000 +0300
@@ -539,6 +539,7 @@ int ufs_make_empty(struct inode * inode,
 		return err;
 
 	inode->i_blocks = sb->s_blocksize / UFS_SECTOR_SIZE;
+	inode->i_size = sb->s_blocksize;
 	de = (struct ufs_dir_entry *) dir_block->b_data;
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);


-- 
/Evgeniy

