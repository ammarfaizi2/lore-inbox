Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbUCSS4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbUCSS4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:56:00 -0500
Received: from smtp05.web.de ([217.72.192.209]:18970 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263063AbUCSSzw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:55:52 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: ross@datscreative.com.au
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Fri, 19 Mar 2004 19:55:36 +0100
User-Agent: KMail/1.5.4
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, len.brown@intel.com,
       linux-kernel@vger.kernel.org
References: <200403181019.02636.ross@datscreative.com.au>
In-Reply-To: <200403181019.02636.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403191955.38059.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 18. März 2004 01:19 schrieb Ross Dickson:

~~ snip ~~

> > The only way to cool down my CPU was to enable timer_ack.
> >  I don't know how to help you, but of course I am willing to test
> > patches... ;-) Thomas
>
> I agree with Len Brown's comments to try to examine which power saving
> state but if you want to try to brute force C1 state ( only works if
> chipset supported ) you could try this patch for process.c,
> (ignore the io-apic patch as it is nforce2 specific).
>
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/6520.html
> The KERNEL ARG to invoke it is "idle=C1halt".
>
> It has an extra function pointer to prevent the power management idle
> routine hikjacking things after the command line arg has requested an idle
> routine.
>
> These idle mods appear to assist more than just nforce2 Athlon boards.
> Thomas Herrmann has had success with an SIS740
>
> > Hi Ross,
> > I just want to let you know that your nforce2_idle patch does work with
> > the SiS740 chipset too. While the current ACPI patch already routes the
> > timer of the SiS740 to IO-APIC-edge with out the C1halt option of your
> > nforce2_idle patch the system locked up when STPGNT was enabled. But
> > after I applied your nforce2_idle patch to kernel 2.4.24 together with
> > the C1halt kernel boot option, the system runs stable for hours.
> > Great work, thanks!
> > Best regards,   Thomas
>
> Craig Bradney has put it into the gentoo dev sources also.
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/1746.html

OK, now I had the time to test if different C states are working with 
following three kernels:

1. 2.6.4-mm2 without the 8259-timer-ack-fix.patch and without the C1halt idle 
function.
2. 2.6.4-mm2 with the 8259-timer-ack-fix.patch and without the C1 halt idle 
function enabled.
3. 2.6.4-mm2 with the 8259-timer-ack-fix.patch and with the C1 halt idle 
function enabled.

I used following script to print the C-state counters on an complete idle 
machine before and after a 10second interval:

# /bin/sh
cat /proc/acpi/processor/CPU0/power
sleep 10
cat /proc/acpi/processor/CPU0/power

Now the results:

1.:
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] 
usage[00006280]
   *C2:                  promotion[--] demotion[C1] latency[100] 
usage[00300041]
    C3:                  <not supported>
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] 
usage[00006300]
   *C2:                  promotion[--] demotion[C1] latency[100] 
usage[00310045]
    C3:                  <not supported>

2.:
active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[C2] demotion[--] latency[000] 
usage[00000000]
    C2:                  promotion[--] demotion[C1] latency[100] 
usage[00000000]
    C3:                  <not supported>
active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[C2] demotion[--] latency[000] 
usage[00000000]
    C2:                  promotion[--] demotion[C1] latency[100] 
usage[00000000]
    C3:                  <not supported>

3.:
active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[C2] demotion[--] latency[000] 
usage[00000000]
    C2:                  promotion[--] demotion[C1] latency[100] 
usage[00000000]
    C3:                  <not supported>
active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[C2] demotion[--] latency[000] 
usage[00000000]
    C2:                  promotion[--] demotion[C1] latency[100] 
usage[00000000]
    C3:                  <not supported>

So, as you can see, the C1halt patch does not help here... ;-(

Regards
   Thomas Schlichter

