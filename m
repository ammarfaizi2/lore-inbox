Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbTCRJOV>; Tue, 18 Mar 2003 04:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbTCRJOV>; Tue, 18 Mar 2003 04:14:21 -0500
Received: from w1312.hostcentric.net ([66.40.206.254]:61704 "HELO
	w1312.hostcentric.net") by vger.kernel.org with SMTP
	id <S262314AbTCRJOR>; Tue, 18 Mar 2003 04:14:17 -0500
Message-Id: <5.2.0.9.0.20030318150912.033626b0@mail.impulsesoft.com>
Illegal-Object: Syntax error in X-Sender: address found on vger.kernel.org:
	X-Sender:	nalin@impulsesoft.com@mail.impulsesoft.com
					     ^-illegal special character in phrase
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 18 Mar 2003 15:09:58 +0530
To: linux-kernel@vger.kernel.org
From: Nalin Gupta <nalin@impulsesoft.com>
Subject: alloc_skb panic oops / virtual network interface
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friends,

I desperately need help on following issue.
I'll be extremely grateful for the help.
May be my approach is incorrect, as I am a sort of starter.

I'm using (RH 7.3) 2.4.18-3

For some reason, I am writing a "virtual network device interface"
which in turn uses UDP Socket to perform IP packet transfer as payload,
across network. For this reason, I have a daemonized kernel_thread,
which further creates a udp socket and passes it to a
new kernel thread as argument.

This new kernel_thread blocks on sock_recvmsg call. I have wrapped
calls like "sock_recvmsg" and "sock_sendmsg" with get_fs/set_fs in
typical manner.

I understand that sock->sk->allocation will be GFP_KERNEL, and
whenever any local user application like ping will use my device
to transmit out its data, that will happen on BH/Tasklet -
"do_softirq/net_tx_action".

For this reason, it will be in interrupt context. So I mask
GFP_WAIT bit like:
             priv->sock->sk->allocation &= ~__GFP_WAIT;

My network interface comes up nicely: (appears to me)

%ifconfig

mic0 Link encap:Point-to-Point Protocol
           inet addr:30.0.0.1 P-t-P:30.0.0.2 Mask:255.255.255.255
           UP POINTOPOINT RUNNING NOARP MULTICAST MTU:1300 Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:50
           RX bytes:0 (0.0 b) TX bytes:0 (0.0 b)

I can also do
                 %ping 30.0.0.1
but now if I try
                 %ping 30.0.0.2 -I mic0
kernel panic with oops.

Using Serial Console, I captured Oops msg, appended at end.

Using ksymoops and also objdump/nm tool, it appears to me
that it panics at file:(include/linux/skbuff.h:575)
     inline function: __skb_dequeue (struct sk_buff_head *list)
     line 575: next->prev = prev;

Probably the statment before this (line:572)
       next = next->next;
plays some important role. From edx becoming ZERO, implies
next is assigned NULL. Is it correct ?

Am I doing something conceptually incorrect ?
Or is it some paging problem and I need to take care of same.
If yes, then how.

It seems that function sock_alloc_send_pskb is pretty complicated
and needs to be used with care. If some one could share related
vital point, that would be great help to me.

regards,
- nalin

==================== Oops ==========================
Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
c01c5b5d
*pde = 00000000
Oops: 0002
f t binfmt_misc autofs 8139too mii ide-cd cdrom ehci-hcd usb-uhci usbcore ext3
CPU: 0
EIP: 0010:[<c01c5b5d>] Tainted: P
EFLAGS: 00010006

EIP is at alloc_skb [kernel] 0x7d (2.4.18-3)

eax: c6bca500 ebx: 00000013 ecx: 00000202 edx: 00000000
esi: 000001e0 edi: 00000000 ebp: c4ea65a0 esp: c4545a1c
ds: 0018 es: 0018 ss: 0018

Process ping (pid: 1171, stackpage=c4545000)

Stack: 000001e0 c4544000 c01c5083 0000008f 000001e0 c6bca5c0 c02d16e0 c6bca5c0
        c594d120 c01cd509 00000010 c4ea65a0 00000000 c4ea65a0 c01c51fb 
c4ea65a0
        0000008f 00000000 00000000 c4545a84 c01de445 c4ea65a0 0000008f 
00000000
Call Trace:
[<c01c5083>] sock_alloc_send_pskb [kernel] 0x73
[<c01cd509>] neigh_resolve_output [kernel] 0xc9
[<c01c51fb>] sock_alloc_send_skb [kernel] 0x1b
[<c01de445>] ip_build_xmit [kernel] 0x105
[<c01f6ed6>] udp_sendmsg [kernel] 0x386
[<c01f6a20>] udp_getfrag [kernel] 0x0
[<c01778e9>] scrup [kernel] 0x69
[<c01b3192>] vgacon_cursor [kernel] 0x192
[<c01fcc65>] inet_sendmsg [kernel] 0x35
[<c01c2adc>] sock_sendmsg [kernel] 0x6c
[<c0117feb>] call_console_drivers [kernel] 0xeb
[<c80ddc9e>] mic_SendMsgTo [f] 0x72
[<c80dd8f5>] micdev_xmit [f] 0x12d
[<c809b401>] rh_status_urb [usbcore] 0xa1
[<c01d165a>] qdisc_restart [kernel] 0x4a
[<c01c9dee>] net_tx_action [kernel] 0x9e
[<c011bccb>] do_softirq [kernel] 0x4b
[<c01cb5d2>] .text.lock.dev [kernel] 0x4c
[<c01dd8ee>] ip_output [kernel] 0xde
[<c01de601>] ip_build_xmit [kernel] 0x2c1
[<c01de623>] ip_build_xmit [kernel] 0x2e3
[<c01f5f30>] raw_sendmsg [kernel] 0x2d0
[<c01f5b80>] raw_getfrag [kernel] 0x0
[<c0200bc8>] fn_hash_lookup [kernel] 0x98
[<c01fcc65>] inet_sendmsg [kernel] 0x35
[<c01c2adc>] sock_sendmsg [kernel] 0x6c
[<c01c2602>] move_addr_to_kernel [kernel] 0x32
[<c01c3cb6>] sys_sendmsg [kernel] 0x186
[<c016c4c7>] tty_write [kernel] 0x187
[<c016dbd9>] tty_ioctl [kernel] 0x189
[<c01c412c>] sys_socketcall [kernel] 0x1dc
[<c0108923>] system_call [kernel] 0x33

Code: c7 42 04 c0 be 36 c0 89 15 c0 be 36 c0 c7 00 00 00 00 00 c7
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

================================= Ksymoops ================================
ksymoops 2.4.4 on i686 2.4.18-3. Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.18-3/ (default)
      -m /boot/System.map-2.4.18-3 (default)

Warning: You did not tell me where to find symbol information. I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc. ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (compare_maps): mismatch on symbol partition_name , ksyms_base says
c01bd130, System.map says c015abe0. Ignoring ksyms_base entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique 
module
object. Trace may not be reliable.
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01c5b5d
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c01c5b5d>] Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c6bca500 ebx: 00000013 ecx: 00000202 edx: 00000000
esi: 000001e0 edi: 00000000 ebp: c4ea65a0 esp: c4545a1c
ds: 0018 es: 0018 ss: 0018
Process ping (pid: 1171, stackpage=c4545000)
Stack: 000001e0 c4544000 c01c5083 0000008f 000001e0 c6bca5c0 c02d16e0 c6bca5c0
        c594d120 c01cd509 00000010 c4ea65a0 00000000 c4ea65a0 c01c51fb 
c4ea65a0
        0000008f 00000000 00000000 c4545a84 c01de445 c4ea65a0 0000008f 
00000000

Call Trace:
[<c01c5083>] sock_alloc_send_pskb [kernel] 0x73
[<c01cd509>] neigh_resolve_output [kernel] 0xc9
[<c01c51fb>] sock_alloc_send_skb [kernel] 0x1b
[<c01de445>] ip_build_xmit [kernel] 0x105
[<c01f6ed6>] udp_sendmsg [kernel] 0x386
[<c01f6a20>] udp_getfrag [kernel] 0x0
[<c01778e9>] scrup [kernel] 0x69
[<c01b3192>] vgacon_cursor [kernel] 0x192
[<c01fcc65>] inet_sendmsg [kernel] 0x35
[<c01c2adc>] sock_sendmsg [kernel] 0x6c
[<c0117feb>] call_console_drivers [kernel] 0xeb
[<c80ddc9e>] mic_SendMsgTo [f] 0x72
[<c80dd8f5>] micdev_xmit [f] 0x12d
[<c809b401>] rh_status_urb [usbcore] 0xa1
[<c01d165a>] qdisc_restart [kernel] 0x4a
[<c01c9dee>] net_tx_action [kernel] 0x9e
[<c011bccb>] do_softirq [kernel] 0x4b
[<c01cb5d2>] .text.lock.dev [kernel] 0x4c
[<c01dd8ee>] ip_output [kernel] 0xde
[<c01de601>] ip_build_xmit [kernel] 0x2c1
[<c01de623>] ip_build_xmit [kernel] 0x2e3
[<c01f5f30>] raw_sendmsg [kernel] 0x2d0
[<c01f5b80>] raw_getfrag [kernel] 0x0
[<c0200bc8>] fn_hash_lookup [kernel] 0x98
[<c01fcc65>] inet_sendmsg [kernel] 0x35
[<c01c2adc>] sock_sendmsg [kernel] 0x6c
[<c01c2602>] move_addr_to_kernel [kernel] 0x32
[<c01c3cb6>] sys_sendmsg [kernel] 0x186
[<c016c4c7>] tty_write [kernel] 0x187
[<c016dbd9>] tty_ioctl [kernel] 0x189
[<c01c412c>] sys_socketcall [kernel] 0x1dc
[<c0108923>] system_call [kernel] 0x33
Code: c7 42 04 c0 be 36 c0 89 15 c0 be 36 c0 c7 00 00 00 00 00 c7
 >>EIP; c01c5b5d <alloc_skb+7d/1b0> <=====
Trace; c01c5083 <sock_alloc_send_pskb+73/1d0>
Trace; c01cd509 <neigh_resolve_output+c9/1a0>
Trace; c01c51fb <sock_alloc_send_skb+1b/20>
Trace; c01de445 <ip_build_xmit+105/390>
Trace; c01f6ed6 <udp_sendmsg+386/410>
Trace; c01f6a20 <udp_getfrag+0/d0>
Trace; c01778e9 <scrup+69/120>
Trace; c01b3192 <vgacon_cursor+192/1a0>
Trace; c01fcc65 <inet_sendmsg+35/40>
Trace; c01c2adc <sock_sendmsg+6c/90>
Trace; c0117feb <call_console_drivers+eb/100>
Trace; c80ddc9e <.bss.end+5f1b/????>
Trace; c80dd8f5 <.bss.end+5b72/????>
Trace; c809b401 <[usbcore]rh_status_urb+a1/b0>
Trace; c01d165a <qdisc_restart+4a/d0>
Trace; c01c9dee <net_tx_action+9e/b0>
Trace; c011bccb <do_softirq+4b/90>
Trace; c01cb5d2 <.text.lock.dev+4c/10a>
Trace; c01dd8ee <ip_output+de/140>
Trace; c01de601 <ip_build_xmit+2c1/390>
Trace; c01de623 <ip_build_xmit+2e3/390>
Trace; c01f5f30 <raw_sendmsg+2d0/350>
Trace; c01f5b80 <raw_getfrag+0/20>
Trace; c0200bc8 <fn_hash_lookup+98/f0>
Trace; c01fcc65 <inet_sendmsg+35/40>
Trace; c01c2adc <sock_sendmsg+6c/90>
Trace; c01c2602 <move_addr_to_kernel+32/50>
Trace; c01c3cb6 <sys_sendmsg+186/1e0>
Trace; c016c4c7 <tty_write+187/200>
Trace; c016dbd9 <tty_ioctl+189/360>
Trace; c01c412c <sys_socketcall+1dc/200>
Trace; c0108923 <system_call+33/38>
Code; c01c5b5d <alloc_skb+7d/1b0>
00000000 <_EIP>:
Code; c01c5b5d <alloc_skb+7d/1b0> <=====
    0: c7 42 04 c0 be 36 c0 movl $0xc036bec0,0x4(%edx) <=====
Code; c01c5b64 <alloc_skb+84/1b0>
    7: 89 15 c0 be 36 c0 mov %edx,0xc036bec0
Code; c01c5b6a <alloc_skb+8a/1b0>
    d: c7 00 00 00 00 00 movl $0x0,(%eax)
Code; c01c5b70 <alloc_skb+90/1b0>
   13: c7 00 00 00 00 00 movl $0x0,(%eax)

  <0>Kernel panic: Aiee, killing interrupt handler!

3 warnings and 2 errors issued. Results may not be reliable.

