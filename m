Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277549AbRJESt5>; Fri, 5 Oct 2001 14:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277548AbRJESts>; Fri, 5 Oct 2001 14:49:48 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4598 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277544AbRJESth>; Fri, 5 Oct 2001 14:49:37 -0400
Date: Fri, 5 Oct 2001 12:48:24 -0600
From: Andreas Dilger <adilger@turbolabs.com>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: mingo@elte.hu, jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011005124824.F315@turbolinux.com>
Mail-Followup-To: Robert Olsson <Robert.Olsson@data.slu.se>, mingo@elte.hu,
	jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.GSO.4.30.0110031138150.4833-100000@shell.cyberus.ca> <Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain> <15291.32311.499838.886628@robur.slu.se> <20011003162210.L8954@turbolinux.com> <15293.51488.280808.469262@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15293.51488.280808.469262@robur.slu.se>
User-Agent: Mutt/1.3.22i
"X-GPG-Key: 1024D/0D35BED6"
"X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 05, 2001  16:52 +0200, Robert Olsson wrote:
>  > If you get to the stage where you are turning off IRQs and going to a
>  > polling mode, then don't turn IRQs back on until you have a poll (or
>  > two or whatever) that there is no work to be done.  This will at worst
>  > give you 50% polling success, but in practise you wouldn't start polling
>  > until there is lots of work to be done, so the real success rate will
>  > be much higher.
>  > 
>  > At this point (no work to be done when polling) there are clearly no
>  > interrupts would be generated (because no packets have arrived), so it
>  > should be reasonable to turn interrupts back on and stop polling (assuming
>  > non-broken hardware).  You now go back to interrupt-driven work until
>  > the rate increases again.  This means you limit IRQ rates when needed,
>  > but only do one or two excess polls before going back to IRQ-driven work.
> 
>  Yes this has been considered and actually I think Jamal did this in one of
>  the pre NAPI patch. I tried something similar... but instead of using a
>  number of excess polls I was doing excess polls for a short time (a
>  jiffie). This was the showstopper mentioned the previous mails. :-) 

(Note that I hadn't read the NAPI paper until after I posted the above, and
it appears that I was describing pretty much what NAPI already does ;-).  In
light of that, I wholly agree that NAPI is a superior solution for handling
IRQ overload from a network device.

>  Anyway it up to driver to decide this policy. If the driver returns 
>  "not_done" it is simply polled again. So low-rate network drivers can have 
>  a different policy compared to an OC-48 driver. Even continues polling is
>  therefore possible and even showstoppers. :-)  There are protection for
>  polling livelocks.

One question which I have is why would you ever want to continue polling
if there is no work to be done?  Is it a tradeoff between the amount of
time to handle an IRQ vs. the time to do a poll?  An assumption that if
there was previous network traffic there is likely to be more the next
time the interface is checked (assuming you have other work to do between
the time you last polled the device and the next poll)?

Is enabling/disabling of the RX interrupts on the network card an issue
in the sense of "you need to wait X us after writing to this register
for it to take effect" or other issue which makes it preferrable to have
some "hysteresis" between changing state from IRQ-driven to polling?

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

