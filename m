Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUEDIyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUEDIyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUEDIyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:54:05 -0400
Received: from ee.oulu.fi ([130.231.61.23]:51172 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264276AbUEDIxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:53:31 -0400
Date: Tue, 4 May 2004 11:53:30 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: linux-kernel@vger.kernel.org
Subject: Re: bug: sleeping function called from invalid context at
 include/linux/rwsem.h:43
In-Reply-To: <Pine.GSO.4.58.0405031122050.11293@stekt37>
Message-ID: <Pine.GSO.4.58.0405041145280.13203@stekt37>
References: <Pine.GSO.4.58.0405031122050.11293@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004, Tuukka Toivonen wrote:

>I have dual PentiumIII, gcc 2.95.4 on Debian 3.0, linux 2.6.5. I open two

The computer has ECC memory so I don't think it's memory error, especially
since the error message seems to be same every time.

>aterms and run
>	while true; do rmmod atkbd; done
>in first and
>	while true; do modprobe atkbd; done
>in the second. Works fine for a while, but then I got the following Oops:
>
>input: AT Translated Set 2 keyboard on isa0060/serio0
>input: AT Translated Set 2 keyboard on isa0060/serio0
>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
>in_atomic():0, irqs_disabled():1
>Call Trace:
> [<c011c48b>] __might_sleep+0xa3/0xb0
> [<c0116ccb>] do_page_fault+0x83/0x4ba
> [<c0116c48>] do_page_fault+0x0/0x4ba
> [<c0143ccf>] kmem_cache_free+0x253/0x298
> [<c0150b52>] __pte_chain_free+0x46/0x64
> [<c011781e>] __change_page_attr+0x22/0x1b4
> [<c0117a1b>] change_page_attr+0x6b/0xd0
<snipped rest, look for earlier message for full first report>

I tried again, this time with the "rtc" module. So no, (as someone asked),
it doesn't depend on atkbd module, and I can produce the same problem each
time (although it takes maybe 30 seconds before the problem occurs).

Real Time Clock Driver v1.12
Real Time Clock Driver v1.12
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c011c48b>] __might_sleep+0xa3/0xb0
 [<c0116ccb>] do_page_fault+0x83/0x4ba
 [<c0116c48>] do_page_fault+0x0/0x4ba
 [<c016e2f7>] dput+0x1f/0x37c
 [<c0165a2b>] link_path_walk+0x90b/0xac0
 [<c0117fb8>] recalc_task_prio+0x140/0x150
 [<c0119f17>] schedule+0x5d7/0x710
 [<c0107ed9>] error_code+0x2d/0x38
 [<c013890b>] module_text_address+0x67/0x84
 [<c0131a1b>] kernel_text_address+0x2f/0x3b
 [<c0141685>] store_stackinfo+0x61/0x88
 [<c0143c7d>] kmem_cache_free+0x221/0x298
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c010746f>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address 00100100
 printing eip:
c013890b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    1
EIP:    0060:[<c013890b>]    Not tainted
EFLAGS: 00010007   (2.6.5)
EIP is at module_text_address+0x67/0x84
eax: f88f0000   ebx: 00002124   ecx: 00000000   edx: 001000fc
esi: 00000000   edi: 00000001   ebp: f6fa7f1c   esp: f6fa7f10
ds: 007b   es: 007b   ss: 0068
Process devfsd (pid: 283, threadinfo=f6fa6000 task=f6fd3a30)
Stack: e556b010 00000000 f6fa7f5c f6fa7f28 c0131a1b 00000000 f6fa7f44 c0141685
       00000000 e4dc7e68 f7ffd788 e556b000 00000ff0 f6fa7f74 c0143c7d f7ffd788
       e556b000 c01673db 00000000 e5b8df58 e556b000 00001000 c01673db c1af9f78
Call Trace:
 [<c0131a1b>] kernel_text_address+0x2f/0x3b
 [<c0141685>] store_stackinfo+0x61/0x88
 [<c0143c7d>] kmem_cache_free+0x221/0x298
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c010746f>] syscall_call+0x7/0xb

Code: 8b 42 04 0f 18 00 90 8d 42 04 3d 98 5c 2c c0 75 b4 31 c0 5b
 <7>CLASS: registering class device: ID = 'rtc'
class_hotplug - name = rtc
Real Time Clock Driver v1.12
CLASS: Unregistering class device. ID = 'rtc'
class_hotplug - name = rtc
device class 'rtc': release.
CLASS: registering class device: ID = 'rtc'
class_hotplug - name = rtc
Real Time Clock Driver v1.12
CLASS: Unregistering class device. ID = 'rtc'
<...>

I also ran ksymoops, although I'm not sure if this old version works very
well. At least is disassembler the code. Also note that the Oops happens
just after the first problem.

ksymoops 2.4.5 on i686 2.6.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5/ (default)
     -m /mnt/powerzone/boot/vmlinuz-2.6.5.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace:
 [<c011c48b>] __might_sleep+0xa3/0xb0
 [<c0116ccb>] do_page_fault+0x83/0x4ba
 [<c0116c48>] do_page_fault+0x0/0x4ba
 [<c016e2f7>] dput+0x1f/0x37c
 [<c0165a2b>] link_path_walk+0x90b/0xac0
 [<c0117fb8>] recalc_task_prio+0x140/0x150
 [<c0119f17>] schedule+0x5d7/0x710
 [<c0107ed9>] error_code+0x2d/0x38
 [<c013890b>] module_text_address+0x67/0x84
 [<c0131a1b>] kernel_text_address+0x2f/0x3b
 [<c0141685>] store_stackinfo+0x61/0x88
 [<c0143c7d>] kmem_cache_free+0x221/0x298
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c010746f>] syscall_call+0x7/0xb
Unable to handle kernel paging request at virtual address 00100100
c013890b
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c013890b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007   (2.6.5)
eax: f88f0000   ebx: 00002124   ecx: 00000000   edx: 001000fc
esi: 00000000   edi: 00000001   ebp: f6fa7f1c   esp: f6fa7f10
ds: 007b   es: 007b   ss: 0068
Stack: e556b010 00000000 f6fa7f5c f6fa7f28 c0131a1b 00000000 f6fa7f44 c0141685
       00000000 e4dc7e68 f7ffd788 e556b000 00000ff0 f6fa7f74 c0143c7d f7ffd788
       e556b000 c01673db 00000000 e5b8df58 e556b000 00001000 c01673db c1af9f78
Call Trace:
 [<c0131a1b>] kernel_text_address+0x2f/0x3b
 [<c0141685>] store_stackinfo+0x61/0x88
 [<c0143c7d>] kmem_cache_free+0x221/0x298
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c01673db>] sys_unlink+0xf7/0x148
 [<c010746f>] syscall_call+0x7/0xb
Code: 8b 42 04 0f 18 00 90 8d 42 04 3d 98 5c 2c c0 75 b4 31 c0 5b


Trace; c011c48b <__might_sleep+a3/b0>
Trace; c0116ccb <do_page_fault+83/4ba>
Trace; c0116c48 <do_page_fault+0/4ba>
Trace; c016e2f7 <dput+1f/37c>
Trace; c0165a2b <link_path_walk+90b/ac0>
Trace; c0117fb8 <recalc_task_prio+140/150>
Trace; c0119f17 <schedule+5d7/710>
Trace; c0107ed9 <error_code+2d/38>
Trace; c013890b <module_text_address+67/84>
Trace; c0131a1b <kernel_text_address+2f/3b>
Trace; c0141685 <store_stackinfo+61/88>
Trace; c0143c7d <kmem_cache_free+221/298>
Trace; c01673db <sys_unlink+f7/148>
Trace; c01673db <sys_unlink+f7/148>
Trace; c01673db <sys_unlink+f7/148>
Trace; c010746f <syscall_call+7/b>

>>EIP; c013890b <module_text_address+67/84>   <=====

>>eax; f88f0000 <__crc_utf8_wctomb+5feef7/61ed76>
>>ebx; 00002124 Before first symbol
>>edx; 001000fc <__crc_do_rw_taskfile+366f1/825c6>
>>ebp; f6fa7f1c <__crc_net_ratelimit+ebee1/181be3>
>>esp; f6fa7f10 <__crc_net_ratelimit+ebed5/181be3>

Trace; c0131a1b <kernel_text_address+2f/3b>
Trace; c0141685 <store_stackinfo+61/88>
Trace; c0143c7d <kmem_cache_free+221/298>
Trace; c01673db <sys_unlink+f7/148>
Trace; c01673db <sys_unlink+f7/148>
Trace; c01673db <sys_unlink+f7/148>
Trace; c010746f <syscall_call+7/b>

Code;  c013890b <module_text_address+67/84>
00000000 <_EIP>:
Code;  c013890b <module_text_address+67/84>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  c013890e <module_text_address+6a/84>
   3:   0f 18 00                  prefetchnta (%eax)
Code;  c0138911 <module_text_address+6d/84>
   6:   90                        nop
Code;  c0138912 <module_text_address+6e/84>
   7:   8d 42 04                  lea    0x4(%edx),%eax
Code;  c0138915 <module_text_address+71/84>
   a:   3d 98 5c 2c c0            cmp    $0xc02c5c98,%eax
Code;  c013891a <module_text_address+76/84>
   f:   75 b4                     jne    ffffffc5 <_EIP+0xffffffc5> c01388d0 <module_text_address+2c/84>
Code;  c013891c <module_text_address+78/84>
  11:   31 c0                     xor    %eax,%eax
Code;  c013891e <module_text_address+7a/84>
  13:   5b                        pop    %ebx


1 error issued.  Results may not be reliable.
