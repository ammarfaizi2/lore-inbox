Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRAVEyo>; Sun, 21 Jan 2001 23:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbRAVEyY>; Sun, 21 Jan 2001 23:54:24 -0500
Received: from 64-32-134-244.phx1.phoenixdsl.net ([64.32.134.244]:34825 "EHLO
	virtualwire.org") by vger.kernel.org with ESMTP id <S129826AbRAVEyT>;
	Sun, 21 Jan 2001 23:54:19 -0500
Date: Sun, 21 Jan 2001 21:54:23 -0700
From: Duncan Laurie <duncan@virtualwire.org>
To: Petr Matula <pem@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org, randy.dunlap@intel.com
Subject: Re: int. assignment on SMP + ServerWorks chipset
Message-ID: <20010121215423.A20953@virtualwire.org>
In-Reply-To: <3A64F7E2.30807@virtualwire.org> <20010118095810.A13218780@aisa.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010118095810.A13218780@aisa.fi.muni.cz>; from "pem@informatics.muni.cz" on Thu, Jan 18, 2001 at 09:58:10AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Petr Matula wrote:
| On Tue, Jan 16, 2001 at 06:39:46PM -0700, Duncan Laurie wrote:
| > There may be bogus data in the PIRQ table as well, which is why this
| > explicitly routes the interrupt & sets the ELCR.  If you enable DEBUG
| > in pci-i386.h and re-send the dmesg output I will look it over.
| I tied your patch. dmesg output si attached.
| 
| Without this patch the smp kernel crashes when my USB printer is detected.
| With this patch only a USB Hub is detected but not the printer. It seems to
| be stable.
| 
| Petr
|

Hi Petr,

I didn't consider that your hardware would have subtle differences
than Mr. Dunlap's Intel SBT2 board, but these could have made the
hard-coded values in the patch invalid.  So instead try the attached
patch, and this time you'll need to plug in some values into a boot
parameter to override the mptable entry.

This "mpint=" parameter allows you to alter a specific (IO)INT mptable
entry destination APIC and INT.  It takes four arguments, the first
two for looking up the entry to change in the current mptable by APIC
and INT, and the second two are for the new APIC and INT values to use.
(I also have an expanded version that allows more detailed
modifications but the number of arguments gets out of hand very fast)

The values to use depend on what your system is configured to use
for the USB interrupt.  This can be obtained by using the dump_pirq
utility from the recent pcmcia utilities.  (I made some modifications
to recognize the ServerWorks IRQ router which is available from
ftp://virtualwire.org/dump_pirq)

The output you are looking for should look something like this:

Device 00:0f.0 (slot 0): ISA bridge
    INTA: link 0x01, irq mask 0x0400 [10]

The USB device is actually function 2, but uses INTA#.  The irq
mask value should give you the new INT value to put in the
mptable.  The old INT value can be read from the dmesg output
or by compiling and running mptable, which I also made available
at ftp://virtualwire.org/mptable.c.  (it appears to be '0' on your
hardware as well as Mr. Dunlap's)  The destination APIC should just
be the ID of the first IO-APIC in the system, in this case 4.

So based on the example above, you would add "mpint=5,0,4,10" to
the boot parameters.  One caveat, this doesn't actually change the
mptable as it is stored in memory so if you use the mptable program
to view it you will still see the original values.

Good luck, and feel free to send me the output from "dump_pirq"
and "mptable" if it doesn't work..

  -duncan


--- linux.orig/arch/i386/kernel/io_apic.c	Sun Oct  1 20:35:15 2000
+++ linux-2.4.1-pre8/arch/i386/kernel/io_apic.c	Sun Jan 21 21:08:42 2001
@@ -229,6 +229,43 @@
 }
 
 /*
+ * "mpint=oldAPIC,oldINT,newAPIC,newINT"
+ */
+static int __init ioapic_mpint_setup(char *str)
+{
+       struct mpc_config_intsrc newint;
+       int ints[5];
+       int i;
+
+       get_options(str, ARRAY_SIZE(ints), ints);
+       if (ints[0] < 4)
+               return 0;
+
+       for (i = 0; i < nr_ioapics; i++)
+               if (mp_ioapics[i].mpc_apicid == ints[1])
+                       ints[1] = i;
+
+       i = find_irq_entry(ints[1], ints[2], mp_INT);
+       if (i < 0)
+               return 0;
+
+       printk(KERN_DEBUG "(old) mpint: APIC ID %1d, APIC INT %02x\n",
+              mp_irqs[i].mpc_dstapic, mp_irqs[i].mpc_dstirq);
+
+       memcpy(&newint, &mp_irqs[i], sizeof(newint));
+       newint.mpc_dstapic = ints[3];
+       newint.mpc_dstirq = ints[4];
+       mp_irqs[i] = newint;
+
+       printk(KERN_DEBUG "(new) mpint: APIC ID %1d, APIC INT %02x\n",
+              mp_irqs[i].mpc_dstapic, mp_irqs[i].mpc_dstirq);
+
+       return 1;
+}
+
+__setup("mpint=", ioapic_mpint_setup);
+
+/*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
 static int __init find_isa_irq_pin(int irq, int type)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
