Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313796AbSDIC5i>; Mon, 8 Apr 2002 22:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313802AbSDIC5h>; Mon, 8 Apr 2002 22:57:37 -0400
Received: from smtp.polyu.edu.hk ([158.132.14.103]:55304 "EHLO
	hkpa04.polyu.edu.hk") by vger.kernel.org with ESMTP
	id <S313796AbSDIC5g>; Mon, 8 Apr 2002 22:57:36 -0400
Message-ID: <000e01c1df72$554007d0$ccd7fea9@winxp>
From: "Anthony Chee" <anthony.chee@polyu.edu.hk>
To: <linux-kernel@vger.kernel.org>
Subject: Question about deleting inode / drop inode
Date: Tue, 9 Apr 2002 10:57:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made some modification inode.c for my purpose. I defined myfunc() for my
own use

I modified write_inode as following. My purpose is to use a function to
determine such inode should pass to lower to lower file system (ext2, vfat,
etc) for writing on disk.

static inline void write_inode(struct inode *inode, int sync)
{
    if (myfunc() == 0) {
              if (inode->i_sb && inode->i_sb->s_op &&
inode->i_sb->s_op->write_inode && !is_bad_inode inode)) {
                    inode->i_sb->s_op->write_inode(inode, sync);

  } else {
            if (inode->i_sb && inode->i_sb->s_op &&
inode->i_sb->s_op->write_inode && !is_bad_inode(inode)) {
                    inode->i_sb->s_op->write_inode(inode, sync);
            die(inode);
  }
 }
}

static inline void die(inode) {
    iput(inode);
}

I used iput(inode) in this case. Is it right? I supposed the inode will
immediatly deleted after written on disk, and release the block used. But I
found that I still can see such file when I press "ls". I also tried to add
inode->i_nlink = 0 and atomic_set(&inode->i_count, 0) in die(inode) function
before iput(inode), but not success. It may also have input/output error on
that file after I reboot system and "ls".

Or any method to drop the inode (do not pass to lower file system layer,
just delete it in VFS layer) when myfunc() != 0?

Any one can give suggestion on it? Thanks for help. :D


