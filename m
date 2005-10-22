Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVJVLtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVJVLtj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVJVLtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 07:49:39 -0400
Received: from quimbies.gnus.org ([80.91.231.2]:36562 "EHLO quimbies.gnus.org")
	by vger.kernel.org with ESMTP id S1751291AbVJVLti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 07:49:38 -0400
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
To: linux-kernel@vger.kernel.org
Cc: support@comtrol.com
Subject: Rocketport driver fails if more than four cards are inserted
Date: Sat, 22 Oct 2005 13:47:13 +0200
Message-ID: <m34q79kc3i.fsf@quimbies.gnus.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.3.50 (gnu/linux)
X-Now-Playing: Brigitte Bardot's _The Best Of Bardot_: "Harley Davidson"
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEXBNhTgUhegIRXhXzfh
 fm/qp45BCwzRSBVg7uUkAAACc0lEQVQ4jV3UTXPaMBAGYMWQctY4GV1dh5BrjGy4QrxKr+2gndyB
 qFcrbqq/33dtTDvVMGOsh1efO6hyaEVZ3nJlshnRNqWUlaXKJpjzNpXhSHuAukAhjxlvu1UI1BpA
 NoLK8HiiZ4ET6SEyAlpZ2G1XPiBSmf8gN6nsdyN02QRdqbRJyvZz2g9j4aeYHJCpaNLCHmuARCbA
 T6JZqHWoqdVj5AoLrHIVlg5gLoABkQVguWcGaNlKoWg3gEoIhCAJWUe2PAjEJAtAf3i8ApN//uW2
 GE8C4XyYwDv3Rvw2wVFAY++S8MzfMEkYmp+A0JirTmWhECABA3AD7DFqmA2TXKBEf3vHP3Bw4Syw
 FNDTxvPKdGp1uiZGyABW4ChQj5AtCTeb+rbeLX4Pq6JqAAWQRNt8T/3qX5g7UsQ5M6n+y3AmV+DW
 +ZbZq36D/rmbgJwnf898UD0mKWu3nxLOO27YHVRcl8fiLzBjHIDv4rp4uCaSItL1MFzXf2T9+gpp
 EXWfdN2arleZXc+aCW50ztsB8qKwm/DejhCZ79gIpOfw064niHfMDomcTNqEk8BhhHtc3xVm1o6X
 LoB+NjEnHVfBCuBuI+bAKTXeRF3riJEAxwtg2nuPb3XVhTNgdYFFijq3+Garj7AUkDIxOJLeylzQ
 ah0IsAm+Gs7qc6gjtJxeyTa8CbQVKD55r/MWgdq/UNvwS3Aj3KLY5EPsSfbahsddRF0JYIsHdOFa
 0Ci8726k4Oby3nhuDnIEzHU4774K3MqbA/AI7eoCM7lBAA5zOUJ4eZJqL+pW19a22r2eHJMDZE9G
 /htSwk4jVvjlVKPALYrrKXV/ADoJ+iLSXNJAAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inserting a fifth Rocketport card into a machines gives me the
backtrace included below.

Looking at the source, it looks like there's two problems: the
sController array only has four entries, even though CTL_SIZE is
eight, and some pc104 initialisation is run even though we're not
running on a pc104 platform.  (Apparently the maximum number of
controllers on pc104 is four.)

The patch (against 2.6.13.3) included below fixes both these problems.
The other way to fix the latter problem would be to extend the pc104
(i.e. ISA) case to allow eight cards, but that seems somewhat less
likely...

Signed-off-by: Lars Magne Ingebrigtsen <larsi@gnus.org>

Unable to handle kernel NULL pointer dereference at virtual address 00000201
 printing eip:
dc863796
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: rocket
CPU:    0
EIP:    0060:[<dc863796>]    Not tainted VLI
EFLAGS: 00010246   (2.6.13.3) 
EIP is at init_r_port+0x126/0x334 [rocket]
eax: 00000001   ebx: 00000000   ecx: 00000004   edx: 00000000
esi: 00000000   edi: 00000080   ebp: dc869c40   esp: db8abee8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 886, threadinfo=db8aa000 task=db813a40)
Stack: 00000000 00000000 00000001 dc869c7c dbbe0800 00000080 dc8029c2 00000004 
       00000000 00000000 dbe17800 dc866ae0 00000004 00000000 00000000 dbe17800 
       00000004 00000000 00000000 dbe178e8 00000010 00000008 00000000 00000000 
Call Trace:
 [<dc8029c2>] register_PCI+0x9c2/0xacc [rocket]
 [<dc802aea>] init_PCI+0x1e/0x44 [rocket]
 [<dc80316f>] init_module+0x293/0x2e4 [rocket]
 [<c01311bd>] sys_init_module+0xd1/0x1cc
 [<c0102ac9>] syscall_call+0x7/0xb
Code: 01 00 00 00 83 c0 0c 89 87 0c 01 00 00 89 87 10 01 00 00 8b 57 08 80 e6 cf 89 57 08 8b 4c 24 1c 8b 7c 24 14 8b 04 8d 60 99 86 dc <8b> 04 b8 3d a6 01 00 00 74 10 76 28 3d e5 01 00 00 74 17 eb 1f 

 
--- rocket.c.~1~	Tue Oct  4 01:27:35 2005
+++ rocket.c	Sat Oct 22 13:37:41 2005
@@ -206,6 +206,14 @@
 	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
 	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
 	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
+	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
+	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
+	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
+	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
+	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
+	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
+	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}},
+	{-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0, 0},
 	 {0, 0, 0, 0}, {-1, -1, -1, -1}, {0, 0, 0, 0}}
 };
 
@@ -675,17 +683,19 @@
 	init_waitqueue_head(&info->open_wait);
 	init_waitqueue_head(&info->close_wait);
 	info->flags &= ~ROCKET_MODE_MASK;
-	switch (pc104[board][line]) {
-	case 422:
-		info->flags |= ROCKET_MODE_RS422;
-		break;
-	case 485:
-		info->flags |= ROCKET_MODE_RS485;
-		break;
-	case 232:
-	default:
-		info->flags |= ROCKET_MODE_RS232;
-		break;
+	if (ctlp->boardType == ROCKET_TYPE_PC104) {
+	        switch (pc104[board][line]) {
+		case 422:
+		  info->flags |= ROCKET_MODE_RS422;
+		  break;
+		case 485:
+		  info->flags |= ROCKET_MODE_RS485;
+		  break;
+		case 232:
+		default:
+		  info->flags |= ROCKET_MODE_RS232;
+		  break;
+		}
 	}
 
 	info->intmask = RXF_TRIG | TXFIFO_MT | SRC_INT | DELTA_CD | DELTA_CTS | DELTA_DSR;

 
-- 
(domestic pets only, the antidote for overdose, milk.)
  larsi@gnus.org * Lars Magne Ingebrigtsen
