Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSBIFkl>; Sat, 9 Feb 2002 00:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288484AbSBIFkb>; Sat, 9 Feb 2002 00:40:31 -0500
Received: from mx1.fuse.net ([216.68.2.90]:5550 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S288477AbSBIFkU>;
	Sat, 9 Feb 2002 00:40:20 -0500
Message-ID: <3C64B635.5080804@fuse.net>
Date: Sat, 09 Feb 2002 00:40:05 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020203
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: USB OOPS persists in 2.5.3-dj4
In-Reply-To: <3C644F9B.4050702@fuse.net> <20020209001405.GG27610@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>
>Can you let me know if 2.5.4-pre3 has this problem?
>
No, it does not have *this* problem, however...

rmmod usb-uhci
rmmod usbcore - "in use"
umount /proc/bus/usb
rmmod usbcore
modprobe usbcore
mount -t usbdevfs none /proc/bus/usb
modprobe uhci - OOPS.  Didn't manage to capture it.  System kept running.
rmmod uhci - "in use"
modprobe usb-uhci - two messages then deadlock except for Alt-SysRQ.

I suppose two drivers atop one another is bad and I shouldn't do that.

Booting 2.5.4-pre3 again gave me an oops in the first modprobe usb-uhci. 
 Here is the *really weird* decode of it:

Feb  9 00:11:47 Vivations kernel: c011e296
Feb  9 00:11:47 Vivations kernel: Oops: 0000
Feb  9 00:11:47 Vivations kernel: CPU:    0
Feb  9 00:11:47 Vivations kernel: EIP:    0010:[<c011e296>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Feb  9 00:11:47 Vivations kernel: EFLAGS: 00010202
Feb  9 00:11:47 Vivations kernel: eax: 736d7973   ebx: cf7534c0   ecx: 
cf753758   edx: cf753770
Feb  9 00:11:47 Vivations kernel: esi: 0000183f   edi: 00001820   ebp: 
cf7534c0   esp: cd819e74
Feb  9 00:11:47 Vivations kernel: ds: 0018   es: 0018   ss: 0018
Feb  9 00:11:47 Vivations kernel: Stack: cf753758 00001820 cf7534dc 
c011e567 cf753758 cf7534c0 cfc51400 00000004
Feb  9 00:11:47 Vivations kernel:        d08841c0 cd819ed4 d088227e 
c02643f8 00001820 00000020 d0883a7d cfc51400
Feb  9 00:11:47 Vivations kernel:        00000004 d08841c0 00000000 
00000000 fffffff0 00000000 00000000 c012f224
Feb  9 00:11:47 Vivations kernel: Call Trace: [<c011e567>] [<d08841c0>] 
[<d088227e>] [<d0883a7d>] [<d08841c0>]
Feb  9 00:11:47 Vivations kernel:    [<c012f224>] [<d0882994>] 
[<d0883ed0>] [<c01ce881>] [<d0883ed0>] [<d08841c0>]
Feb  9 00:11:47 Vivations kernel:    [<c01ce8e4>] [<d08841c0>] 
[<d0882ad2>] [<d08841c0>] [<c011a64d>] [<d087e060>]
Feb  9 00:11:47 Vivations kernel:    [<c0108947>]
Feb  9 00:11:47 Vivations kernel: Code: 39 70 04 76 0c 89 43 14 89 1a 89 
4b 10 31 c0 eb 08 8d 50 14

 >>EIP; c011e296 <__request_resource+32/50>   <=====
Trace; c011e566 <__request_region+62/94>
Trace; d08841c0 <END_OF_CODE+66c7e/????>
Trace; d088227e <END_OF_CODE+64d3c/????>
Trace; d0883a7c <END_OF_CODE+6653a/????>
Trace; d08841c0 <END_OF_CODE+66c7e/????>
Trace; c012f224 <enable_cpucache+3c/5c>
Trace; d0882994 <END_OF_CODE+65452/????>
Trace; d0883ed0 <END_OF_CODE+6698e/????>
Trace; c01ce880 <pci_announce_device+34/50>
Trace; d0883ed0 <END_OF_CODE+6698e/????>
Trace; d08841c0 <END_OF_CODE+66c7e/????>
Trace; c01ce8e4 <pci_register_driver+48/60>
Trace; d08841c0 <END_OF_CODE+66c7e/????>
Trace; d0882ad2 <END_OF_CODE+65590/????>
Trace; d08841c0 <END_OF_CODE+66c7e/????>
Trace; c011a64c <sys_init_module+524/5ec>
Trace; d087e060 <END_OF_CODE+60b1e/????>
Trace; c0108946 <syscall_call+6/a>
Code;  c011e296 <__request_resource+32/50>
00000000 <_EIP>:
Code;  c011e296 <__request_resource+32/50>   <=====
   0:   39 70 04                  cmp    %esi,0x4(%eax)   <=====
Code;  c011e298 <__request_resource+34/50>
   3:   76 0c                     jbe    11 <_EIP+0x11> c011e2a6 
<__request_resource+42/50>
Code;  c011e29a <__request_resource+36/50>
   5:   89 43 14                  mov    %eax,0x14(%ebx)
Code;  c011e29e <__request_resource+3a/50>
   8:   89 1a                     mov    %ebx,(%edx)
Code;  c011e2a0 <__request_resource+3c/50>
   a:   89 4b 10                  mov    %ecx,0x10(%ebx)
Code;  c011e2a2 <__request_resource+3e/50>
   d:   31 c0                     xor    %eax,%eax
Code;  c011e2a4 <__request_resource+40/50>
   f:   eb 08                     jmp    19 <_EIP+0x19> c011e2ae 
<__request_resource+4a/50>
Code;  c011e2a6 <__request_resource+42/50>
  11:   8d 50 14                  lea    0x14(%eax),%edx



