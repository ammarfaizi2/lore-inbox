Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSLOPId>; Sun, 15 Dec 2002 10:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSLOPId>; Sun, 15 Dec 2002 10:08:33 -0500
Received: from sysdoor.net ([62.212.103.239]:29963 "EHLO celia")
	by vger.kernel.org with ESMTP id <S261678AbSLOPIc>;
	Sun, 15 Dec 2002 10:08:32 -0500
Message-ID: <009601c2a44c$e51ba860$3803a8c0@descript>
From: "Vergoz Michael \(SYSDOOR\)" <mvergoz@sysdoor.Com>
To: "Octave" <oles@ovh.net>, "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, <ext3-users@redhat.com>
References: <20021215144050.GY12395@ovh.net>
Subject: Re: problem with Andrew's patch ext3
Date: Sun, 15 Dec 2002 16:15:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

@@ -454,6 +456,7 @@ static struct super_operations ext3_sops
      delete_inode: ext3_delete_inode, /* BKL not held.  We take it */
      put_super: ext3_put_super,  /* BKL held */
      write_super: ext3_write_super, /* BKL held */
    + sync_fs: ext3_sync_fs,
      write_super_lockfs: ext3_write_super_lockfs, /* BKL not held. Take it
*/
      unlockfs: ext3_unlockfs,  /* BKL not held.  We take it */
      statfs:  ext3_statfs,  /* BKL held */
  @@ -1577,24 +1580,22 @@ int ext3_force_commit(struct super_block
  * This implicitly triggers the writebehind on sync().
  */

Someone can explain to me how he can put a sync_fs label into a
super_operation structure ?
The segfault is normal.

==> Linux/Documentation/filesystems/vfs.txt
177 struct super_operations {
178         void (*read_inode) (struct inode *);
179         void (*write_inode) (struct inode *, int);
180         void (*put_inode) (struct inode *);
181         void (*delete_inode) (struct inode *);
182         int (*notify_change) (struct dentry *, struct iattr *);
183         void (*put_super) (struct super_block *);
184         void (*write_super) (struct super_block *);
185         int (*statfs) (struct super_block *, struct statfs *, int);
186         int (*remount_fs) (struct super_block *, int *, char *);
187         void (*clear_inode) (struct inode *);
188 };

Well,

==> Linux/Documentation/filesystems/vfs.txt
327 struct file_operations {
328         loff_t (*llseek) (struct file *, loff_t, int);
329         ssize_t (*read) (struct file *, char *, size_t, loff_t *);
330         ssize_t (*write) (struct file *, const char *, size_t, loff_t
*);
331         int (*readdir) (struct file *, void *, filldir_t);
332         unsigned int (*poll) (struct file *, struct poll_table_struct
*);
333         int (*ioctl) (struct inode *, struct file *, unsigned int,
unsigned long);
334         int (*mmap) (struct file *, struct vm_area_struct *);
335         int (*open) (struct inode *, struct file *);
336         int (*release) (struct inode *, struct file *);
337         int (*fsync) (struct file *, struct dentry *);
338         int (*fasync) (struct file *, int);
339         int (*check_media_change) (kdev_t dev);
340         int (*revalidate) (kdev_t dev);
341         int (*lock) (struct file *, int, struct file_lock *);
342 };

You can only use a sync function into the file_operation structure.
Well the patch can't work.

Octave, anyway you don't need this patch :P
Everything is already implemented.

Or perhaps i'v lost something ?!

Regards,
Michael

============================================================================
===
===============================ORIGINAL
MESSAGE===============================
============================================================================
===
From: "Octave" <oles@ovh.net>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>; <ext3-users@redhat.com>
Sent: Sunday, December 15, 2002 3:40 PM
Subject: problem with Andrew's patch ext3


> Hello Andrew,
>
> I patched 2.4.20 with your patch found out on
http://lwn.net/Articles/17447/
> and I have a big problem with:
> once server is booted on 2.4.20 with your patch, when I want to reboot
> with /sbin/reboot, server makes a Segmentation fault and it crashs.
> I tested it on 50-60 servers and it is the same problem. I tested kernel
> 2.4.20 without your patch: no problem.
>
> # uname -a
> Linux XXXXXX 2.4.20 #1 ven déc 13 17:21:23 CET 2002 i686 unknown
> # /sbin/reboot
>
> Broadcast message from root (pts/0) Sun Dec 15 14:26:03 2002...
>
> The system is going down for reboot NOW !!
> Segmentation fault
> #
> # dmRead from remote host XXXXXXXX: Connection reset by peer
>
> It is crashed.
>
> no logs :/
>
> Regards
> Octave
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

