Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278959AbRKAOGN>; Thu, 1 Nov 2001 09:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278960AbRKAOGC>; Thu, 1 Nov 2001 09:06:02 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:58758 "EHLO gin")
	by vger.kernel.org with ESMTP id <S278959AbRKAOFt>;
	Thu, 1 Nov 2001 09:05:49 -0500
Date: Thu, 1 Nov 2001 15:05:47 +0100
To: linux-kernel@vger.kernel.org
Subject: oops 2.4.13
Message-ID: <20011101150547.A584@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

got another oops on my smp-PII-system today with 2.4.13 with lvm1.0.1-rc4.
The network load is pretty high on this machine. It has four ide-chains
fully populated with disks with quite some activity at times (running as ftp
and webserver).

As far as i can see, its task_list that is currupted in the buffer_head (am
i right?). After this oops the nmi-watchdog detects a deadlock on the other
processor because it's waiting on a lock, but that isn't relevant for
analyzing this problem, is it?

Decoded it looks like this:

Unable to handle kernel paging request at virtual address 6361661c
c0114b90
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0114b90>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010893
eax: dba7ebec   ebx: 63616620   ecx: 00000001   edx: 00000003
esi: c14b0180   edi: dba7ebe8   ebp: cd183ee8   esp: cd183ecc
ds: 0018   es: 0018   ss: 0018
Process lftp (pid: 27738, stackpage=cd183000)
Stack: dba7ebe8 c14b0180 00000002 dba7ebec 00000001 00000086 00000003 00000001
       c013476d dba7eba0 c0135207 dba7eba0 dbf1d680 00000008 c0194509 dba7eba0
       00000001 dbf1d680 00000096 dbf61c60 c02c1ba0 c0198947 dbf1d680 00000001
Call Trace: [<c013476d>] [<c0135207>] [<c0194509>] [<c0198947>] [<c019d208>]
   [<c019a261>] [<c019d1a0>] [<c0108411>] [<c01085f6>] [<c010a638>]
Code: 8b 4b fc 8b 01 85 45 fc 74 66 31 c0 9c 5e fa f0 fe 0d 00 08

>>EIP; c0114b90 <__wake_up+38/c0>   <=====
Trace; c013476c <unlock_buffer+3c/40>
Trace; c0135206 <end_buffer_io_async+4e/ec>
Trace; c0194508 <end_that_request_first+60/c0>
Trace; c0198946 <ide_end_request+66/a4>
Trace; c019d208 <ide_dma_intr+68/a8>
Trace; c019a260 <ide_intr+124/18c>
Trace; c019d1a0 <ide_dma_intr+0/a8>
Trace; c0108410 <handle_IRQ_event+4c/78>
Trace; c01085f6 <do_IRQ+a6/ec>
Trace; c010a638 <call_do_IRQ+6/e>
Code;  c0114b90 <__wake_up+38/c0>
00000000 <_EIP>:
Code;  c0114b90 <__wake_up+38/c0>   <=====
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=====
   Code;  c0114b92 <__wake_up+3a/c0>
   3:   8b 01                     mov    (%ecx),%eax
Code;  c0114b94 <__wake_up+3c/c0>
   5:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0114b98 <__wake_up+40/c0>
   8:   74 66                     je     70 <_EIP+0x70> c0114c00 <__wake_up+a8/c0>
Code;  c0114b9a <__wake_up+42/c0>
   a:   31 c0                     xor    %eax,%eax
Code;  c0114b9c <__wake_up+44/c0>
   c:   9c                        pushf  
Code;  c0114b9c <__wake_up+44/c0>
   d:   5e                        pop    %esi
Code;  c0114b9e <__wake_up+46/c0>
   e:   fa                        cli    
Code;  c0114b9e <__wake_up+46/c0>
   f:   f0 fe 0d 00 08 00 00      lock decb 0x800
	 
-- 

//anders/g

