Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276828AbRJMKS0>; Sat, 13 Oct 2001 06:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276832AbRJMKSQ>; Sat, 13 Oct 2001 06:18:16 -0400
Received: from siaar2ab.compuserve.com ([149.174.40.138]:61868 "EHLO
	siaar2ab.compuserve.com") by vger.kernel.org with ESMTP
	id <S276828AbRJMKSB>; Sat, 13 Oct 2001 06:18:01 -0400
From: Signal9 <signal9@gmx.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: possible bug in VFS ?
Date: Sat, 13 Oct 2001 12:32:15 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
In-Reply-To: <Pine.GSO.4.21.0110122004080.76-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110122004080.76-100000@weyl.math.psu.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01101312321500.00286@apocalipsis>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 October 2001 00:06, you wrote:
> On Sat, 13 Oct 2001, Signal9 wrote:
> >                root = current->fs->rootmnt;
> >                list_for_each(ptr, &root->mnt_list) {
> >                         mnt = list_entry(ptr, struct vfsmount, mnt_list);
> >                         sb = mnt ? mnt->mnt_sb : NULL;
> >                          if (NULL != sb && dev == sb->s_dev)
> > <============ mntget(mnt);
> >                 }
>
> 	What the hell is it trying to do?

 Here goes the complete function:
static 
int bc_lock_dev(struct bc_disk *bd, struct bc_device *bc, kdev_t dev, 
		int lock)
{
        struct super_block *sb;
        struct vfsmount    *mnt, *root;
        struct list_head   *ptr;

        if (!capable(CAP_SYS_ADMIN))
                return -EPERM;

        if (!bd->bd_flags.configured) {
                if (!lock)
                        return 0;
                printk(KERN_ERR "bc: attempt to lock free device.\n");
                return -ENXIO;
        }

        if (lock && !bd->bd_flags.mounted) {
                root = current->fs->rootmnt;            
                list_for_each(ptr, &root->mnt_list) {
                        mnt = list_entry(ptr, struct vfsmount, mnt_list);
                        sb = mnt ? mnt->mnt_sb : NULL;
             
	           printk (KERN_WARNING "\n\n[++++] The pointer to sb is: %08x\nAnd 
the name is: %s\n\n",
                                        sb, mnt->mnt_devname);
             
	           if (NULL != sb && dev == sb->s_dev) 
                                        mntget(mnt);
                }
                bd->bd_flags.mounted = 1;
                bc->bc_refcnt++;
        } else if (!lock && bd->bd_flags.mounted) {
                root = current->fs->rootmnt;            
                list_for_each(ptr, &root->mnt_list) {
                        mnt = list_entry(ptr, struct vfsmount, mnt_list);
                        sb = mnt ? mnt->mnt_sb : NULL;

                        if (NULL != sb && dev == sb->s_dev)
                                        mntget(mnt);
                }
                bd->bd_flags.mounted = 0;
                bc->bc_refcnt--;
       }
        return 0;
}
