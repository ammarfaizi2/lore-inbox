Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUEONdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUEONdu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 09:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUEONdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 09:33:50 -0400
Received: from linuxhacker.ru ([217.76.32.60]:55765 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262453AbUEONdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 09:33:45 -0400
Date: Sat, 15 May 2004 16:21:49 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: NFS & long symlinks = stack overflow
Message-ID: <20040515132149.GA14880@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   For some time already I am investigating problems where fsstress run on
   NFS where NFSD is run on ext3 crashes in something like a hour.
   (but does not crash on reiserfs). On x86 crash looks like stack overflow
   (deref of pointer with last 3 digits being zero in kmap directly after
   get_current() call on 2.4.2x).

   Finally I was able to reduce a test case to two simple operations
   that reproduce the problem 100% reliably:

[root@ranma root]# mount ranma:/testing /mnt -t nfs
[root@ranma root]# cd /mnt
[root@ranma mnt]# perl -e 'symlink("a"x4095, "f")'; ls -la f
Segmentation fault

   (btw if you try to pass in something like 4090 worth of symbols, then
   subsequent ls won't crash, but last few symbols of link content will be
   corrupted)

   The crash happens on both 2.4 and 2.6. Below are backtraces for both
   (pretty much identical), but I think it is clear that stack was overflowed
   in some other place then the crash itself.
   Also fsstress crashes over time if run in UML (and again if you run
   nfsd from reiserfs, it does not crash, so I think this confirms the
   problem is related, as reiserfs imposes more strict limit on symlink length),
   but the crash is usually because some slab structures are corrupted and
   I do not yet have two commands that will reproduce the problem in uml
   instantly.

   2.6.6-bk1 trace:
Unable to handle kernel paging request at virtual address fffd1000
 printing eip:
f8ac41c0
*pde = 003eb067
*pte = 00000000
Oops: 0002 [#1]
SMP DEBUG_PAGEALLOC
CPU:    1
EIP:    0060:[<f8ac41c0>]    Not tainted
EFLAGS: 00010202   (2.6.6)
EIP is at nfs3_xdr_readlinkres+0x66/0xb1 [nfs]
eax: fffd0000   ebx: 00000074   ecx: 00000ffc   edx: 00000ffc
esi: f56630fc   edi: f56630bc   ebp: f5067c88   esp: f5067c74
ds: 007b   es: 007b   ss: 0068
Process fsstress (pid: 2016, threadinfo=f5066000 task=f5a3fa60)
Stack: 00000000 f5067e54 f8a404d4 f5067d40 f56630bc f5067cb0 f8a25b7b c1816060
       f4fc8a60 00000282 c1816d20 f8ac415a f5067d40 f5663120 f5663160 f5067cdc
       f8a1f1d0 d91e9474 f5067e54 00000002 c036a780 f8ac415a f56630bc f5067d40
Call Trace:
 [<f8a25b7b>] rpcauth_unwrap_resp+0x5b/0x87 [sunrpc]
 [<f8ac415a>] nfs3_xdr_readlinkres+0x0/0xb1 [nfs]
 [<f8a1f1d0>] call_decode+0x117/0x22e [sunrpc]
 [<f8ac415a>] nfs3_xdr_readlinkres+0x0/0xb1 [nfs]
 [<f8a237f0>] __rpc_execute+0x386/0x3fd [sunrpc]
 [<c0118758>] default_wake_function+0x0/0xc
 [<f8a1e71a>] rpc_call_sync+0x62/0xa1 [sunrpc]
 [<f8a22648>] rpc_run_timer+0x0/0xcf [sunrpc]
 [<f8ac12c9>] nfs3_rpc_wrapper+0x2d/0x6e [nfs]
 [<f8ac18cd>] nfs3_proc_readlink+0xa9/0xed [nfs]
 [<c0136877>] add_to_page_cache+0x5a/0x132
 [<f8abe066>] nfs_symlink_filler+0x62/0x101 [nfs]
 [<c0136983>] add_to_page_cache_lru+0x34/0x36
 [<c0138296>] read_cache_page+0x60/0x20e
 [<f8abe004>] nfs_symlink_filler+0x0/0x101 [nfs]
 [<f8abe18b>] nfs_getlink+0x86/0xe8 [nfs]
 [<f8abe214>] nfs_readlink+0x27/0x81 [nfs]
 [<c01662fe>] __user_walk+0x4b/0x4d
 [<c016130d>] sys_readlink+0x79/0x7d
 [<c0169eec>] filldir64+0x0/0xe3
 [<c015683b>] sys_close+0x7d/0xea
 [<c0103f35>] sysenter_past_esp+0x52/0x71

2.4.27-pre2 trace:
Unable to handle kernel paging request at virtual address ff8e8000
c01a2c64
*pde = 00005063
Oops: 0002
CPU:    0
EIP:    0010:[<c01a2c64>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000ffc   ebx: 00000074   ecx: ff8e7000   edx: 00000ffc
esi: f5b220ac   edi: 00000000   ebp: f73f5d08   esp: f73f5cf4
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 1094, stackpage=f73f5000)
Stack: f76a627c f73f5e84 f5b22074 f5b220cc f5b22108 f73f5d30 c02a3025 f5b22074 
       f76a6274 f73f5e84 c01a2bd0 f5b22074 f73f4000 f73f5d8c ffffe000 f73f5d6c 
       c02a7ab5 f73f5d8c f73f5d8c f73f5d5c f73f5df4 00000000 f73f4000 00000000 
Call Trace:    [<c02a3025>] [<c01a2bd0>] [<c02a7ab5>] [<c02a2413>] [<c02a6ac0>]
  [<c019fd86>] [<c01a030e>] [<c019c66c>] [<c0135937>] [<c019c719>] [<c019c600>]
  [<c019c7b5>] [<c015226c>] [<c01076fb>]
Code: c6 44 08 04 00 8b 46 10 8b 08 b8 00 e0 ff ff 21 e0 8b 50 30 


>>EIP; c01a2c64 <nfs3_xdr_readlinkres+94/140>   <=====

>>eax; 00000ffc Before first symbol
>>ecx; ff8e7000 <END_OF_CODE+6ef5921/????>
>>edx; 00000ffc Before first symbol
>>esi; f5b220ac <_end+3574d200/384e51b4>
>>ebp; f73f5d08 <_end+37020e5c/384e51b4>
>>esp; f73f5cf4 <_end+37020e48/384e51b4>

Trace; c02a3025 <call_decode+125/240>
Trace; c01a2bd0 <nfs3_xdr_readlinkres+0/140>
Trace; c02a7ab5 <__rpc_execute+f5/3c0>
Trace; c02a2413 <rpc_call_sync+73/c0>
Trace; c02a6ac0 <rpc_run_timer+0/f0>
Trace; c019fd86 <nfs3_rpc_wrapper+46/90>
Trace; c01a030e <nfs3_proc_readlink+8e/f0>
Trace; c019c66c <nfs_symlink_filler+6c/f0>
Trace; c0135937 <read_cache_page+97/160>
Trace; c019c719 <nfs_getlink+29/a0>
Trace; c019c600 <nfs_symlink_filler+0/f0>
Trace; c019c7b5 <nfs_readlink+25/a0>
Trace; c015226c <sys_readlink+9c/b0>
Trace; c01076fb <system_call+33/38>

Code;  c01a2c64 <nfs3_xdr_readlinkres+94/140>
00000000 <_EIP>:
Code;  c01a2c64 <nfs3_xdr_readlinkres+94/140>   <=====
   0:   c6 44 08 04 00            movb   $0x0,0x4(%eax,%ecx,1)   <=====
Code;  c01a2c69 <nfs3_xdr_readlinkres+99/140>
   5:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c01a2c6c <nfs3_xdr_readlinkres+9c/140>
   8:   8b 08                     mov    (%eax),%ecx
Code;  c01a2c6e <nfs3_xdr_readlinkres+9e/140>
   a:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c01a2c73 <nfs3_xdr_readlinkres+a3/140>
   f:   21 e0                     and    %esp,%eax
Code;  c01a2c75 <nfs3_xdr_readlinkres+a5/140>
  11:   8b 50 30                  mov    0x30(%eax),%edx


Bye,
    Oleg

