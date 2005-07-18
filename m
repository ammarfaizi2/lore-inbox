Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVGRNIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVGRNIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVGRNIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 09:08:39 -0400
Received: from alpha.tmit.bme.hu ([152.66.246.10]:7946 "EHLO alpha.ttt.bme.hu")
	by vger.kernel.org with ESMTP id S261429AbVGRNHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 09:07:55 -0400
Message-ID: <42DC2871.1030103@alpha.tmit.bme.hu>
Date: Mon, 18 Jul 2005 15:08:49 -0700
From: Gyorgy Horvath <horvaath@alpha.tmit.bme.hu>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ANNOUNCE: Driver for Rocky 4782E WDT and pls help
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi out there,

I am VERY SAD to announce a new driver for the
watchdog on Rocky 4782E2V processor card.

The architecture is very close to "Acquire WDT".
Effectivelly one or two additional line is needed, that allow
programming the timeout and properly kick the dog.

Writing a byte with the number of seconds to 0x0443
in the device open function will configure the timeout.
Ping needs a close before rearming.

I have compiled with CONFIG_WATCHDOG_NOWAYOUT and worked.

echo "1" > /dev/watchdog

15,14,13,...3,2,1,0 Booom.

The driver - rockywdt - can be downloaded from here

http://alpha.tmit.bme.hu/~horvaath/lk/rockywdt.tar.gz

The watchdog daemon can be pulled from the Debian pool.

CC-me on replies please.

P.S. Why I am so sad?
---------------------

I'll tell you.

In the most recent application of SGA155D dual
SONET/SDH PCI adapter I have to pass thru POS
traffic - but hold on the packets for a while.

The things are now perfect. It can do 20..30 Mbytes/sec
but there is a very strange side effect - decribed below.

1. Metrics:  Moderate load

   - cca. 60000 packets/second A-In, B-Out, B-In, A-Out - for each
   - cca. 4x5 Mbytes/sec R/W on the PCI bus, a Concorde can
     easily land between my two DMA R/Ws.
   - packet size = 80 bytes
   - SGA155D generates interrupt in every 100 usec. Everything is
     made here resulting 5% system load when idle, and 14% when fired.
   - Half of the RAM were stolen from Linux.
     (mem=xxxx kernel parameter)
     This range was requeset_mem_region-ed, then
     ioremap-ped for bus mastering DMA transfer.
     Actually 30 M is used.
     (cat /proc/iomem shows 0c800000-0e7fffff : sga155d0)
   - The granulity of the DMA transfer is 128 bytes (64 DWORDS) per turn.
     The card reqests the PCI bus for each turn, then release it.
     (Note that each packet can get thru in one turn)
   - Total of 16M small blocks were vmalloc-ed to keep track on
     flows. This blocks has been kicked randomly upon each packet
     arrival (2x60000 times/sec) by the Interrupt routine.
   - Linux: Latest Debian woody
   - Kernel: kernel-source-2.4.18 (1..3)

2. Technique

   - On Rx - the card do everything. Once it fired - it fills the DMA
     buffer, and once reach the end it restarts from the beginning.
     There is no need for any kind of intervention from the PC.
     It's progress is snooped through a stabilized regitser showing
     where the DMA write address currently is.

   - The interrupt routine contact the vmalloc-ed blocks to schedule
     the transmission.

   - On Tx - the interrupt routine writes a register with the
     address of the packet to send. There is no flow control here either.
     If the transmit queue (taking that register) is full, the
     packet is then simply dropped and counted.

3. Good news

   - Every single inbound packet has been succesfully sent at
     this load. No miss-sequence, no CRC, none... Seamless.

   - PCI slots behind the backplane's DECHIP PCI bridge
     can perform up to this rate without packet loss.
     At higher rates rx drops arises.

   - Slots routed directly from the CPU card well outperform this.

   - It can do for more than a day continously if unattended (see below).

4. Bad news

   - Issuing a simple ls -la / surelly causes instant death.

     Instant mean -> not a single last breath. (no kernel printouts)
     Death mean   -> plain dead. Only hard reset is working here.

5. The chalenge
   
   5.1 - Fire up the card
       - Apply the load
       - Issue - let say - lynx
       - Dead :-(

   5.2 - Fire up the card
       - Issue lynx - OK
       - Apply the load
       - Issue lynx again - OK :-O
       - Issue ls -la /
       - Dead :-S

   5.3 - Fire up the card
       - issue lynx - OK
       - issue ls -la / -OK
       - Apply the load
       - Issue pos sga155d0 -x (thats a control app)
       - Dead :-Z

   5.4 - Fire up the card
       - issue lynx - OK
       - Apply the load
       - issue lynx - OK
       - Sieze the load !!!!!!
       - issue ls -la / -OK !!
       - Reapply the load
       - Issue pos sga155d0 -x
       - Dead ;-/

   ... etc ...

6. Investigation

   At the very beginning I spent a lot of time finding a
   hardware bug. None. I feel it.  Although I noticed that
   someone (not me) takes control of the PC - time to time -
   for cca. 400..500 usec so that no DMA can occur.
   Therefore at at higher load some packet loss may occur.
   (I'will enlarge some FIFO's to bridge out this)
   
   I have gdb-d my 'crashing' controll app and found that a
   simple sscanf causes the sudden death.

   Moreover, I have applied a breakpoint to sscanf in the
   shared.o. Disassembling the the code causes sudden death
   at a given point. The code portions were not executed, just
   disassembled. What the hell is that?

   Besides the system is responsive and stable during that load
   - if I try things have been tried already before the load
   is applied. I am using ssh to control the box for example.

   This is the point where I gave up. I will modify the fire-up
   script so that every usual app will be preloaded/cahced once
   before applying the load. Also, a watchdog will be settled.
   (Just in case someone issuing a fortune accidentally :-).
   Hmmm... I am wondering how to preload reboot or halt...

   That is why I AM SO SAD.

7. Suspects

   Yes, I know that I am using Linux for something - not intended to.
   My suspects are the following:

   - The way I do the things eats-up something that is vital for Linux.

   - Linux hangs at the very point when a portion of a shared object, or
     an application is going to be mapped? or cached? into the memory
     space.
    
   I smell some MMU/VM's smoke. I tried ioremap_nocache, but none
   - except that system load is up to 75% when fired.

   I put kmalloc/vmalloc-ed stuff under my ioremap-ped region.
   None.

8. Reason: Unknown (for me)

   Can anybody help out there with this?
   
   http://alpha.tmit.bme.hu/~horvaath/lk/sga155d.tar.gz
   -- --
   sga155d.c  - Core driver for IP-Core management
   d1550382.c - This the real driver for the IP-Core (0xD1550382)
   -- --
   Do not beat me for the aboves. I am in terrible hurry, so
   there are a lot of Quick-And-Dirty work in them.

Best regards

Gyuri

       

