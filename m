Return-Path: <linux-kernel-owner+w=401wt.eu-S1422978AbWLUROL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422978AbWLUROL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422990AbWLUROL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:14:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52935 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422978AbWLUROJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:14:09 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Dan Williams <dcbw@redhat.com>
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jiri Benc <jbenc@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612211359400.30016@mercury.sdinet.de>
References: <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
	 <20061220150009.1d697f15@griffin.suse.cz>
	 <1166638371.2798.26.camel@localhost.localdomain>
	 <20061221011526.GB32625@srcf.ucam.org>
	 <1166670411.23168.13.camel@localhost.localdomain>
	 <20061221031418.GA1277@srcf.ucam.org>
	 <1166671967.23168.40.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612211359400.30016@mercury.sdinet.de>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 12:16:06 -0500
Message-Id: <1166721367.3067.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 14:19 +0100, Sven-Haegar Koch wrote:
> On Wed, 20 Dec 2006, Dan Williams wrote:
> 
> >> If we define interface down as meaning that the device is powered down
> >> and the radio switched off, then (b) and (c) would presumably just need
> >> to ensure that the interface is downed. (a) is a slightly more special
> >> case - if the switch disables the radio, I guess we then want the driver
> >> to down the interface as well.
> >
> > Correct.
> >
> >> In the (a) case, drivers should presumably refuse to bring the interface
> >> up if the radio is disabled?
> >
> > Right; the driver simply can't do anything about it, because the switch
> > is hardwired to the card and either the card's firmware takes care of
> > it, or the chipset takes care of it.  The driver has no say whatsoever
> > in the state of the card's radio for this case.  I tend to think this
> > case is on it's way out in the same way that fullmac cards are falling
> > out of favor (ie, do everything in software and save $$$), but they are
> > around and we need to support them.
> >
> > In this case, down really does mean down too.  The driver cannot honor
> > requests to set SSID, frequency, etc, because it's simply not possible
> > at that time.
> 
> What do you mean with this exactly?
> Should the user not be able to set these values, or should the driver not 
> be able to activate them?
> 
> I think it is correct when the driver does not activate them, but I think 
> the user should be able to configure them, have them stored inside 
> cfg80211/the driver, and have them activated/used when uping the 
> interface, or when the rfkill switch has been deactivated. Otherwise it 
> will get impossible to boot with rfkill disabled, toggle the switch later 
> on and have everything working.

This would be an optimization.  You could possibly _set_ values, but
obviously an 'associate' command would fail, and so it should.  But
there's really not that much of a point to doing this, because cfg80211
should support "packaging" up all the config for a particular
association request into one call, and then just blasting that to the
card.  Ideally configuration wouldn't be pushed to the card piecemeal.
As WEXT stands right now, setting the SSID on the card is essentially
the "associate" command, which obviously wouldn't work when the card is
down.  cfg80211 can fix that, you're right.

> And another side to this:
> if a disabled rfkill switch downs the interface (opposed to just 
> disabling it but staying "ifconfig up") - what happens to the ip config 
> of this interface? What reconfigures the needed routes when a re-enabled 
> rfkill switch reactivates the interface? Will manual route add and 
> ifconfig statements be impossible and we'll get forced to use some crappy 
> distri-scripts and daemons for it?

For anything other than unencrypted and WEP-only networks, you already
need a userspace program to configure your wireless card.  Dynamic WEP,
LEAP, WPA, WPA2, 802.1x all require much, much more handshake and
validation that should _ever_ be in a driver.  You should _never_, ever
be configuring your wireless card with module parameters.  I'm sure
something like iwconfig would be fine to configure your card with.

When the card goes down, it normally looses it's association to the
access point anyway, and you need to start the assocaition and
authentication over completely.  At that point, it's no longer
guaranteed that you could ever get a previous IP address back.

What does downing an ethernet device do?  It clears out routes
associated with that device, and clears assigned addresses (I think?).
Wireless is and should not be any different here.  When you bring the
device back up, you need to go through some amount of renegotiation
anyway.

> And third point just coming to my mind:
> how is changing the mac address of the card supposed to work? Chaning it 
> through ifconfig only works when the interface is downed, so the newly 
> wanted mac address has to be saved somewhere before the interface is 
> reenabled and reinitialized on the next "ifconfig up".
> (And I think it is an absolute requirement that NO packet with the 
> old/default mac address may be sent into the air whatsoever)

That's how it should work.  If you want to change the MAC address, the
card shouldn't probably be down.

Dan

