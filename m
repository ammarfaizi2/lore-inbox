Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314358AbSEXMFM>; Fri, 24 May 2002 08:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317125AbSEXMFL>; Fri, 24 May 2002 08:05:11 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:38648 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S314358AbSEXMFK>; Fri, 24 May 2002 08:05:10 -0400
Date: Fri, 24 May 2002 08:05:06 -0400
To: linux-kernel@vger.kernel.org
Subject: NFS oops in 2.5.17
Message-ID: <20020524080506.A8347@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running bonnie++ over NFS on kernels >= 2.5.11 have been giving errors like:

Delete files in sequential order...Bonnie: drastic I/O error (rmdir): Directory not empty
Cleaning up test directory after error.
Bonnie: drastic I/O error (rmdir): No such file or directory

The filesystem is exported with:
/opt/testing/nfs 192.168.0.0/24(rw,root_squash,no_wdelay,anonuid=18008,anongid=18008)

And mounted locally with:
mount -t nfs -o rsize=8192,wsize=8192,hard,intr mountain:/opt/testing/nfs /nfs

config options:
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y

2.5.17 gave this oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013fe20>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000000   ebx: c7b93af0   ecx: d7d731e8   edx: d71a4800
esi: c7b93af0   edi: c7b93af8   ebp: c7b93b80   esp: cd541e9c
ds: 0018   es: 0018   ss: 0018
Stack: c7b93af0 c7b93af0 00000000 fffffff7 d71a4800 00000000 c013ffd7 c7b93af0
       00000001 00000000 00000001 c014032f c7b93af0 00000001 00000000 c7b93af0
       d71a4800 c013c2df c7b93af0 00000001 c7b93af0 c2cc0cc0 c7b93af0 c015260a
Call Trace: [<c013ffd7>] [<c014032f>] [<c013c2df>] [<c015260a>] [<c013a898>]
   [<c013ab99>] [<c012f05e>] [<c012f47f>] [<c012f4a7>] [<c012ef1b>] [<c013d639>]
   [<c012bd3e>] [<c0140e0a>] [<c0106c67>]
Code: 89 78 04 89 46 08 83 ea 80 89 57 04 8b 44 24 10 89 b8 80 00


>>EIP; c013fe20 <__sync_single_inode+30/194>   <=====

>>ebx; c7b93af0 <END_OF_CODE+78ce5f4/????>
>>ecx; d7d731e8 <END_OF_CODE+17aadcec/????>
>>edx; d71a4800 <END_OF_CODE+16edf304/????>
>>esi; c7b93af0 <END_OF_CODE+78ce5f4/????>
>>edi; c7b93af8 <END_OF_CODE+78ce5fc/????>
>>ebp; c7b93b80 <END_OF_CODE+78ce684/????>
>>esp; cd541e9c <END_OF_CODE+d27c9a0/????>

Trace; c013ffd7 <__writeback_single_inode+53/58>
Trace; c014032f <write_inode_now+13/30>
Trace; c013c2df <iput+12f/19c>
Trace; c015260a <nfs_dentry_iput+22/28>
Trace; c013a898 <prune_dcache+bc/13c>
Trace; c013ab99 <shrink_dcache_anon+49/54>
Trace; c012f05e <generic_shutdown_super+2e/b0>
Trace; c012f47f <kill_anon_super+f/1c>
Trace; c012f4a7 <kill_litter_super+1b/20>
Trace; c012ef1b <deactivate_super+33/5c>
Trace; c013d639 <__mntput+1d/24>
Trace; c012bd3e <fput+c6/d0>
Trace; c0140e0a <sys_nfsservctl+112/128>
Trace; c0106c67 <syscall_call+7/b>

Code;  c013fe20 <__sync_single_inode+30/194>
00000000 <_EIP>:
Code;  c013fe20 <__sync_single_inode+30/194>   <=====
   0:   89 78 04                  mov    %edi,0x4(%eax)   <=====
Code;  c013fe23 <__sync_single_inode+33/194>
   3:   89 46 08                  mov    %eax,0x8(%esi)
Code;  c013fe26 <__sync_single_inode+36/194>
   6:   83 ea 80                  sub    $0xffffff80,%edx
Code;  c013fe29 <__sync_single_inode+39/194>
   9:   89 57 04                  mov    %edx,0x4(%edi)
Code;  c013fe2c <__sync_single_inode+3c/194>
   c:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  c013fe30 <__sync_single_inode+40/194>
  10:   89 b8 80 00 00 00         mov    %edi,0x80(%eax)

-- 
Randy Hron

