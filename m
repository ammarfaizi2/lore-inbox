Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUBOQiM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 11:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUBOQht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 11:37:49 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:44780 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S265094AbUBOQhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 11:37:46 -0500
Message-ID: <402FA076.7D6304C6@users.sourceforge.net>
Date: Sun, 15 Feb 2004 18:38:14 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net> <m265e9oyrs.fsf@tnuctip.rychter.com> <402F877C.C9B693C1@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> Jan Rychter wrote:
> > FWIW, I've just tried loop-AES with 2.4.24, after using cryptoapi for a
> > number of years. My machine froze dead in the midst of copying 2.8GB of
> > data onto my file-backed reiserfs encrypted loopback mount.
> >
> > Since the system didn't ever freeze on me before and since I've had zero
> > problems with cryptoapi, I attribute the freeze to loop-AES.
> >
> > Yes, I know this isn't a good bugreport...
> 
> Is there any particular reason why you insist on using file backed loops?
> 
> File backed loops have hard to fix re-entry problem: GFP_NOFS memory
> allocations that cause dirty pages to written out to file backed loop, will
> have to re-enter the file system anyway to complete the write. This causes
> deadlocks. Same deadlocks are there in mainline loop+cryptoloop combo.
> 
> This is one of the reasons why this is in loop-AES README: "If you can
> choose between device backed and file backed, choose device backed even if
> it means that you have to re-partition your disks."

A quick grep of potential deadlock points:

armas:/usr/src/linux-2.4.24/fs/reiserfs # grep -r GFP_NOFS *
dir.c:              local_buf = reiserfs_kmalloc(d_reclen, GFP_NOFS, inode->i_sb) ;
fix_node.c:         buf = reiserfs_kmalloc(size, GFP_NOFS, tb->tb_sb);
journal.c:  bn = reiserfs_kmalloc(sizeof(struct reiserfs_bitmap_node), GFP_NOFS, p_s_sb) ;
journal.c:  bn->data = reiserfs_kmalloc(p_s_sb->s_blocksize, GFP_NOFS, p_s_sb) ;
journal.c:  log_blocks = reiserfs_kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS, p_s_sb) ;
journal.c:  real_blocks = reiserfs_kmalloc(le32_to_cpu(desc->j_len) * sizeof(struct buffer_head *), GFP_NOFS, p_s_sb) ;
journal.c:  /* using GFP_NOFS, GFP_KERNEL could try to flush inodes, which will try
journal.c:  ct = reiserfs_kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_NOFS, p_s_sb) ;
namei.c:        buffer = reiserfs_kmalloc (buflen, GFP_NOFS, dir->i_sb);
namei.c:    name = reiserfs_kmalloc (item_len, GFP_NOFS, parent_dir->i_sb);
armas:/usr/src/linux-2.4.24/fs/reiserfs #

Many potential deadlock points there in reiserfs.

armas:/usr/src/linux-2.4.24/fs/ext2 # grep -r GFP_NOFS *
armas:/usr/src/linux-2.4.24/fs/ext2 #

File backed loop to a file on ext2 may work.

armas:/usr/src/linux-2.4.24/fs/ext3 # grep -r GFP_NOFS *
inode.c:        page = find_or_create_page(mapping, index, GFP_NOFS);
armas:/usr/src/linux-2.4.24/fs/ext3 #

Potential deadlock point there in ext3.

armas:/usr/src/linux-2.4.24/fs/nfs # grep -r GFP_NOFS *
armas:/usr/src/linux-2.4.24/fs/nfs # 

File backed loop to a file on nfs may work.

armas:/usr/src/linux-2.4.24/fs/smbfs # grep -r GFP_NOFS *
armas:/usr/src/linux-2.4.24/fs/smbfs #

File backed loop to a file on smbfs may work.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
