Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbRE3J57>; Wed, 30 May 2001 05:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbRE3J5t>; Wed, 30 May 2001 05:57:49 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:26888 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262692AbRE3J5k>; Wed, 30 May 2001 05:57:40 -0400
Date: Wed, 30 May 2001 11:57:38 +0200 (CEST)
From: Joris van Rantwijk <joris@deadlock.et.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: Minor problem in shmem_remount_fs()
Message-ID: <Pine.LNX.4.21.0105301137180.22235-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I'm sorry if this isn't the right place to send this stuff, but
the MAINTAINERS file wasn't being very helpful either.

I believe there is a minor bug in the remount code for the shm
filesystem in the Linux 2.4.5 kernel. When parsing the mount flags,
the code fails to set default values for unspecified options.

mm/shmem.c: 1026:
        unsigned long max_blocks, blocks;
        unsigned long max_inodes, inodes;
        struct shmem_sb_info *info = &sb->u.shmem_sb;

        if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
                return -EINVAL;
---
If the nr_blocks / nr_inodes options are not specified, the value of
max_(block|inodes) will be undefined.

This would explain the following observed behaviour:
[root@kitty /]# mount -t shm none /mnt
[root@kitty /]# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda7              1981000   1258014    620574  67% /
/dev/hda8               995115    447813    495896  47% /home
/dev/hda1              2557352   1807324    750028  71% /dosc
/dev/hda5              1027856    550192    477664  54% /dosd
/dev/hda6               513776    270480    243296  53% /dose
none                    163616         0    163616   0% /mnt
[root@kitty /]# mount -o remount /mnt
[root@kitty /]# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda7              1981000   1258014    620574  67% /
/dev/hda8               995115    447813    495896  47% /home
/dev/hda1              2557352   1807324    750028  71% /dosc
/dev/hda5              1027856    550192    477664  54% /dosd
/dev/hda6               513776    270480    243296  53% /dose
none                 17179869096         0 17179869096   0% /mnt
[root@kitty /]# ?

Just to give complete information, ver_linux:
Linux kitty 2.4.5 #1 Tue May 29 20:46:15 CEST 2001 i586 unknown
Gnu C                  2.95.2
Gnu make               3.78.1
binutils               2.9.5.0.37
mount                  2.10f
modutils               2.4.1
e2fsprogs              1.18
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         rtc nls_iso8859-1 nls_cp437 vfat fat powerswitch \
                         mad16 ad1848 uart401 sound soundcore ne2k-pci 8390
Bye,
  Joris.

Joris van Rantwijk
joris@deadlock.et.tudelft.nl - http://deadlock.et.tudelft.nl/~joris/

