Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSIPA4k>; Sun, 15 Sep 2002 20:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318358AbSIPA4k>; Sun, 15 Sep 2002 20:56:40 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:27366 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S318357AbSIPA4i>;
	Sun, 15 Sep 2002 20:56:38 -0400
Message-ID: <3D852D6D.2070401@candelatech.com>
Date: Sun, 15 Sep 2002 18:01:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linux.nics@intel.com
Subject: BUG() in e1000 driver (2.4.20-pre7)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier I had generated a similar crash in a NAPI-fied driver.  I
was able to reproduce it in the default e1000 driver in 2.4.20-pre7
as well.  To cause the problem, I send bi-directional tcp/ip traffic
(240Mbps send, 240Mbps receive on two ports on the same machine).  It
crashes in around 30 minutes, after about 43,469,910,000 bytes in this case.

This is not a stock kernel:  I have some small tweaks to the tcp/ip stack
to allow me to send traffic to myself over the interfaces, so it could be
my fault somehow.  I have yet to reproduce this on other machines running
the tulip driver (10/100) though...

Trying to reproduce on 2.4.20-pre4 now...

Machine:  dual AMD 2Ghz-equiv, Intel pro/1000 MT nics.
kernel: 2.4.20-pre7
  + send-to-self patch I wrote
  + pktgen patch (happens when module is loaded or not)
  * Loaded e1000 driver with TxDescriptors=4096 RxDescriptors=1024


[root@localhost root]# ksymoops < oops2.txt
ksymoops 2.4.4 on i686 2.4.20-pre7.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.20-pre7/ (default)
      -m /boot/System.map-2.4.20-pre7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

[root@localhost lanforge]# kernel BUG in header file at line 789
kernel BUG at panic.c:141!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c011c00e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000026   ebx: daff1180   ecx: 00000086   edx: df013f64
esi: d0c  edi: 00000046
ds: 0018   es: 0018   ss: 0018
Process btserver (pid: 2846, stackpage=d9f81000)
Stack: c0242ea0 00000315 e08ba8fc 00000315 daff1180 d9f80000 00006a18 0000054e
        dee61000 dee6120c dee61000 00000286 d9901400 00000202 db86f540 dee61000
        dee611e0 dbab1cc0 dbab1cc0 dbab1d1c c01dd69c 00000287 dee61160 0000000a
Call Trace:    [<e08ba8fc>] [<c01dd69c>] [<e08ba4f3>] [<c010a54c>] [<c010a753>]
   [<c010cdf8>] [<c0232163>] [<c01ded77>] [<c01df3e6>] [<c01ff550>] [<c021a829>]
   [<c01da110>] [<c01e18f0>] [<c022977e>] [<c01da4ff>] [<c01da218>] [<c014c828>]
   [<c013c995>] [<c01204bb>] [<c0108bfb>]
Code: 0f 0b 8d 00 da 3b 24 c0 58 5a 90 8d b4 26 00 00 00 00 eb fe

 >>EIP; c011c00e <__out_of_line_bug+e/30>   <=====
Trace; e08ba8fc <[e1000]e1000_clean_rx_irq+21c/3c0>
Trace; c01dd69c <kfree_skbmem+c/70>
Trace; e08ba4f3 <[e1000]e1000_intr+33/60>
Trace; c010a54c <handle_IRQ_event+5c/90>
Trace; c010a753 <do_IRQ+a3/f0>
Trace; c010cdf8 <call_do_IRQ+5/d>
Trace; c0232163 <__generic_copy_to_user+33/40>
Trace; c01ded77 <memcpy_toiovec+37/60>
Trace; c01df3e6 <skb_copy_datagram_iovec+46/1d0>
Trace; c01ff550 <tcp_recvmsg+630/920>
Trace; c021a829 <inet_recvmsg+39/60>
Trace; c01da110 <sock_recvmsg+30/b0>
Trace; c01e18f0 <netif_receive_skb+190/1c0>
Trace; c022977e <packet_poll+1e/a0>
Trace; c01da4ff <sock_poll+1f/30>
Trace; c01da218 <sock_read+88/a0>
Trace; c014c828 <sys_select+468/480>
Trace; c013c995 <sys_read+95/110>
Trace; c01204bb <sys_gettimeofday+1b/a0>
Trace; c0108bfb <system_call+33/38>
Code;  c011c00e <__out_of_line_bug+e/30>
00000000 <_EIP>:
Code;  c011c00e <__out_of_line_bug+e/30>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c011c010 <__out_of_line_bug+10/30>
    2:   8d 00                     lea    (%eax),%eax
Code;  c011c012 <__out_of_line_bug+12/30>
    4:   da 3b                     fidivrl (%ebx)
Code;  c011c014 <__out_of_line_bug+14/30>
    6:   24 c0                     and    $0xc0,%al

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


