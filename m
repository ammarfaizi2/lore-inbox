Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136540AbREIPYX>; Wed, 9 May 2001 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136543AbREIPYN>; Wed, 9 May 2001 11:24:13 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:63471 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136540AbREIPYG>; Wed, 9 May 2001 11:24:06 -0400
Message-ID: <3AF96164.40F73A9@redhat.com>
Date: Wed, 09 May 2001 11:25:24 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benedict Bridgwater <bennyb@ntplx.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
In-Reply-To: <E14xUbS-0002Op-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > This has been reported to both Mandrake and Redhat:
> >
> > http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=29555
> >
> > I've been trying to find out if there's a fix (if it's aic7xxx 6.1.13
> > that's great!), but Redhat seem to believe it's a 2.4 kernel PCI bug:
> 
> Personally I still think its a BIOS bug in those Intel BIOS boards. Hopefully
> some of the VA folks will eventually have time to double check the BIOS
> $PIRQ routing table on these systems and verify if the kernel is parsing it
> wrong or if its wrong in the BIOS ROM

EXTREMELY unlikely.  Under a 2.2 no-apic kernel, the aic7xxx card uses IRQ 11
and works.  Under a 2.2 ioapic kernel, it uses high interrupts and works. 
Under a 2.4 no-apic kernel it *thinks* it is using IRQ 11, but it doesn't work
(however, the card BIOS thinks it is using IRQ 11 as well, and it *does* work
until we boot the linux kernel).  Under a 2.4 ioapic kernel it uses high
interrupts and works.

Now, the failure mode of the 2.4 no-apic kernel varies depending upon
situation.  Specifically, if the eepro100 or e100 drivers are not loaded, then
IRQ 10 is not enabled by any device driver and loading the aic7xxx driver
simply results in infinite SCSI bus timeouts with nary a single interrupt on
pin 11.  However, if the eepro100 or e100 driver is loaded, then IRQ 10 will
have an active interrupt handler on it (which implies the interrupt is enabled
in the PIC) and loading the aic7xxx driver will hard lock the machine (which
implies an unanswered interrupt storm, which is fatal to the machine in
no-apic mode, while an interrupt storm is merely "inconvenient" in ioapic
mode, which makes debugging so much harder in no-apic mode :-(  The
combination of this information implies to me that the PCI code in the linux
kernel is *somehow* (and I don't know how because I haven't looked deep enough
to find out) fixing things up in such a way that the interrupt for the aic7xxx
card that used to go to IRQ 11 is now coming in on IRQ 10 and as a result,
things don't work.

Now, I'm all for blaming Intel BIOS bugs if they are the cause of the problem,
but I'm having a hard time seeing that here...


-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
