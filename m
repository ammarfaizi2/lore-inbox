Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUFVRmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUFVRmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUFVRFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:05:01 -0400
Received: from mail.jambit.com ([62.245.207.83]:28938 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S265029AbUFVQWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:22:01 -0400
Message-ID: <041c01c45875$0368e340$c100a8c0@wakatipu>
From: "Michael Kerrisk" <mtk-lists@jambit.com>
To: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Cc: "mk" <michael.kerrisk@gmx.net>
Subject: Strange NOTAIL inheritance behaviour in Reiserfs 3.6
Date: Tue, 22 Jun 2004 18:21:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

Problem summary:
On a Reiserfs 3.6 file system, I create a directory with the NOTAIL
attribute set and create 10000 1-byte files in that directory.  lsattr(1)
shows that the NOTAIL attribute is set on (i.e., inherited by) all of the
files.  However, the disk space consumption remains small (certainly not
10000 blocks used).  Only when I explicitly set the NOTAIL attribute on all
the files does disk consumption rise to what I would expect.  In other
words, the files are inheriting the NOTAIL attribute form their parent
directory, but this inheritance has no effect.

Looking at the 2.6.6 (vanilla) kernel sources, AFAICS the code matches my
observations (unpacking is only performed on an explicit ioctl() call).

The question is why are things done like this?  It certainly seems to be
misleading, possibly buggy and undesirable behaviour.

This behaviour observed on Reiserfs 3.6.13 (SUSE's 2.6.4 kernel on SUSE
9.1).


Detailed example follows:

Create a file system, with a directory marked NOTAIL:

    # mkreiserfs -b 4096  /dev/hda12
    mkreiserfs 3.6.13 (2003 www.namesys.com)
    [...]
    Guessing about desired format.. Kernel 2.6.4-52-default is running.
    Format 3.6 with standard journal
    Count of blocks on the device: 158624
    Number of blocks consumed by mkreiserfs formatting process: 8216
    Blocksize: 4096
    Hash function used to sort names: "r5"
    Journal Size 8193 blocks (first block 18)
    Journal Max transaction length 1024
    inode generation number: 0
    UUID: 89f14047-2daf-4707-bce3-bbf9128ace2e
    ATTENTION: YOU SHOULD REBOOT AFTER FDISK!
        ALL DATA WILL BE LOST ON '/dev/hda12'!
    Continue (y/n):y
    Initializing journal - 0%....20%....40%....60%....80%....100%
    Syncing..ok
    ReiserFS is successfully created on /dev/hda12.

    # mount -t reiserfs /dev/hda12 /testfs
    # mkdir /testfs/t
    # chattr +t /testfs/t
    # df /dev/hda12
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/hda12              634472     32840    601632   6% /testfs

The 'write_blocks' program creates 1000 files, each 1 byte long:

    # time ./write_blocks -s 1 -n 1 -m 10000 /te stfs/t/x
    real    0m1.142s
    user    0m0.056s
    sys     0m1.075s
    # df /dev/hda12
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/hda12              634472     34080    600392   6% /testfs

Above, we see a change in disc consumption of 1240 1-k blocks -- i.e., those
10000 files are consuming way less than 10000 * 4096 bytes.

    # cd /testfs/t

Show that there really are 10000 files, that they are 1 byte long, and that
the NOTAIL attribute is set on on them:

    # ls | wc
      10002   10002   80005
    # ls -l | head -8
    total 40234
    drwxr-xr-x  2 root root 240048 2004-06-22 17:59 .
    drwxr-xr-x  5 root root    104 2004-06-22 17:59 ..
    -rw-r--r--  1 root root      1 2004-06-22 17:59 x000000
    -rw-r--r--  1 root root      1 2004-06-22 17:59 x000001
    -rw-r--r--  1 root root      1 2004-06-22 17:59 x000002
    -rw-r--r--  1 root root      1 2004-06-22 17:59 x000003
    -rw-r--r--  1 root root      1 2004-06-22 17:59 x000004
    # lsattr | head -5
    -----------t- ./x000000
    -----------t- ./x000001
    -----------t- ./x000002
    -----------t- ./x000003
    -----------t- ./x000004

Now explicitly setting the NOTAIL attribute on all of the files causes the
expected disk consumption:

    # time chattr +t *

    real    0m0.836s
    user    0m0.117s
    sys     0m0.711s
    # df /dev/hda12
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/hda12              634472     74080    560392  12% /testfs

74080-34080 ==> 40000 1-k bytes.

Best regards,

Michael Kerrisk

