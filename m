Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316892AbSGNPSz>; Sun, 14 Jul 2002 11:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSGNPSy>; Sun, 14 Jul 2002 11:18:54 -0400
Received: from t6o913p234.telia.com ([213.64.36.234]:26496 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S316892AbSGNPSx>;
	Sun, 14 Jul 2002 11:18:53 -0400
To: Dominik Brodowski <devel@brodo.de>
Cc: zwane@linuxpower.ca, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac3
References: <1026611437.13885.37.camel@irongate.swansea.linux.org.uk>
	<m265zj9zxn.fsf@best.localdomain> <6010.1026651788@www53.gmx.net>
	<20020714150912.A1148@brodo.de>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2002 17:19:54 +0200
In-Reply-To: <20020714150912.A1148@brodo.de>
Message-ID: <m2k7nyqqud.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <devel@brodo.de> writes:

> On Sun, Jul 14, 2002 at 03:03:08PM +0200, Alan Cox wrote:
> > > 3. The cpu voltage is automatically reduced when the frequency is
> > >    reduced.
> > 
> > True for some x86 processors, either automatically, or on some
> > controlled by us.
> 
> The p4-clockmod driver you seem to using does not scale the voltage. 
> In case you own a P4-M and a ICH2-M or ICH3-M southbridge: the 
> speedstep.c driver in the 2.5.-cpufreq patchset (backport to 2.4. 
> will be available soon) should do the job and adjust the processor 
> voltage.

I tried speedstep but it didn't work because of this check in
speedstep_detect_processor:

		/* Intel Pentium 4 Mobile P4-M */
		if (c->x86_model != 2)
			return 0;

		if (c->x86_mask != 4)
			return 0;     /* all those seem to support Enhanced
					 SpeedStep */

My cpu has model == 1 and mask == 2. I deleted that code just to see
what would happen, but then I tripped over this code in
pentium4_get_frequency:

	/* Don't trust unseen values yet, except in the MHz field 
	 */
	if (msr_hi || ((msr_lo & 0x00FFFFFF) != 0x300511)) {
		printk(KERN_INFO "cpufreq: Due to incomplete documentation, please send a mail to devel@brodo.de\n");
		printk(KERN_INFO "with a dmesg of a boot while on ac-power, and one of a boot on battery-power.\n");
		printk(KERN_INFO "Thanks in advance.\n");
		return 0;
	}

I removed the return statement, and then got:

        apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
        cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.34 $
        model:1 mask:2
        cpufreq: chipset 0x3 - processor 0x3
        cpufreq: activating SpeedStep (TM) registers
        cpufreq: read at pmbase 0x1000 + 0x50 returned 0x1
        cpufreq: P4 - MSR_EBC_FREQUENCY_ID: 0x8a01fe00 0x0
        cpufreq: Due to incomplete documentation, please send a mail to devel@brodo.de
        with a dmesg of a boot while on ac-power, and one of a boot on battery-power.
        Thanks in advance.
        cpufreq: read at pmbase 0x1000 + 0x50 returned 0x1
        cpufreq: writing 0x0 to pmbase 0x1000 + 0x50
        cpufreq: read at pmbase 0x1000 + 0x50 returned 0x0
        cpufreq: change to 0 MHz succeded
        cpufreq: read at pmbase 0x1000 + 0x50 returned 0x0
        cpufreq: P4 - MSR_EBC_FREQUENCY_ID: 0x8a01fe00 0x0
        cpufreq: Due to incomplete documentation, please send a mail to devel@brodo.de
        with a dmesg of a boot while on ac-power, and one of a boot on battery-power.
        Thanks in advance.
        cpufreq: read at pmbase 0x1000 + 0x50 returned 0x0
        cpufreq: read at pmbase 0x1000 + 0x50 returned 0x0
        cpufreq: currently at low speed setting - 13800 MHz
        CPU clock: 13800.000 MHz (13800.000-13800.000 MHz)
        Starting kswapd

There was no difference in dmesg output when booting on battery power
instead of ac power.

So what can I do to make speedstep work? According to the notebook
manual, speedstep is supported on this computer.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
