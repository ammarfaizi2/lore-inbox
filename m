Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284688AbRLZSeg>; Wed, 26 Dec 2001 13:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284691AbRLZSe0>; Wed, 26 Dec 2001 13:34:26 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:10671 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284688AbRLZSeH>; Wed, 26 Dec 2001 13:34:07 -0500
Date: Wed, 26 Dec 2001 20:33:07 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: BUG and Kernel Panic on 2.5.2-pre1 with loop and cdrom
Message-ID: <Pine.LNX.4.33.0112262029370.28333-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Hope you all enjoyed your Christmas break, if anyone's still around heres one to
look at :) (oops message and decode at the end).

I got the oops+panic by doing "mount /dev/hdd /cdrom -o loop"
Box is highmem 64G with 192M ram and SMP kernel on UP. The oops is
reproducible and produces a similar trace each time (a bit of noise from
other subsystems). And yes the symbol resolving is all correct.

ll_rw_blk.c: end_that_request_first()
<--snip-->
	if (!bio->bi_size) {
			req->bio = bio->bi_next;
			if (unlikely(bio_endio(bio, uptodate, total_nsect)))
				BUG(); <==== [1]
			total_nsect = 0;
		}
<--snip-->

[1] looks like we're hitting it there but bio_endio _never_ returns non zero, did we just
drive off the edge of the world!? =)

eip: cc916780 <== is this because we're in an interrupt handler?
kernel BUG at /usr/src/linux-2.5.2-pre1.orig/include/asm/spinlock.h:133! <= ??
invalid operand: 0000
CPU:    0
EIP:    0010:[<cc9167ba>]    Not tainted
EFLAGS: 00010082
eax: 00000049   ebx: cb889b00   ecx: c0303c84   edx: 00058231
esi: cbf2c924   edi: 00000096   ebp: c156e5d4   esp: c0319c28
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0319000)
Stack: cc918140 00000085 cb889b00 cbf2c924 00000004 cc916997 cb889b00 cbf2c924
       cbf2c924 00000004 c014d9ee cbf2c924 00000004 cbf2c924 00000004 c020b7de
       cbf2c924 00000001 00000004 00000004 c0318000 c0318000 c1519cb0 c90f7f2c
Call Trace: [<cc918140>] [<cc916997>] [<c014d9ee>] [<c020b7de>] [<c021b7db>]
   [<c0222dde>] [<c02a4400>] [<c01453d4>] [<c014cfdd>] [<c02a4422>] [<c01453d4>]
   [<c014cfdd>] [<c0126a30>] [<c010e707>] [<c0126540>] [<c010a99e>] [<cc835198>]
   [<cc83ad45>] [<cc83889a>] [<c0222d40>] [<c0218a62>] [<c010a99e>] [<c010acf9>]
   [<c0106dc0>] [<c0106dc0>] [<c01e0018>] [<c01ec713>] [<c0106dc0>] [<c01ec600>]
   [<c0106e72>] [<c0105000>]

Code: 0f 0b 5a 59 89 f6 f0 fe 8b cc 00 00 00 0f 88 31 18 00 00 8b
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

>>EIP; cc9187ba <END_OF_CODE+9215a/????>   <=====
Trace; cc91a140 <END_OF_CODE+93ae0/????>
Trace; cc918997 <END_OF_CODE+92337/????>
Trace; c014db03 <bio_endio+23/30>
Trace; c020b8ee <end_that_request_first+19e/2a0>
Trace; c024b125 <qdisc_restart+15/290>
Trace; c021b8eb <__ide_end_request+bb/150>
Trace; c0222eee <cdrom_read_intr+9e/330>
Trace; c010aeda <do_IRQ+1aa/1c0>
Trace; c013b9c6 <kfree+196/1a0>
Trace; c023ed8c <kfree_skbmem+c/70>
Trace; cc87aa2d <[8139too]rtl8139_start_xmit+fd/170>
Trace; cc87d229 <[8139too].text.end+c8a/de1>
Trace; c024b125 <qdisc_restart+15/290>
Trace; c02430de <dev_queue_xmit+19e/4e0>
Trace; c023e7b7 <sock_def_readable+57/90>
Trace; c0253ff3 <ip_output+113/180>
Trace; c023ff94 <skb_checksum+54/3d0>
Trace; c02543a4 <ip_queue_xmit+344/4a0>
Trace; c026b12f <tcp_v4_checksum_init+7f/110>
Trace; c026b7ad <tcp_v4_rcv+46d/740>
Trace; c026a19e <tcp_v4_send_check+6e/b0>
Trace; c0264b35 <tcp_transmit_skb+565/620>
Trace; cc835198 <[usb-ohci]roothub_portstatus+28/70>
Trace; cc83ad45 <[usb-ohci].text.end+876/8e1>
Trace; cc83889a <[usb-ohci]rh_send_irq+fa/1a0>
Trace; cc838940 <[usb-ohci]rh_int_timer_do+0/70>
Trace; c0222e50 <cdrom_read_intr+0/330>
Trace; c0218b72 <ide_intr+162/240>
Trace; c010a99e <handle_IRQ_event+5e/90>
Trace; c010ae39 <do_IRQ+109/1c0>
Trace; c0106dc0 <default_idle+0/40>
Trace; c0106dc0 <default_idle+0/40>
Trace; c01e0018 <acpi_rs_address64_stream+148/160>
Trace; c01ec823 <pr_power_idle+113/270>
Trace; c0106dc0 <default_idle+0/40>
Trace; c01ec710 <pr_power_idle+0/270>
Trace; c0106e72 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  cc9187ba <END_OF_CODE+9215a/????>
00000000 <_EIP>:
Code;  cc9187ba <END_OF_CODE+9215a/????>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  cc9187bc <END_OF_CODE+9215c/????>
   2:   5a                        pop    %edx
Code;  cc9187bd <END_OF_CODE+9215d/????>
   3:   59                        pop    %ecx
Code;  cc9187be <END_OF_CODE+9215e/????>
   4:   89 f6                     mov    %esi,%esi
Code;  cc9187c0 <END_OF_CODE+92160/????>
   6:   f0 fe 8b cc 00 00 00      lock decb 0xcc(%ebx)
Code;  cc9187c7 <END_OF_CODE+92167/????>
   d:   0f 88 31 18 00 00         js     1844 <_EIP+0x1844> cc919ffe <END_OF_CODE+9399e/????>
Code;  cc9187cd <END_OF_CODE+9216d/????>
  13:   8b 00                     mov    (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler


