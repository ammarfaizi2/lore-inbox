Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291606AbSBHPLk>; Fri, 8 Feb 2002 10:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291603AbSBHPKk>; Fri, 8 Feb 2002 10:10:40 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18959 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291606AbSBHPK0>; Fri, 8 Feb 2002 10:10:26 -0500
Message-Id: <200202081459.g18Ex3t19504@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: [BUG] 2.4.18pre6+ll: autofs+smbfs: processes in D state
Date: Fri, 8 Feb 2002 16:58:45 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is here somebody willing to look into smbfs related bugs?

Ok, now to the bug report:

I have a multistream downloader (JetCar) on my NT box at work.
It locks files exclusively while downloading them.

I have automounter running on my Linux box. I use it to access
SMB filesystems over the network.

I wanted to verify that mp3 was good before I got all of it,
so cd'ed to /mnt/auto/smb.host.dir, paused download,
copied incomplete file to Linux and tried to resume dl.
It failed (JetCar: "can't open file").
I rebooted NT box.

Now I have some processes in D state. mc and ls hung trying to stat
/mnt/auto/smb.host.dir it seems. Ksymoopsed SysRq-T output below.

BTW, do I have to run klogd with -x? It seems to produce half-ksymoopsed
output otherwise (no module info I guess). I had to restart syslogd+klogd
to make usable trace.
--
vda

automount     D C02AE060     0  1986      1          2007  1962 (NOTLB)
Call Trace: [<c0105d25>] [<c0105eb8>] [<c9056ad6>] [<c905b960>] [<c9058f72>]
   [<c9058f54>] [<c014c23f>] [<c0149d06>] [<c01177d9>] [<c9058e01>] [<c90589fc>]
   [<c905b2c0>] [<c90563fb>] [<c90565a4>] [<c90565d4>] [<c9058e23>] [<c9058f19>]
   [<c013e406>] [<c01071ff>]
Trace; c0105d25 <__down+61/c0>
Trace; c0105eb8 <__down_failed+8/c>
Trace; c9056ad6 <[smbfs]_text_lock_proc+55/17f>
Trace; c905b960 <[smbfs]smb_sops+0/60>
Trace; c9058f72 <[smbfs]smb_delete_inode+1e/6c>
Trace; c9058f54 <[smbfs]smb_delete_inode+0/6c>
Trace; c014c23f <iput+1a3/1cc>
Trace; c0149d06 <shrink_dcache_sb+146/180>
Trace; c01177d9 <printk+131/164>
Trace; c9058e01 <[smbfs]smb_invalidate_inodes+11/1c>
Trace; c90589fc <[smbfs]smb_trans2_request+60/1fd>
Trace; c905b2c0 <[smbfs].rodata.start+1220/175f>
Trace; c90563fb <[smbfs]smb_proc_getattr_trans2+87/188>
Trace; c90565a4 <[smbfs]smb_proc_do_getattr+a8/ac>
Trace; c90565d4 <[smbfs]smb_proc_getattr+2c/44>
Trace; c9058e23 <[smbfs]smb_refresh_inode+17/b8>
Trace; c9058f19 <[smbfs]smb_revalidate_inode+55/90>
Trace; c013e406 <sys_lstat64+3e/6c>
Trace; c01071ff <system_call+33/38>

mc            D C02AE060     0  2604      1          2757  2615 (NOTLB)
Call Trace: [<c0105d25>] [<c0105eb8>] [<c9056bb2>] [<c9058e23>] [<c014970c>]
   [<c0140778>] [<c9058f19>] [<c013e406>] [<c01071ff>]
Trace; c0105d25 <__down+61/c0>
Trace; c0105eb8 <__down_failed+8/c>
Trace; c9056bb2 <[smbfs]_text_lock_proc+131/17f>
Trace; c9058e23 <[smbfs]smb_refresh_inode+17/b8>
Trace; c014970c <dput+1c/15c>
Trace; c0140778 <getname+70/a8>
Trace; c9058f19 <[smbfs]smb_revalidate_inode+55/90>
Trace; c013e406 <sys_lstat64+3e/6c>
Trace; c01071ff <system_call+33/38>

mc            D C02AE060     0  2612      1          2615  2618 (NOTLB)
Call Trace: [<c025c050>] [<c0105d25>] [<c0105eb8>] [<c9056bb2>] [<c9058e23>]
   [<c014970c>] [<c0140778>] [<c9058f19>] [<c013e406>] [<c01071ff>]
Trace; c025c050 <rb_insert_color+a8/dc>
Trace; c0105d25 <__down+61/c0>
Trace; c0105eb8 <__down_failed+8/c>
Trace; c9056bb2 <[smbfs]_text_lock_proc+131/17f>
Trace; c9058e23 <[smbfs]smb_refresh_inode+17/b8>
Trace; c014970c <dput+1c/15c>
Trace; c0140778 <getname+70/a8>
Trace; c9058f19 <[smbfs]smb_revalidate_inode+55/90>
Trace; c013e406 <sys_lstat64+3e/6c>
Trace; c01071ff <system_call+33/38>

ls            D C02AE060     0  2615      1          2604  2612 (NOTLB)
Call Trace: [<c012986b>] [<c0105d25>] [<c0105eb8>] [<c9056bb2>] [<c9058e23>]
   [<c0145025>] [<c0140778>] [<c9058f19>] [<c013e406>] [<c01072f0>] [<c01071ff>]
Trace; c012986b <do_generic_file_read+253/498>
Trace; c0105d25 <__down+61/c0>
Trace; c0105eb8 <__down_failed+8/c>
Trace; c9056bb2 <[smbfs]_text_lock_proc+131/17f>
Trace; c9058e23 <[smbfs]smb_refresh_inode+17/b8>
Trace; c0145025 <vfs_readdir+89/bc>
Trace; c0140778 <getname+70/a8>
Trace; c9058f19 <[smbfs]smb_revalidate_inode+55/90>
Trace; c013e406 <sys_lstat64+3e/6c>
Trace; c01072f0 <error_code+34/3c>
Trace; c01071ff <system_call+33/38>
