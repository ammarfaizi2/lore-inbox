Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbRELXA7>; Sat, 12 May 2001 19:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbRELXAt>; Sat, 12 May 2001 19:00:49 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:31186 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S261335AbRELXAl>;
	Sat, 12 May 2001 19:00:41 -0400
Date: Sun, 13 May 2001 01:00:39 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
Message-ID: <Pine.A41.4.31.0105130055400.19270-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

root@kama3:/home/szabi# cat /proc/mounts
...
/dev/hdb2 /usr ext2 rw 0 0
...
root@kama3:/home/szabi# swapon /dev/hdb2
set_blocksize: b_count 1, dev ide0(3,66), block 2, from c0126b48
set_blocksize: b_count 1, dev ide0(3,66), block 3, from c0126b48
set_blocksize: b_count 1, dev ide0(3,66), block 4, from c0126b48
set_blocksize: b_count 1, dev ide0(3,66), block 5, from c0126b48
set_blocksize: b_count 1, dev ide0(3,66), block 6, from c0126b48
set_blocksize: b_count 1, dev ide0(3,66), block 7, from c0126b48
set_blocksize: b_count 1, dev ide0(3,66), block 8, from c0126b48
set_blocksize: b_count 1, dev ide0(3,66), block 1, from c0126b48
Unable to find swap-space signature
swapon: /dev/hdb2: Invalid argument
root@kama3:/home/szabi#

and then set_blocksize keeps flooding the console, not continuously,
but 20-40 lines at a time, then it sleeps a bit, sometimes half a
minute (caused by kupdated?)

root@kama3:/home/szabi# mount -o remount,ro /usr
ll_rw_block: device 03:42: only 4096-char blocks implemented (1024)
root@kama3:/home/szabi#

once I got these:
ll_rw_block: device 03:42: only 4096-char blocks implemented (1024)
EXT2-fs error (device ide0(3,66)): ext2_write_inode: unable to read inode block
- inode=2084, block=8207
ll_rw_block: device 03:42: only 4096-char blocks implemented (1024)
EXT2-fs error (device ide0(3,66)): ext2_write_inode: unable to read inode block
- inode=6328, block=24609
...

szabi@kama3:/hdc1/kernel/linux-2.4.4-ac6# gdb vmlinux
(gdb) disas 0xc0126b48
...
0xc0126b43 <sys_swapon+371>:    call   0xc012bcc0 <set_blocksize>
0xc0126b48 <sys_swapon+376>:    mov    0xe8(%edi),%edi
0xc0126b4e <sys_swapon+382>:    mov    %edi,0xffffffd0(%ebp)
...

I tried it on several partitions, and it worked on /dev/hdc,
and did not work on /dev/hdb
on /dev/hdb all the filesystems are ext2
on /dev/hdc one fs is a new, clean ext2, the others are reiserfs

so I really don't know what's the problem.

do you need any other information?

Bye,
Szabi

