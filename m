Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262623AbREZJZ1>; Sat, 26 May 2001 05:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbREZJZR>; Sat, 26 May 2001 05:25:17 -0400
Received: from t2.redhat.com ([199.183.24.243]:47613 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262623AbREZJZL>; Sat, 26 May 2001 05:25:11 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010525044008.14212.qmail@nwcst284.netaddress.usa.net> 
In-Reply-To: <20010525044008.14212.qmail@nwcst284.netaddress.usa.net> 
To: Blesson Paul <blessonpaul@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Re: How to add ntfs support] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 May 2001 10:25:01 +0100
Message-ID: <23383.990869101@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


blessonpaul@usa.net said:
>               So you are constructing a improved NTFS file driver. So
> when you have to check your written codes of file driver, will u
> recompile the whole kernel ? . That is what I am asking. I am in a way
> to build a new file system.

In general, it is not necessary to rebuild the kernel when you enable and
compile (or indeed write) a new module.

Places where the code in the kernel itself actually depends on the value of
CONFIG_blah_MODULE are thankfully relatively rare, although this ugliness
does happen at times. The filesystem code is fairly sane in this respect,
though, so you shouldn't have problems.

The main thing you have to watch when loading a new filesystem is the size 
of the inode and superblock unions. If you are adding your 
shinynewfs_inode_info to the inode union, and it's _larger_ than the 
previous size of the inode union, then you would have to recompile the 
kernel (or allocate it separately, which you're probably going to have to 
do in 2.5 anyway).

Note that this isn't particularly likely to be a problem - the inode union
has space for _all_ the filesystems, not just the ones you said 'y' or 'm'
to, and some of them are quite large. But it's worth checking.

Most of the JFFS2 development was done without recompiling kernels. I 
didn't even touch the kernel build tree - just
	make -C /usr/src/linux SUBDIRS=`pwd` modules

For safety, I put the following in the module init routine during development:

#ifdef JFFS2_OUT_OF_KERNEL
        /* sanity checks. Could we do these at compile time? */
        if (sizeof(struct jffs2_sb_info) > sizeof (((struct super_block *)NULL)->u)) {
                printk(KERN_ERR "JFFS2 error: struct jffs2_sb_info (%d bytes) doesn't fit in the super_block union (%d bytes)\n", 
                       sizeof(struct jffs2_sb_info), sizeof (((struct super_block *)NULL)->u));
                return -EIO;
        }

        if (sizeof(struct jffs2_inode_info) > sizeof (((struct inode *)NULL)->u)) {
                printk(KERN_ERR "JFFS2 error: struct jffs2_inode_info (%d bytes) doesn't fit in the inode union (%d bytes)\n", 
                       sizeof(struct jffs2_inode_info), sizeof (((struct inode *)NULL)->u));
                return -EIO;
        }
#endif


--
dwmw2


