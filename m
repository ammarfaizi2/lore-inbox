Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272323AbRIEV2Y>; Wed, 5 Sep 2001 17:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272324AbRIEV2O>; Wed, 5 Sep 2001 17:28:14 -0400
Received: from ns2.auctionwatch.com ([64.14.24.2]:22281 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S272323AbRIEV2G>; Wed, 5 Sep 2001 17:28:06 -0400
Message-ID: <5179B27750A9D411B968009027E06E2702EB5FCE@exback.corp.auctionwatch.com>
From: "Michael S. Fischer" <michael@auctionwatch.com>
To: "'mingo@redhat.com'" <mingo@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Oops in md_error/set_disk_faulty
Date: Wed, 5 Sep 2001 14:28:43 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.8-ac8
raidsetfaulty v0.3d compiled for md raidtools-0.90

I accidentally entered the wrong disk device in a raidsetfaulty command,
which caused a kernel oops and appears to have locked the thread (so that
subsequent commands just hang).

The md device in question was:

md2 : active raid1 sdb4[0] sda4[1]
      5839552 blocks [2/2] [UU]

And the command I entered was 

# raidsetfaulty /dev/md2 /dev/hdb4 
Segmentation fault

Then, I realized I put in the wrong device, so I tried to fix it...

# raidsetfaulty /dev/md2 /dev/sdb4
[hangs eternally]

I checked the kernel logs, and sure enough:

Unable to handle kernel NULL pointer dereference at virtual address 00000034
 printing eip:
c01f36ff
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01f36ff>]
EFLAGS: 00010292
eax: 00000000   ebx: 00000000   ecx: f7d33494   edx: f7dc2920
esi: f7d33480   edi: 00000344   ebp: 00000000   esp: e57d3ed0
ds: 0018   es: 0018   ss: 0018
Process raidsetfaulty (pid: 9586, stackpage=e57d3000)
Stack: 00000344 f7d33480 00000002 c01f2b26 f7d33480 00000344 00000902
f7d33480 
       00000344 c01f325f f7d33480 00000344 00000929 ffffffe7 00000344
c2e86de0 
       f74edd60 f74edd60 c061cba0 00000000 f7d33480 00000000 bffffe88
bffffb1c 
Call Trace: [<c01f2b26>] [<c01f325f>] [<c0146969>] [<c013bac8>] [<c0142af9>]

   [<c0106d4b>] 

>>EIP; c01f36ff <md_error+43/bc>   <=====
Trace; c01f2b26 <set_disk_faulty+22/28>
Trace; c01f325f <md_ioctl+733/7d0>
Trace; c0146969 <dput+19/144>
Trace; c013bac8 <blkdev_ioctl+28/38>
Trace; c0142af9 <sys_ioctl+2ad/2f4>
Trace; c0106d4b <system_call+33/38>
Code;  c01f36ff <md_error+43/bc>
00000000 <_EIP>:
Code;  c01f36ff <md_error+43/bc>   <=====
   0:   83 7b 34 00               cmpl   $0x0,0x34(%ebx)   <=====
Code;  c01f3703 <md_error+47/bc>
   4:   74 0b                     je     11 <_EIP+0x11> c01f3710
<md_error+54/bc>
Code;  c01f3705 <md_error+49/bc>
   6:   31 c0                     xor    %eax,%eax
Code;  c01f3707 <md_error+4b/bc>
   8:   eb 6b                     jmp    75 <_EIP+0x75> c01f3774
<md_error+b8/bc>
Code;  c01f3709 <md_error+4d/bc>
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01f3710 <md_error+54/bc>
  11:   8b 46 04                  mov    0x4(%esi),%eax

--
Michael S. Fischer / michael at auctionwatch.com
Systems Engineer, AuctionWatch Inc. / Phone: +1 650 808 5842  
