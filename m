Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752014AbWISCKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbWISCKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 22:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWISCKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 22:10:04 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:59303 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752014AbWISCKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 22:10:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=C77i4drY8aCG5n6D8Ki0IvYp4iy+JNciQXu8g8xYyamie4dlO6Az1swaNENgr85gpYr3xG7mnYwBA7RQGLrHrLWGcu6zbKHrnAhFBbNcJ17AZsMh7frtEWezKAsJaHkWhTKT6Vi1NgyeN75P90GGcZ4vXeP1cDNgLrs4TuqA2+A=  ;
From: David Brownell <david-b@pacbell.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jan De Luyck <ml_linuxkernel_20060528@kcore.org>
Subject: Re: 2.6.18-rc6-mm2 (-mm1): ohci_hcd sometimes does not initialize properly on x86_64
Date: Mon, 18 Sep 2006 17:04:41 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <200609160013.16014.rjw@sisk.pl>
In-Reply-To: <200609160013.16014.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609181704.42063.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 September 2006 3:13 pm, Rafael J. Wysocki wrote:
> Hi,
> 
> It looks like the ohci_hcd driver sometimes has problems with the
> initialization (eg. USB mouse doesn't work after a fresh boot and reloading
> of the driver helps).
> 
> I have observed this on two different x86_64 boxes (HPC 6325, Asus L5D),
> but it is not readily reproducible.  Anyway I've got a dmesg output from a
> failing case which is attached.

Where I've seen such issues in the past has been with one specific
device:  a UPS that seems unhappy if it doesn't get a VBUS power cycle,
so that OHCI implementations that don't implement power switching are
bad choices for connecting that particular UPS.

I believe that's not the issue in your case.  I compared the boot
sequence you sent with one for the NF3-150 I use a lot (also x86_64)
which does not exhibit this failure, and the differences I noticed
were:

 - NOCP set in roothub.a ... your BIOS reports no overcurrent protection
 - different 2.6.18 prepatches ... you used rc6-mm2, not rc7
 - different irqs (you used PIC not IOAPIC)
 - driver registration sequence different ... I registered EHCI first
 - yours came _up_ with RHSC irq pending on one root (device present)

And re those last two, it didn't finish mouse enumeration with OHCI before
starting to  do it with EHCI.  I could easily see how that would lead to
timing-dependent/intermittent failures.

Now, registering EHCI first is not "supposed" to matter, but I'm thinking
it started to matter a while back, since a few folk have reported as much.

One suspicion being that some of the hub driver changes have had some bad
consequences.  (My suspicions there were highlighted by noticing some of
the misbehavior associated with an embedded USB controller I was testing,
which provoked failures in those same code paths...)  The root hub handoff
relies on the usb/core/hub.c code to do the right things, notably treating
disconnect-during-reset (handoff to companion) as routine, but I think I
noticed that fault handling logic has changed.

At any rate, that suggests a few experiments to me.

 -  First, does this still show up with the stock RC7 code?  There are
    a bunch of IMO rather experimental USB patches in the MM tree...
    including several affecting usbcore hub support.

 -  Second does it appear without EHCI loaded?  If not, that would
    tend to confirm an issue usbcore hub driver handoff logic.

 -  Third, does it appear if EHCI is loaded _first_ (as the distro
    should already have been doing just to avoid thrashing during
    system startup)?  Similar comment re previous experiment, though
    it'd provide a potential workaround.

I'd kind of suspect that the generic RC7 code, with EHCI loaded first
as it should be, would "just work".

- Dave



