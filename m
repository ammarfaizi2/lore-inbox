Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135968AbRD0JIX>; Fri, 27 Apr 2001 05:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135989AbRD0JIO>; Fri, 27 Apr 2001 05:08:14 -0400
Received: from t2.redhat.com ([199.183.24.243]:44280 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135968AbRD0JIF>; Fri, 27 Apr 2001 05:08:05 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15080.40123.543633.854889@pizda.ninka.net> 
In-Reply-To: <15080.40123.543633.854889@pizda.ninka.net>  <4148FEAAD879D311AC5700A0C969E89006CDDD9F@orsmsx35.jf.intel.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'John Fremlin'" <chief@bandits.org>,
        "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown [linux-power] [linux-pm-devel] [linux-kernel-mailing-list] [some-other-list]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Apr 2001 10:03:12 +0100
Message-ID: <17244.988362192@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
> You can break the whole power management problem down to "here are the
> levels of low-power provided by the hardware, here are the idleness
> triggers that may be monitored".  That's it, nothing more.
> This is powerful enough to do all the things you could want a pm layer
> to do:
>
>	1) CPU's have been in their idle threads for X percent of
>	   of the past measurement quantum, half clock the processors.
>
>	2) The user has hit the "sleep" trigger, spin down the disks,
>	   reduce clock the cpus, bus, PCI controller and PCI devices.

Often the 'sleep trigger' is an _absence_ of activity rather than anything
explicit like a button being pressed. You need inactivity timers, and events
which _reset_ those timers, on triggers like keyboard/touchscreen/serial
input, etc. 

It's arguable that you can do that in userspace. Possibly - I'm not 100% 
convinced of that. If you have many events which can reset many different 
timers, the amount of traffic between kernel and user space just to reset 
those timers may be quite high. 

If an inactivity timer is implemented in userspace, with serial input being 
one of the events that resets it, you're going to get a lot of wakeup/reset
events if you do a large download over that port.

It's possible that we could optimise that somehow, so we can avoid having 
to implement PM timers in kernelspace. I'm not sure.  Perhaps the wakeup 
events could be on a separate queue, with no duplicates permitted, and the 
PM daemon could poll that queue only when it's about to shoot one of its 
timers.

For maximum efficiency, when receiving an event in sleep mode which isn't 
supposed to wake the system, we should drop the event and go back to sleep 
as quickly as possible. If you have to run userspace processes to make that 
decision, it's not going to be particularly fast. 

It may be sensible to have a simple policy engine in the kernel which
implement a policy provided by userspace. Some kind of simple state machine.

--
dwmw2


