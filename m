Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131162AbQKXOTa>; Fri, 24 Nov 2000 09:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131121AbQKXOTX>; Fri, 24 Nov 2000 09:19:23 -0500
Received: from univ.uniyar.ac.ru ([193.233.51.120]:54438 "EHLO
        univ.uniyar.ac.ru") by vger.kernel.org with ESMTP
        id <S131162AbQKXOCa>; Fri, 24 Nov 2000 09:02:30 -0500
Date: Fri, 24 Nov 2000 16:32:26 +0300 (MSK)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: linux-kernel@vger.kernel.org, andy@lysaker.kvaerner.no
Subject: Kernel Oops on locking sockets via fcntl()
Message-ID: <Pine.GSO.3.96.SK.1001124163030.25896C-100000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

One fine day accidentally I have opened an Xserver's socket placed in /tmp
with my favourite text editor "le". I have got a message from the kernel similar
to this:

Unable to handle kernel NULL pointer dereference at virtual address 00000038
current->tss.cr3 = 0336f000, %cr3 = 0336f000
*pde = 0336d067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012d49f>]
EFLAGS: 00010202
... and so on.

I couldn't leave it aside. And I started to debug the Kernel by inserting printk
(it's my favourite method of kernel debugging :). Finally I found out the place
where the "Oops" has occurred. It is in function fcntl_setlk() which is placed
in the file linux/fs/locks.c. Here is a piece of code from this function:
        -----------------------------------------------------------
        struct file *filp;
        ...
        if (filp->f_op->lock != NULL) {  /* Oooops!!! */
                error = filp->f_op->lock(filp, cmd, &file_lock);
                if (error < 0)
                        goto out_putf;
        }
        error = posix_lock_file(filp, &file_lock, cmd == F_SETLKW);
        -----------------------------------------------------------
As you may see the first "if" statement checks if "filp->f_op->lock" is equal
to "NULL". But in the case of sockets "filp->f_op" is equal to "NULL"!
The "filp->f_op" is the pointer to "file_operations" structure which contains
pointers to functions operating with this type of file.

This problem can be fixed in several ways:
1) We must check EVERYWHERE if "filp->f_op" is equal to "NULL" (inserting this
   check to fcntl_setlk() is not enough since you will get an "Oops" when you
   will try to unlock the socket).
2) We make certain the "filp->f_op" is not equal to "NULL". Thoughts about it
   is described below.
3) Both 1) and 2).
4) Something else.

By the way can we lock a sockets or a pipes or another special files? Or maybe
the function should return an error in case of special files? The answer to this
question depends on the concepts of the Linux Kernel.

It seems what there are no problems with flock() but does is actually locks the
sockets?

Now some words about "filp->f_op". In many functions deal with files and inodes
we may see peace of code like this (linux/fs/ext2/inode.c):
        -----------------------------------------------------
        inode->i_op = NULL;
        if (inode->i_ino == EXT2_ACL_IDX_INO ||
            inode->i_ino == EXT2_ACL_DATA_INO)
                /* Nothing to do */ ;
        else if (S_ISREG(inode->i_mode))
                inode->i_op = &ext2_file_inode_operations;
        else if (S_ISDIR(inode->i_mode))
                inode->i_op = &ext2_dir_inode_operations;
        else if (S_ISLNK(inode->i_mode))
                inode->i_op = &ext2_symlink_inode_operations;
        else if (S_ISCHR(inode->i_mode))
                inode->i_op = &chrdev_inode_operations;
        else if (S_ISBLK(inode->i_mode))
                inode->i_op = &blkdev_inode_operations;
        else if (S_ISFIFO(inode->i_mode))
                init_fifo(inode);
        -----------------------------------------------------
What about "else if (S_ISSOCK(inode->i_mode)) ..."? Since there is no "S_ISSOCK"
the "inode->i_op" is still equal to "NULL" by default. Is it normal or we just
forgot about the sockets? Since the EXT2 is not the only one file system which
can contain a sockets I have found similar code in the following files:
    linux/fs/coda/cnode.c
    linux/fs/isofs/inode.c
    linux/fs/nfs/inode.c
    linux/fs/umsdos/inode.c
    linux/fs/ext2/inode.c
    linux/fs/ext2/namei.c
    linux/fs/minix/inode.c
    linux/fs/minix/namei.c
    linux/fs/sysv/inode.c
    linux/fs/sysv/namei.c
    linux/fs/ufs/inode.c
    linux/fs/ufs/namei.c

And everywhere "S_ISSOCK()" is absent. Is it normal?

Also I have found "struct file_operations socket_file_ops" structure definition
in the file "linux/net/socket.c". Should we use this structure?

That's all. Awaiting your suggestions.

P.S. Since I'm not currently subscribed to Linux Kernel Mailing List please Cc:
all replies also to bsg@uniyar.ac.ru if any.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
