Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264456AbUDZKFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbUDZKFJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbUDZKFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:05:08 -0400
Received: from web13909.mail.yahoo.com ([216.136.172.94]:48566 "HELO
	web13909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264456AbUDZKE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:04:57 -0400
Message-ID: <20040426100456.82710.qmail@web13909.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Mon, 26 Apr 2004 03:04:56 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Two problems after upgrade tto 2.4.26
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1082861443.3160.18.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Len Brown <len.brown@intel.com> wrote:
> On Fri, 2004-04-23 at 04:22, Martin Knoblauch wrote:
> 
> Re: keyboard/mouse instability with ACPI enabled starting in 2.4.26
> 
> > >Does /proc/interrupts show any acpi events?
> > >Did it in 2.4.23?
> > >
> > Len,
> > 
> >   some ACPI Interrupts:
> > 
> > cat /proc/interrupts
> >            CPU0
> >   0:      31464          XT-PIC  timer
> >   1:        570          XT-PIC  keyboard
> >   2:          0          XT-PIC  cascade
> >   3:          5          XT-PIC  HiSax
> >   8:          2          XT-PIC  rtc
> >   9:       1197          XT-PIC  acpi
> >  10:       1695          XT-PIC  eth0, usb-uhci, Texas Instruments
> >  PCI1420, Texas Instruments PCI1420 (#2)
> >  12:       5460          XT-PIC  PS/2 Mouse
> >  14:      18052          XT-PIC  ide0
> >  15:         11          XT-PIC  ide1
> 
> kill acpid and
> # cat /proc/acpi/event
> to see what the events are.
> We we are working on a GPE issue related to spurious
> ACPI interrupts right now, but I'd actually expect
> 2.4.26 to get _fewer_ acpi interrupts than 2.4.25, not more.
>
Hi Len,

 just to make things clear: I never talked about 2.4.25 :-) I went
directly from 2.4.23 to 2.4.26. And ACPI was not set in my 2.4.23
config. Not sure how it got set in 2.4.26? Interesting ...

 Anyway, I killed acpid and did a cat on the event stream. All I see
is:

# cat /proc/acpi/event
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
thermal_zone THRM 00000081 00000000
^C
#

 During this snapshot, the number of ACPI interrupts went up by about
270. So, it seems not every ACPI interrupt ends in /proc/acpi/event.

 In general, the whole thing is pretty hard to reproduce. It seems to
be also depenant on the system load. The keyboard double-hit is much
more likely to happen when running a kernel compile instead of an
otherwise idle system.

> Re: fan running more
> it would be interesting if you notice a temperature difference
> between the releases in /proc/acpi/thermal...
> 
> eg.
> cat /proc/acpi/thermal_zone/THRM/temperature
> temperature:             37 C
> 
> 
> FAN isn't always controlled by ACPI.  If it is, you'll see it
> in the dmesg like this:
> ACPI: Power Resource [PFAN] (off)
> In either case, it may be that we're running hotter (say idle
> isn't working right), or we're running the fan more often by mistake.
>

 Nope, no such messages in dmesg.
 
> For idle, you can compare the /proc/acpi/processor/CPU0/power
> file in the two releases to see if one release is getting into
> a deeper power-saving state than the other.
> 
> Eg, this centrino box isn't getting into C3 because USB is active.
> 
> cat /proc/acpi/processor/CPU0/power
> active state:            C2
> default state:           C1
> bus master activity:     ffffffff
> states:
>     C1:                  promotion[C2] demotion[--] latency[000]
> usage[00000010]
>    *C2:                  promotion[C3] demotion[C1] latency[001]
> usage[00370077]
>     C3:                  promotion[--] demotion[C2] latency[085]
> usage[00000000]
> 
>

 On my system it looks like this:

# cat /proc/acpi/processor/CPU0/power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000]
usage[00012170]
   *C2:                  promotion[--] demotion[C1] latency[010]
usage[00888388]
    C3:                  <not supported>

 
> cheers,
> -Len
> 
Thanks
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
