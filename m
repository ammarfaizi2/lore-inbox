Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRCHUAi>; Thu, 8 Mar 2001 15:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbRCHUA3>; Thu, 8 Mar 2001 15:00:29 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:23240 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129509AbRCHUAQ>; Thu, 8 Mar 2001 15:00:16 -0500
Message-Id: <5.0.2.1.2.20010308114958.02868518@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 08 Mar 2001 11:57:30 -0800
To: linux-kernel@vger.kernel.org (Linux Kernel)
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: ReiserFS on 2.4.2-ac13
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I have a ide raid setup and was using the Reiserfs code known to cause 
filesystem corruption.  The questions is: How do we recover from this 
corruption?  I have the latest reiserfs utils and the latest code from the 
website and the latest kernel.  When I mount /dev/md0, I still get problems 
while listing files.  The kernel previous to this one was giving these 
errors (2.4.2-ac5):

Mar  5 16:08:15 bertha kernel: vs-13048: reiserfs_iget: bad_inode. Stat 
data of (698895 780972) not found
Mar  5 16:08:16 bertha kernel: vs-13048: reiserfs_iget: bad_inode. Stat 
data of (698895 929630) not found
Mar  5 16:08:17 bertha kernel: vs-13048: reiserfs_iget: bad_inode. Stat 
data of (698895 778316) not found

I get no such errors in this kernel, but the filesystem is not 
usable.  Here is what happens if I try to access this filesystem:

[root@bertha adm]# ls -l LOG
-rw-r-----    1 pcbackup pcbackup    32387 Mar  7 14:55 LOG
[root@bertha adm]# tail -f LOG
tail: LOG: Bad address
tail: tail.c:727: recheck: Assertion `valid_file_spec (f)' failed.
Aborted (core dumped)
[root@bertha adm]# su pcbackup
sh-2.04$ tail LOG
tail: LOG: Bad address
sh-2.04$


Here is the output from "strace tail -f LOG".  These are the last few 
relevant lines:

open("LOG", O_RDONLY|O_LARGEFILE)       = 3
fstat64(3, {st_mode=S_IFREG|0640, st_size=32387, ...}) = 0
_llseek(3, 0, [0], SEEK_CUR)            = 0
_llseek(3, 0, 0xbffff938, SEEK_END)     = -1 EINVAL (Invalid argument)
_llseek(3, 0, [0], SEEK_SET)            = 0
read(3, 0xbfffd928, 4294967295)         = -1 EFAULT (Bad address)
write(2, "tail: ", 6tail: )                   = 6
write(2, "LOG", 3LOG)                      = 3
brk(0x8052000)                          = 0x8052000
open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT 
(No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No 
such file or directory)
write(2, ": Bad address", 13: Bad address)           = 13
write(2, "\n", 1
)                       = 1
fstat64(3, {st_mode=S_IFREG|0640, st_size=32387, ...}) = 0
close(3)                                = 0
write(2, "tail: tail.c:727: recheck: Asser"..., 67tail: tail.c:727: 
recheck: Assertion `valid_file_spec (f)' failed.
) = 67
rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
getpid()                                = 2968
kill(2968, SIGABRT)                     = 0
--- SIGABRT (Aborted) ---
+++ killed by SIGABRT +++

