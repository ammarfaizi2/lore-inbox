Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268003AbTCFJ4V>; Thu, 6 Mar 2003 04:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268004AbTCFJ4V>; Thu, 6 Mar 2003 04:56:21 -0500
Received: from comtv.ru ([217.10.32.4]:54659 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S268003AbTCFJ4U>;
	Thu, 6 Mar 2003 04:56:20 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm1
References: <20030305230712.5a0ec2d4.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 06 Mar 2003 13:00:30 +0300
In-Reply-To: <20030305230712.5a0ec2d4.akpm@digeo.com>
Message-ID: <m365qw3jcx.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As far as I understand this isn't error path. 

	lock_kernel();

	sb = inode->i_sb;

	if (is_dx(inode)) {
		err = ext3_dx_readdir(filp, dirent, filldir);
		if (err != ERR_BAD_DX_DIR)
			return err;
		/*
		 * We don't set the inode dirty flag since it's not
		 * critical that it get flushed back to the disk.
		 */
		EXT3_I(filp->f_dentry->d_inode)->i_flags &= ~EXT3_INDEX_FL;
	}

So, if ext3_dx_readdir() returns 0 (OK path), then ext3_readdir() finish
w/o unlock_kernel(). The remain part of ext3_readdir() gets used if
ext3_dx_readdir() can't use HTree and returns ERR_BAD_DX_DIR.

Am I miss something?

>>>>> Andrew Morton (AM) writes:

 AM> +htree-lock_kernel-fix.patch

 AM>  Missing unlock_kernel() on htree error path


