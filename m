Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272621AbRHaHTh>; Fri, 31 Aug 2001 03:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272622AbRHaHT1>; Fri, 31 Aug 2001 03:19:27 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:64530 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S272621AbRHaHTY>; Fri, 31 Aug 2001 03:19:24 -0400
Date: Fri, 31 Aug 2001 08:19:42 +0100 (BST)
From: <mb/ext3@dcs.qmul.ac.uk>
To: <linux-kernel@vger.kernel.org>
cc: <ext3-users@redhat.com>
Subject: ext3 oops under moderate load
In-Reply-To: <Pine.LNX.4.33.0108301740420.7921-100000@inconnu.isu.edu>
Message-ID: <Pine.LNX.4.33.0108310759460.13139-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi bug hunters,

I left my spangly new dual PIII with an ext3 partition on a Promise
FastTrak 100TX2 being used both by a local process and knfsd for a few
hours, and the following happened:

[ 2.4.9-ac3 SMP (noapic) + the one patch from Zygo Blaxell to recognise
the Promise card; now I have kupdated, kjournald and user-space processes
trying to access the volume in question all in state 'D' ]

kernel BUG at revoke.c:307!
invalid operand: 0000
CPU:    1
EIP:    0010:[<e0829237>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001c   ebx: c3e13d6c   ecx: c023f7a0   edx: 0001af83
esi: dfc1b800   edi: c3e13d6c   ebp: 0000000a   esp: d5cd1c70
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 568, stackpage=d5cd1000)
Stack: e082e31e 00000133 0000d172 d5688044 00000001 cc89c8ac e0833bfc
cc89c8ac
       0000d172 c3e13d6c d5cd1d28 c0143a68 00007201 c3e13d6c c3e13d6c
0000d172
       d5688044 d5cd1d28 e0835e6d cc89c8ac 00000001 d5688044 c3e13d6c
0000d172
Call Trace: [<e082e31e>] [<e0833bfc>] [<c0143a68>] [<e0835e6d>]
[<e08361ab>]
   [<e082b17b>] [<e0823334>] [<e08234af>] [<e083f800>] [<e0833c96>]
[<e083f800>]
   [<e0833e0e>] [<c015b6b4>] [<c01575d6>] [<e095aa27>] [<e095ac8a>]
[<e095c087>]
   [<e095c65d>] [<c01f0965>] [<c01b15ac>] [<c0134a68>] [<e0959100>]
[<e0968ea0>]
   [<e0958661>] [<e0968ea0>] [<e098785a>] [<e0968d08>] [<e0968d38>]
[<e095847a>]
   [<e0968d00>] [<c0105926>] [<e0958190>]
Code: 0f 0b 58 5a f0 0f ab 6b 18 b8 0b 00 00 00 f0 0f ab 43 18 85

>>EIP; e0829237 <[jbd]journal_revoke+d7/180>   <=====
Trace; e082e31e <[jbd].rodata.start+23de/347f>
Trace; e0833bfc <[ext3]ext3_forget+bc/120>
Trace; c0143a68 <bread+18/70>
Trace; e0835e6d <[ext3]ext3_free_branches+ed/170>
Trace; e08361ab <[ext3]ext3_truncate+2bb/380>
Trace; e082b17b <[jbd]__jbd_kmalloc+2b/c0>
Trace; e0823334 <[jbd]start_this_handle+1d4/290>
Trace; e08234af <[jbd]journal_start+bf/f0>
Trace; e083f800 <[ext3]ext3_sops+0/40>
Trace; e0833c96 <[ext3]start_transaction+36/40>
Trace; e083f800 <[ext3]ext3_sops+0/40>
Trace; e0833e0e <[ext3]ext3_delete_inode+be/170>
Trace; c015b6b4 <iput+1d4/310>
Trace; c01575d6 <dput+166/200>
Trace; e095aa27 <[nfsd]find_fh_dentry+3d7/410>
Trace; e095ac8a <[nfsd]fh_verify+22a/470>
Trace; e095c087 <[nfsd]nfsd_open+27/280>
Trace; e095c65d <[nfsd]nfsd_write+4d/2d0>
Trace; c01f0965 <inet_sendmsg+35/40>
Trace; c01b15ac <sock_sendmsg+6c/90>
Trace; c0134a68 <free_block+1c8/2d0>
Trace; e0959100 <[nfsd]nfsd_proc_write+c0/d0>
Trace; e0968ea0 <[nfsd]nfsd_procedures2+100/240>
Trace; e0958661 <[nfsd]nfsd_dispatch+c1/160>
Trace; e0968ea0 <[nfsd]nfsd_procedures2+100/240>
Trace; e098785a <[sunrpc]svc_process+34a/510>
Trace; e0968d08 <[nfsd]nfsd_version2+0/10>
Trace; e0968d38 <[nfsd]nfsd_program+0/18>
Trace; e095847a <[nfsd]nfsd+2ea/410>
Trace; e0968d00 <[nfsd]nfsd_list+0/0>
Trace; c0105926 <kernel_thread+26/30>
Trace; e0958190 <[nfsd]nfsd+0/410>
Code;  e0829237 <[jbd]journal_revoke+d7/180>
00000000 <_EIP>:
Code;  e0829237 <[jbd]journal_revoke+d7/180>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  e0829239 <[jbd]journal_revoke+d9/180>
   2:   58                        pop    %eax
Code;  e082923a <[jbd]journal_revoke+da/180>
   3:   5a                        pop    %edx
Code;  e082923b <[jbd]journal_revoke+db/180>
   4:   f0 0f ab 6b 18            lock bts %ebp,0x18(%ebx)
Code;  e0829240 <[jbd]journal_revoke+e0/180>
   9:   b8 0b 00 00 00            mov    $0xb,%eax
Code;  e0829245 <[jbd]journal_revoke+e5/180>
   e:   f0 0f ab 43 18            lock bts %eax,0x18(%ebx)
Code;  e082924a <[jbd]journal_revoke+ea/180>
  13:   85 00                     test   %eax,(%eax)




