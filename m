Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293547AbSCSCmS>; Mon, 18 Mar 2002 21:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293556AbSCSCmJ>; Mon, 18 Mar 2002 21:42:09 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:13248 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S293547AbSCSCl4>; Mon, 18 Mar 2002 21:41:56 -0500
Date: Mon, 18 Mar 2002 20:41:06 -0600
From: Ken Brownfield <ken@irridia.com>
To: marcelo@conectiva.com.br, macro@ds2.pg.gda.pl, manfred@colorfullife.com,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com, mhunter@archway.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: I/O APIC fixed in 2.4.19-pre3 & 2.5.6 (was Re: Linux 2.4.19-pre3)
Message-ID: <20020318204106.A24611@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva> <20020311183746.A10303@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a followup, this APIC patch also prevents 2.4 machines on quite a bit
of common hardware from freezing up after a few hours to a few days of
production use.  Especially ServerWorks boards distributed by HP and
Rackable/Tyan.

This patch (applied to 2.4.18) seems to fix my long-standing (and
oft-mentioned on LKML) I/O APIC issue with all 2.4 kernels, and I no
longer need my "pintimer" patch to disable the through-8259A mode.

Kudos to the authors -- this was definitely a hard one to find, and I
expect a lot of people will have more stable machines because of it.
I'm also sending this to the folks who helped me with this issue in the
past.

Good work!
-- 
Ken.
ken@irridia.com

<macro@ds2.pg.gda.pl> (02/03/05 1.466.1.12)
[PATCH] 2.4.18, 2.5.5: I/O APIC through-8259A mode IRQ 0 routing
  There is a problem with the through-8259A mode for IRQ 0 on I/O APIC
systems.  Depending on correctness of an MP table, IRQ 0 routing is
either not registered at all or registered at a wrong pin.  As a result
the 8254 timer IRQ only works by an accident (it's edge-triggered and
never disabled/enabled so it happens to survive this incorrect
configuration).  A visible effect is you can't change the affinity for
IRQ 0.  Following is a patch that fixes both cases referred to above.
The code looks obvious but it was additionally run-time tested just in
case.  The issue is serious -- please apply the patch ASAP.  As no
changes were done to io_apic.c since the development fork, the patch
applies cleanly both to 2.4 and to 2.5.  Credit goes to Joe for
discovering the affinity problem and providing a fix proposal
(incorporated in the final one).  Maciej


On Mon, Mar 11, 2002 at 06:37:46PM -0600, Ken Brownfield wrote:
| Can the authors of this patch post separately on what is fixed here?  I
| apply the following patch to work around an eventual hang of the machine
| due to IRQ0 being "attached" to the IO APIC, and I'm hoping that this
| 2.4.19-pre3 patch fixes my problem the correct way.  V.s. my workaround
| hack.
| 
| Thanks much,
| -- 
| Ken.
| brownfld@irridia.com
| 
| On Mon, Mar 11, 2002 at 06:08:19PM -0300, Marcelo Tosatti wrote:
| | - Fix through-8259A mode for IRQ0 routing on APIC 	(Maciej W. Rozycki/Joe Korty)
| 
| 
| --- linux/arch/i386/kernel/io_apic.c.orig	Tue Nov 13 17:28:41 2001
| +++ linux/arch/i386/kernel/io_apic.c	Tue Dec 18 15:10:45 2001
| @@ -172,6 +172,7 @@
|  int pirq_entries [MAX_PIRQS];
|  int pirqs_enabled;
|  int skip_ioapic_setup;
| +int pintimer_setup;
|  
|  static int __init ioapic_setup(char *str)
|  {
| @@ -179,7 +180,14 @@
|  	return 1;
|  }
|  
| +static int __init do_pintimer_setup(char *str)
| +{
| +	pintimer_setup = 1;
| +	return 1;
| +}
| +
|  __setup("noapic", ioapic_setup);
| +__setup("pintimer", do_pintimer_setup);
|  
|  static int __init ioapic_pirq_setup(char *str)
|  {
| @@ -1524,27 +1532,31 @@
|  		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
|  	}
|  
| -	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
| -	if (pin2 != -1) {
| -		printk("\n..... (found pin %d) ...", pin2);
| -		/*
| -		 * legacy devices should be connected to IO APIC #0
| -		 */
| -		setup_ExtINT_IRQ0_pin(pin2, vector);
| -		if (timer_irq_works()) {
| -			printk("works.\n");
| -			if (nmi_watchdog == NMI_IO_APIC) {
| -				setup_nmi();
| -				check_nmi_watchdog();
| +	if ( pintimer_setup )
| +		printk(KERN_INFO "...skipping 8259A init for IRQ0\n");
| +	else {
| +		printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
| +		if (pin2 != -1) {
| +			printk("\n..... (found pin %d) ...", pin2);
| +			/*
| +			 * legacy devices should be connected to IO APIC #0
| +			 */
| +			setup_ExtINT_IRQ0_pin(pin2, vector);
| +			if (timer_irq_works()) {
| +				printk("works.\n");
| +				if (nmi_watchdog == NMI_IO_APIC) {
| +					setup_nmi();
| +					check_nmi_watchdog();
| +				}
| +				return;
|  			}
| -			return;
| +			/*
| +			 * Cleanup, just in case ...
| +			 */
| +			clear_IO_APIC_pin(0, pin2);
|  		}
| -		/*
| -		 * Cleanup, just in case ...
| -		 */
| -		clear_IO_APIC_pin(0, pin2);
| +		printk(" failed.\n");
|  	}
| -	printk(" failed.\n");
|  
|  	if (nmi_watchdog) {
|  		printk(KERN_WARNING "timer doesnt work through the IO-APIC - disabling NMI Watchdog!\n");
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
