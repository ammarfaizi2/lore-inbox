Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291075AbSAaNzx>; Thu, 31 Jan 2002 08:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291076AbSAaNzo>; Thu, 31 Jan 2002 08:55:44 -0500
Received: from nlakdiva.slt.lk ([203.115.0.1]:58241 "EHLO lakdiva.slt.lk")
	by vger.kernel.org with ESMTP id <S291075AbSAaNz2>;
	Thu, 31 Jan 2002 08:55:28 -0500
Message-ID: <3C59E8A5.6878F0FD@sltnet.lk>
Date: Thu, 31 Jan 2002 20:00:21 -0500
From: "Ishan O. Jayawardena" <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-0.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings everyone,

	I'm afraid that try as I may, I couldn't reproduce Kris's symptoms.
This is with 2.4.18pre7aa1, No HIGHMEM, Plus a patch from _Andreas
Dilger_ (appended below), e2fsprogs 1.25, single IDE disk. Everything
works as expected.

Alexander Viro wrote:
> WTF???  Very interesting...  What about kernel messages?  It looks like
> stat(2) failing.

> Just in case - could you put the same find before the second attempt of
> mount?

Did that. Still No Problem. Gentlemen, this is a low end (real) IBM
machine with 64 MB SDRAM, 333 MHz Celeron (pre-Coppermine), 128 kb L2
cache (16 kb (*2?) L1), on sloooow vesafb, in X, while compiling
gcc-3.0.3 for C only :)

(I even did away with the umounts after the first runs were
successful... then just kept mounting over and over on the same
directory.) I'm afraid I can't test with plain 2.4.18-pre7 or anything
else as this is the only 2.4 kernel I have, and Kris did say the faults
were not reproducible on 2.2. Everything was done as root.

My Script:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#!/bin/bash
DEVICE=./loopdev
MOUNT=/mnt/tmp

# umount $MOUNT

dd if=/dev/zero of=$DEVICE bs=1k count=1000
mke2fs -v -F $DEVICE
# rm -rf $MOUNT
# mkdir -p $MOUNT
mount -v -t ext2 -o loop $DEVICE $MOUNT
cp -vr /bin/tar $MOUNT
cp -vr /bin/zcat $MOUNT
#sleep 5
#sync

find $MOUNT -ls

mount -t ext2 -o loop $DEVICE $MOUNT

find $MOUNT -ls
# umount $MOUNT
# umount $MOUNT

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Andreas's patch (adopted for 2.4.1[78])
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN PATCH
--- linux/fs/ext2/super.c       Mon Jan 28 14:10:16 2002
+++ linux/fs/ext2/super.c.mod   Mon Jan 28 13:41:06 2002
@@ -286,14 +286,14 @@ static int ext2_setup_super (struct supe
                              struct ext2_super_block * es,
                              int read_only)
 {
-       int res = 0;
+       if (read_only)
+               return 0;
        if (le32_to_cpu(es->s_rev_level) > EXT2_MAX_SUPP_REV) {
                printk ("EXT2-fs warning: revision level too high, "
                        "forcing read-only mode\n");
-               res = MS_RDONLY;
+               sb->s_flags |= MS_RDONLY;
+               return MS_RDONLY;
        }
-       if (read_only)
-               return res;
        if (!(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
                printk ("EXT2-fs warning: mounting unchecked fs, "
                        "running e2fsck is recommended\n");
@@ -328,7 +328,7 @@ static int ext2_setup_super (struct supe
                ext2_check_inodes_bitmap (sb);
        }
 #endif
-       return res;
+       return 0;
 }
 
 static int ext2_check_descriptors (struct super_block * sb)
@@ -751,8 +751,9 @@ int ext2_remount (struct super_block * s
                 * by e2fsck since we originally mounted the partition.)
                 */
                sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
-               if (!ext2_setup_super (sb, es, 0))
-                       sb->s_flags &= ~MS_RDONLY;
+               if (ext2_setup_super (sb, es, 0))
+                       return -EROFS;
+               sb->s_flags &= ~MS_RDONLY;
        }
        ext2_sync_super(sb, es);
        return 0;
~~~~~~~~~~~~~~~~~~~~~ END PATCH

Hope this helps...

Cheerio!
	 alvin
~~~~
	We build a virtual shell around us to keep away the sorrows of life.
Most of us are very good at it... Those who aren't good enough, become
saints.
.
