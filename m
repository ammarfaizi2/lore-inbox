Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUJONzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUJONzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJONyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:54:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:11960 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267852AbUJONxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:53:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16751.54873.668167.981073@alkaid.it.uu.se>
Date: Fri, 15 Oct 2004 15:53:29 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "mobil@wodkahexe.de" <mobil@wodkahexe.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
In-Reply-To: <Pine.LNX.4.58L.0410142225160.25607@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
	<Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
	<16750.23132.41441.649851@alkaid.it.uu.se>
	<Pine.LNX.4.58L.0410142225160.25607@blysk.ds.pg.gda.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 > @@ -667,7 +667,7 @@ static int __init detect_init_APIC (void
 >  	u32 h, l, features;
 >  	extern void get_cpu_vendor(struct cpuinfo_x86*);
 >  
 > -	/* Disabled by DMI scan or kernel option? */
 > +	/* Disabled by kernel option? */
 >  	if (enable_local_apic < 0)
 >  		return -1;
 >  

DMI scan may still be relevant. Previously we used it to
override the default force-enable policy. Now we may still
need it to force-disable the lapic on systems that boot with
it enabled but malfunction if it's used. (I don't know of
any, but given BIOS history, they aren't impossible.)
So the comment doesn't need to change.

 > @@ -681,8 +681,7 @@ static int __init detect_init_APIC (void
 >  			break;
 >  		goto no_apic;
 >  	case X86_VENDOR_INTEL:
 > -		if (boot_cpu_data.x86 == 6 ||
 > -		    (boot_cpu_data.x86 == 15 && (cpu_has_apic || enable_local_apic > 0)) ||
 > +		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
 >  		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 >  			break;
 >  		goto no_apic;

Looks Ok

 > @@ -692,15 +691,20 @@ static int __init detect_init_APIC (void
 >  
 >  	if (!cpu_has_apic) {
 >  		/*
 > -		 * Over-ride BIOS and try to enable LAPIC
 > -		 * only if "lapic" specified
 > +		 * Over-ride BIOS and try to enable the local
 > +		 * APIC only if "lapic" specified.
 >  		 */
 > -		if (enable_local_apic != 1)
 > -			goto no_apic;
 > +		if (enable_local_apic <= 0) {
 > +			printk("Not enabling local APIC "
 > +			       "because of frequent BIOS bugs\n");
 > +			printk("You can enable it with \"lapic\"\n");
 > +			return -1;

I agree with Alan that accusing the BIOS of being buggy is unwarranted.
The text should just state the obvious:

The local APIC was disabled by the BIOS.
You can enable it with "lapic".

 > +		}
 >  		/*
 >  		 * Some BIOSes disable the local APIC in the
 >  		 * APIC_BASE MSR. This can only be done in
 > -		 * software for Intel P6 and AMD K7 (Model > 1).
 > +		 * software for Intel P6, Intel P4 and AMD K7
 > +		 * (Model > 1).

To implicitly include P4 and K8, just change this to:
Intel P6 and later, and AMD K7 (Model > 1) and later

/Mikael
