Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRJLSFc>; Fri, 12 Oct 2001 14:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276698AbRJLSFW>; Fri, 12 Oct 2001 14:05:22 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:180 "EHLO e22.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S274299AbRJLSFO>;
	Fri, 12 Oct 2001 14:05:14 -0400
Date: Fri, 12 Oct 2001 10:59:47 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Sean Cavanaugh <seanc@gearboxsoftware.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: P4 SMP load balancing
Message-ID: <2157008025.1002884387@mbligh.des.sequent.com>
In-Reply-To: <002601c15300$3a9f0510$150a10ac@gearboxsoftware.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ovendev:~# cat /proc/interrupts 
>            CPU0       CPU1       
>   0:    6348212          0    IO-APIC-edge  timer
>   1:          2          0    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          1          0    IO-APIC-edge  rtc
>   9:          0          0    IO-APIC-edge  acpi
>  16:      92620          0   IO-APIC-level  eth0
>  18:       5085          0   IO-APIC-level  aic7xxx, aic7xxx
> NMI:          0          0 
> LOC:    6348388    6348427 
> ERR:          0
> MIS:          0

I don't think this should happen. In the event of both procs having equal 
priority (linux never changes them, so they always do), we should fall back 
to the arbitration priority of the lapic. Whether you have 1 or 2 I/O apics
working shouldn't make a difference. 

The arb priority of the local apic should change whenever a message
is sent (see the Intel docs on developer.intel.com), so we effectively
get round robin. For instance, a 4 way looks like this:

          CPU0       CPU1       CPU2       CPU3
  0:    1608606    1595657    2168078    1575546 	IO-APIC-edge  timer
  1:          0          0          0          2	IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  4:         76         52         62         48    IO-APIC-edge  serial
 23:       7983       8263       8286       8306   IO-APIC-level  qlogicisp
 39:          0          0          0          0          IO-APIC-level  eth1
 40:       6247       6216       6894       6325	IO-APIC-level  eth0
NMI:          0          0          0          0          
LOC:    6947876    6947859    6947873    6947874  
ERR:          0
MIS:          0

Which isn't perfectly balanced, but it looks a damned sight better than
yours does ;-) Do you have something in the log that looks like this?

Oct 11 15:35:04 elm3b76 kernel: IO APIC #13...... 
Oct 11 15:35:04 elm3b76 kernel: .... register #00: 0D000000 
Oct 11 15:35:04 elm3b76 kernel: .......    : physical APIC id: 0D 
Oct 11 15:35:04 elm3b76 kernel: .... register #01: 00170011 
Oct 11 15:35:04 elm3b76 kernel: .......     : max redirection entries: 0017 
Oct 11 15:35:04 elm3b76 kernel: .......     : IO APIC version: 0011 
Oct 11 15:35:04 elm3b76 kernel: .... register #02: 00000000 
Oct 11 15:35:04 elm3b76 kernel: .......     : arbitration: 00 
Oct 11 15:35:04 elm3b76 kernel: .... IRQ redirection table: 
Oct 11 15:35:04 elm3b76 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:    
Oct 11 15:35:04 elm3b76 kernel:  00 000 00  1    0    0   0   0    0    0    00 
Oct 11 15:35:05 elm3b76 kernel:  01 00F 0F  0    0    0   0   0    0    1    39 
Oct 11 15:35:05 elm3b76 kernel:  02 00F 0F  0    0    0   0   0    0    1    31 
Oct 11 15:35:05 elm3b76 kernel:  03 00F 0F  0    0    0   0   0    0    1    41 
Oct 11 15:35:05 elm3b76 kernel:  04 00F 0F  0    0    0   0   0    0    1    49 
Oct 11 15:35:05 elm3b76 kernel:  05 00F 0F  0    0    0   0   0    0    1    51 
Oct 11 15:35:05 elm3b76 kernel:  06 00F 0F  0    0    0   0   0    0    1    59 
Oct 11 15:35:05 elm3b76 kernel:  07 00F 0F  1    1    0   1   0    0    1    61 
Oct 11 15:35:05 elm3b76 kernel:  08 00F 0F  1    1    0   0   0    0    1    69 
Oct 11 15:35:05 elm3b76 kernel:  09 00F 0F  0    0    0   0   0    0    1    71 
Oct 11 15:35:05 elm3b76 kernel:  0a 00F 0F  0    0    0   0   0    0    1    79 
Oct 11 15:35:05 elm3b76 kernel:  0b 00F 0F  1    1    0   1   0    0    1    81 
Oct 11 15:35:05 elm3b76 kernel:  0c 00F 0F  0    0    0   0   0    0    1    89 
Oct 11 15:35:05 elm3b76 kernel:  0d 00F 0F  1    1    0   1   0    0    1    91 
Oct 11 15:35:05 elm3b76 kernel:  0e 00F 0F  0    0    0   0   0    0    1    99 
Oct 11 15:35:05 elm3b76 kernel:  0f 00F 0F  1    1    0   1   0    0    1    A1 
Oct 11 15:35:05 elm3b76 kernel:  10 00F 0F  1    1    0   1   0    0    1    A9 
Oct 11 15:35:05 elm3b76 kernel:  11 00F 0F  1    1    0   1   0    0    1    B1 
Oct 11 15:35:05 elm3b76 kernel:  12 00F 0F  1    1    0   1   0    0    1    B9 
Oct 11 15:35:05 elm3b76 kernel:  13 00F 0F  1    1    0   1   0    0    1    C1 
Oct 11 15:35:05 elm3b76 kernel:  14 00F 0F  1    1    0   1   0    0    1    C9 
Oct 11 15:35:05 elm3b76 kernel:  15 00F 0F  1    1    0   1   0    0    1    D1 
Oct 11 15:35:05 elm3b76 kernel:  16 00F 0F  1    1    0   1   0    0    1    D9 
Oct 11 15:35:05 elm3b76 kernel:  17 00F 0F  1    1    0   1   0    0    1    E1 

You might have to tweak syslog.conf to log the debug messages. And 
possibly increase LOG_BUF_LEN in kernel/printk.c to something sensible
(63356?)

M.


