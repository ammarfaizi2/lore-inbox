Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSGYMT6>; Thu, 25 Jul 2002 08:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSGYMT6>; Thu, 25 Jul 2002 08:19:58 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:40330 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S293203AbSGYMT5>; Thu, 25 Jul 2002 08:19:57 -0400
Date: Thu, 25 Jul 2002 05:20:12 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
cc: rmk@linux.org.uk
Subject: Oops w/PCMCIA modem & 8250_cs in 2.5.28
Message-ID: <Pine.LNX.4.44.0207250502170.17973-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The recent changes in the serial driver have broken PCMCIA modem support 
for me, although ordinary serial support itself works great.  I'll look at 
this more tonight but figured I'd send this now. 

Since the driver changed names, I symlinked 8250_cs to the old 
name, serial_cs. 

	cardmgr[509]: initializing socket 1
	cardmgr[509]: socket 1: 3Com 3CCM156 56K Global Modem
	cs: memory probe 0xa0000000-0xa0ffffff: clean.
	cardmgr[509]: executing: 'modprobe serial_cs'
	Serial: 8250/16550 driver $Revision: 1.84 $ IRQ sharing enabled
	ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
	serial_cs: register_serial() at 0x02f8, irq 3 failed
	cardmgr[509]: 
	get dev info on socket 1 failed: Resource temporarily unavailable

[Note:  io = 0x02f8, irq 3 is where it lived happily in 2.5.27.]
[I eject the card at this point...]

	cardmgr[509]: shutting down socket 1
	cardmgr[509]: executing: 'modprobe -r serial_cs'
	Removing wrong port: 2404b60f != ccaee01c


And now the subsequent oops:

Unable to handle kernel NULL pointer dereference at virtual address 
0000010c 
ccae84fb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<ccae84fb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000104   ebx: ccae9e04   ecx: cbadb060   edx: c021c068
esi: cb28d7e4   edi: ccaedec0   ebp: c8526000   esp: c8cfbf68
ds: 0018   es: 0018   ss: 0018
Stack: ccae89a8 ccaedec0 cb28d7e4 ccaee0b8 00000002 00000000 ccaecd12 
ccaedec0 
       ccaee01c ccaeb000 c8526000 c0115b2e ccaeb000 c8526000 00000000 
c0115019 
       ccaeb000 00000000 c8cfa000 00000000 00000000 bfffebe8 c0106cff 
080670b0 
Call Trace: [<ccae89a8>] [<ccaedec0>] [<ccaee0b8>] [<ccaecd12>] 
[<ccaedec0>] 
   [<ccaee01c>] [<c0115b2e>] [<c0115019>] [<c0106cff>] 
Code: 8b 40 08 85 c0 74 0e 89 44 24 04 e9 15 82 6a f3 90 8d 74 26 

>>EIP; ccae84fb <[core]__uart_hangup_port+b/30>   <=====
Trace; ccae89a8 <[core]uart_remove_one_port+58/90>
Trace; ccaedec0 <.data.end+40a9/????>
Trace; ccaee0b8 <.data.end+42a1/????>
Trace; ccaecd12 <.data.end+2efb/????>
Trace; ccaedec0 <.data.end+40a9/????>
Trace; ccaee01c <.data.end+4205/????>
Trace; c0115b2e <free_module+1e/b0>
Trace; c0115019 <sys_delete_module+f9/1d0>
Trace; c0106cff <syscall_call+7/b>
Code;  ccae84fb <[core]__uart_hangup_port+b/30>
00000000 <_EIP>:
Code;  ccae84fb <[core]__uart_hangup_port+b/30>   <=====
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=====
Code;  ccae84fe <[core]__uart_hangup_port+e/30>
   3:   85 c0                     test   %eax,%eax
Code;  ccae8500 <[core]__uart_hangup_port+10/30>
   5:   74 0e                     je     15 <_EIP+0x15> ccae8510 
<[core]__uart_hangup_port+20/30>
Code;  ccae8502 <[core]__uart_hangup_port+12/30>
   7:   89 44 24 04               mov    %eax,0x4(%esp,1)
Code;  ccae8506 <[core]__uart_hangup_port+16/30>
   b:   e9 15 82 6a f3            jmp    f36a8225 <_EIP+0xf36a8225> 
c0190720 <tty_vhangup+0/10>
Code;  ccae850b <[core]__uart_hangup_port+1b/30>
  10:   90                        nop    
Code;  ccae850c <[core]__uart_hangup_port+1c/30>
  11:   8d 74 26 00               lea    0x0(%esi,1),%esi


Craig Kulesa
Steward Obs. 
Univ. of Arizona

