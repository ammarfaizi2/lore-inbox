Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271187AbTHHD3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 23:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHHD3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 23:29:21 -0400
Received: from main.gmane.org ([80.91.224.249]:11490 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271187AbTHHD3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 23:29:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: kswapd oops in 2.4.22-rc1
Date: Fri, 8 Aug 2003 03:28:51 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnbj6684.jqn.lunz@orr.homenet>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built a raid5 nfs server out of an old pentium 200 mmx, and one of the
drives was having issues:

hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }

so I was messing with the cabling and rechecking to see if I was still
getting the errors. The easiest way to reproduce the errors was running
"cat /dev/hdc > /dev/null", and while that was going on I ran "vmstat 2"
out of curiousity. While that was going on, I got the oops included
below.

The machine is a Pentium MMX 200 with 64M of ram, running a completely
vanilla 2.4.22-rc1 compiled with gcc 3.3.1 (yesterday's debian unstable
gcc-3.3 1:3.3.1-1 package).

Is there any reason to think I might be getting an oops in what looks
like core vm code? I'm running memtest86 on the machine now, but
overheating isn't normally an issue on old machines like this.

Jason


ksymoops 2.4.8 on i586 2.4.22-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc1/ (default)
     -m /boot/System.map-2.4.22-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000824
c0136b56
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0136b56>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00000000   ecx: 00000800   edx: 00000000
esi: c3771380   edi: c3771380   ebp: c10766dc   esp: c3fa1f2c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c3fa1000)
Stack: c3771320 c3771380
Call Trace:    [<c01394bd>] [<c012e460>] [<c012e650>] [<c012e6b0>] [<c012e7c0>]
  [<c012e826>] [<c012e940>] [<c0105000>] [<c0105673>] [<c012e8b0>]
Code: 89 51 24 81 e3 ff ff 00 00 89 4a 20 39 34 9d b0 94 30 c0 74


>>EIP; c0136b56 <__remove_from_lru_list+16/80>   <=====

>>esi; c3771380 <_end+3441c54/450d934>
>>edi; c3771380 <_end+3441c54/450d934>
>>ebp; c10766dc <_end+d46fb0/450d934>
>>esp; c3fa1f2c <_end+3c72800/450d934>

Trace; c01394bd <try_to_free_buffers+4d/e0>
Trace; c012e460 <shrink_cache+240/2f0>
Trace; c012e650 <shrink_caches+50/80>
Trace; c012e6b0 <try_to_free_pages_zone+30/50>
Trace; c012e7c0 <kswapd_balance_pgdat+50/a0>
Trace; c012e826 <kswapd_balance+16/30>
Trace; c012e940 <kswapd+90/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105673 <arch_kernel_thread+23/30>
Trace; c012e8b0 <kswapd+0/c0>

Code;  c0136b56 <__remove_from_lru_list+16/80>
00000000 <_EIP>:
Code;  c0136b56 <__remove_from_lru_list+16/80>   <=====
   0:   89 51 24                  mov    %edx,0x24(%ecx)   <=====
Code;  c0136b59 <__remove_from_lru_list+19/80>
   3:   81 e3 ff ff 00 00         and    $0xffff,%ebx
Code;  c0136b5f <__remove_from_lru_list+1f/80>
   9:   89 4a 20                  mov    %ecx,0x20(%edx)
Code;  c0136b62 <__remove_from_lru_list+22/80>
   c:   39 34 9d b0 94 30 c0      cmp    %esi,0xc03094b0(,%ebx,4)
Code;  c0136b69 <__remove_from_lru_list+29/80>
  13:   74 00                     je     15 <_EIP+0x15>


1 warning issued.  Results may not be reliable.

