Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbTDWUld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDWUld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:41:33 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:22540 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263585AbTDWUla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:41:30 -0400
Message-ID: <3EA6FD50.2090103@inet6.fr>
Date: Wed, 23 Apr 2003 22:53:36 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RH9 2.4.20-9] SIS based Ibm Aptiva : Invalid EIP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

one user reported what seemed to be an SiS5513 IDE related bug during 
kernel loading with the 2.4.20-9 RH9 kernel.

# Summary :

- The hardware is a SiS5513 based IBM Aptiva (Pentium 166 with F00F bug)
- The symptom is an invalid EIP in sis5513.c's config_art_rwp_pio (from 
the stack trace summary reported) when trying to configure hdc or hdd. 
The kernel boots if passed hdc=none and hdd=none.
- Reverting to the 2.4.18-27.8.0 RH8 kernel solves the problem.
- The problem is 100% reproducible on this hardware.
- different lspci -vxxx tries show unexpected results, see below

# More matter for thought :

What puzzles me is that the sis5513.c driver behaviour at boot time 
didn't change for this hardware between these 2 kernels !
I requested lspci -vxxx and dmesg output from fresh cold boots in the 
following configurations :

RH8   : 2.4.18-27.8.0 without extra parameters
RH8_2 : 2.4.18-27.8.0 with "hdc=none hdd=none"
RH9   : 2.4.20-9 with "hdc=none hdd=none"

and found out the following :

1/ Some dmesg differences :

RH9 inits the floppy device earlier (before the ide devices instead of 
after them),
RH9 adds "Speakup".

2/ There's a difference in the ISA bridge config registers between the 
RH8 and the RH8_2 tests :

--- lspci_rh8.txt       2003-04-23 22:19:07.000000000 +0200
+++ lspci_rh8_hdc=none,hdd=none.txt     2003-04-23 22:19:07.000000000 +0200
@@ -17,21 +17,21 @@
 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
        Flags: bus master, medium devsel, latency 0
 00: 39 10 08 00 07 00 00 02 01 00 01 06 00 00 80 00
 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 40: 0a 0b 0a 80 80 00 00 00 ff ff 10 0f 11 20 04 01
-50: 11 28 02 01 60 00 66 00 9c 2e 12 00 0c e9 00 00
+50: 11 28 02 01 60 00 62 00 9c 2e 12 00 0c e9 00 00
 60: 80 80 44 80 82 80 02 00 02 00 04 00 00 00 00 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[...]

I don't know what these registers are used for but I don't see any 
reason for these changes. I guess there aren't related to the kernel 
parameters as previously (without cold boot guarantee) lspci reported 
once the following register values too (RH8 or RH8_2 type boot) :

50: 11 28 02 01 60 00 66 00 9c 2e 12 00 36 06 00 00

3/ lspci couldn't find the IDE I/O ports with the RH9 kernel (on several 
tries)

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 
08) (prog-if 8a [Mas
ter SecP PriP])
        Flags: bus master, fast devsel, latency 0
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at fe80 [size=16]
00: 39 10 13 55 07 00 00 00 08 8a 01 01 00 00 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 81 fe 00 00 00 00 00 00 00 00 00 00 00 00 80 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 02 03 02 03 02 03 02 03 00 00 46 df 00 02 00 02
50: 02 03 02 03 02 03 02 03 00 00 46 df 00 02 00 02
60: 02 03 02 03 02 03 02 03 00 00 46 df 00 02 00 02
70: 02 03 02 03 02 03 02 03 00 00 46 df 00 02 00 02
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 02 03 02 03 02 03 02 03 00 00 46 df 00 02 00 02
d0: 02 03 02 03 02 03 02 03 00 00 46 df 00 02 00 02
e0: 02 03 02 03 02 03 02 03 00 00 46 df 00 02 00 02
f0: 02 03 02 03 02 03 02 03 00 00 46 df 00 02 00 02

With the RH8 kernel lspci reports the following :
00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 
08) (prog-if 8a [Mas
ter SecP PriP])
        Flags: bus master, fast devsel, latency 0
        I/O ports at 01f0
        I/O ports at 03f4
        I/O ports at 0170
        I/O ports at 0374
        I/O ports at fe80 [size=16]
[...]

I don't know what to think of this one either.

Hoping this will make some sense for somebody,

LB

