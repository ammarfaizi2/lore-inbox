Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRAVPmE>; Mon, 22 Jan 2001 10:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131240AbRAVPly>; Mon, 22 Jan 2001 10:41:54 -0500
Received: from pixy.dgap.mipt.ru ([194.85.81.243]:37382 "EHLO
	pixy.dgap.mipt.ru") by vger.kernel.org with ESMTP
	id <S129886AbRAVPlf>; Mon, 22 Jan 2001 10:41:35 -0500
Date: Mon, 22 Jan 2001 18:36:17 +0300 (MSK )
From: Yuri Polyansky <tcp@pixy.dgap.mipt.ru>
Reply-To: Yuri Polyansky <yura_pol@mail.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 8139too.c min frame size check
Message-ID: <Pine.LNX.4.10.10101221827250.3300-100000@pixy.dgap.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi, Jeff!

  Recently i got 2.4.0 crashed with oops in rtl8139_rx_interrupt() due
to packet with size = 0.
  
  Patch and oops message below. 


			      Cheers,
					-up


patch-8139driver-2.4.0
--- linux-2.4.0/drivers/net/8139too.c	Mon Jan 22 18:14:22 2001
+++ linux/drivers/net/8139too.c	Mon Jan 22 18:20:14 2001
@@ -210,6 +210,9 @@ static int multicast_filter_limit = 32;
 /* max supported ethernet frame size -- must be at least (dev->mtu+14+4).*/
 #define MAX_ETH_FRAME_SIZE	1536
 
+/* min supported ethernet frame size, according to RFC894 */
+#define MIN_ETH_FRAME_SIZE	60
+
 /* Size of the Tx bounce buffers -- must be at least (dev->mtu+14+4). */
 #define TX_BUF_SIZE	MAX_ETH_FRAME_SIZE
 #define TX_BUF_TOT_LEN	(TX_BUF_SIZE * NUM_TX_DESC)
@@ -1804,7 +1807,8 @@ static void rtl8139_rx_interrupt (struct
 		 * Rx processing.
 		 */
 		if ((rx_size > (MAX_ETH_FRAME_SIZE+4)) ||
-		    (!(rx_status & RxStatusOK))) {
+		    (!(rx_status & RxStatusOK)) ||
+		    (rx_size < (MIN_ETH_FRAME_SIZE + 4))) {
 			rtl8139_rx_err (rx_status, dev, tp, ioaddr);
 			return;
 		}


OOPS MESSAGE:

Unable to handle kernel paging request at virtual address 0xcc000000
*pde = 00000000
Oops: 00000000
CPU:    0
EIP:    0010:[<ce89f1a4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: cb798aa0   ebx: cb798aa0     ecx: 3fe94dc4       edx: fffffffc
esi: cc000000   edi: cb86b77e     ebp: fffffffc       esp: cab45d1c
ds: 0018        es: 0018       ss: 0018
Stack:  00000051 ce8a209e ce8a2000 cbd57c00 ce8a2038 ce8a2037 00000000 ce893710
        cba50000 ce89f63b cbd57c00 cbd57d40 ce8a2000 cbd4faa0 04000001 0000000b
        cab45db4 00000000 00000014 cbd57d40 c010a05d 0000000b cbd57c00
	cab45db4

Call Trace: [<ce8a203e>] [<ce8a2000>] [<ce8a2038>] [<ce8a2037>] [<ce893710>]
 [<ce8a2000>] [<c010a05d>] [<c010a1ce>] [<c0108e6c>] [<c01189ba>] [<c010a201>]
 [<c0108e6c>] [<c0180018>] [<c018a290>] [<c018a81b>] [<c017d686>] [<c017d4f1>]
 [<c017f2a4>] [<c017b384>] [<c017f168>] [<c012fd32>] [<c0108dc3>]

Code: f3 a5 f6 c2 02 74 02 66 a5 f6 c2 01 74 01 a4 89 e8 03 83 80

>>EIP; ce89f1a4 <[8139too]rtl8139_rx_interrupt+164/264>   <=====
Trace; ce8a203e <.data.end+163f/????>
Trace; ce8a2000 <.data.end+1601/????>
Trace; ce8a2038 <.data.end+1639/????>
Trace; ce8a2037 <.data.end+1638/????>
Trace; ce893710 <[opl3sa2]__module_author+9570/eec0>
Trace; ce8a2000 <.data.end+1601/????>
Trace; c010a05d <handle_IRQ_event+31/5c>
Trace; c010a1ce <do_IRQ+6e/b4>
Trace; c0108e6c <ret_from_intr+0/20>
Trace; c01189ba <do_softirq+3e/6c>
Trace; c010a201 <do_IRQ+a1/b4>
Trace; c0108e6c <ret_from_intr+0/20>
Trace; c0180018 <mmap_mem+40/c4>
Trace; c018a290 <vt_console_print+134/2e4>
Trace; c018a81b <vc_init+3f/11c>
Trace; c017d686 <opost_block+186/194>
Trace; c017d4f1 <opost+1a5/1b4>
Trace; c017f2a4 <write_chan+13c/1e4>
Trace; c017b384 <tty_write+1b8/1fc>
Trace; c017f168 <write_chan+0/1e4>
Trace; c012fd32 <sys_write+8e/c4>
Trace; c0108dc3 <system_call+33/38>
Code;  ce89f1a4 <[8139too]rtl8139_rx_interrupt+164/264>
00000000 <_EIP>:
Code;  ce89f1a4 <[8139too]rtl8139_rx_interrupt+164/264>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  ce89f1a6 <[8139too]rtl8139_rx_interrupt+166/264>
   2:   f6 c2 02                  testb  $0x2,%dl
Code;  ce89f1a9 <[8139too]rtl8139_rx_interrupt+169/264>
   5:   74 02                     je     9 <_EIP+0x9> ce89f1ad <[8139too]rtl8139_rx_interrupt+16d/264>
Code;  ce89f1ab <[8139too]rtl8139_rx_interrupt+16b/264>
   7:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  ce89f1ad <[8139too]rtl8139_rx_interrupt+16d/264>
   9:   f6 c2 01                  testb  $0x1,%dl
Code;  ce89f1b0 <[8139too]rtl8139_rx_interrupt+170/264>
   c:   74 01                     je     f <_EIP+0xf> ce89f1b3 <[8139too]rtl8139_rx_interrupt+173/264>
Code;  ce89f1b2 <[8139too]rtl8139_rx_interrupt+172/264>
   e:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  ce89f1b3 <[8139too]rtl8139_rx_interrupt+173/264>
   f:   89 e8                     movl   %ebp,%eax
Code;  ce89f1b5 <[8139too]rtl8139_rx_interrupt+175/264>
  11:   03 83 80 00 00 00         addl   0x80(%ebx),%eax

Kernel panic: Aiee, killing interrupt handler

580 warnings issued.  Results may not be reliable.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
