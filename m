Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263214AbSJCJOU>; Thu, 3 Oct 2002 05:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJCJOU>; Thu, 3 Oct 2002 05:14:20 -0400
Received: from gate.perex.cz ([194.212.165.105]:52493 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S263214AbSJCJOS>;
	Thu, 3 Oct 2002 05:14:18 -0400
Date: Thu, 3 Oct 2002 11:19:05 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: "Jens.Toerring@physik.fu-berlin.de" 
	<Jens.Toerring@physik.fu-berlin.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: possible bug in 2.5.39 ISA PnP patch
In-Reply-To: <15772.1423.291413.372141@kim.it.uu.se>
Message-ID: <Pine.LNX.4.33.0210031111360.521-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Mikael Pettersson wrote:

> On 2002-09-27 11:16:04, Jaroslav Kysela wrote:
> >	the read port (RDP) of ISA PnP cards must be set only when card is 
> >in the isolation phase. Bellow is a patch to follow the ISA PnP 
> >specification. Please, apply.
> >...
> >diff -Nru a/drivers/pnp/isapnp.c b/drivers/pnp/isapnp.c
> >--- a/drivers/pnp/isapnp.c	Fri Sep 27 13:13:51 2002
> >+++ b/drivers/pnp/isapnp.c	Fri Sep 27 13:13:51 2002
> >@@ -1048,11 +1048,19 @@
> > 	isapnp_wait();
> > 	isapnp_key();
> > 	isapnp_wake(csn);
> >-#if 1	/* to avoid malfunction when the isapnptools package is used */
> >-	isapnp_set_rdp();
> >-	udelay(1000);	/* delay 1000us */
> >-	write_address(0x01);
> >-	udelay(1000);	/* delay 1000us */
> >+#if 1
> >+	/* to avoid malfunction when the isapnptools package is used */
> >+	/* we must set RDP to our value again */
> >+	/* it is possible to set RDP only in the isolation phase */ 
> >+	/*   Jens Thoms Toerring <Jens.Toerring@physik.fu-berlin.de> */
> >+	isapnp_write_byte(0x02, 0x04);	/* clear CSN of card */
> >+	mdelay(2);			/* is this necessary? */
> >+	isapnp_wake(csn);		/* bring card into sleep state */
> >+	isapnp_wake(0);			/* bring card into isolation state */
> >+	isapnp_set_rdp();		/* reset the RDP port */
> >+	udelay(1000);			/* delay 1000us */
> >+	isapnp_write_byte(0x06, csn);	/* reset CSN to previous value */
> >+	udelay(250);			/* is this necessary? */
> > #endif
> > 	if (logdev >= 0)
> > 		isapnp_device(logdev);
> 
> Linus included this patch in 2.5.39. Unfortunately, it causes
> my ISA PnP cards to malfunction:
> - My 3c509(b?) combo TP/BNC Ethernet card stops working completely.
>   The kernel thinks the NIC is up, but the leds on its segment aren't
>   lit and no traffic can be generated.
>   Backing out this patch, or disabling ISAPNP, makes it work again.
> - My ESS sound card is a multi-function device. With this patch, some
>   sub-devices get bogus resources listed in /proc/isapnp, as if the
>   data is all-bits-one. Backing out this patch solves the problem.
> 
> I have several other ISA PnP card at another location, but I won't be
> able to test them until Saturday.
> 
> I can't comment on whether the new code in the patch correctly implements
> the specification or not, but something's definitely wrong here. Do you
> have any evidence of cards that malfunctioned with the old code?
> 
> Also, the comment "to avoid malfunction when the isapnptools package is used"
> strikes me a bit strange. Why use isapnptools if the kernel has ISAPNP=y ?
> Is that actually supposed to work?

Thanks for this report. Indeed, the code should be removed, if it causes 
trouble. I recommend to comment the whole code trying to reset the RDP:

===== isapnp.c 1.14 vs edited =====
--- 1.14/drivers/pnp/isapnp.c   Mon Sep 30 03:19:31 2002
+++ edited/isapnp.c     Thu Oct  3 11:15:46 2002
@@ -1048,7 +1048,7 @@
        isapnp_wait();
        isapnp_key();
        isapnp_wake(csn);
-#if 1
+#if 0
        /* to avoid malfunction when the isapnptools package is used */
        /* we must set RDP to our value again */
        /* it is possible to set RDP only in the isolation phase */


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

