Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263341AbTCNO2f>; Fri, 14 Mar 2003 09:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263343AbTCNO2f>; Fri, 14 Mar 2003 09:28:35 -0500
Received: from port-212-202-184-40.reverse.qdsl-home.de ([212.202.184.40]:42891
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S263341AbTCNO2b>; Fri, 14 Mar 2003 09:28:31 -0500
Message-ID: <3E71E996.8060302@trash.net>
Date: Fri, 14 Mar 2003 15:39:18 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030311 Debian/1.2.1-10
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Strange Oops with 2.4.20 and ISDN Channel bundling
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we receive the following oops reproducible with vanilla 2.4.20 and isdn 
channel bundling:

Oops: 0007
CPU:    0
EIP:    0023:[<0804b6e7>]    Not tainted
EFLAGS: 00010287
eax: 080d7940   ebx: 080d7958   ecx: 3fdd2b14   edx: 3fdd2bb4
esi: 0806c204   edi: 00000001   ebp: bffffdc8   esp: bffff7a0
ds: 002b   es: 002b   ss: 002b
Process ipppd (pid: 1001, stackpage=cded5000)
 <0>Kernel panic: Aiee, killing interrupt handler!
 In interrupt handler - not syncing

No backtrace is displaced. We had to linux machines connected, only the 
one sending data
oopses. Before it happens "Warning: kfree_skb on hard IRQ d08342a4" is 
logged a couple of times.
We first noticed the oops with a heavily patched kernel we use. With 
this kernel, all kinds of
BUG()s were hit, f.e. in schedule() and alloc_skb(), both expected 
in_interrupt() to be false.

The alloc_skb BUG() looks like this:
kernel BUG at skbuff.c:174!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c02204e8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000003a   ebx: 00000000   ecx: cd674000   edx: 00000001
esi: 000001f0   edi: c8f5f4c0   ebp: cd6a8000   esp: cd6a9ddc
ds: 0018   es: 0018   ss: 0018
Process ipppd (pid: 876, stackpage=cd6a9000)
Stack: c02a8580 c021f894 000001f0 00000000 c021f894 00000078 000001f0 
00000000
       c8f5f4c0 00000078 00000000 c8f5fb80 c021f99b c8f5f4c0 00000078 
00000000
       00000000 cd6a9e48 c02676f4 c8f5f4c0 00000078 00000000 cd6a9e48 
c8f5fbc8
Call Trace:    [<c021f894>] [<c021f894>] [<c021f99b>] [<c02676f4>] 
[<c021d48c>]
  [<c0118740>] [<c021e20b>] [<d0836bb6>] [<c022f03f>] [<c0224a34>] 
[<c011c7d9>]
  [<c0108421>] [<c021e24d>] [<c021e949>] [<c01070d3>]
Code: 0f 0b ae 00 20 85 2a c0 58 5a e9 7c fe ff ff 90 90 8d b4 26
                                                                                                                             
                                                                                                                             
 >>EIP; c02204e8 <alloc_skb+1a8/1c0>   <=====
                                                                                                                             
 >>ecx; cd674000 <_end+d30dc54/104acc54>
 >>edi; c8f5f4c0 <_end+8bf9114/104acc54>
 >>ebp; cd6a8000 <_end+d341c54/104acc54>
 >>esp; cd6a9ddc <_end+d343a30/104acc54>
 
Trace; c021f894 <sock_alloc_send_pskb+b4/1a0>
Trace; c021f894 <sock_alloc_send_pskb+b4/1a0>
Trace; c021f99b <sock_alloc_send_skb+1b/20>
Trace; c02676f4 <unix_stream_sendmsg+124/2e0>
Trace; c021d48c <sock_sendmsg+5c/90>
Trace; c0118740 <printk+f0/130>
Trace; c021e20b <sys_sendto+cb/f0>
Trace; d0836bb6 <[isdn]isdn_net_start_xmit+196/2e0>
Trace; c022f03f <qdisc_restart+6f/d0>
Trace; c0224a34 <net_tx_action+74/a0>
Trace; c011c7d9 <do_softirq+99/a0>
Trace; c0108421 <do_IRQ+a1/b0>
Trace; c021e24d <sys_send+1d/30>
Trace; c021e949 <sys_socketcall+e9/1b0>
Trace; c01070d3 <system_call+33/40>
                                                                                                                             
Code;  c02204e8 <alloc_skb+1a8/1c0>
00000000 <_EIP>:
Code;  c02204e8 <alloc_skb+1a8/1c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c02204ea <alloc_skb+1aa/1c0>
   2:   ae                        scas   %es:(%edi),%al
Code;  c02204eb <alloc_skb+1ab/1c0>
   3:   00 20                     add    %ah,(%eax)
Code;  c02204ed <alloc_skb+1ad/1c0>
   5:   85 2a                     test   %ebp,(%edx)
Code;  c02204ef <alloc_skb+1af/1c0>
   7:   c0 58 5a e9               rcrb   $0xe9,0x5a(%eax)
Code;  c02204f3 <alloc_skb+1b3/1c0>
   b:   7c fe                     jl     b <_EIP+0xb>
Code;  c02204f5 <alloc_skb+1b5/1c0>
   d:   ff                        (bad)
Code;  c02204f6 <alloc_skb+1b6/1c0>
   e:   ff 90 90 8d b4 26         call   *0x26b48d90(%eax)
                                                                                                                             
 <0>Kernel panic: Aiee, killing interrupt handler!
                                                                                                                             

To me it looks like something in the area of isdn_net_start_xmit does 
something
so in_interrupt later returns true when it is not supposed to do so (all 
unix socket
handling should be done in user context if i understand correctly).
I'm not sure what this would be, is it correct to look for:

- *_lock_bk() without *_unlock_bh()
- local_bh_disable() without local_bh_enable()
- save_flags(), sti() without restore_flags()

Am i missing some ? Any other suggestions would be welcome, too.

Regards,
Patrick


Additional Information:
Gnu C                  3.2
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11w
mount                  2.11w
modutils               2.4.19
e2fsprogs              1.29
reiserfsprogs          3.x.1b
pcmcia-cs              3.2.4
PPP                    2.4.1
isdn4k-utils           3.2p1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5.0.0
Procps                 2.0.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0


