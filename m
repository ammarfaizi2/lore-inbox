Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261468AbSIWXm0>; Mon, 23 Sep 2002 19:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbSIWXm0>; Mon, 23 Sep 2002 19:42:26 -0400
Received: from transport.cksoft.de ([62.111.66.27]:44555 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S261468AbSIWXmZ>; Mon, 23 Sep 2002 19:42:25 -0400
Date: Tue, 24 Sep 2002 01:47:31 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux-kernel@vger.kernel.org
Subject: 2.5-bk oops in vsnprintf/scsi_mod
Message-ID: <Pine.BSF.4.44.0209240140020.13460-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

got this one :(

bk pull from linux-20020923-211332 UTC

Linux megablast 2.5.38 #52 SMP Mon Sep 23 21:52:55 UTC 2002 i686 unknown
gcc version 3.2
binutils-2.13.90.0.4

could be related to sym53c416 module re-loading (after cli() removal; see
diff I posted some minutes ago). Seems the driver needs more cleanup ...

--- dmesg extract ---
scsi: device set offline - command error recover failed: host 0 channel 0 id 3 lun 0
Trying to free free IRQ5
scsi : 1 host left.
Unable to handle kernel paging request at virtual address da68a828
....
--- more down under ---


ksymoops 2.4.6 on i686 2.5.38.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.38/ (specified)
     -m /usr/src/linux/System.map (specified)

cpu: 0, clocks: 100211, slice: 3036
cpu: 1, clocks: 100211, slice: 3036
CPU 1 IS NOW UP!
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97  codec, id: 0x5452:0x4103 (TriTech TR28023)
Unable to handle kernel paging request at virtual address da68a828
c018b722
*pde = 150bd067
Oops: 0000
CPU:    0
EIP:    0060:[<c018b722>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013297
eax: da68a828   ebx: 0000000a   ecx: da68a828   edx: fffffffe
esi: d1c58119   edi: 00000000   ebp: d1c58fff   esp: d3e2fec4
ds: 0068   es: 0068   ss: 0068
Stack: d3e2ff08 d1c58fff 00000f87 00000000 0000000a 0000000a 00000003 00000000
       ffffffff ffffffff 00000117 d64b3460 d444cb40 d64b3460 c015fd22 d1c58117
       00000ee9 c0273c36 d3e2ff28 c033274c 00000020 c0109704 d64b3460 c0273c33
Call Trace: [<c015fd22>] [<c0109704>] [<c015f702>] [<c014256a>] [<c01426fe>]
   [<c010796f>]
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75


>>EIP; c018b722 <vsnprintf+2d2/450>   <=====

>>eax; da68a828 <[scsi_mod].bss.end+2f69/4741>
>>ecx; da68a828 <[scsi_mod].bss.end+2f69/4741>
>>esi; d1c58119 <_end+118d23a5/1852828c>
>>ebp; d1c58fff <_end+118d328b/1852828c>
>>esp; d3e2fec4 <_end+13aaa150/1852828c>

Trace; c015fd22 <seq_printf+52/70>
Trace; c0109704 <show_interrupts+e4/290>
Trace; c015f702 <seq_read+a2/2d0>
Trace; c014256a <vfs_read+ca/110>
Trace; c01426fe <sys_read+3e/60>
Trace; c010796f <syscall_call+7/b>

Code;  c018b722 <vsnprintf+2d2/450>
00000000 <_EIP>:
Code;  c018b722 <vsnprintf+2d2/450>   <=====
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c018b725 <vsnprintf+2d5/450>
   3:   74 07                     je     c <_EIP+0xc> c018b72e <vsnprintf+2de/450>
Code;  c018b727 <vsnprintf+2d7/450>
   5:   40                        inc    %eax
Code;  c018b728 <vsnprintf+2d8/450>
   6:   4a                        dec    %edx
Code;  c018b729 <vsnprintf+2d9/450>
   7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c018b72c <vsnprintf+2dc/450>
   a:   75 f4                     jne    0 <_EIP>
Code;  c018b72e <vsnprintf+2de/450>
   c:   29 c8                     sub    %ecx,%eax
Code;  c018b730 <vsnprintf+2e0/450>
   e:   83 e7 10                  and    $0x10,%edi
Code;  c018b733 <vsnprintf+2e3/450>
  11:   89 c3                     mov    %eax,%ebx
Code;  c018b735 <vsnprintf+2e5/450>
  13:   75 00                     jne    15 <_EIP+0x15> c018b737 <vsnprintf+2e7/450>


-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

