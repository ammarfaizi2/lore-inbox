Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273376AbRINMy0>; Fri, 14 Sep 2001 08:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273379AbRINMyI>; Fri, 14 Sep 2001 08:54:08 -0400
Received: from mout0.freenet.de ([194.97.50.131]:36755 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S273376AbRINMxz>;
	Fri, 14 Sep 2001 08:53:55 -0400
From: Matthias Kramm <matthias.kramm@stud.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: ISOFS corrupt filesizes
Message-ID: <20010914145352.A9952@stud.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Date: Fri, 14 Sep 2001 14:54:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


According to the (2.4.9) MAINTAINERS-File,  ISOFS doesn't have a maintainer,
so this probably best fits in this list.

I came across a (commercial) DVD with an ISOFS Filesystem on it and filesizes
bigger than 1M.
I.e. "ls -l /mnt/cdrom/video_ts" shows

total 8153965
-r-xr-xr-x    1 root     root        34816 Feb 29  2000 video_ts.bup
-r-xr-xr-x    1 root     root        34816 Feb 29  2000 video_ts.ifo
-r-xr-xr-x    1 root     root   1201278976 Feb 29  2000 video_ts.vob <---
-r-xr-xr-x    1 root     root        18432 Feb 29  2000 vts_01_0.bup
-r-xr-xr-x    1 root     root        18432 Feb 29  2000 vts_01_0.ifo
-r-xr-xr-x    1 root     root        20480 Feb 29  2000 vts_01_0.vob
-r-xr-xr-x    1 root     root        10240 Feb 29  2000 vts_01_1.vob
-r-xr-xr-x    1 root     root        18432 Feb 29  2000 vts_02_0.bup
-r-xr-xr-x    1 root     root        18432 Feb 29  2000 vts_02_0.ifo
-r-xr-xr-x    1 root     root    967038976 Feb 29  2000 vts_02_1.vob
-r-xr-xr-x    1 root     root        96256 Feb 29  2000 vts_03_0.bup
-r-xr-xr-x    1 root     root        96256 Feb 29  2000 vts_03_0.ifo
-r-xr-xr-x    1 root     root    195196928 Feb 29  2000 vts_03_0.vob
-r-xr-xr-x    1 root     root   1073709056 Feb 29  2000 vts_03_1.vob
-r-xr-xr-x    1 root     root   1073709056 Feb 29  2000 vts_03_2.vob
-r-xr-xr-x    1 root     root   1073709056 Feb 29  2000 vts_03_3.vob
                                   (...)

Actually, that is what it _should_ show. Here is the  actual output:
(kernel versions 2.2.18 through 2.4.9)

$ ls -l /mnt/cdrom/video_ts
Warning: defective CD-ROM. Enabling "cruft" mount option.
total 142925
-r-xr-xr-x    1 root     root        34816 Feb 29  2000 video_ts.bup
-r-xr-xr-x    1 root     root        34816 Feb 29  2000 video_ts.ifo
-r-xr-xr-x    1 root     root     10096640 Feb 29  2000 video_ts.vob
-r-xr-xr-x    1 root     root        18432 Feb 29  2000 vts_01_0.bup
-r-xr-xr-x    1 root     root        18432 Feb 29  2000 vts_01_0.ifo
-r-xr-xr-x    1 root     root        20480 Feb 29  2000 vts_01_0.vob
-r-xr-xr-x    1 root     root        10240 Feb 29  2000 vts_01_1.vob
-r-xr-xr-x    1 root     root        18432 Feb 29  2000 vts_02_0.bup
-r-xr-xr-x    1 root     root        18432 Feb 29  2000 vts_02_0.ifo
-r-xr-xr-x    1 root     root     10737664 Feb 29  2000 vts_02_1.vob
-r-xr-xr-x    1 root     root        96256 Feb 29  2000 vts_03_0.bup
-r-xr-xr-x    1 root     root        96256 Feb 29  2000 vts_03_0.ifo
-r-xr-xr-x    1 root     root     10647552 Feb 29  2000 vts_03_0.vob
-r-xr-xr-x    1 root     root     16744448 Feb 29  2000 vts_03_1.vob
-r-xr-xr-x    1 root     root     16744448 Feb 29  2000 vts_03_2.vob
-r-xr-xr-x    1 root     root     16744448 Feb 29  2000 vts_03_3.vob
                                   (...)

Notice the corrupt filesizes. The culprit is obviously in the code which
"printk"s the "cruft" message above.

In 2.4.9-kernel/fs/isofs/inode.c around line 1190 it says

if ((inode->i_size < 0 || inode->i_size > 1073741824) &&
    inode->i_sb->u.isofs_sb.s_cruft == 'n') {
	printk(KERN_WARNING "Warning: defective CD-ROM.  "
	       "Enabling \"cruft\" mount option.\n");
	inode->i_sb->u.isofs_sb.s_cruft = 'y';
}

My personal guess would be that the assumption that iso files can't be
bigger than 1M unless the CD-ROM is defective is wrong.
(I don't know where the 1M comes from. 2M sounds more logical to me,
 however)
After removing the "indode->i_size > 1073741824" test, I got the correct
output for ls. Also was I able to cat (css-cat, actually) the whole 1201278976 
bytes without an error, which may lead to the assumption the file
is actually that big.
If I'm wrong and the dvd is actually broken, however, I'd like to 
suggest making the automatic cruft mount optional.

Greetings 

Matthias


