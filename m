Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270703AbTHJVzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270707AbTHJVzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:55:17 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:40977 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270703AbTHJVzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:55:10 -0400
Subject: Oops in usblp_cleanup, 2.6.0-test3
From: "Rafael D'Halleweyn (List)" <list@noduck.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1060552487.846.5.camel@bigboy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 17:54:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While printing to my USB printer (HP PhotoSmart 1000) I got the
following errors:

drivers/usb/class/usblp.c: usblp0: error -84 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
drivers/usb/class/usblp.c: usblp0: error -110 reading printer status

I then powered off the printer (HP PhotoSmart P1000) and then turned it
on again:

usb 1-2: USB disconnect, address 2
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0
alt 1 proto 2 vid 0x03F0 pid 0x3002
drivers/usb/class/usblp.c: usblp0: removed

Finally, I get this oops:

Unable to handle kernel paging request at virtual address fbceed1f
c0269c75
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0269c75>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: d1d9a400   ebx: d1d79be0   ecx: c0475cc4   edx: fbceecff
esi: d1d79be4   edi: d1fc4820   ebp: d05538e0   esp: cef3bf3c
ds: 007b   es: 007b   ss: 0068
Stack: 00000007 d1d79be0 d1d79be4 d1fc4820 d2a0f37e d1d9a400 00002000
d1646000
       11646000 d1d79be0 d2a0f478 d1d79be0 d18165a0 d183f880 c015505a
d05538e0
       d18165a0 ceff91c0 d18165a0 d183f880 00000000 cef3a000 c015368d
d18165a0
Call Trace:
 [<d2a0f37e>] usblp_cleanup+0x3e/0xa0 [usblp]
 [<d2a0f478>] usblp_release+0x58/0x60 [usblp]
 [<c015505a>] __fput+0x10a/0x120
 [<c015368d>] filp_close+0x4d/0x80
 [<c0153721>] sys_close+0x61/0xa0
 [<c010adab>] syscall_call+0x7/0xb
Code: 8b 4a 20 85 c9 74 14 8b 41 18 85 c0 75 11 8d b6 00 00 00 00
 
 
>>EIP; c0269c75 <usb_buffer_free+15/60>   <=====
 
>>eax; d1d9a400 <__crc_auth_unix_lookup+4c2ca/55b66>
>>ebx; d1d79be0 <__crc_auth_unix_lookup+2baaa/55b66>
>>ecx; c0475cc4 <per_cpu__runqueues+24/928>
>>edx; fbceecff <__crc_pskb_expand_head+d5fa8/38150d>
>>esi; d1d79be4 <__crc_auth_unix_lookup+2baae/55b66>
>>edi; d1fc4820 <__crc_nf_setsockopt+220b84/48b840>
>>ebp; d05538e0 <__crc_nf_unregister_sockopt+182799/30cc9c>
>>esp; cef3bf3c <__crc_ide_toggle_bounce+a7c45/39b93c>
 
Trace; d2a0f37e <__crc_d_invalidate+3e7df0/3f8239>
Trace; d2a0f478 <__crc_d_invalidate+3e7eea/3f8239>
Trace; c015505a <__fput+10a/120>
Trace; c015368d <filp_close+4d/80>
Trace; c0153721 <sys_close+61/a0>
Trace; c010adab <syscall_call+7/b>
 
Code;  c0269c75 <usb_buffer_free+15/60>
00000000 <_EIP>:
Code;  c0269c75 <usb_buffer_free+15/60>   <=====
   0:   8b 4a 20                  mov    0x20(%edx),%ecx   <=====
Code;  c0269c78 <usb_buffer_free+18/60>
   3:   85 c9                     test   %ecx,%ecx
Code;  c0269c7a <usb_buffer_free+1a/60>
   5:   74 14                     je     1b <_EIP+0x1b>
Code;  c0269c7c <usb_buffer_free+1c/60>
   7:   8b 41 18                  mov    0x18(%ecx),%eax
Code;  c0269c7f <usb_buffer_free+1f/60>
   a:   85 c0                     test   %eax,%eax
Code;  c0269c81 <usb_buffer_free+21/60>
   c:   75 11                     jne    1f <_EIP+0x1f>
Code;  c0269c83 <usb_buffer_free+23/60>
   e:   8d b6 00 00 00 00         lea    0x0(%esi),%esi


-- 
Rafael D'Halleweyn (List) <list@noduck.net>

