Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271182AbRHTKVb>; Mon, 20 Aug 2001 06:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271174AbRHTKVM>; Mon, 20 Aug 2001 06:21:12 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:52867 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S271167AbRHTKVC>;
	Mon, 20 Aug 2001 06:21:02 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15232.58521.815192.337227@harpo.it.uu.se>
Date: Mon, 20 Aug 2001 12:21:13 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: georgn@somanetworks.com, linux-kernel@vger.kernel.org
Subject: Re: Dell I8000, 2.4.8-ac5 and APM 
In-Reply-To: <28536.998043272@redhat.com>
In-Reply-To: <200108162056.WAA18756@harpo.it.uu.se>
	<28536.998043272@redhat.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
 > mikpe@csd.uu.se said:
 > >  Concerning your problem with pulling the AC plug on your Dell I8000,
 > > my suspicion is that either (a) the BIOS isn't notifying apm.c of the
 > > event, or (b) apm.c fails to propagate the event to its PM clients. 
 > 
 > The problem with suspend actually turned out to be because the APIC is
 > unconditionally enabled _before_ the command line is scanned and the 'noapic'
 > option is detected.

Right, the local APIC is enabled very early, for some reason I don't recall right now.

 > The noapic option, however, does have the effect of
 > preventing the registration of the power management code :)

Hmm, the "noapic" kernel option does not and never has had anything to do with
the local APIC, only the IO-APIC which is a completely different beast.
However, RedHat 7.1+ added a bug in init/main.c where they bypass the second
half of the UP APIC initialisation if "noapic" is specified. So using "noapic"
you now end up with the local APIC enabled but its PM code disabled. Nice, eh?

 > Booting with 'apic' makes the thing take some time to suspend, and then 
 > it reboots instead of resuming. That may be your case (b). I put printk in 
 > the apic suspend and resume functions and neither of them seem to appear.

Please try this with a normal 2.4-ac kernel. Add a printk and a delay at the top
of apm.c's send_event() so we can see exactly which events occur. Boot with
UP_APIC enabled. Initiate suspend: did apm.c log an event and if so which one?
Try to resume: did apm.c log anything before the machine rebooted?

/Mikael
