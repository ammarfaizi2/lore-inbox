Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271219AbRHOPFG>; Wed, 15 Aug 2001 11:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271218AbRHOPEz>; Wed, 15 Aug 2001 11:04:55 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:49931 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S271216AbRHOPEl>; Wed, 15 Aug 2001 11:04:41 -0400
To: linux-kernel@vger.kernel.org
Subject: the problem of dentry cache handling on vfat
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 16 Aug 2001 00:04:47 +0900
Message-ID: <87y9oll5yo.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the problem of vfat, it miss handling the dentry cache.
This problem reproduce by the following operations.

------------------------------------------------------------
    root@devron (/)[503]# mount -t vfat /dev/hda2 /mnt/
    root@devron (/)[505]# touch /mnt/File.Txt
    root@devron (/)[506]# ls /mnt/
    File.Txt
    root@devron (/)[507]# umount /mnt/
    root@devron (/)[508]# mount -t vfat /dev/hda2 /mnt/
    root@devron (/)[509]# rm -f /mnt/File.Txt 
    root@devron (/)[510]# touch /mnt/file.txt
    root@devron (/)[511]# ls /mnt/
    File.Txt
    root@devron (/)[512]# 
------------------------------------------------------------

The above created `File.Txt', although creating `file.txt'.
This problem hit the dentry cache, and vfat create the file by old
filename.

Umm, How should this problem be solved?
IMHO, the following. 

   a) delete the negative dentry cache

        static struct dentry_operations vfat_relaxed_dentry_ops = {
        	d_hash:		vfat_hashi,
        	d_compare:	vfat_cmpi,
        	d_delete:	vfat_dentry_delete,
        };
        static int vfat_dentry_delete(struct dentry *dentry)
        {
        	PRINTK1(("vfat_dentry_delete: %s, %p\n",
        		 dentry->d_name.name, dentry->d_inode));
        	if (dentry->d_inode != NULL)
        		return 0;
        
        	return 1;
        }

    b) add d_revalidate to all dentry cache

        static struct dentry_operations vfat_dentry_ops = {
        	d_revalidate:	vfat_revalidate,
        	d_hash:		vfat_hashi,
        	d_compare:	vfat_cmpi,
        };
        struct dentry *vfat_lookup(struct inode *dir,struct dentry *dentry)
        {
		inode = NULL;
		res = vfat_find(dir,&dentry->d_name,&sinfo,&bh,&de);
        	if (res < 0)
        		goto error;
        
        	...
        
        error:
        	dentry->d_op = dir->i_sb->s_root->d_op;
        	dentry->d_time = dentry->d_parent->d_inode->i_version;
        	d_add(dentry,inode);
        	return NULL;
        }

    c) other??


I don't know what is good. Please advise.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

