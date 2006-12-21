Return-Path: <linux-kernel-owner+w=401wt.eu-S1422654AbWLUD1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWLUD1L (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWLUD1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:27:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52082 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422654AbWLUD1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:27:09 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Dan Williams <dcbw@redhat.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Michael Wu <flamingice@sourmilk.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <4589FAA6.509@gentoo.org>
References: <20061220042648.GA19814@srcf.ucam.org>
	 <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
	 <20061221011209.GA32625@srcf.ucam.org>
	 <200612202105.31093.flamingice@sourmilk.net>
	 <20061221021832.GA723@srcf.ucam.org> <4589F39C.7010201@gentoo.org>
	 <20061221024533.GA1025@srcf.ucam.org>  <4589FAA6.509@gentoo.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 22:29:09 -0500
Message-Id: <1166671750.23168.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 22:08 -0500, Daniel Drake wrote:
> Matthew Garrett wrote:
> >> There are additional implementation problems: scanning requires 2 
> >> different ioctl calls: siwscan, then several giwscan. If you want the 
> >> driver to effectively temporarily bring the interface up when userspace 
> >> requests a scan but the interface was down, then how does the driver 
> >> know when to bring it down again?
> > 
> > Hm. Does the spec not set any upper bound on how long it might take for 
> > APs to respond? I'm afraid that my 802.11 knowledge is pretty slim. 
> 
> I'm not sure, but thats not entirely relevant either.  The time it takes 
> for the AP to respond is not related to the delay between userspace 
> sending the siwscan and giwscan ioctls (unless you're thinking of 
> userspace being too quick, but GIWSCAN already returns -EINPROGRESS when 
> appropriate so this is detectable)

Channel dwell time for a passive scan is usually around 100ms - 250ms,
depending on how accurate you want your scan results (== wait longer),
and how much power you want to save (== don't wait long).

Correct userspace apps should:

1) Set a timer for, say, 8 seconds
2) Issue an SIWSCAN command
3) Wait for the GIWSCAN netlink event from the card, get results via
GIWSCAN command when it comes; cancel the timer from (2)
4) If the timer fires because no GIWSCAN event was received, try to get
scan results via GIWSCAN command from the driver anyway

<rant>
Note that NDIS requires a driver to return _something_ within 2 seconds
of a scan request.  Even if you're an 802.11a card (madwifi *cough*, I'm
starting a new thing where I cough after...).  So it's certainly
possible to return scan results in a timely manner, since the Windows
drivers for these cards are obviously doing it just fine.

Drivers should buffer scan results from past scans, age them
appropriately, and purge them when they get too old.  Drivers should
never, ever, clear the scan result list when SIWSCAN or GIWSCAN is
called, because that means there's a window when a scan result request
from some other app could illegitimately return no BSSID records.
</rant>

> > Picking a number out of thin air would be one answer, but clearly less 
> > than ideal. This may be a case of us not being able to satisfy everyone, 
> > and so just having to force the user to choose between low power or 
> > wireless scanning.
> 
> I think it's reasonable to keep the interface down, but then when the 
> user does want to connect, bring the interface up, scan, present scan 
> results. Scanning is quick, there would be minimal wait needed here.

Unless you're madwifi *cough* and then you may have to wait up to _14_
seconds for a full scan of all a/bg channels.  That's just insane.  I
have no idea why that's the case (or at least was up to earlier this
year) but it's just unacceptable.

> Alternatively, if you do want to prepare scan results in the background 
> every 2 minutes, use a sequence something like:
> 
> - bring interface up
> - siwscan
> - giwscan [...]
> - bring interface down
> - repeat after 2 mins
> 
> If this kind of thing was implemented at the driver level, in most cases 
> it would be identical to doing the above anyway.

Right.  It should 100% be in userspace and not in the drivers.  Who says
2 minutes is the right interval?  Putting that stuff, and the get/set
commands for changing that interval, in the driver is just plain wrong.

Dan

> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

