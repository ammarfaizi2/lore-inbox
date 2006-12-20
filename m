Return-Path: <linux-kernel-owner+w=401wt.eu-S1160994AbWLTWtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160994AbWLTWtR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWLTWtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:49:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46335 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030411AbWLTWtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:49:15 -0500
Date: Wed, 20 Dec 2006 14:49:06 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
Message-ID: <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
In-Reply-To: <1166629900.3365.1428.camel@laptopd505.fenrus.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	<200612191959.43019.david-b@pacbell.net>
	<20061220042648.GA19814@srcf.ucam.org>
	<200612192114.49920.david-b@pacbell.net>
	<20061220053417.GA29877@suse.de>
	<20061220055209.GA20483@srcf.ucam.org>
	<1166601025.3365.1345.camel@laptopd505.fenrus.org>
	<20061220125314.GA24188@srcf.ucam.org>
	<1166621931.3365.1384.camel@laptopd505.fenrus.org>
	<20061220143134.GA25462@srcf.ucam.org>
	<1166629900.3365.1428.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 16:51:39 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

> 
> > Yeah, I guess that's a problem. From a user perspective, the 
> > functionality is only really useful if the latency is very small. I 
> > think where possible we'd want to power down the chip while keeping the 
> > phy up, but it would be nice to know how much power that would actually 
> > cost us.
> 
> 
> I'm no expert but afaik the PHY is the power hungry part, the rest is
> peanuts. So if we can get the PHY to sleep most of the time that would
> be great.
> 

There are two different problems:

1) Behavior seems to be different depending on device driver
   author. We should document the expected semantics better.

   IMHO:
	When device is down, it should:
	 a) use as few resources as possible:
	       - not grab memory for buffers
	       - not assign IRQ unless it could get one
	       - turn off all power consumption possible
	 b) allow setting parameters like speed/duplex/autonegotiation,
            ring buffers, ... with ethtool, and remember the state
	 c) not accept data coming in, and drop packets queued

	When device is up, it should:
	 a) Start negotiation if needed
	 b) Not bring up carrier till it is ready
	 c) Allow reconfiguration

	Wake on Lan should be disabled by default, until changed.
	
2) Network device infrastructure should make it easier for devices:
    bring interface down on suspend and bring it up after resume
    (if it was running when suspended). This would allow many devices to
    have no suspend/resume hook; except those that have some better power
    control over hardware.



	
