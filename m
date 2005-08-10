Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbVHJN1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVHJN1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVHJN1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:27:24 -0400
Received: from mxs2.siemens.at ([194.138.12.133]:48768 "EHLO mxs2.siemens.at")
	by vger.kernel.org with ESMTP id S965105AbVHJN1X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:27:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Skbuff problem - kernel BUG ???
Date: Wed, 10 Aug 2005 15:27:07 +0200
Message-ID: <AE99B7B733E1BB49B019CAA0F806D7A7014BF9C8@nets13ka.ww300.siemens.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Skbuff problem - kernel BUG ???
thread-index: AcWdrzSC2VHudDjbTG2A5+nykqiOxw==
From: "Schaffer Roland" <roland.schaffer@siemens.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2005 13:27:18.0898 (UTC) FILETIME=[3B428520:01C59DAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

I write a kernel module (metadrv) to send a frame over the ethernet; I
use sk_buff's to do this.
Metadrv enslaves the NICs eth0 and eth1 and is something like the
linux-bonding-driver.

The skb I got has to be changed slightly. I want to send it out on a
DIFFERENT NIC, thus I change the DEVICE of the skb and the MAC adresses
of the frame.
For test-purpose (due to not working;) I DROPPED the MAC-modification
code temporarily: nothing changed at all!

NOW WHATS GOING ON:
The code below works a few times, but suddenly it crashes with:

kernel BUG at skbuff.c:329!

"it works a few times"  means: it does not report an error,
dev_queue_xmit() returns 0, but the frames cannot be seen on copper by a
sniffer running on a different host. This happen 4 or 5 times, then the
kernel BUG appears. I am afraid that those 4 or 5 frames are NOT sent
although claimed so by dev_queue_xmit().
Ah: NO, there is NO firewall, NO traffic shaping and NO other
packet/frame dumper stuff running.

The frame carries an IP-Packet, payload: UDP-packet, ports 67 or 68

When I copy the skb using skb_copy() the kernel crashes immediately.
When I do this with ARP-Packets skb_copy() works very well. 

What else did I try?
--------------------
1) skb_copy() -> kernel crash
2) making my own skb and sending it -> does not crash, dev_queue_xmit()
claims to send but does not
3) modifying the original skb -> kernel BUG happens

If you have any idea how an skb can be sent over an other device or if
you know what I do wrong, please let me know!!!

Technical Data:
---------------
System: Linux sb1-1 2.4.20_mvlcge31-mpcbl0001_V2.0.8-omm #1 SMP Mi Aug 3
15:15:31 CEST 2005 i686 unknown
Vendor/Version: MontaVista-Linux Carrier-Grade-Edition 3.1
gcc: 3.2.3
CPU: 2 x Xeon 1.6(HT)
Networkdriver: e1000 (compiled into kernel)

Loaded Modules (these are ALL, I do not use more!! REALLY!!!) :
----
root@sb1-1:~# lsmod
Module                  Size  Used by    Not tainted
etnkernel             118288   2 
drbd                  116160  16 
e100                   53844   0  (unused)
metadrv               39720   2 
----
metadrv is my very own module and drbd is a disk-mirror module.

Thanks a lot!
Kind regards,
Roland


###-CODE-START-##################
// PL_SIDE_RIGHT = eth1
// slave = metadrv_get_slave_by_side (PL_SIDE_RIGHT);
				
skb->dev=slave->dev;
					
hexdump("ReroutedFrame",skb,128);
					
printk("DUPLICATE packet sending...!\n");
ret = dev_queue_xmit (skb);
printk("DUPLICATE packet sent! rc:%d\n",ret);

###-CODE-END-##################

###-KERNEL-DISPLAY-############
 
*********
HEXDUMPING ETHERNET-FRAME --ReroutedFrame--
tot_len 76
timestamp: 1123600707.228472
line 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
                 
0000 00 c0 95 87 6c 10 fe ff 00 00 01 0d 08 00 45 00  ....l.........E.
0010 00 4c 1e 6d 00 00 3c 11 4c 27 0c 03 04 05 01 02  .L.m....L.......
0020 03 04 00 44 00 43 00 38 e2 05 61 73 64 66 67 68  ...D.C.8..asdfgh
0030 6a 6b 6c 71 77 65 72 74 7a 75 69 6f 70 41 53 44  jklqwertzuiopASD
0040 46 47 48 4a 4b 4c 51 57 45 52 54 5a 55 49 4f 50  FGHJKLQWERTZUIOP
0050 31 32 33 34 35 36 37 38 39 30 39 20 2d 20 37 39  12345678909...79
0060 39 0a 01 03 03 00 00 00 00 00 00 00 00 00 00 00  9...............
0070 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00  ................
----
DUPLICATE packet sending...!
kernel BUG at skbuff.c:329!
invalid operand: 0000
etnkernel drbd e100 nvethdrv  
CPU:    3
EIP:    0060:[<c0240d81>]    Not tainted
EFLAGS: 00010282
eax: 00000045   ebx: f5a66e80   ecx: 00000002   edx: 00000001
esi: f5a66e80   edi: 0000009f   ebp: f79f2ee8   esp: f7bb1f20
ds: 0068   es: 0068   ss: 0068
Process ksoftirqd_CPU3 (pid: 10, stackpage=f7bb1000)
Stack: c02e9880 c0215f88 f45be380 f79f2000 c0215f88 f5a66e80 0000009f
f5e869f0 
       f7a2c800 f7a2caa0 f7bb1f90 f7a2c800 00000040 f7a2ca00 c0215ccc
f7a2ca00 
       f7bb0000 f6a08280 00000000 f7a2c8c4 f7a2c800 c039689c c0396880
c0245b35 
Call Trace: [<c0215f88>]  [<c0215f88>]  [<c0215ccc>]  [<c0245b35>]
[<c0127a66>]  [<c0127fe0>]  [<c0127f29>]  [<c0107371>] 
Code: 0f 0b 49 01 05 6a 2e c0 8b 5c 24 14 e9 ab fe ff ff 55 31 d2 
Dumping to block device (3,3) on CPU 3

###-KERNEL-DISPLAY-END-################

Thanks a lot!!
Best regards,

Roland
