Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290866AbSAaDDb>; Wed, 30 Jan 2002 22:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290865AbSAaDDY>; Wed, 30 Jan 2002 22:03:24 -0500
Received: from mx1.fuse.net ([216.68.2.90]:53951 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S290866AbSAaDDG>;
	Wed, 30 Jan 2002 22:03:06 -0500
Message-ID: <3C58B3DD.3000800@fuse.net>
Date: Wed, 30 Jan 2002 22:02:53 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Various issues with 2.5.2-dj6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got 2.5.2-dj6 building today and have the following to report:

system stability is very nice.  Rock solid and responsive despite it 
being experimental.

I have the kernel patched in the following order:
2.5.2
2.5.2-dj6
preempt-kernel
acpi (against 2.4.17 - all mispatches fixed except for some trivia in 
Configure.help)
acpi-pci-irq-routing (obtained from LKML)

The following options are passed to the kernel:
pci=acpiirq root=/dev/hda7 ro

I can send my config to anybody who needs it.

Issue 1: kernel does not compile without SMP support (missing references 
to global_irq_holder in sched.c)
Issue 2: Two IEEE1934 modules needed to have "#include 
<linux/interrupt.h>" added (host.c and another one I forget)
Issue 3: Turning off hotplug (/etc/init.d/hotplug stop on a Debian 
unstable box - updated today) gives the following oopses (captured by 
"klogd -x") - see below.
Issue 4: Unmounting the drives read-only with Alt-SysRQ-U gives the 
following oops and locks the box except for further Alt-SysRQ-* (mount 
-o ro,remout /mount/point works fine) - see below.
Issue 5: Mouse (via /dev/input/mice) seems slugish this time (after a 
fresh cold boot).  Seemed fine first few times on 2.5.2-dj6 and fine 
under 2.4.18-pre7 /dev/psaux.


Hope this helps the 2.5 effort and isn't just something stupid (or a 
whole lot of stupid somethings) on my part.

--Nathan


--------------------------- batch of sequential OOPSes on hotplug unregister

Jan 30 18:22:12 (none) kernel: usb.c: USB disconnect on device 1
Jan 30 18:22:12 (none) kernel: usb.c: USB bus 1 deregistered
Jan 30 18:22:12 (none) kernel: usb.c: USB disconnect on device 1
Jan 30 18:22:12 (none) kernel: usb.c: USB disconnect on device 2
Jan 30 18:22:12 (none) kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000032
Jan 30 18:22:12 (none) kernel:  printing eip:
Jan 30 18:22:12 (none) kernel: c0153caa
Jan 30 18:22:12 (none) kernel: *pde = 00000000
Jan 30 18:22:12 (none) kernel: Oops: 0000
Jan 30 18:22:12 (none) kernel: CPU:    0
Jan 30 18:22:12 (none) kernel: EIP:    0010:[<c0153caa>]    Not tainted
Jan 30 18:22:12 (none) kernel: EFLAGS: 00010202
Jan 30 18:22:12 (none) kernel: eax: cf091220   ebx: cf1de000   ecx: 
00000000   edx: cf15eb40
Jan 30 18:22:12 (none) kernel: esi: 00000000   edi: 00000000   ebp: 
cf1be960   esp: cf1dff6c
Jan 30 18:22:12 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:12 (none) kernel: Process usb.agent (pid: 161, 
stackpage=cf1df000)
Jan 30 18:22:12 (none) kernel: Stack: cf1de000 cf1be960 00000000 
cf1be960 00000001 c013c01a 00000000 cf1be960
Jan 30 18:22:12 (none) kernel:        00000000 cf1de000 cf15ea20 
00000001 c014ad4e cf1be960 cf15ea20 cf1de000
Jan 30 18:22:12 (none) kernel:        00000003 080e4ec8 bffff650 
cf1be8e0 fffffff0 c0108a1b 00000003 00000001
Jan 30 18:22:12 (none) kernel: Call Trace: [<c013c01a>] [<c014ad4e>] 
[<c0108a1b>]
Jan 30 18:22:12 (none) kernel:
Jan 30 18:22:12 (none) kernel: Code: 0f b7 46 32 25 00 f0 ff ff 66 3d 00 
40 74 0a b8 ec ff ff ff

 >>EIP; c0153caa <fcntl_dirnotify+3e/190>   <=====
Trace; c013c01a <filp_close+9e/bc>
Trace; c014ad4e <sys_dup2+f6/160>
Trace; c0108a1a <system_call+32/38>
Code;  c0153caa <fcntl_dirnotify+3e/190>
00000000 <_EIP>:
Code;  c0153caa <fcntl_dirnotify+3e/190>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c0153cae <fcntl_dirnotify+42/190>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c0153cb2 <fcntl_dirnotify+46/190>
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  c0153cb6 <fcntl_dirnotify+4a/190>
   d:   74 0a                     je     19 <_EIP+0x19> c0153cc2 
<fcntl_dirnotify+56/190>
Code;  c0153cb8 <fcntl_dirnotify+4c/190>
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax

Jan 30 18:22:12 (none) kernel:  <6>usb.c: USB bus 2 deregistered
Jan 30 18:22:12 (none) kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Jan 30 18:22:12 (none) kernel:  printing eip:
Jan 30 18:22:12 (none) kernel: 00000000
Jan 30 18:22:12 (none) kernel: *pde = 00000000
Jan 30 18:22:12 (none) kernel: Oops: 0000
Jan 30 18:22:12 (none) kernel: CPU:    0
Jan 30 18:22:12 (none) kernel: EIP:    0010:[<00000000>]    Not tainted
Jan 30 18:22:12 (none) kernel: EFLAGS: 00010206
Jan 30 18:22:12 (none) kernel: eax: 00000000   ebx: c13c85c0   ecx: 
cf1be4e0   edx: 00000000
Jan 30 18:22:12 (none) kernel: esi: cf217000   edi: 00000000   ebp: 
cfe28ab4   esp: cf1adf30
Jan 30 18:22:12 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:12 (none) kernel: Process rmmod (pid: 125, stackpage=cf1ad000)
Jan 30 18:22:12 (none) kernel: Stack: c012fdeb cf1be4e0 c13c85c0 
00000000 00001000 cf1be4e0 ffffffea 00000000
Jan 30 18:22:12 (none) kernel:        00001000 cfc5baa8 00001000 
00000000 00001000 fffffff4 00000000 00000000
Jan 30 18:22:12 (none) kernel:        00000000 cfc5ba40 cfc5baf0 
00000000 6c000000 c016109a cf1be4e0 bfffdd64
Jan 30 18:22:12 (none) kernel: Call Trace: [<c012fdeb>] [<c016109a>] 
[<c013c66b>] [<c0108a1b>]
Jan 30 18:22:12 (none) kernel:
Jan 30 18:22:12 (none) kernel: Code:  Bad EIP value

 >>EIP; 00000000 Before first symbol
Trace; c012fdea <generic_file_write+452/6b8>
Trace; c016109a <ext3_file_write+46/4c>
Trace; c013c66a <sys_write+8e/c4>
Trace; c0108a1a <system_call+32/38>


Jan 30 18:22:12 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000032
Jan 30 18:22:12 (none) kernel:  printing eip:
Jan 30 18:22:12 (none) kernel: c0153caa
Jan 30 18:22:12 (none) kernel: *pde = 00000000
Jan 30 18:22:12 (none) kernel: Oops: 0000
Jan 30 18:22:12 (none) kernel: CPU:    0
Jan 30 18:22:12 (none) kernel: EIP:    0010:[<c0153caa>]    Not tainted
Jan 30 18:22:12 (none) kernel: EFLAGS: 00010202
Jan 30 18:22:12 (none) kernel: eax: cf091220   ebx: 0000000b   ecx: 
00000000   edx: cfb4f220
Jan 30 18:22:12 (none) kernel: esi: 00000000   edi: 00000000   ebp: 
cfb4f220   esp: cf1dfe10
Jan 30 18:22:12 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:12 (none) kernel: Process usb.agent (pid: 161, 
stackpage=cf1df000)
Jan 30 18:22:12 (none) kernel: Stack: 0000000b cfb4f220 00000000 
00000001 00000001 c013c01a 00000000 cfb4f220
Jan 30 18:22:12 (none) kernel:        00000000 0000000b cf15ea20 
00000000 c011dcf9 cfb4f220 cf15ea20 cf1de000
Jan 30 18:22:12 (none) kernel:        cf15ea20 cf1de000 cf64977c 
cf15eb40 c011e597 cf1de000 00000000 cf649760
Jan 30 18:22:12 (none) kernel: Call Trace: [<c013c01a>] [<c011dcf9>] 
[<c011e597>] [<c0108fda>] [<c0116215>]
Jan 30 18:22:12 (none) kernel:    [<c0115e70>] [<c012a480>] [<c012ad23>] 
[<c0116017>] [<c0115e70>] [<c0108b40>]
Jan 30 18:22:12 (none) kernel:    [<c0153caa>] [<c013c01a>] [<c014ad4e>] 
[<c0108a1b>]
Jan 30 18:22:12 (none) kernel:
Jan 30 18:22:12 (none) kernel: Code: 0f b7 46 32 25 00 f0 ff ff 66 3d 00 
40 74 0a b8 ec ff ff ff

 >>EIP; c0153caa <fcntl_dirnotify+3e/190>   <=====
Trace; c013c01a <filp_close+9e/bc>
Trace; c011dcf8 <put_files_struct+4c/b4>
Trace; c011e596 <do_exit+13e/350>
Trace; c0108fda <die+7e/80>
Trace; c0116214 <do_page_fault+3a4/4da>
Trace; c0115e70 <do_page_fault+0/4da>
Trace; c012a480 <do_wp_page+64/208>
Trace; c012ad22 <handle_mm_fault+8e/f8>
Trace; c0116016 <do_page_fault+1a6/4da>
Trace; c0115e70 <do_page_fault+0/4da>
Trace; c0108b40 <error_code+34/40>
Trace; c0153caa <fcntl_dirnotify+3e/190>
Trace; c013c01a <filp_close+9e/bc>
Trace; c014ad4e <sys_dup2+f6/160>
Trace; c0108a1a <system_call+32/38>
Code;  c0153caa <fcntl_dirnotify+3e/190>
00000000 <_EIP>:
Code;  c0153caa <fcntl_dirnotify+3e/190>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c0153cae <fcntl_dirnotify+42/190>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c0153cb2 <fcntl_dirnotify+46/190>
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  c0153cb6 <fcntl_dirnotify+4a/190>
   d:   74 0a                     je     19 <_EIP+0x19> c0153cc2 
<fcntl_dirnotify+56/190>
Code;  c0153cb8 <fcntl_dirnotify+4c/190>
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax

Jan 30 18:22:12 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000032
Jan 30 18:22:12 (none) kernel: c0153caa
Jan 30 18:22:12 (none) kernel: *pde = 00000000
Jan 30 18:22:12 (none) kernel: Oops: 0000
Jan 30 18:22:12 (none) kernel: CPU:    0
Jan 30 18:22:12 (none) kernel: EIP:    0010:[<c0153caa>]    Not tainted
Jan 30 18:22:12 (none) kernel: EFLAGS: 00010202
Jan 30 18:22:12 (none) kernel: eax: cf091220   ebx: 00000003   ecx: 
00000000   edx: cf1be960
Jan 30 18:22:12 (none) kernel: esi: 00000000   edi: 00000000   ebp: 
cf1be960   esp: cf2b9e10
Jan 30 18:22:12 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:12 (none) kernel: Process usb.agent (pid: 162, 
stackpage=cf2b9000)
Jan 30 18:22:12 (none) kernel: Stack: 00000003 cf1be960 00000000 
00000001 00000001 c013c01a 00000000 cf1be960
Jan 30 18:22:12 (none) kernel:        00000000 00000003 cf15e6e0 
00000001 c011dcf9 cf1be960 cf15e6e0 cf2b8000
Jan 30 18:22:12 (none) kernel:        cf15e6e0 cf2b8000 cf64963c 
cf15e800 c011e597 cf2b8000 00000000 cf649620
Jan 30 18:22:12 (none) kernel: Call Trace: [<c013c01a>] [<c011dcf9>] 
[<c011e597>] [<c0108fda>] [<c0116215>]
Jan 30 18:22:12 (none) kernel:    [<c0115e70>] [<c012a480>] [<c012ad23>] 
[<c0116017>] [<c0115e70>] [<c0108b40>]
Jan 30 18:22:12 (none) kernel:    [<c0153caa>] [<c013c01a>] [<c014ad4e>] 
[<c0108a1b>]

Jan 30 18:22:12 (none) kernel: Code: 0f b7 46 32 25 00 f0 ff ff 66 3d 00 
40 74 0a b8 ec ff ff ff

 >>EIP; c0153caa <fcntl_dirnotify+3e/190>   <=====
Trace; c013c01a <filp_close+9e/bc>
Trace; c011dcf8 <put_files_struct+4c/b4>
Trace; c011e596 <do_exit+13e/350>
Trace; c0108fda <die+7e/80>
Trace; c0116214 <do_page_fault+3a4/4da>
Trace; c0115e70 <do_page_fault+0/4da>
Trace; c012a480 <do_wp_page+64/208>
Trace; c012ad22 <handle_mm_fault+8e/f8>
Trace; c0116016 <do_page_fault+1a6/4da>
Trace; c0115e70 <do_page_fault+0/4da>
Trace; c0108b40 <error_code+34/40>
Trace; c0153caa <fcntl_dirnotify+3e/190>
Trace; c013c01a <filp_close+9e/bc>
Trace; c014ad4e <sys_dup2+f6/160>
Trace; c0108a1a <system_call+32/38>
Code;  c0153caa <fcntl_dirnotify+3e/190>
00000000 <_EIP>:
Code;  c0153caa <fcntl_dirnotify+3e/190>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c0153cae <fcntl_dirnotify+42/190>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c0153cb2 <fcntl_dirnotify+46/190>
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  c0153cb6 <fcntl_dirnotify+4a/190>
   d:   74 0a                     je     19 <_EIP+0x19> c0153cc2 
<fcntl_dirnotify+56/190>
Code;  c0153cb8 <fcntl_dirnotify+4c/190>
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax


Jan 30 18:22:12 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000032
Jan 30 18:22:12 (none) kernel: c0153caa
Jan 30 18:22:12 (none) kernel: *pde = 00000000
Jan 30 18:22:12 (none) kernel: Oops: 0000
Jan 30 18:22:12 (none) kernel: CPU:    0
Jan 30 18:22:12 (none) kernel: EIP:    0010:[<c0153caa>]    Not tainted
Jan 30 18:22:12 (none) kernel: EFLAGS: 00010202
Jan 30 18:22:12 (none) kernel: eax: cf091220   ebx: 00000003   ecx: 
00000000   edx: cfb4f220
Jan 30 18:22:12 (none) kernel: esi: 00000000   edi: 00000000   ebp: 
cfb4f220   esp: cefb7f54
Jan 30 18:22:12 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:12 (none) kernel: Process usb.agent (pid: 158, 
stackpage=cefb7000)
Jan 30 18:22:12 (none) kernel: Stack: 00000003 cfb4f220 00000000 
00000001 00000001 c013c01a 00000000 cfb4f220
Jan 30 18:22:12 (none) kernel:        00000000 00000003 cfb7e1e0 
00000000 c011dcf9 cfb4f220 cfb7e1e0 cefb6000
Jan 30 18:22:12 (none) kernel:        cfb7e1e0 cefb6000 bffff95c 
cfb7e300 c011e597 cefb6000 4017f384 0000008b
Jan 30 18:22:12 (none) kernel: Call Trace: [<c013c01a>] [<c011dcf9>] 
[<c011e597>] [<c011e7ce>] [<c0108a1b>]

Jan 30 18:22:12 (none) kernel: Code: 0f b7 46 32 25 00 f0 ff ff 66 3d 00 
40 74 0a b8 ec ff ff ff

 >>EIP; c0153caa <fcntl_dirnotify+3e/190>   <=====
Trace; c013c01a <filp_close+9e/bc>
Trace; c011dcf8 <put_files_struct+4c/b4>
Trace; c011e596 <do_exit+13e/350>
Trace; c011e7ce <sys_exit+e/10>
Trace; c0108a1a <system_call+32/38>
Code;  c0153caa <fcntl_dirnotify+3e/190>
00000000 <_EIP>:
Code;  c0153caa <fcntl_dirnotify+3e/190>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c0153cae <fcntl_dirnotify+42/190>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c0153cb2 <fcntl_dirnotify+46/190>
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  c0153cb6 <fcntl_dirnotify+4a/190>
   d:   74 0a                     je     19 <_EIP+0x19> c0153cc2 
<fcntl_dirnotify+56/190>
Code;  c0153cb8 <fcntl_dirnotify+4c/190>
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax



Jan 30 18:22:12 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 000000a8
Jan 30 18:22:12 (none) kernel: c013c54a
Jan 30 18:22:12 (none) kernel: *pde = 00000000
Jan 30 18:22:12 (none) kernel: Oops: 0000
Jan 30 18:22:12 (none) kernel: CPU:    0
Jan 30 18:22:12 (none) kernel: EIP:    0010:[<c013c54a>]    Not tainted
Jan 30 18:22:12 (none) kernel: EFLAGS: 00010202
Jan 30 18:22:12 (none) kernel: eax: cf091220   ebx: cfb4f220   ecx: 
00000000   edx: 00000000
Jan 30 18:22:12 (none) kernel: esi: 00000000   edi: 00000000   ebp: 
00000080   esp: ceffbfb0
Jan 30 18:22:12 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:12 (none) kernel: Process usb.agent (pid: 141, 
stackpage=ceffb000)
Jan 30 18:22:12 (none) kernel: Stack: ceffa000 00000080 bffff8dc 
bffff89c c0108a1b 00000000 bffff8dc 00000080
Jan 30 18:22:12 (none) kernel:        00000080 bffff8dc bffff89c 
00000003 0000002b 0000002b 00000003 4012b3c4
Jan 30 18:22:12 (none) kernel:        00000023 00000293 bffff86c 0000002b
Jan 30 18:22:12 (none) kernel: Call Trace: [<c0108a1b>]

Jan 30 18:22:12 (none) kernel: Code: 83 ba a8 00 00 00 00 74 2e 8b 82 98 
00 00 00 f6 40 28 40 74

 >>EIP; c013c54a <sys_read+32/c4>   <=====
Trace; c0108a1a <system_call+32/38>
Code;  c013c54a <sys_read+32/c4>
00000000 <_EIP>:
Code;  c013c54a <sys_read+32/c4>   <=====
   0:   83 ba a8 00 00 00 00      cmpl   $0x0,0xa8(%edx)   <=====
Code;  c013c550 <sys_read+38/c4>
   7:   74 2e                     je     37 <_EIP+0x37> c013c580 
<sys_read+68/c4>
Code;  c013c552 <sys_read+3a/c4>
   9:   8b 82 98 00 00 00         mov    0x98(%edx),%eax
Code;  c013c558 <sys_read+40/c4>
   f:   f6 40 28 40               testb  $0x40,0x28(%eax)
Code;  c013c55c <sys_read+44/c4>
  13:   74 00                     je     15 <_EIP+0x15> c013c55e 
<sys_read+46/c4>


Jan 30 18:22:12 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000032
Jan 30 18:22:12 (none) kernel: c0153caa
Jan 30 18:22:12 (none) kernel: *pde = 00000000
Jan 30 18:22:12 (none) kernel: Oops: 0000
Jan 30 18:22:12 (none) kernel: CPU:    0
Jan 30 18:22:12 (none) kernel: EIP:    0010:[<c0153caa>]    Not tainted
Jan 30 18:22:12 (none) kernel: EFLAGS: 00010202
Jan 30 18:22:12 (none) kernel: eax: cf091220   ebx: 00000001   ecx: 
00000000   edx: cfb4f220
Jan 30 18:22:12 (none) kernel: esi: 00000000   edi: 00000000   ebp: 
cfb4f220   esp: ceffbe54
Jan 30 18:22:12 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:12 (none) kernel: Process usb.agent (pid: 141, 
stackpage=ceffb000)
Jan 30 18:22:12 (none) kernel: Stack: 00000001 cfb4f220 00000000 
00000001 00000001 c013c01a 00000000 cfb4f220
Jan 30 18:22:12 (none) kernel:        00000000 00000001 cfb7e040 
00000000 c011dcf9 cfb4f220 cfb7e040 ceffa000
Jan 30 18:22:12 (none) kernel:        cfb7e040 ceffa000 cf649a9c 
cfb7e160 c011e597 ceffa000 00000000 cf649a80
Jan 30 18:22:12 (none) kernel: Call Trace: [<c013c01a>] [<c011dcf9>] 
[<c011e597>] [<c0108fda>] [<c0116215>]
Jan 30 18:22:12 (none) kernel:    [<c0115e70>] [<c0116017>] [<c0115e70>] 
[<c0108b40>] [<c013c54a>] [<c0108a1b>]

Jan 30 18:22:12 (none) kernel: Code: 0f b7 46 32 25 00 f0 ff ff 66 3d 00 
40 74 0a b8 ec ff ff ff

 >>EIP; c0153caa <fcntl_dirnotify+3e/190>   <=====
Trace; c013c01a <filp_close+9e/bc>
Trace; c011dcf8 <put_files_struct+4c/b4>
Trace; c011e596 <do_exit+13e/350>
Trace; c0108fda <die+7e/80>
Trace; c0116214 <do_page_fault+3a4/4da>
Trace; c0115e70 <do_page_fault+0/4da>
Trace; c0116016 <do_page_fault+1a6/4da>
Trace; c0115e70 <do_page_fault+0/4da>
Trace; c0108b40 <error_code+34/40>
Trace; c013c54a <sys_read+32/c4>
Trace; c0108a1a <system_call+32/38>
Code;  c0153caa <fcntl_dirnotify+3e/190>
00000000 <_EIP>:
Code;  c0153caa <fcntl_dirnotify+3e/190>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c0153cae <fcntl_dirnotify+42/190>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c0153cb2 <fcntl_dirnotify+46/190>
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  c0153cb6 <fcntl_dirnotify+4a/190>
   d:   74 0a                     je     19 <_EIP+0x19> c0153cc2 
<fcntl_dirnotify+56/190>
Code;  c0153cb8 <fcntl_dirnotify+4c/190>
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax


---------------------- following OOPS on Alt-SysRQ-U

Jan 30 18:22:20 (none) kernel: Remounting device 03:06 ... <1>Unable to 
handle kernel NULL pointer dereference at virtual address 00000032
Jan 30 18:22:20 (none) kernel:  printing eip:
Jan 30 18:22:20 (none) kernel: c01ceb54
Jan 30 18:22:20 (none) kernel: *pde = 00000000
Jan 30 18:22:20 (none) kernel: Oops: 0000
Jan 30 18:22:20 (none) kernel: CPU:    0
Jan 30 18:22:20 (none) kernel: EIP:    0010:[<c01ceb54>]    Not tainted
Jan 30 18:22:20 (none) kernel: EFLAGS: 00010202
Jan 30 18:22:20 (none) kernel: eax: 00000000   ebx: cfb55470   ecx: 
cfce8f20   edx: cf1be4e0
Jan 30 18:22:20 (none) kernel: esi: cfb55400   edi: 0000000f   ebp: 
0008e000   esp: cfc3bfbc
Jan 30 18:22:20 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:20 (none) kernel: Process bdflush (pid: 6, stackpage=cfc3b000)
Jan 30 18:22:20 (none) kernel: Stack: cfb55400 00000001 cfc3a34e 
cfc3a34e c01cec8c cfb55400 00000001 cfc3a000
Jan 30 18:22:20 (none) kernel:        c024c88e c014096e 00010f00 
cfe6bfbc c02bb9e8 c0107058 c02bb9e8 00000078
Jan 30 18:22:20 (none) kernel:        c02a5fc0
Jan 30 18:22:20 (none) kernel: Call Trace: [<c01cec8c>] [<c014096e>] 
[<c0107058>]
Jan 30 18:22:20 (none) kernel:
Jan 30 18:22:20 (none) kernel: Code: 0f b7 40 32 25 00 f0 ff ff 66 3d 00 
80 75 04 80 62 1c fd 8bReading Oops report from the terminal
Jan 30 18:22:20 (none) kernel: Remounting device 03:06 ... <1>Unable to 
handle kernel NULL pointer dereference at virtual address 00000032
Jan 30 18:22:20 (none) kernel: c01ceb54
Jan 30 18:22:20 (none) kernel: *pde = 00000000
Jan 30 18:22:20 (none) kernel: Oops: 0000
Jan 30 18:22:20 (none) kernel: CPU:    0
Jan 30 18:22:20 (none) kernel: EIP:    0010:[<c01ceb54>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 30 18:22:20 (none) kernel: EFLAGS: 00010202
Jan 30 18:22:20 (none) kernel: eax: 00000000   ebx: cfb55470   ecx: 
cfce8f20   edx: cf1be4e0
Jan 30 18:22:20 (none) kernel: esi: cfb55400   edi: 0000000f   ebp: 
0008e000   esp: cfc3bfbc
Jan 30 18:22:20 (none) kernel: ds: 0018   es: 0018   ss: 0018
Jan 30 18:22:20 (none) kernel: Process bdflush (pid: 6, stackpage=cfc3b000)
Jan 30 18:22:20 (none) kernel: Stack: cfb55400 00000001 cfc3a34e 
cfc3a34e c01cec8c cfb55400 00000001 cfc3a000
Jan 30 18:22:20 (none) kernel:        c024c88e c014096e 00010f00 
cfe6bfbc c02bb9e8 c0107058 c02bb9e8 00000078
Jan 30 18:22:20 (none) kernel:        c02a5fc0
Jan 30 18:22:20 (none) kernel: Call Trace: [<c01cec8c>] [<c014096e>] 
[<c0107058>]

Jan 30 18:22:20 (none) kernel: Code: 0f b7 40 32 25 00 f0 ff ff 66 3d 00 
80 75 04 80 62 1c fd 8b

 >>EIP; c01ceb54 <go_sync+a0/174>   <=====
Trace; c01cec8c <do_emergency_sync+64/110>
Trace; c014096e <bdflush+9e/100>
Trace; c0107058 <kernel_thread+28/38>
Code;  c01ceb54 <go_sync+a0/174>
00000000 <_EIP>:
Code;  c01ceb54 <go_sync+a0/174>   <=====
   0:   0f b7 40 32               movzwl 0x32(%eax),%eax   <=====
Code;  c01ceb58 <go_sync+a4/174>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c01ceb5c <go_sync+a8/174>
   9:   66 3d 00 80               cmp    $0x8000,%ax
Code;  c01ceb60 <go_sync+ac/174>
   d:   75 04                     jne    13 <_EIP+0x13> c01ceb66 
<go_sync+b2/174>
Code;  c01ceb62 <go_sync+ae/174>
   f:   80 62 1c fd               andb   $0xfd,0x1c(%edx)
Code;  c01ceb66 <go_sync+b2/174>
  13:   8b 00                     mov    (%eax),%eax



