Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132248AbQK3AFJ>; Wed, 29 Nov 2000 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132263AbQK3AE7>; Wed, 29 Nov 2000 19:04:59 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:47087 "EHLO
        webber.adilger.net") by vger.kernel.org with ESMTP
        id <S132248AbQK3AE4>; Wed, 29 Nov 2000 19:04:56 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011292334.eATNYNB09518@webber.adilger.net>
Subject: Re: 'holey files' not holey enough.
In-Reply-To: <3A2584DC.1699B6CD@Mutz.com> "from Marc Mutz at Nov 29, 2000 10:36:12
 pm"
To: Marc Mutz <Marc@mutz.com>
Date: Wed, 29 Nov 2000 16:34:22 -0700 (MST)
CC: Adam <adam@cfar.umd.edu>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Mutz writes:
> kernel 2.2.17, '/' being a 1k blocksize ext2fs:
> 
> root@adam:/ > dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
> 1000+0 records in
> 1000+0 records out
> root@adam:/ > ls -l holed.file
> -rw-r--r--   1 root     root      6000000 Nov 29 23:33 holed.file
> root@adam:/ > du -sh holed.file
> 5.7M    holed.file

Strangely, I have 2.2.17 (TurboLinux patched), on a 1k filesystem and
I have no problems.  I have 1k, 2k, and 4k ext2 fs, all OK.

What people who have the problem should be doing is:
> ls -li holed.file        # find inode number
10732 -rw-r--r--    1 root     root      6000000 Nov 29 16:17 holed.file
> du -sk holed.file        # see what "stat" thinks
983k    holed.file
> debugfs /dev/XXX
debugfs> stats           # find out ext2 block size
...
Block size = 1024, fragment size = 1024
...
debugfs> stat <10732>  # (with < and >)
Inode: 10732   Type: regular    Mode:  0644   Flags: 0x0   Generation:
4048594821
User:     0   Group:     0   Size: 6000000
File ACL: 0    Directory ACL: 0
Links: 1   Blockcount: 1966
                       ^^^^ these are 512-byte blocks, so / 2 for ~kB
		            they include indirect blocks and such
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x3a258e82 -- Wed Nov 29 16:17:22 2000
atime: 0x3a258e82 -- Wed Nov 29 16:17:22 2000
mtime: 0x3a258e82 -- Wed Nov 29 16:17:22 2000
BLOCKS:
47512 47513 47514 47515 47516 47517 47518 47519 47520 ... 48723 48724
TOTAL: 983
       ^^^ these are ext2fs sized blocks, not necessarily kB

If what debugfs says doesn't match du, then it is du/libc/stat that is
broken.  If debugfs says the file actually has 6000000 bytes of data,
then it is the filesystem that is broken.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
