Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbRAUMIW>; Sun, 21 Jan 2001 07:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbRAUMIG>; Sun, 21 Jan 2001 07:08:06 -0500
Received: from quechua.inka.de ([212.227.14.2]:14852 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131986AbRAUMHs>;
	Sun, 21 Jan 2001 07:07:48 -0500
Date: Sun, 21 Jan 2001 13:07:45 +0100
To: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Cc: Werner.Almesberger@epfl.ch
Subject: the remount problem [2.4.0] kind of solved [patch]
Message-ID: <20010121130745.A1383@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following patch against 2.4.0 will allow the kernel to write a message
to the kernel log in case files are open for write or delete on a partition
which should be remounted.

I run my System with Read-Only /usr File System and this works fairly well.
I have a script to remount the different Filesystems if I want to upgrade
them (using the cool apt-get from Debian).

Sometimes after upgrades I noticed, that I am unable to remount the /usr
File system read only. Since I was unable to detect the Reason for it (no
file according to lsof or fuser was open for writing) i decided to patch the
kernel to debug the problem.

The Solution: some files are deleted but open. Most of the time this is due
to an upgrade of a shared lib without restarting the related daemon. I am
not sure why I dont see the open but deleted files in lsof (according to its
man page "lsof -aL1 /usr" should work, but anyway. Here is my patch, in case
you experience the same problems. Not sure if it is ok to include it that
way into mainstream kernel since it might produce quite a few lines of logs
and i am not sure if prinkt is save inside the file list lock anyway.

So my question: which user mode program can be used to detect those "open
but deleted" mmaped files?

With my patch i get the inode an can grep in maps...

calista:/usr/src/linux# grep 145429 /proc/*/maps
/proc/354/maps:40156000-4016d000 r-xp 00000000 08:05 145429
/usr/lib/jabber/jsm/jsm.so (deleted)
/proc/354/maps:4016d000-4016e000 rw-p 00016000 08:05 145429
/usr/lib/jabber/jsm/jsm.so (deleted)
/proc/366/maps:40156000-4016d000 r-xp 00000000 08:05 145429
/usr/lib/jabber/jsm/jsm.so (deleted)
/proc/366/maps:4016d000-4016e000 rw-p 00016000 08:05 145429
/usr/lib/jabber/jsm/jsm.so (deleted)

Perhaps it is enough to run "grep '(deleted)' /proc/*/maps" in cron.daily?

Well, for Debian, it would be nice if we can make sure that on shared lib
upgrade at least a list of programs which needs to be restarted is mailed to
root. We do restartes on libc upgrade, but I guess it is not possible to
restart for other shared libs (automatically).

Greetings
Bernd

--- /usr/src/linux/fs/file_table.corg   Sun Jan 21 12:29:04 2001
+++ /usr/src/linux/fs/file_table.c      Sun Jan 21 12:40:07 2001
@@ -182,12 +182,15 @@
                inode = file->f_dentry->d_inode;
 
                /* File with pending delete? */
-               if (inode->i_nlink == 0)
+               if (inode->i_nlink == 0) {
+                       printk("ro-remount failed: pending delete on %s, inode no %lu\n",kdevname(inode->i_dev),inode->i_ino);
                        goto too_bad;
-
+               }
                /* Writable file? */
-               if (S_ISREG(inode->i_mode) && (file->f_mode & FMODE_WRITE))
+               if (S_ISREG(inode->i_mode) && (file->f_mode & FMODE_WRITE)) {
+                       printk("ro-remount failed: file open for write on %s, inode no %lu\n",kdevname(inode->i_dev),inode->i_ino);
                        goto too_bad;
+               }
        }
        file_list_unlock();
        return 1; /* Tis' cool bro. */

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
