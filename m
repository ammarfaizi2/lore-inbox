Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265404AbTLHNve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265412AbTLHNve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:51:34 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:20957 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265404AbTLHNv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:51:28 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16340.33245.887082.96412@laputa.namesys.com>
Date: Mon, 8 Dec 2003 16:51:25 +0300
To: Petr Sebor <petr@scssoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: incorrect inode count on reiserfs
In-Reply-To: <3FD47BFC.9020008@scssoft.com>
References: <3FD47BFC.9020008@scssoft.com>
X-Mailer: VM 7.17 under 21.5 (patch 16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Sebor writes:
 > I have noticed this behavior when moving the inn2 news server to 
 > 2.6.0-test11 kernel
 > from 2.4.23
 > (inn2 refuses to start because if free inode shortage)
 > 
 > 2.6.0-test11:
 > df -i:
 > 
 > Filesystem            Inodes   IUsed   IFree IUse% Mounted on
 > /dev/sda1                  0       0       0    -  /
 > /dev/sdb1                  0       0       0    -  /mnt/sdb1
 > 
 > while df shows:
 > Filesystem           1K-blocks      Used Available Use% Mounted on
 > /dev/sda1            243208608  11069612 232138996   5% /
 > /dev/sdb1             36150172     32840  36117332   1% /mnt/sdb1
 > 
 > different reiserfs based machine with 2.4.23; this is where the inn2
 > used to work before, but the inode test was not failing because of the
 > 'always-nonzero' inode count:
 > 
 > df -i
 > Filesystem            Inodes   IUsed   IFree IUse% Mounted on
 > /dev/hde1            4294967295       0 4294967295    0% /
 > /dev/hdg1            4294967295       0 4294967295    0% /mnt/d2
 > 
 > df
 > Filesystem           1K-blocks      Used Available Use% Mounted on
 > /dev/hde1             77634256  77092844    541412 100% /
 > /dev/hdg1             38586912  19156508  19430404  50% /mnt/d2
 > 
 > another 2.6.0-test11 machine with ext2 reports inode counts correctly. 
 > my assumption is
 > that the problem is somehow reiserfs related, but my knowledge ends here.
 > all reiser fs's are of version 3.6

reiserfs has no fixed predefined number of inodes on the file
system. Hence, field f_files of struct statfs (see man 2 statfs) is not
applicable to this file system. Man page explicitly says:

       Fields that are undefined for a particular file system are
       set  to  0.

Previous man page stated that file system should put -1 (4294967295)
into undefined fields. Reiserfs has been changed to conform to the
changed specification.

SuS simply says:

NAME

    fstatvfs, statvfs - get file system information

SYNOPSIS

    [XSI] #include <sys/statvfs.h>

    int fstatvfs(int fildes, struct statvfs *buf);
    int statvfs(const char *restrict path, struct statvfs *restrict buf);

DESCRIPTION

    [...]

    It is unspecified whether all members of the statvfs structure have
    meaningful values on all file systems.

 > 
 > any ideas?

inn2 should be fixed. :)

Fix would really be simple: ignore test results if ->f_files is 0 or
0xffffffff.

 > 
 > Petr
 > 

Nikita.
