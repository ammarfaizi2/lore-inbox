Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133114AbRAZQKk>; Fri, 26 Jan 2001 11:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135469AbRAZQKa>; Fri, 26 Jan 2001 11:10:30 -0500
Received: from www.gtgi.com ([209.183.204.34]:233 "EHLO www.gtgi.com")
	by vger.kernel.org with ESMTP id <S133114AbRAZQKW>;
	Fri, 26 Jan 2001 11:10:22 -0500
From: "Lee Cremeans" <leec@gtgi.com>
To: <linux-kernel@vger.kernel.org>, <linux-ipsec@freeswan.org>
Subject: IPSec stack and calling a hardware driver using sleep_on/wake_up
Date: Fri, 26 Jan 2001 11:09:07 -0500
Message-ID: <000d01c087b2$4fd288e0$0500a8c0@fw.gtgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with a client on integrating a hardware driver for one of our
products (using the Hi/fn 7751 encryption processor) with a FreeS/WAN-based
IPSec stack. The problem I keep running into is when I send a packet to our
driver to be decrypted. Usually, when we send a request to our driver, the
request is sent to it and then put to sleep using add_wait_queue and
schedule(), and once the card is done processing the request, we hit a
callback and wake up the sleeping process. What I see happening when I call
our driver from inside the IPsec code (in klips/src/ipsec_rcv.c from
FreeS/WAN 1.5), we hit the callback *before* the card is done, followed by a
"Scheduling in interrupt" message, and a crash inside the scheduler:


ksymoops 2.3.4 on i586 2.2.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/misc/ (specified)
     -m /System.map (specified)

Warning (compare_maps): mismatch on symbol zeroes  , ipsec says c484bcc0,
/lib/modules/2.2.18/misc/ipsec.o says c484bb60.  Ignoring
/lib/modules/2.2.18/misc/ipsec.o entry
Oops: 0002
CPU:    0
EIP:    0010:[<c0113df5>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000018   ebx: c0261ccc   ecx: c02503fd   edx: 00000001
esi: c0260000   edi: c028cf00   ebp: c0261cb4   esp: c0261c84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c0261000)
Stack: 00000010 00000286 c0261ccc 00000086 c2f5962c c01171a6 c2f59680
c39eec80
       c2f5962c c2f59600 00000000 00000001 c0261cd4 c0114173 00000002
c39eec80
       c2f5962c c2f59600 c0260000 c484a854 c2f59600 c482ecaf c2d99700
c0261e10
Call Trace: [<c01171a6>] [<c0114173>] [<c484a854>] [<c482ecaf>] [<c482e3aa>]
[<c484a840>] [<c0194700>]
       [<c484a6e0>] [<c48164e0>] [<c017f737>] [<c48164e0>] [<c017f9dc>]
[<c48164e0>] [<c0178ef6>] [<c48164e0>]
       [<c011bf19>] [<c0106000>] [<c010bed9>] [<c010bef0>] [<c010a948>]
[<c0106000>] [<c0107ec5>] [<c0106000>]
       [<c010607c>] [<c0106000>] [<c01001ae>]
Code: c7 05 00 00 00 00 00 00 00 00 8d 65 d8 5b 5e 5f 89 ec 5d c3

>>EIP; c0113df5 <schedule+395/3ac>   <=====
Trace; c01171a6 <printk+16e/17c>
Trace; c0114173 <interruptible_sleep_on+5b/a8>
Trace; c484a854 <[ipsec]esp_protocol+14/18>
Trace; c482ecaf <[ipsec]DEScrypto+297/32e>
Trace; c482e3aa <[ipsec]ipsec_rcv+150a/1b39>
Trace; c484a840 <[ipsec]esp_protocol+0/18>
Trace; c0194700 <fn_new_zone+f0/158>
Trace; c484a6e0 <[ipsec]dev_ipsec0+0/100>
Trace; c48164e0 <[ne]dev_ne+0/390>
Trace; c017f737 <ip_local_deliver+173/1c8>
Trace; c48164e0 <[ne]dev_ne+0/390>
Trace; c017f9dc <ip_rcv+250/280>
Trace; c48164e0 <[ne]dev_ne+0/390>
Trace; c0178ef6 <net_bh+1aa/208>
Trace; c48164e0 <[ne]dev_ne+0/390>
Trace; c011bf19 <do_bottom_half+89/ac>
Trace; c0106000 <get_options+0/7c>
Trace; c010bed9 <do_IRQ+3d/58>
Trace; c010bef0 <do_IRQ+54/58>
Trace; c010a948 <common_interrupt+18/20>
Trace; c0106000 <get_options+0/7c>
Trace; c0107ec5 <cpu_idle+41/54>
Trace; c0106000 <get_options+0/7c>
Trace; c010607c <init+0/144>
Trace; c0106000 <get_options+0/7c>
Trace; c01001ae <L6+0/2>
Code;  c0113df5 <schedule+395/3ac>
00000000 <_EIP>:
Code;  c0113df5 <schedule+395/3ac>   <=====
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0   <=====
Code;  c0113dfc <schedule+39c/3ac>
   7:   00 00 00
Code;  c0113dff <schedule+39f/3ac>
   a:   8d 65 d8                  lea    0xffffffd8(%ebp),%esp
Code;  c0113e02 <schedule+3a2/3ac>
   d:   5b                        pop    %ebx
Code;  c0113e03 <schedule+3a3/3ac>
   e:   5e                        pop    %esi
Code;  c0113e04 <schedule+3a4/3ac>
   f:   5f                        pop    %edi
Code;  c0113e05 <schedule+3a5/3ac>
  10:   89 ec                     mov    %ebp,%esp
Code;  c0113e07 <schedule+3a7/3ac>
  12:   5d                        pop    %ebp
Code;  c0113e08 <schedule+3a8/3ac>
  13:   c3                        ret

The questions I have, given all this, are:

1) Are schedule()-based functions (like sleep_on, wake_up, add_wait_queue,
etc.) safe to call from inside the networking code?

2) If not, is there a better way I could do this?

Thanks in advance for any help...

-lee

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
