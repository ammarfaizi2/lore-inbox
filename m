Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRALSKa>; Fri, 12 Jan 2001 13:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130571AbRALSKU>; Fri, 12 Jan 2001 13:10:20 -0500
Received: from colorfullife.com ([216.156.138.34]:31749 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130425AbRALSKI>;
	Fri, 12 Jan 2001 13:10:08 -0500
Message-ID: <3A5F4428.F3249D2@colorfullife.com>
Date: Fri, 12 Jan 2001 18:51:36 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware 
 related?
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com> <20010112183314.A24174@unternet.org>
Content-Type: multipart/mixed;
 boundary="------------19C27FC008B04CB8FB347F1A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------19C27FC008B04CB8FB347F1A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Frank de Lange wrote:
> 
> On Fri, Jan 12, 2001 at 06:16:36PM +0100, Manfred Spraul wrote:
> > I would first concentrate on the differences between 2.2 and 2.4:
> >
> > Frank, could you try what happens with the NMI oopser disabled?
> 
> Here's the results with nmi_watchdog=0
> 
> 
> After network hang (nmi_watchdog=0)
> ===================================
> 

It still hangs.

Frank, I've attached a proposed kick_IOAPIC pin. Could you try it?
I'm rebooting with that patch right now.
--
	Manfred
--------------19C27FC008B04CB8FB347F1A
Content-Type: text/plain; charset=us-ascii;
 name="patch-frank"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-frank"

1) add to the end of io_apic.c:

static void print_line(struct IO_APIC_route_entry* entry)
{
	printk(KERN_EMERG " %02x %03X %02X  ",
			0,
			entry->dest.logical.logical_dest,
			entry->dest.physical.physical_dest
		);

	printk("%1d    %1d    %1d   %1d   %1d    %1d    %1d    %02X\n",
			entry->mask,
			entry->trigger,
			entry->irr,
			entry->polarity,
			entry->delivery_status,
			entry->dest_mode,
			entry->delivery_mode,
			entry->vector
		);
}

void kick_IOAPIC_pin(int pin)
{
    	unsigned long flags;
	struct IO_APIC_route_entry entry;

	local_irq_save(flags);

	*(((int *)&entry) + 1) = io_apic_read(0, 0x11 + 2 * pin);
	*(((int *)&entry) + 0) = io_apic_read(0, 0x10 + 2 * pin);

	printk(KERN_EMERG " NR Log Phy Mask Trig IRR Pol"
			  " Stat Dest Deli Vect:   \n");
	printk(KERN_EMERG "Before:\n");
	print_line(&entry);

	entry.trigger = 0;
	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry) + 1));
	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry) + 0));
	udelay(10);
	printk(KERN_EMERG "After switching to edge:\n");
	print_line(&entry);

	entry.trigger = 1;
	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry) + 1));
	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry) + 0));
	udelay(10);
	printk(KERN_EMERG "After switch back:\n");
	print_line(&entry);

	local_irq_restore(flags);
}

2) add to sysrq.c:
--- 2.4/drivers/char/sysrq.c	Mon Dec  4 02:48:19 2000
+++ build-2.4/drivers/char/sysrq.c	Fri Jan 12 18:37:57 2001
@@ -137,6 +137,9 @@
 		send_sig_all(SIGKILL, 1);
 		orig_log_level = 8;
 		break;
+	case 'q':
+		kick_IOAPIC_pin(19);
+
 	default:					    /* Unknown: help */
 		if (kbd)
 			printk("unRaw ");

--------------19C27FC008B04CB8FB347F1A--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
