Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRC0PDX>; Tue, 27 Mar 2001 10:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRC0PDE>; Tue, 27 Mar 2001 10:03:04 -0500
Received: from dupla.xtdnet.nl ([213.160.202.75]:37587 "EHLO dupla.xtdnet.nl")
	by vger.kernel.org with ESMTP id <S131324AbRC0PC5>;
	Tue, 27 Mar 2001 10:02:57 -0500
Date: Tue, 27 Mar 2001 17:01:48 +0200 (MET DST)
From: Paul Wouters <paul@xtdnet.nl>
To: <linux-kernel@vger.kernel.org>
Subject: SMP bugs (2.4.0-ac11, 2.4.1) with traces from the serial console
 (fwd)
Message-ID: <Pine.LNX.4.30.0103271701110.10833-100000@dupla.xtdnet.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, linux-smp is rather dead, so I'll repost it here.

Paul
---------- Forwarded message ----------
Date: Tue, 27 Mar 2001 12:40:23 +0200 (MET DST)
From: Paul Wouters <paul@xtdnet.nl>
To: linux-smp@vger.kernel.org
Subject: SMP bugs (2.4.0-ac11, 2.4.1) with traces from the serial console (fwd)


We've had quite some problems with one of our SMP servers, a dual P-III 333,
Asus mainboard.

I'll post some traces, which I got over the serial console. Machine would
normally be 99% dead in the water, no serial console input worked anymore
(eg sending a break for SysRq-u and SysRq-b would not work).
The machine is colocated, so I don't know if keyboard input was still
accepted. Userland would be quite dead, and networking would bein the worst
state imaginable. It would send out ICMP (eg ping works), and it would send
exactly one packet for each TCP connection (eg it would send syn-ack, but
then be silent forever).

When running 2.4.0-ac11 it would be reasonable stable (1-2 weeks of uptime).
On 2.4.1 it would die within hours. 2.4.2 didn't compile for me.

One of the things I noticed was that the system was also leaking fd's. I
would get messages like "VFS: file-max limit 4096 reached" and raising them
would only help for a day or so, "VFS: file-max limit 16384 reached"
This usually happened when I was doing something tough, heavy NFS stuff one
time, and heavy dns (webstats resolving an masse) at other times.

Below are the traces of the two kernels involved. If it is useful, I can
supply more data, if you tell me what else you need. But I'm fearing the
length of this email as it is.

Please CC: me on any replies, as I'm not on the linux-smp list.

Cheers,

Paul


On 2.4.0-ac11:

kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f579>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010092
eax: 00000020   ebx: cfff9400   ecx: 00000001   edx: 0000002f
esi: c0296c40   edi: c0296c18   ebp: 00000000   esp: cd19be44
ds: 0018   es: 0018   ss: 0018
Process named-xfer (pid: 17095, stackpage=cd19b000)
Stack: c0240eab c0241059 000000bf c0296c18 c0296df0 00000001 c5dad508 00000007
       c0296d94 c0296d90 00000286 00000000 c0296c18 c012f915 c15e22a0 c6296dc0
       00000001 c5dad508 00000000 c6296dc0 00000005 00000001 c0296dec c0124c77
Call Trace: [<c012f915>] [<c0124c77>] [<c0124cf4>] [<c0124eaa>] [<c0114447>] [<c01142e8>] [<c0125468>]
       [<c010dc6f>] [<c01090dc>]
Code: 0f 0b 83 c4 0c 89 f6 8b 53 04 8b 03 89 50 04 89 02 89 5c 24

>>EIP; c012f579 <rmqueue+79/278>   <=====
Trace; c012f915 <__alloc_pages+ed/2ec>
Trace; c0124c77 <do_anonymous_page+2f/7c>
Trace; c0124cf4 <do_no_page+30/c4>
Trace; c0124eaa <handle_mm_fault+122/1a8>
Trace; c0114447 <do_page_fault+15f/438>
Trace; c01142e8 <do_page_fault+0/438>
Trace; c0125468 <do_mmap_pgoff+360/424>
Trace; c010dc6f <old_mmap+c3/f0>
Trace; c01090dc <error_code+34/3c>
Code;  c012f579 <rmqueue+79/278>
00000000 <_EIP>:
Code;  c012f579 <rmqueue+79/278>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f57b <rmqueue+7b/278>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012f57e <rmqueue+7e/278>
   5:   89 f6                     mov    %esi,%esi
Code;  c012f580 <rmqueue+80/278>
   7:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c012f583 <rmqueue+83/278>
   a:   8b 03                     mov    (%ebx),%eax
Code;  c012f585 <rmqueue+85/278>
   c:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012f588 <rmqueue+88/278>
   f:   89 02                     mov    %eax,(%edx)
Code;  c012f58a <rmqueue+8a/278>
  11:   89 5c 24 00               mov    %ebx,0x0(%esp,1)

NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c022c492>]
EFLAGS: 00000082
eax: 00000000   ebx: c0296c18   ecx: c0296c18   edx: 00000000
esi: c0296c40   edi: 00000001   ebp: 00000000   esp: c50c7e88
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 469, stackpage=c50c7000)
Stack: c0296c18 c0296e18 00000001 cfdc1ea4 00000007 c0296d94 c0296d90 00000292
       00000000 c0296c18 c012f915 00000000 c50c7f58 c14e2d80 cfdc1ea4 00000000
       cf193ea0 00000007 00000001 c0296e14 c012fb28 c01444e3 ce706cc0 c14e2d80
Call Trace: [<c012f915>] [<c012fb28>] [<c01444e3>] [<c01e9a6f>] [<c01e62cb>] [<c014474b>] [<c0144c92>]
       [<c0108fab>]
Code: 80 39 00 f3 90 7e f9 e9 84 30 f0 ff 80 3f 00 f3 90 7e f9 e9

>>EIP; c022c492 <stext_lock+16e6/667d>   <=====
Trace; c012f915 <__alloc_pages+ed/2ec>
Trace; c012fb28 <__get_free_pages+14/20>
Trace; c01444e3 <__pollwait+33/94>
Trace; c01e9a6f <datagram_poll+27/f8>
Trace; c01e62cb <sock_poll+23/28>
Trace; c014474b <do_select+14b/234>
Trace; c0144c92 <sys_select+436/5a8>
Trace; c0108fab <system_call+33/38>
Code;  c022c492 <stext_lock+16e6/667d>
00000000 <_EIP>:
Code;  c022c492 <stext_lock+16e6/667d>   <=====
   0:   80 39 00                  cmpb   $0x0,(%ecx)   <=====
Code;  c022c495 <stext_lock+16e9/667d>
   3:   f3 90                     repz nop
Code;  c022c497 <stext_lock+16eb/667d>
   5:   7e f9                     jle    0 <_EIP>
Code;  c022c499 <stext_lock+16ed/667d>
   7:   e9 84 30 f0 ff            jmp    fff03090 <_EIP+0xfff03090> c012f522 <rmqueue+22/278>
Code;  c022c49e <stext_lock+16f2/667d>
   c:   80 3f 00                  cmpb   $0x0,(%edi)
Code;  c022c4a1 <stext_lock+16f5/667d>
   f:   f3 90                     repz nop
Code;  c022c4a3 <stext_lock+16f7/667d>
  11:   7e f9                     jle    c <_EIP+0xc> c022c49e <stext_lock+16f2/667d>
Code;  c022c4a5 <stext_lock+16f9/667d>
  13:   e9 00 00 00 00            jmp    18 <_EIP+0x18> c022c4aa <stext_lock+16fe/667d>



Crash number 2, same kernel:

EIP: [<c012f7LAGS: 00eax: 00000020   ebx: c1110670   ecx: 00000046   edx: 00000001
esi: 00000002   edi: c0296c18   ebp: 00000001   esp: c52a3ef8
ds: 0018   es: 0018   ss: 0018
Process java (pid: 15235, stackpage=c52a3000)
Stack: c0240eab c0241059 000000cb c0296c18 c0296e18 00000007 c52a3fbc c0296c4c
       00003018 00003018 00000286 00000001 c0296c18 c012f915 c52a2000 c52a3f94
       c52a2000 c52a3fbc 00000001 00000132 00000007 00000000 c0296e14 c012fb28
Call Trace: [<c012f915>] [<c012fb28>] [<c0116d0b>] [<c010dc6f>] [<c01078ca>] [<c0108fab>]
Code: 0f 0b 83 c4 0c 90 89 d8 eb 1c 45 83 c6 0c 83 fd 09 0f 86 cf
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c012f915 <__alloc_pages+ed/2ec>
Trace; c012fb28 <__get_free_pages+14/20>
Trace; c0116d0b <do_fork+93/774>
Trace; c010dc6f <old_mmap+c3/f0>
Trace; c01078ca <sys_clone+1e/28>
Trace; c0108fab <system_call+33/38>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   90                        nop
Code;  00000006 Before first symbol
   6:   89 d8                     mov    %ebx,%eax
Code;  00000008 Before first symbol
   8:   eb 1c                     jmp    26 <_EIP+0x26> 00000026 Before first symbol
Code;  0000000a Before first symbol
   a:   45                        inc    %ebp
Code;  0000000b Before first symbol
   b:   83 c6 0c                  add    $0xc,%esi
Code;  0000000e Before first symbol
   e:   83 fd 09                  cmp    $0x9,%ebp
Code;  00000011 Before first symbol
  11:   0f 86 cf 00 00 00         jbe    e6 <_EIP+0xe6> 000000e6 Before first symbol

kernel BUG at page_alloc.c:75!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c012f22e>]
EFLAGS: 00010296
eax: 0000001f   ebx: c1110670   ecx: 00000097   edx: 00000001
esi: c1110670   edi: c0296c38   ebp: 00000000   esp: c1477f78
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 5, stackpage=c1477000)
Stack: c0240eab c0241059 0000004b c1110698 c1110670 c0296c38 000000c7 000000c6
       ce2563c0 00000018 00000003 c012e36b c012fb7f c012e575 c1476000 c0242d6e
       00000000 0008e000 00000000 00000000 00000004 00000000 00001636 c0138d43
Call Trace: [<c012e36b>] [<c012fb7f>] [<c012e575>] [<c0138d43>] [<c0107503>]
Code: 0f 0b 83 c4 0c 89 d8 2b 05 18 90 30 c0 69 c0 f1 f0 f0 f0 c1

>>EIP; c012f22e <__free_pages_ok+3e/310>   <=====
Trace; c012e36b <page_launder+35b/85c>
Trace; c012fb7f <__free_pages+1b/1c>
Trace; c012e575 <page_launder+565/85c>
Trace; c0138d43 <bdflush+a3/e8>
Trace; c0107503 <kernel_thread+23/30>
Code;  c012f22e <__free_pages_ok+3e/310>
00000000 <_EIP>:
Code;  c012f22e <__free_pages_ok+3e/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f230 <__free_pages_ok+40/310>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012f233 <__free_pages_ok+43/310>
   5:   89 d8                     mov    %ebx,%eax
Code;  c012f235 <__free_pages_ok+45/310>
   7:   2b 05 18 90 30 c0         sub    0xc0309018,%eax
Code;  c012f23b <__free_pages_ok+4b/310>
   d:   69 c0 f1 f0 f0 f0         imul   $0xf0f0f0f1,%eax,%eax
Code;  c012f241 <__free_pages_ok+51/310>
  13:   c1 00 00                  roll   $0x0,(%eax)

Third crash, these were preceded by errors like:
fh_verify: logs/www.filename.com permission failure, acc=44, error=13

kernel BUG at page_alloc.c:203!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f3aa>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000020   ebx: c13a8f68   ecx: 00000000   edx: cf79403c
esi: 00000001   edi: c0290658   ebp: 00000000   esp: c50e5e60
ds: 0018   es: 0018   ss: 0018
Process grep (pid: 32211, stackpage=c50e5000)
Stack: c023e645 c023e7d3 000000cb c0290658 c0290830 00000001 cd799ae0 c0290680
       0000cc76 0000cc76 00000292 00000000 c0290658 c012f575 c1004520 cc3d2400
       00104025 cd799ae0 00000000 c1499304 00000005 00000001 c029082c c01245b0
Call Trace: [<c012f575>] [<c01245b0>] [<c0124d34>] [<c01142b7>] [<c0114158>] [<c0147d29>] [<c0125837>]
       [<c0125c0f>] [<c0125c47>] [<c01090dc>]
Code: 0f 0b 83 c4 0c 90 89 d8 eb 1c 45 83 c6 0c 83 fd 09 0f 86 cf

>>EIP; c012f3aa <__free_pages_ok+1ba/310>   <=====
Trace; c012f575 <rmqueue+75/278>
Trace; c01245b0 <remap_page_range+344/358>
Trace; c0124d34 <do_no_page+70/c4>
Trace; c01142b7 <__verify_write+f7/110>
Trace; c0114158 <free_initmem+5c/80>
Trace; c0147d29 <get_locks_status+c1/168>
Trace; c0125837 <find_vma+5f/64>
Trace; c0125c0f <do_munmap+9b/268>
Trace; c0125c47 <do_munmap+d3/268>
Trace; c01090dc <error_code+34/3c>
Code;  c012f3aa <__free_pages_ok+1ba/310>
00000000 <_EIP>:
Code;  c012f3aa <__free_pages_ok+1ba/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f3ac <__free_pages_ok+1bc/310>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012f3af <__free_pages_ok+1bf/310>
   5:   90                        nop
Code;  c012f3b0 <__free_pages_ok+1c0/310>
   6:   89 d8                     mov    %ebx,%eax
Code;  c012f3b2 <__free_pages_ok+1c2/310>
   8:   eb 1c                     jmp    26 <_EIP+0x26> c012f3d0 <__free_pages_ok+1e0/310>
Code;  c012f3b4 <__free_pages_ok+1c4/310>
   a:   45                        inc    %ebp
Code;  c012f3b5 <__free_pages_ok+1c5/310>
   b:   83 c6 0c                  add    $0xc,%esi
Code;  c012f3b8 <__free_pages_ok+1c8/310>
   e:   83 fd 09                  cmp    $0x9,%ebp
Code;  c012f3bb <__free_pages_ok+1cb/310>
  11:   0f 86 cf 00 00 00         jbe    e6 <_EIP+0xe6> c012f490 <__free_pages_ok+2a0/310>

kernel BUG at page_alloc.c:203!
kernel BUG at page_alloc.c:203!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f3aa>]
EFLAGS: 00010292
eax: 00000020   ebx: c1179f04   ecx: 00000001   edx: 00000001
esi: 00000001   edi: c0290658   ebp: 00000000   esp: c1d11e44
ds: 0018   es: 0018   ss: 0018
Process script (pid: 31775, stackpage=c1d11000)
Stack: c023e645 c023e7d3 000000cb c0290658 c0290830 00000001 c3f24f64 c0290680
       000048ed 000048ed 00000286 00000000 c0290658 c012f575 cfae2420 c63d1960
       00000001 c3f24f64 00000000 cfff9230 00000005 00000001 c029082c c0124ab7
Call Trace: [<c012f575>] [<c0124ab7>] [<c0124b34>] [<c0124cea>] [<c01142b7>] [<c0114158>] [<c01ea8d3>]
       [<c011adb1>] [<c01090dc>]
Code: 0f 0b 83 c4 0c 90 89 d8 eb 1c 45 83 c6 0c 83 fd 09 0f 86 cf

>>EIP; c012f3aa <__free_pages_ok+1ba/310>   <=====
Trace; c012f575 <rmqueue+75/278>
Trace; c0124ab7 <swapin_readahead+97/c4>
Trace; c0124b34 <do_swap_page+50/164>
Trace; c0124cea <do_no_page+26/c4>
Trace; c01142b7 <__verify_write+f7/110>
Trace; c0114158 <free_initmem+5c/80>
Trace; c01ea8d3 <dev_remove_pack+6f/b4>
Trace; c011adb1 <sys_wait4+261/3fc>
Trace; c01090dc <error_code+34/3c>
Code;  c012f3aa <__free_pages_ok+1ba/310>
00000000 <_EIP>:
Code;  c012f3aa <__free_pages_ok+1ba/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f3ac <__free_pages_ok+1bc/310>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012f3af <__free_pages_ok+1bf/310>
   5:   90                        nop
Code;  c012f3b0 <__free_pages_ok+1c0/310>
   6:   89 d8                     mov    %ebx,%eax
Code;  c012f3b2 <__free_pages_ok+1c2/310>
   8:   eb 1c                     jmp    26 <_EIP+0x26> c012f3d0 <__free_pages_ok+1e0/310>
Code;  c012f3b4 <__free_pages_ok+1c4/310>
   a:   45                        inc    %ebp
Code;  c012f3b5 <__free_pages_ok+1c5/310>
   b:   83 c6 0c                  add    $0xc,%esi
Code;  c012f3b8 <__free_pages_ok+1c8/310>
   e:   83 fd 09                  cmp    $0x9,%ebp
Code;  c012f3bb <__free_pages_ok+1cb/310>
  11:   0f 86 cf 00 00 00         jbe    e6 <_EIP+0xe6> c012f490 <__free_pages_ok+2a0/310>
invalid operand: 0000
CPU:    1
EIP:    0010:[<c012f3aa>]
EFLAGS: 00010286
eax: 00000020   ebx: c12547b4   ecx: 00000001   edx: 00000001
esi: 00000001   edi: c0290658   ebp: 00000000   esp: cf777e7c
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 456, stackpage=cf777000)
Stack: c023e645 c023e7d3 000000cb c0290658 c0290858 00000001 cf767b20 c0290680
       00007c59 00007c59 00000292 00000000 c0290658 c012f575 00000000 cf777f58
       cfd9ec80 cf767b20 00000000 cf7c7920 00000007 00000001 c0290854 c012f788
Call Trace: [<c012f575>] [<c012f788>] [<c0144233>] [<c01e900f>] [<c01e586b>] [<c014449b>] [<c01449e2>]
       [<c0108fab>]
Code: 0f 0b 83 c4 0c 90 89 d8 eb 1c 45 83 c6 0c 83 fd 09 0f 86 cf

>>EIP; c012f3aa <__free_pages_ok+1ba/310>   <=====
Trace; c012f575 <rmqueue+75/278>
Trace; c012f788 <__alloc_pages_limit+10/b0>
Trace; c0144233 <sys_getdents+6f/98>
Trace; c01e900f <copy_skb_header+43/cc>
Trace; c01e586b <evdev_connect+5f/d4>
Trace; c014449b <poll_freewait+3b/50>
Trace; c01449e2 <sys_select+186/5a8>
Trace; c0108fab <system_call+33/38>
Code;  c012f3aa <__free_pages_ok+1ba/310>
00000000 <_EIP>:
Code;  c012f3aa <__free_pages_ok+1ba/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f3ac <__free_pages_ok+1bc/310>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012f3af <__free_pages_ok+1bf/310>
   5:   90                        nop
Code;  c012f3b0 <__free_pages_ok+1c0/310>
   6:   89 d8                     mov    %ebx,%eax
Code;  c012f3b2 <__free_pages_ok+1c2/310>
   8:   eb 1c                     jmp    26 <_EIP+0x26> c012f3d0 <__free_pages_ok+1e0/310>
Code;  c012f3b4 <__free_pages_ok+1c4/310>
   a:   45                        inc    %ebp
Code;  c012f3b5 <__free_pages_ok+1c5/310>
   b:   83 c6 0c                  add    $0xc,%esi
Code;  c012f3b8 <__free_pages_ok+1c8/310>
   e:   83 fd 09                  cmp    $0x9,%ebp
Code;  c012f3bb <__free_pages_ok+1cb/310>
  11:   0f 86 cf 00 00 00         jbe    e6 <_EIP+0xe6> c012f490 <__free_pages_ok+2a0/310>

kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f1d9>]
EFLAGS: 00010092
eax: 00000020   ebx: c8cf4e44   ecx: 00000001   edx: 00000001
esi: c0290680   edi: c0290658   ebp: 00000000   esp: cf76dd68
ds: 0018   es: 0018   ss: 0018
Process sendmail (pid: 32214, stackpage=cf76d000)
Stack: c023e645 c023e7d3 000000bf c0290658 c0290830 00000001 c66ec05c 0000000b
       c02907d4 c02907d0 00000286 00000000 c0290658 c012f575 cfdc2320 ca1693c0
       00000001 c66ec05c 00000000 00002102 00000005 00000001 c029082c c0124ab7
Call Trace: [<c012f575>] [<c0124ab7>] [<c0124b34>] [<c0124cea>] [<c01142b7>] [<c0114158>] [<c0126e4c>]
       [<c0127e0d>] [<c0124b5d>] [<c01090dc>] [<c012790e>] [<c01278e0>] [<c0127584>] [<c0127997>] [<c01278e0>]
       [<c0134656>] [<c0108fab>]
Code: 0f 0b 83 c4 0c 89 f6 8b 53 04 8b 03 89 50 04 89 02 89 5c 24

>>EIP; c012f1d9 <rw_swap_page_nolock+d9/f0>   <=====
Trace; c012f575 <rmqueue+75/278>
Trace; c0124ab7 <swapin_readahead+97/c4>
Trace; c0124b34 <do_swap_page+50/164>
Trace; c0124cea <do_no_page+26/c4>
Trace; c01142b7 <__verify_write+f7/110>
Trace; c0114158 <free_initmem+5c/80>
Trace; c0126e4c <read_cluster_nonblocking+11c/144>
Trace; c0127e0d <nopage_sequential_readahead+5/12c>
Trace; c0124b5d <do_swap_page+79/164>
Trace; c01090dc <error_code+34/3c>
Trace; c012790e <do_generic_file_read+406/5b8>
Trace; c01278e0 <do_generic_file_read+3d8/5b8>
Trace; c0127584 <do_generic_file_read+7c/5b8>
Trace; c0127997 <do_generic_file_read+48f/5b8>
Trace; c01278e0 <do_generic_file_read+3d8/5b8>
Trace; c0134656 <sys_read+52/c8>
Trace; c0108fab <system_call+33/38>
Code;  c012f1d9 <rw_swap_page_nolock+d9/f0>
00000000 <_EIP>:
Code;  c012f1d9 <rw_swap_page_nolock+d9/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f1db <rw_swap_page_nolock+db/f0>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012f1de <rw_swap_page_nolock+de/f0>
   5:   89 f6                     mov    %esi,%esi
Code;  c012f1e0 <rw_swap_page_nolock+e0/f0>
   7:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c012f1e3 <rw_swap_page_nolock+e3/f0>
   a:   8b 03                     mov    (%ebx),%eax
Code;  c012f1e5 <rw_swap_page_nolock+e5/f0>
   c:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012f1e8 <rw_swap_page_nolock+e8/f0>
   f:   89 02                     mov    %eax,(%edx)
Code;  c012f1ea <rw_swap_page_nolock+ea/f0>
  11:   89 5c 24 00               mov    %ebx,0x0(%esp,1)

NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c022b9d6>]
EFLAGS: 00000082
eax: c0290680   ebx: 00132cc0   ecx: 00000001   edx: c1000010
esi: c0290658   edi: 00004830   ebp: 00000000   esp: ca32fee4
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 23612, stackpage=ca32f000)
Stack: c5830008 c583000c 00000000 c5830008 c1044010 c0290680 00000206 ffffffff
       00002418 c012f7df c012f804 c01441f6 00000000 ca32ff58 00000104 00000020
       c0144569 ca32ff58 ca32ffa8 00000006 c93cafd8 00000025 cde882a0 ca32ff58
Call Trace: [<c012f7df>] [<c012f804>] [<c01441f6>] [<c0144569>] [<c01449e2>] [<c0108fab>] [<c010002b>]
Code: 80 3e 00 f3 90 7e f9 e9 1d 36 f0 ff 80 39 00 f3 90 7e f9 e9

>>EIP; c022b9d6 <stext_lock+c2a/667d>   <=====
Trace; c012f7df <__alloc_pages_limit+67/b0>
Trace; c012f804 <__alloc_pages_limit+8c/b0>
Trace; c01441f6 <sys_getdents+32/98>
Trace; c0144569 <max_select_fd+25/bc>
Trace; c01449e2 <sys_select+186/5a8>
Trace; c0108fab <system_call+33/38>
Trace; c010002b <startup_32+2b/cb>
Code;  c022b9d6 <stext_lock+c2a/667d>
00000000 <_EIP>:
Code;  c022b9d6 <stext_lock+c2a/667d>   <=====
   0:   80 3e 00                  cmpb   $0x0,(%esi)   <=====
Code;  c022b9d9 <stext_lock+c2d/667d>
Trace; c010002b <startup_32+2b/cb>
Code;  c022b9d6 <stext_lock+c2a/667d>
00000000 <_EIP>:
Code;  c022b9d6 <stext_lock+c2a/667d>   <=====
   0:   80 3e 00                  cmpb   $0x0,(%esi)   <=====
Code;  c022b9d9 <stext_lock+c2d/667d>
   3:   f3 90                     repz nop
Code;  c022b9db <stext_lock+c2f/667d>
   5:   7e f9                     jle    0 <_EIP>
Code;  c022b9dd <stext_lock+c31/667d>
   7:   e9 1d 36 f0 ff            jmp    fff03629 <_EIP+0xfff03629> c012efff <rw_swap_page_base+16f/1ac>
Code;  c022b9e2 <stext_lock+c36/667d>
   c:   80 39 00                  cmpb   $0x0,(%ecx)
Code;  c022b9e5 <stext_lock+c39/667d>
   f:   f3 90                     repz nop
Code;  c022b9e7 <stext_lock+c3b/667d>
  11:   7e f9                     jle    c <_EIP+0xc> c022b9e2 <stext_lock+c36/667d>
Code;  c022b9e9 <stext_lock+c3d/667d>
  13:   e9 00 00 00 00            jmp    18 <_EIP+0x18> c022b9ee <stext_lock+c42/667d>

And a last one on 2.4.1 (two traces, it panics, and panics again while I tried
to remotely reboot it)

(ksymoops ran with -V -K, sorry)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at page_alloc.c:203!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f3aa>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000020   ebx: c10968c0   ecx: 00000002   edx: 00000002
esi: 00000001   edi: c0290658   ebp: 00000000   esp: c8ee1e9c
ds: 0018   es: 0018   ss: 0018
Process pine (pid: 4811, stackpage=c8ee1000)
Stack: c023e645 c023e7d3 000000cb c0290658 c0290830 00000001 0000001f c0290680
       0000136c 0000136c 00000296 00000000 c0290658 c012f575 00000000 c2f3f0e0
       c465a124 0000001f 00000000 c1096904 00000005 00000001 c029082c c012726f
Call Trace: [<c012f575>] [<c012726f>] [<c012756b>] [<c0127997>] [<c01278e0>] [<c0134656>] [<c0108fab>]
Code: 0f 0b 83 c4 0c 90 89 d8 eb 1c 45 83 c6 0c 83 fd 09 0f 86 cf

>>EIP; c012f3aa <rmqueue+24a/278>   <=====
Trace; c012f575 <__alloc_pages+ed/2ec>
Trace; c012726f <generic_file_readahead+20f/2c8>
Trace; c012756b <do_generic_file_read+243/5b8>
Trace; c0127997 <generic_file_read+63/80>
Trace; c01278e0 <file_read_actor+0/54>
Trace; c0134656 <sys_read+92/c8>
Trace; c0108fab <system_call+33/38>
Code;  c012f3aa <rmqueue+24a/278>
00000000 <_EIP>:
Code;  c012f3aa <rmqueue+24a/278>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f3ac <rmqueue+24c/278>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012f3af <rmqueue+24f/278>
   5:   90                        nop
Code;  c012f3b0 <rmqueue+250/278>
   6:   89 d8                     mov    %ebx,%eax
Code;  c012f3b2 <rmqueue+252/278>
   8:   eb 1c                     jmp    26 <_EIP+0x26> c012f3d0 <rmqueue+270/278>
Code;  c012f3b4 <rmqueue+254/278>
   a:   45                        inc    %ebp
Code;  c012f3b5 <rmqueue+255/278>
   b:   83 c6 0c                  add    $0xc,%esi
Code;  c012f3b8 <rmqueue+258/278>
   e:   83 fd 09                  cmp    $0x9,%ebp
Code;  c012f3bb <rmqueue+25b/278>
  11:   0f 86 cf 00 00 00         jbe    e6 <_EIP+0xe6> c012f490 <__alloc_pages+8/2ec>

kernel BUG at page_alloc.c:203!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f3aa>]
EFLAGS: 00010292
eax: 00000020   ebx: c1068e8c   ecx: 00000002   edx: 00000002
esi: 00000001   edi: c0290658   ebp: 00000000   esp: c71afe38
ds: 0018   es: 0018   ss: 0018
Process ypserv (pid: 7723, stackpage=c71af000)
Stack: c023e645 c023e7d3 000000cb c0290658 c0290830 00000002 00000000 c0290680
       000008a8 000008af 00000282 00000000 c0290658 c012f466 00000000 c0290838
       c029082c c15fe0a0 0000015e c012f5c4 c029082c 00000000 00000002 00000001
Call Trace: [<c012f466>] [<c012f5c4>] [<c01245b0>] [<c0124d34>] [<c01142b7>] [<c0114158>] [<c01f3d55>]
       [<c0145add>] [<c0134210>] [<c0134277>] [<c01090dc>]
Code: 0f 0b 83 c4 0c 90 89 d8 eb 1c 45 83 c6 0c 83 fd 09 0f 86 cf

>>EIP; c012f3aa <rmqueue+24a/278>   <=====
Trace; c012f466 <__alloc_pages_limit+8e/b0>
Trace; c012f5c4 <__alloc_pages+13c/2ec>
Trace; c01245b0 <do_wp_page+17c/268>
Trace; c0124d34 <handle_mm_fault+16c/1a8>
Trace; c01142b7 <do_page_fault+15f/438>
Trace; c0114158 <do_page_fault+0/438>
Trace; c01f3d55 <ip_rcv+2e5/380>
Trace; c0145add <locks_delete_lock+e9/f0>
Trace; c0134210 <filp_close+b0/bc>
Trace; c0134277 <sys_close+5b/74>
Trace; c01090dc <error_code+34/3c>
Code;  c012f3aa <rmqueue+24a/278>
00000000 <_EIP>:
Code;  c012f3aa <rmqueue+24a/278>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f3ac <rmqueue+24c/278>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012f3af <rmqueue+24f/278>
   5:   90                        nop
Code;  c012f3b0 <rmqueue+250/278>
   6:   89 d8                     mov    %ebx,%eax
Code;  c012f3b2 <rmqueue+252/278>
   8:   eb 1c                     jmp    26 <_EIP+0x26> c012f3d0 <rmqueue+270/278>
Code;  c012f3b4 <rmqueue+254/278>
   a:   45                        inc    %ebp
Code;  c012f3b5 <rmqueue+255/278>
   b:   83 c6 0c                  add    $0xc,%esi
Code;  c012f3b8 <rmqueue+258/278>
   e:   83 fd 09                  cmp    $0x9,%ebp
Code;  c012f3bb <rmqueue+25b/278>
  11:   0f 86 cf 00 00 00         jbe    e6 <_EIP+0xe6> c012f490 <__alloc_pages+8/2ec>

kernel BUG at page_alloc.c:75!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c012ee8e>]
EFLAGS: 00010282
eax: 0000001f   ebx: c10968c0   ecx: 00000046   edx: 00000001
esi: 00000000   edi: 00173000   ebp: 00000000   esp: c1ed3e5c
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 861, stackpage=c1ed3000)
Stack: c023e645 c023e7d3 0000004b c10968c0 00000000 00173000 0000000b c1044010
       c0290680 00000203 ffffffff 00003c02 c012f7df c012fcab c10968c0 00000000
       c012385a c10968c0 c1c9dda0 c15fec80 40573000 0000c000 c10968c0 0236c027
Call Trace: [<c012f7df>] [<c012fcab>] [<c012385a>] [<c0125ef4>] [<c0116378>] [<c011a7cf>] [<c0108e31>]
       [<c01207ed>] [<c0108496>] [<c0108ffc>]
Code: 0f 0b 83 c4 0c 89 d8 2b 05 d8 1f 30 c0 69 c0 f1 f0 f0 f0 c1

>>EIP; c012ee8e <__free_pages_ok+3e/310>   <=====
Trace; c012f7df <__free_pages+1b/1c>
Trace; c012fcab <free_page_and_swap_cache+ab/b0>
Trace; c012385a <zap_page_range+1da/278>
Trace; c0125ef4 <exit_mmap+c4/124>
Trace; c0116378 <mmput+38/50>
Trace; c012385a <zap_page_range+1da/278>
Trace; c0125ef4 <exit_mmap+c4/124>
Trace; c0116378 <mmput+38/50>
Trace; c011a7cf <do_exit+cf/294>
Trace; c0108e31 <do_signal+209/2a0>
Trace; c01207ed <sys_rt_sigaction+81/e0>
Trace; c0108496 <sys_sigreturn+c2/e8>
Trace; c0108ffc <signal_return+14/18>
Code;  c012ee8e <__free_pages_ok+3e/310>
00000000 <_EIP>:
Code;  c012ee8e <__free_pages_ok+3e/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012ee90 <__free_pages_ok+40/310>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012ee93 <__free_pages_ok+43/310>
   5:   89 d8                     mov    %ebx,%eax
Code;  c012ee95 <__free_pages_ok+45/310>
   7:   2b 05 d8 1f 30 c0         sub    0xc0301fd8,%eax
Code;  c012ee9b <__free_pages_ok+4b/310>
   d:   69 c0 f1 f0 f0 f0         imul   $0xf0f0f0f1,%eax,%eax
Code;  c012eea1 <__free_pages_ok+51/310>
  13:   c1 00 00                  roll   $0x0,(%eax)




