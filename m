Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbTA1QgS>; Tue, 28 Jan 2003 11:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267417AbTA1QgS>; Tue, 28 Jan 2003 11:36:18 -0500
Received: from asplinux.ru ([195.133.213.194]:39694 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id <S267415AbTA1QgP>;
	Tue, 28 Jan 2003 11:36:15 -0500
From: "Denis V. Lunev" <den@asplinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15926.45962.729604.789545@artemis.asplinux.ru>
Date: Tue, 28 Jan 2003 19:44:58 +0300
To: linux-kernel@vger.kernel.org
Subject: [BUG] 100% reproducable OOPS in 2.4.20 on ext3 after swapon
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Recently I have found a serious problem in sys_swapon/ext3 code.
The host configuration is the following
[root@ts3 root]# mount  
/dev/sda2 on / type ext2 (rw)
/dev/sdd1 on /vz type ext3 (rw)
[root@ts3 root]#

if one executes
[root@ts3 root]# strace swapon /dev/sdd1
......skipped.....
stat64("/dev/sdd1", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 49), ...}) = 0
swapon("/dev/sdd1")                     = -1 EINVAL (Invalid argument)

OOPS will occure after some time (kjournald, unmapped buffer in
__make_request), see the letter end. The shit was caused by the
following trace
		 discard_buffer
Trace; c0140d94 <discard_bh_page+44/80>
Trace; c012e208 <do_flushpage+28/30>
Trace; c012e224 <truncate_complete_page+14/50>
Trace; c012e3e6 <truncate_list_pages+186/1f0>
Trace; c012e49a <truncate_inode_pages+4a/80>
Trace; c0144770 <kill_bdev+20/30>
Trace; c0144866 <set_blocksize+e6/100>
Trace; c0138bc0 <sys_swapon+1d0/7f0>
Trace; c0106fd2 <system_call+32/38>

which discards buffer held in the journal->j_sb_buffer :(((

I do not see the obvious way to fix the problem right now. Please
note, that this partition is already mounted and swapon fails, but the
journal becomes corrupted :(

Regards,
	Denis V. Lunev

P.S. OOPS decoded

root@ts3 root]# dmesg | tail -17 | ksymoops -VKLO -m
/boot/System.map-2.4.20-smp
ksymoops 2.4.4 on i686 2.4.20-smp.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.20-smp (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c01bd46d>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00004000   ebx: 00000002   ecx: 00000831   edx: 00000002
esi: f3373440   edi: 00000001   ebp: 0222e3d7   esp: f3367d6c
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 140, stackpage=f3367000)
Stack: 00004000 f3ab9bf8 db6db6db 6db6db6d 00000000 00000000 00000002 00000934
       db6db6db 6db6db6d db6db6db 6db6db6d db6db6db 6db6db6d db6db6db 6db6db6d
       db6db6db 6db6db6d db6db6db 6db6db6d db6db6db 00000002 f3373440 00000934
Call Trace: [<c01bdb1f>] [<c0140703>] [<c01bdb7d>] [<c01bdd17>] [<c0140703>]
   [<c01723a3>] [<c016e465>] [<c0114c1a>] [<c0171490>] [<c01712d0>] [<c0105626>]
   [<c01712f0>]
Code: 0f 0b 56 57 e8 0a e9 f7 ff 5b 89 c6 0f b7 4e 14 5d 89 c8 c1

>>EIP; c01bd46d <__make_request+7d/620> <=====
Trace; c01bdb1f <generic_make_request+10f/130>
Trace; c0140703 <__refile_buffer+53/60>
Trace; c01bdb7d <submit_bh+3d/60>
Trace; c01bdd17 <ll_rw_block+177/1c0>
Trace; c0140703 <__refile_buffer+53/60>
Trace; c01723a3 <journal_update_superblock+83/c0>
Trace; c016e465 <journal_commit_transaction+1f5/1230>
Trace; c0114c1a <schedule+5aa/660>
Trace; c0171490 <kjournald+1a0/2f0>
Trace; c01712d0 <commit_timeout+0/10>
Trace; c0105626 <kernel_thread+26/30>
Trace; c01712f0 <kjournald+0/2f0>
Code;  c01bd46d <__make_request+7d/620>
00000000 <_EIP>:
Code;  c01bd46d <__make_request+7d/620> <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01bd46f <__make_request+7f/620>
2:   56                        push   %esi
Code;  c01bd470 <__make_request+80/620>
3:   57                        push   %edi
Code;  c01bd471 <__make_request+81/620>
4:   e8 0a e9 f7 ff            call   fff7e913 <_EIP+0xfff7e913> c013bd80
<create_bounce+0/150>
Code;  c01bd476 <__make_request+86/620>
9:   5b                        pop    %ebx
Code;  c01bd477 <__make_request+87/620>
a:   89 c6                     mov    %eax,%esi
Code;  c01bd479 <__make_request+89/620>
c:   0f b7 4e 14               movzwl 0x14(%esi),%ecx
Code;  c01bd47d <__make_request+8d/620>
10:   5d                        pop    %ebp
Code;  c01bd47e <__make_request+8e/620>
11:   89 c8                     mov    %ecx,%eax
Code;  c01bd480 <__make_request+90/620>
13:   c1 00 00                  roll   $0x0,(%eax)

[root@ts3 root]#

