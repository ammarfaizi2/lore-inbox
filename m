Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131163AbRAMS0B>; Sat, 13 Jan 2001 13:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbRAMSZv>; Sat, 13 Jan 2001 13:25:51 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131179AbRAMSZe>;
	Sat, 13 Jan 2001 13:25:34 -0500
Message-ID: <3A6071C2.47E8418A@colorfullife.com>
Date: Sat, 13 Jan 2001 16:18:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Andrew Morton <andrewm@uow.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Frank de Lange <frank@unternet.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Call for testers: ne2k-pci and io apic (was: Re: QUESTION: Network hangs 
 with BP6...)
In-Reply-To: <200101131237.f0DCb8g15518@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------0855CE8377B022E4058E7507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0855CE8377B022E4058E7507
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Russell King wrote:
> 
> Doesn't the NCR53C9x SCSI drivers use disable_irq() a lot?  Do they have
> any problems?
>

It seems that a certain timing is necessary: one flood ping or a single
ncp usually doesn't trigger any problems, but 2 concurrent flood pings
hang the network after 5-10 seconds. It's not multi processor specific,
both I and Frank can trigger it when we boot with one cpu.

So far it seems that only the io apic for the BX chipset is affected
(only SMP BX boards contain an io apic).

Any volunteers with ne2k-pci cards and other motherboards that include
an io apic (e.g. all Intel motherboards that use an IO Controller Hub,
Via Apollo Pro133, Pro133A, KX133)?

Please:
* apply the attached patch.
* compile the kernel for SMP, or at least enable uniprocessor io apic
support.
* reboot.
* flood ping the computer with 2 concurrent flood pings from a second
computer.
* wait one minute.

According to the ICH2 documentation the IRR bit on the IO APIC is
writable - that's either a docu error, or could cause further problems.

--
	Manfred
--------------0855CE8377B022E4058E7507
Content-Type: text/plain; charset=us-ascii;
 name="patch-focus"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-focus"

--- linux/arch/i386/kernel/apic.c	Tue Dec  5 21:43:48 2000
+++ linux/arch/i386/kernel/apic.c.new	Sat Jan 13 15:54:56 2001
@@ -270,7 +270,7 @@
 	 *   PCI Ne2000 networking cards and PII/PIII processors, dual
 	 *   BX chipset. ]
 	 */
-#if 0
+#if 1
 	/* Enable focus processor (bit==0) */
 	value &= ~(1<<9);
 #else


--------------0855CE8377B022E4058E7507--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
