Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291886AbSBHWXI>; Fri, 8 Feb 2002 17:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291887AbSBHWWy>; Fri, 8 Feb 2002 17:22:54 -0500
Received: from mx1.fuse.net ([216.68.2.90]:14035 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S291884AbSBHWWe>;
	Fri, 8 Feb 2002 17:22:34 -0500
Message-ID: <3C644F9B.4050702@fuse.net>
Date: Fri, 08 Feb 2002 17:22:19 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020203
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: USB OOPS persists in 2.5.3-dj4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to what I reported for 2.5.3-dj1, the following big bunch of 
OOPSes occur when the usb-uhci module is unloaded.  Something similar 
happens with uhci, but I have not tested it.  Removing usb-uhci appears 
to leave usbcore in such a state that modprobing usb-uhci into the 
kernel again causes instant lockup.  Moreover, the system runs for a few 
seconds (of typing, if that's important) after these oopses before it 
completely deadlocks, no SysRQ or anything.  However, this last time it 
didn't deadlock for over ten seconds as I alternated between Alt-SysRq-s 
and Alt-SysRq-u.  Looks like it's something to do with locking?  I've 
memtest86ed the machine and don't believe memory corruption is to blame.

Kernel patched thus: 2.5.3, -dj4, ACPI (20020207), built with gcc-2.95.4 
and binutils 2.11.92.0.12.3 (from Debian Woody).  There were no other 
modules loaded.  Anything else I can offer?

ksymoops 2.4.3 on i686 2.5.3-dj4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.3-dj4/ (default)
     -m /boot/System.map-2.5.3-dj4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Feb  8 16:46:08 (none) kernel: c014a9a2
Feb  8 16:46:08 (none) kernel: Oops: 0000
Feb  8 16:46:08 (none) kernel: CPU:    0
Feb  8 16:46:08 (none) kernel: EIP:    0010:[<c014a9a2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Feb  8 16:46:08 (none) kernel: EFLAGS: 00010246
Feb  8 16:46:08 (none) kernel: eax: cefb8860   ebx: cf001340   ecx: 
00000000   edx: cf001340
Feb  8 16:46:08 (none) kernel: esi: cfd42ba0   edi: 00000000   ebp: 
cfd42ba0   esp: cef57f50
Feb  8 16:46:08 (none) kernel: ds: 0018   es: 0018   ss: 0018
Feb  8 16:46:08 (none) kernel: Stack: cf001340 cfd42ba0 00000000 
00000001 c0138a54 cf001340 cfd42ba0 00000000
Feb  8 16:46:08 (none) kernel:        cf001340 00000000 00000003 
cfd42ba0 00000000 c011cc89 cf001340 cfd42ba0
Feb  8 16:46:08 (none) kernel:        cfa5cda0 401804c4 cf0b6180 
00000000 cfd42cc0 c011d434 cef56000 401804c4
Feb  8 16:46:08 (none) kernel: Call Trace: [<c0138a54>] [<c011cc89>] 
[<c011d434>] [<c011d61a>] [<c0108a27>]
Feb  8 16:46:08 (none) kernel: Code: 83 b9 a8 00 00 00 00 0f 84 69 01 00 
00 bb 00 e0 ff ff 21 e3

 >>EIP; c014a9a2 <locks_remove_posix+12/190>   <=====
Trace; c0138a54 <filp_close+98/a8>
Trace; c011cc88 <put_files_struct+4c/b4>
Trace; c011d434 <do_exit+11c/2dc>
Trace; c011d61a <sys_exit+e/10>
Trace; c0108a26 <syscall_call+6/a>
Code;  c014a9a2 <locks_remove_posix+12/190>
00000000 <_EIP>:
Code;  c014a9a2 <locks_remove_posix+12/190>   <=====
   0:   83 b9 a8 00 00 00 00      cmpl   $0x0,0xa8(%ecx)   <=====
Code;  c014a9a8 <locks_remove_posix+18/190>
   7:   0f 84 69 01 00 00         je     176 <_EIP+0x176> c014ab18 
<locks_remove_posix+188/190>
Code;  c014a9ae <locks_remove_posix+1e/190>
   d:   bb 00 e0 ff ff            mov    $0xffffe000,%ebx
Code;  c014a9b4 <locks_remove_posix+24/190>
  12:   21 e3                     and    %esp,%ebx

Feb  8 16:46:08 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 000000a8
Feb  8 16:46:08 (none) kernel: c0139022
Feb  8 16:46:08 (none) kernel: Oops: 0000
Feb  8 16:46:08 (none) kernel: CPU:    0
Feb  8 16:46:08 (none) kernel: EIP:    0010:[<c0139022>]    Not tainted
Feb  8 16:46:08 (none) kernel: EFLAGS: 00010202
Feb  8 16:46:08 (none) kernel: eax: cefb8860   ebx: cf001340   ecx: 
00000000   edx: 00000000
Feb  8 16:46:08 (none) kernel: esi: 00000000   edi: 00000000   ebp: 
00000080   esp: cf1e9fb0
Feb  8 16:46:08 (none) kernel: ds: 0018   es: 0018   ss: 0018
Feb  8 16:46:08 (none) kernel: Stack: cf1e8000 00000080 bffff89c 
bffff85c c0108a27 00000000 bffff89c 00000080
Feb  8 16:46:08 (none) kernel:        00000080 bffff89c bffff85c 
00000003 0000002b 0000002b 00000003 4012c4f4
Feb  8 16:46:08 (none) kernel:        00000023 00000293 bffff82c 0000002b
Feb  8 16:46:08 (none) kernel: Call Trace: [<c0108a27>]
Feb  8 16:46:08 (none) kernel: Code: 83 ba a8 00 00 00 00 74 35 8b 82 98 
00 00 00 f6 40 28 40 74

 >>EIP; c0139022 <sys_read+32/cc>   <=====
Trace; c0108a26 <syscall_call+6/a>
Code;  c0139022 <sys_read+32/cc>
00000000 <_EIP>:
Code;  c0139022 <sys_read+32/cc>   <=====
   0:   83 ba a8 00 00 00 00      cmpl   $0x0,0xa8(%edx)   <=====
Code;  c0139028 <sys_read+38/cc>
   7:   74 35                     je     3e <_EIP+0x3e> c0139060 
<sys_read+70/cc>
Code;  c013902a <sys_read+3a/cc>
   9:   8b 82 98 00 00 00         mov    0x98(%edx),%eax
Code;  c0139030 <sys_read+40/cc>
   f:   f6 40 28 40               testb  $0x40,0x28(%eax)
Code;  c0139034 <sys_read+44/cc>
  13:   74 00                     je     15 <_EIP+0x15> c0139036 
<sys_read+46/cc>

Feb  8 16:46:08 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 000000a8
Feb  8 16:46:08 (none) kernel: c014a9a2
Feb  8 16:46:08 (none) kernel: Oops: 0000
Feb  8 16:46:08 (none) kernel: CPU:    0
Feb  8 16:46:08 (none) kernel: EIP:    0010:[<c014a9a2>]    Not tainted
Feb  8 16:46:08 (none) kernel: EFLAGS: 00010246
Feb  8 16:46:08 (none) kernel: eax: cefb8860   ebx: cf001340   ecx: 
00000000   edx: cf001340
Feb  8 16:46:08 (none) kernel: esi: cee3ed60   edi: 00000000   ebp: 
cee3ed60   esp: cf1e9e48
Feb  8 16:46:08 (none) kernel: ds: 0018   es: 0018   ss: 0018
Feb  8 16:46:08 (none) kernel: Stack: cf001340 cee3ed60 00000000 
00000001 c0138a54 cf001340 cee3ed60 00000000
Feb  8 16:46:08 (none) kernel:        cf001340 00000000 00000001 
cee3ed60 00000000 c011cc89 cf001340 cee3ed60
Feb  8 16:46:08 (none) kernel:        cfa5c8a0 cfa5c8a0 cee3b580 
0000000b cee3ee80 c011d434 00000000 cfa5c8a0
Feb  8 16:46:08 (none) kernel: Call Trace: [<c0138a54>] [<c011cc89>] 
[<c011d434>] [<c0108f8f>] [<c0115de5>]
Feb  8 16:46:08 (none) kernel:    [<c0115a48>] [<c0115be7>] [<c0115a48>] 
[<c0118496>] [<c0108b10>] [<c0139022>]
Feb  8 16:46:08 (none) kernel:    [<c0108a27>]
Feb  8 16:46:08 (none) kernel: Code: 83 b9 a8 00 00 00 00 0f 84 69 01 00 
00 bb 00 e0 ff ff 21 e3

 >>EIP; c014a9a2 <locks_remove_posix+12/190>   <=====
Trace; c0138a54 <filp_close+98/a8>
Trace; c011cc88 <put_files_struct+4c/b4>
Trace; c011d434 <do_exit+11c/2dc>
Trace; c0108f8e <die+62/64>
Trace; c0115de4 <do_page_fault+39c/4d0>
Trace; c0115a48 <do_page_fault+0/4d0>
Trace; c0115be6 <do_page_fault+19e/4d0>
Trace; c0115a48 <do_page_fault+0/4d0>
Trace; c0118496 <__put_task_struct+1e/24>
Trace; c0108b10 <error_code+34/3c>
Trace; c0139022 <sys_read+32/cc>
Trace; c0108a26 <syscall_call+6/a>
Code;  c014a9a2 <locks_remove_posix+12/190>
00000000 <_EIP>:
Code;  c014a9a2 <locks_remove_posix+12/190>   <=====
   0:   83 b9 a8 00 00 00 00      cmpl   $0x0,0xa8(%ecx)   <=====
Code;  c014a9a8 <locks_remove_posix+18/190>
   7:   0f 84 69 01 00 00         je     176 <_EIP+0x176> c014ab18 
<locks_remove_posix+188/190>
Code;  c014a9ae <locks_remove_posix+1e/190>
   d:   bb 00 e0 ff ff            mov    $0xffffe000,%ebx
Code;  c014a9b4 <locks_remove_posix+24/190>
  12:   21 e3                     and    %esp,%ebx

Feb  8 16:46:08 (none) kernel: c01183ee
Feb  8 16:46:08 (none) kernel: Oops: 0002
Feb  8 16:46:08 (none) kernel: CPU:    0
Feb  8 16:46:08 (none) kernel: EIP:    0010:[<c01183ee>]    Not tainted
Feb  8 16:46:08 (none) kernel: EFLAGS: 00010086
Feb  8 16:46:08 (none) kernel: eax: 00000286   ebx: 00000000   ecx: 
c02c8800   edx: cef9ff68
Feb  8 16:46:08 (none) kernel: esi: cef79360   edi: cef9ff68   ebp: 
cef793c8   esp: cef9ff40
Feb  8 16:46:08 (none) kernel: ds: 0018   es: 0018   ss: 0018
Feb  8 16:46:08 (none) kernel: Stack: cef9e000 c0141c6e cfd31360 
cef79360 00000080 fffffff5 00000000 cf0b6180
Feb  8 16:46:08 (none) kernel:        00000000 00000000 00000000 
cf0b6180 cfd31364 cfd31364 c0141d43 cef79360
Feb  8 16:46:08 (none) kernel:        cfa658a0 ffffffea 00000000 
00000080 cef793c8 cef9e000 00000000 c0139086
Feb  8 16:46:08 (none) kernel: Call Trace: [<c0141c6e>] [<c0141d43>] 
[<c0139086>] [<c0108a27>]
Feb  8 16:46:08 (none) kernel: Code: f0 fe 0b 0f 88 b4 12 00 00 8b 4a 0c 
8b 52 08 89 4a 04 89 11

 >>EIP; c01183ee <remove_wait_queue+6/24>   <=====
Trace; c0141c6e <pipe_wait+8e/ac>
Trace; c0141d42 <pipe_read+b6/1fc>
Trace; c0139086 <sys_read+96/cc>
Trace; c0108a26 <syscall_call+6/a>
Code;  c01183ee <remove_wait_queue+6/24>
00000000 <_EIP>:
Code;  c01183ee <remove_wait_queue+6/24>   <=====
   0:   f0 fe 0b                  lock decb (%ebx)   <=====
Code;  c01183f0 <remove_wait_queue+8/24>
   3:   0f 88 b4 12 00 00         js     12bd <_EIP+0x12bd> c01196aa 
<.text.lock.fork+18/11e>
Code;  c01183f6 <remove_wait_queue+e/24>
   9:   8b 4a 0c                  mov    0xc(%edx),%ecx
Code;  c01183fa <remove_wait_queue+12/24>
   c:   8b 52 08                  mov    0x8(%edx),%edx
Code;  c01183fc <remove_wait_queue+14/24>
   f:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  c0118400 <remove_wait_queue+18/24>
  12:   89 11                     mov    %edx,(%ecx)

Feb  8 16:46:08 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 000000a8
Feb  8 16:46:08 (none) kernel: c014a9a2
Feb  8 16:46:08 (none) kernel: Oops: 0000
Feb  8 16:46:08 (none) kernel: CPU:    0
Feb  8 16:46:08 (none) kernel: EIP:    0010:[<c014a9a2>]    Not tainted
Feb  8 16:46:08 (none) kernel: EFLAGS: 00010246
Feb  8 16:46:08 (none) kernel: eax: cee8dbc0   ebx: cfa658a0   ecx: 
00000000   edx: cfa658a0
Feb  8 16:46:08 (none) kernel: esi: cfd42380   edi: 00000000   ebp: 
cfd42380   esp: cef9fdd8
Feb  8 16:46:08 (none) kernel: ds: 0018   es: 0018   ss: 0018
Feb  8 16:46:08 (none) kernel: Stack: cfa658a0 cfd42380 00000000 
00000001 c0138a54 cfa658a0 cfd42380 00000000
Feb  8 16:46:08 (none) kernel:        cfa658a0 00000000 00000001 
cfd42380 00000000 c011cc89 cfa658a0 cfd42380
Feb  8 16:46:08 (none) kernel:        cfa5c940 cfa5c940 cf0b6180 
0000000b cfd424a0 c011d434 00000002 cfa5c940
Feb  8 16:46:08 (none) kernel: Call Trace: [<c0138a54>] [<c011cc89>] 
[<c011d434>] [<c0108f8f>] [<c0115de5>]
Feb  8 16:46:08 (none) kernel:    [<c0115a48>] [<c012b0fa>] [<c012c118>] 
[<c012c145>] [<c0128648>] [<c0128d63>]
Feb  8 16:46:08 (none) kernel:    [<c0108b10>] [<c01183ee>] [<c0141c6e>] 
[<c0141d43>] [<c0139086>] [<c0108a27>]
Feb  8 16:46:08 (none) kernel: Code: 83 b9 a8 00 00 00 00 0f 84 69 01 00 
00 bb 00 e0 ff ff 21 e3

 >>EIP; c014a9a2 <locks_remove_posix+12/190>   <=====
Trace; c0138a54 <filp_close+98/a8>
Trace; c011cc88 <put_files_struct+4c/b4>
Trace; c011d434 <do_exit+11c/2dc>
Trace; c0108f8e <die+62/64>
Trace; c0115de4 <do_page_fault+39c/4d0>
Trace; c0115a48 <do_page_fault+0/4d0>
Trace; c012b0fa <find_get_page+1a/2c>
Trace; c012c118 <filemap_nopage+94/1dc>
Trace; c012c144 <filemap_nopage+c0/1dc>
Trace; c0128648 <do_wp_page+74/1b0>
Trace; c0128d62 <handle_mm_fault+8a/bc>
Trace; c0108b10 <error_code+34/3c>
Trace; c01183ee <remove_wait_queue+6/24>
Trace; c0141c6e <pipe_wait+8e/ac>
Trace; c0141d42 <pipe_read+b6/1fc>
Trace; c0139086 <sys_read+96/cc>
Trace; c0108a26 <syscall_call+6/a>
Code;  c014a9a2 <locks_remove_posix+12/190>
00000000 <_EIP>:
Code;  c014a9a2 <locks_remove_posix+12/190>   <=====
   0:   83 b9 a8 00 00 00 00      cmpl   $0x0,0xa8(%ecx)   <=====
Code;  c014a9a8 <locks_remove_posix+18/190>
   7:   0f 84 69 01 00 00         je     176 <_EIP+0x176> c014ab18 
<locks_remove_posix+188/190>
Code;  c014a9ae <locks_remove_posix+1e/190>
   d:   bb 00 e0 ff ff            mov    $0xffffe000,%ebx
Code;  c014a9b4 <locks_remove_posix+24/190>
  12:   21 e3                     and    %esp,%ebx

Feb  8 16:46:08 (none) kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 000000a8
Feb  8 16:46:08 (none) kernel: c014a9a2
Feb  8 16:46:08 (none) kernel: Oops: 0000
Feb  8 16:46:08 (none) kernel: CPU:    0
Feb  8 16:46:08 (none) kernel: EIP:    0010:[<c014a9a2>]    Not tainted
Feb  8 16:46:08 (none) kernel: EFLAGS: 00010246
Feb  8 16:46:08 (none) kernel: eax: cee8dbc0   ebx: cf0011c0   ecx: 
00000000   edx: cf0011c0
Feb  8 16:46:08 (none) kernel: esi: cfd421e0   edi: 00000000   ebp: 
cfd421e0   esp: cf06bf50
Feb  8 16:46:08 (none) kernel: ds: 0018   es: 0018   ss: 0018
Feb  8 16:46:08 (none) kernel: Stack: cf0011c0 cfd421e0 00000000 
00000001 c0138a54 cf0011c0 cfd421e0 00000000
Feb  8 16:46:08 (none) kernel:        cf0011c0 00000000 00000001 
cfd421e0 00000001 c011cc89 cf0011c0 cfd421e0
Feb  8 16:46:08 (none) kernel:        cfa5c940 401804c4 cf0b4060 
00000000 cfd42300 c011d434 cf06a000 401804c4
Feb  8 16:46:08 (none) kernel: Call Trace: [<c0138a54>] [<c011cc89>] 
[<c011d434>] [<c011d61a>] [<c0108a27>]
Feb  8 16:46:08 (none) kernel: Code: 83 b9 a8 00 00 00 00 0f 84 69 01 00 
00 bb 00 e0 ff ff 21 e3

 >>EIP; c014a9a2 <locks_remove_posix+12/190>   <=====
Trace; c0138a54 <filp_close+98/a8>
Trace; c011cc88 <put_files_struct+4c/b4>
Trace; c011d434 <do_exit+11c/2dc>
Trace; c011d61a <sys_exit+e/10>
Trace; c0108a26 <syscall_call+6/a>
Code;  c014a9a2 <locks_remove_posix+12/190>
00000000 <_EIP>:
Code;  c014a9a2 <locks_remove_posix+12/190>   <=====
   0:   83 b9 a8 00 00 00 00      cmpl   $0x0,0xa8(%ecx)   <=====
Code;  c014a9a8 <locks_remove_posix+18/190>
   7:   0f 84 69 01 00 00         je     176 <_EIP+0x176> c014ab18 
<locks_remove_posix+188/190>
Code;  c014a9ae <locks_remove_posix+1e/190>
   d:   bb 00 e0 ff ff            mov    $0xffffe000,%ebx
Code;  c014a9b4 <locks_remove_posix+24/190>
  12:   21 e3                     and    %esp,%ebx


1 warning issued.  Results may not be reliable.


