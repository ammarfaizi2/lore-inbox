Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbUKGCMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbUKGCMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 21:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUKGCMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 21:12:17 -0500
Received: from serio.al.rim.or.jp ([202.247.191.123]:32955 "EHLO
	serio.al.rim.or.jp") by vger.kernel.org with ESMTP id S261514AbUKGCMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 21:12:05 -0500
Message-ID: <418D8470.9070907@yk.rim.or.jp>
Date: Sun, 07 Nov 2004 11:12:00 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Chiaki <ishikawa@yk.rim.or.jp>
Subject: Re: Configuration system bug? : tmpfs listing in /proc/filesystems
 when TMPFS was not configured!?
References: <418D0EFB.2040002@yk.rim.or.jp> <418D7AF4.5090500@yk.rim.or.jp>
In-Reply-To: <418D7AF4.5090500@yk.rim.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(Now I am bcc:ing to Hugh Dickins hugh at veritas.com since
  his name was in filesystems/tmpfs.txt documentation file.)

I noticed that /proc/filesystems lists "tmpfs"
although I have not configured TMPFS during the kernel compilation.

I have somehow figured out where tmpfs is registered although
I have not configured it in .config.

(Kernel 2.6.9)

Please note that in mm/shmem.c, all the normal file operations
are ifdef'ed out when CONFI_TMPFS is not set.
(See shmem_dir_inode_operations initial value below.)
So file creation, etc. won't be supported.

However(!), regsiter_filesystem(&tmpfs_fs_type) line
Line 2057 in mm/shmem.c:
in init_tmpfs() is NOT ifdef'ed out.

Should not this line be ifdef'ed out???
That is, should we modify the line like this?

#ifdef CONFIG_TMPFS
	error = register_filesystem(&tmpfs_fs_type);
#endif

Chiaki

cf.
Here is the explanation for kernel mount operation we find
in init_tmpfs().

 From /usr/src/linux/Documentation/filesystems/tmpfs.txt

>tmpfs has the following uses:
>
>1) There is always a kernel internal mount which you will not see at
>   all. This is used for shared anonymous mappings and SYSV shared
>   memory. 
>
>   This mount does not depend on CONFIG_TMPFS. If CONFIG_TMPFS is not
>   set, the user visible part of tmpfs is not build. But the internal
>   mechanisms are always present.

I agree user visible part of tmpfs is not build when CONFIG_TMPFS is
not set, and thus tmpfs should not be registered.
Trying to use tmpfs (by creating files/directories) will fail
when CONFIG_TMPFS is not set. Thus useless and so /proc/filesystems
should not show tmpfs IMHO.
(Or not registering it interferes with the internal kernel mount
operation? [like not being able to find tmpfs function for internal
kernel mount operaton mentioned above??? We probably need to unregister it
in that case immediately after the internal mount succeeded. Maybe.]
]


References:

 From mm/shmem.c:


static struct inode_operations shmem_dir_inode_operations = {
#ifdef CONFIG_TMPFS
	.create		= shmem_create,
	.lookup		= simple_lookup,
	.link		= shmem_link,
	.unlink		= shmem_unlink,
	.symlink	= shmem_symlink,
	.mkdir		= shmem_mkdir,
	.rmdir		= shmem_rmdir,
	.mknod		= shmem_mknod,
	.rename		= shmem_rename,
#endif
};

static struct super_operations shmem_ops = {
	.alloc_inode	= shmem_alloc_inode,
	.destroy_inode	= shmem_destroy_inode,
#ifdef CONFIG_TMPFS
	.statfs		= shmem_statfs,
	.remount_fs	= shmem_remount_fs,
#endif
	.delete_inode	= shmem_delete_inode,
	.drop_inode	= generic_delete_inode,
	.put_super	= shmem_put_super,
};


Then later in init_tmpfs():

static int __init init_tmpfs(void)
{
	int error;

	error = init_inodecache();
	if (error)
		goto out3;

	error = register_filesystem(&tmpfs_fs_type);
	if (error) {
		printk(KERN_ERR "Could not register tmpfs\n");
		goto out2;
	}
#ifdef CONFIG_TMPFS
	devfs_mk_dir("shm");
#endif
	shm_mnt = do_kern_mount(tmpfs_fs_type.name, MS_NOUSER,
				tmpfs_fs_type.name, NULL);



I think the above register_filesystem() ought to be ifdef'ed out.


-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
