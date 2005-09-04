Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVIDLjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVIDLjR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 07:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVIDLjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 07:39:17 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:13965 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750751AbVIDLjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 07:39:16 -0400
Date: Sun, 4 Sep 2005 13:39:15 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 SMP on Athlon X2: nanosleep returning waay to soon, clock_gettime(CLOCK_REALTIME...) proceeding too fast
Message-ID: <20050904113915.GA13954@janus>
References: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu> <20050830134743.GA26890@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830134743.GA26890@janus>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After replacing the kernel on a fresh FC4 install with a stock 2.6.13
(using gcc 3.2) and my own config it appears that the clock is going too
fast: it gains at least an hour every 12 hours or so. FC4 kernel (rpm:
kernel-2.6.11-1.1369_FC4) seems ok

I tried the following from another system with reliable clock:

	for i in `yes|head -100`
	do
		/usr/bin/time -f %e rsh system_with_buggy_clock sleep 1
	done | cat -n

annotated output:

     1	1.03
     2	1.03
     3	1.03
     4	1.03
     5	1.03
     6	1.03
     7	1.02
     8	1.03
     9	1.03
    10	1.03
    11	1.03
    12	1.03
    13	1.03
    14	1.03
    15	1.03
    16	0.72		<==
    17	1.03
    18	1.03
    19	1.03
    20	1.03
    21	1.03
    22	1.03
    23	1.03
    24	1.02
    25	1.03
    26	1.03
    27	1.03
    28	1.03
    29	1.03
    30	1.03
    31	1.03
    32	1.03
    33	1.03
    34	0.14		<==
    35	1.03
    36	1.03
    37	1.03
    38	1.03
    39	1.03
    40	1.03
    41	1.03
    42	1.02
    43	1.03
    44	1.03
    45	1.03
    46	1.03
    47	1.03
    48	1.03
    49	1.03
    50	1.03
    51	1.03
    52	0.18		<==
    53	1.03
    54	1.03
    55	1.03
    56	1.03
    57	1.03
    58	1.03
    59	1.03
    60	1.02
    61	1.03
    62	1.03
    63	1.03
    64	1.04
    65	1.03
    66	1.03
    67	1.03
    68	1.03
    69	1.03
    70	0.13		<==
    71	1.03
    72	1.03
    73	1.03
    74	1.03
    75	1.03
    76	1.03
    77	1.03
    78	1.02
    79	1.03
    80	1.03
    81	1.03
    82	1.03
    83	1.03
    84	1.03
    85	1.03
    86	1.03
    87	1.03
    88	0.15		<==
    89	1.03
    90	1.03
    91	1.03
    92	1.03
    93	1.03
    94	1.03
    95	1.03
    96	1.02
    97	1.03
    98	1.03
    99	1.03
   100	1.03

I also ran the following script on the system with the unstable clock,
measuring timer interrupts per CPU as visible in /proc/interrupts:

           CPU0       CPU1       
  0:    6741707    5860969    IO-APIC-edge  timer
  1:         45         10    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 14:     807745     907612    IO-APIC-edge  ide0
 15:     834978     871118    IO-APIC-edge  ide1
 17:   45336986   45939432   IO-APIC-level  SysKonnect SK-98xx
 18:          0          0   IO-APIC-level  libata
 21:          0          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
 22:          0          0   IO-APIC-level  VIA8237
NMI:          0          0 
LOC:   12601494   12601519 
ERR:          0
MIS:          0

script:

	#!/bin/sh

	for i in `yes|head -100`
	do
		s1=`cat /proc/interrupts`
		sleep 1
		s2=`cat /proc/interrupts`

		t10=`echo "$s1" | awk '$1=="0:"{ print $2}'`
		t11=`echo "$s1" | awk '$1=="0:"{ print $3}'`
		t20=`echo "$s2" | awk '$1=="0:"{ print $2}'`
		t21=`echo "$s2" | awk '$1=="0:"{ print $3}'`
		d1=`expr $t20 - $t10`
		d2=`expr $t21 - $t11`
		echo $d1 + $d2 = `expr $d1 + $d2`
	done | cat -n

annotated output:

      CPU0 CPU1   Total
-----------------------
     1  0 + 251 = 251
     2  0 + 251 = 251
     3  0 + 251 = 251
     4  0 + 251 = 251
     5  0 + 251 = 251
     6  52 + 196 = 248		<== (?)
     7  251 + 0 = 251
     8  251 + 0 = 251
     9  251 + 0 = 251
    10  251 + 0 = 251
    11  251 + 0 = 251
    12  251 + 0 = 251
    13  251 + 0 = 251
    14  251 + 0 = 251
    15  251 + 0 = 251
    16  147 + 1 = 148		<==
    17  0 + 252 = 252
    18  0 + 251 = 251
    19  0 + 251 = 251
    20  0 + 251 = 251
    21  0 + 251 = 251
    22  0 + 252 = 252
    23  0 + 251 = 251
    24  72 + 177 = 249		<== (?)
    25  252 + 0 = 252
    26  252 + 0 = 252
    27  252 + 0 = 252
    28  252 + 0 = 252
    29  252 + 0 = 252
    30  252 + 0 = 252
    31  252 + 0 = 252
    32  253 + 0 = 253
    33  253 + 0 = 253
    34  118 + 2 = 120		<==
    35  0 + 253 = 253
    36  0 + 253 = 253
    37  0 + 253 = 253
    38  0 + 253 = 253
    39  0 + 252 = 252
    40  0 + 252 = 252
    41  0 + 252 = 252
    42  78 + 171 = 249		<== (?)
    43  252 + 0 = 252
    44  252 + 0 = 252
    45  252 + 0 = 252
    46  252 + 0 = 252
    47  251 + 0 = 251
    48  251 + 0 = 251
    49  251 + 0 = 251
    50  251 + 0 = 251
    51  251 + 0 = 251
    52  121 + 1 = 122		<==
    53  0 + 251 = 251
    54  0 + 251 = 251
    55  0 + 251 = 251
    56  0 + 251 = 251
    57  0 + 251 = 251
    58  0 + 251 = 251
    59  0 + 251 = 251
    60  69 + 179 = 248		<== (?)
    61  251 + 0 = 251
    62  251 + 0 = 251
    63  251 + 0 = 251
    64  251 + 0 = 251
    65  251 + 0 = 251
    66  251 + 0 = 251
    67  251 + 0 = 251
    68  251 + 0 = 251
    69  251 + 0 = 251
    70  130 + 1 = 131		<==
    71  0 + 252 = 252
    72  0 + 252 = 252
    73  0 + 252 = 252
    74  0 + 252 = 252
    75  0 + 252 = 252
    76  0 + 252 = 252
    77  0 + 252 = 252
    78  77 + 172 = 249		<== (?)
    79  253 + 0 = 253
    80  253 + 0 = 253
    81  253 + 0 = 253
    82  253 + 0 = 253
    83  253 + 0 = 253
    84  253 + 0 = 253
    85  252 + 0 = 252
    86  252 + 0 = 252
    87  252 + 0 = 252
    88  112 + 2 = 114		<==
    89  0 + 252 = 252
    90  0 + 252 = 252
    91  0 + 252 = 252
    92  0 + 252 = 252
    93  0 + 252 = 252
    94  0 + 252 = 252
    95  0 + 251 = 251
    96  0 + 251 = 251
    97  0 + 251 = 251
    98  53 + 195 = 248		<== (?)
    99  251 + 0 = 251
   100  251 + 0 = 251

The hangcheck timer goes off when configured.

-- 
Frank
