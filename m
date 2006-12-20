Return-Path: <linux-kernel-owner+w=401wt.eu-S965093AbWLTObu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWLTObu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWLTObu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:31:50 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:53639 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965091AbWLTObt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:31:49 -0500
Date: Wed, 20 Dec 2006 14:31:35 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20061220143134.GA25462@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <1166621931.3365.1384.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166621931.3365.1384.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Network drivers that don't suspend on interface down
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 02:38:51PM +0100, Arjan van de Ven wrote:
> about your driver list;
> do you have an idea of what the top 5 relevant ones would be?
> I'd be surprised if the top 5 together had less than 95% market share,
> so if we fix those we'd be mostly done already.

In terms of what I've seen on vaguely modern hardware, I'd guess at 
e1000 and sky2 as the top ones. b44 is still common in cheaper hardware, 
with via-rhine appearing at the very low end. I'll try to grep through 
our hardware database results to get a stronger idea about percentages.

> > The situation is more complicated for wireless. Userspace expects to be 
> > able to get scan results from the card even if the interface is down.
> 
> if it's down userspace cannot currently expect this (if it does it's
> broken), just as it currently can't expect link notifications when the
> interface is down. It needs to have the interface up for this. 
> (but point taken for a 3rd state)

The documentation for what userspace can legitimately expect of the 
kernel is distinctly lacking, and as far as I can tell most of the 
common drivers support scanning while the interface is down. It would be 
immensely helpful if we could have a better idea of which kernel 
behaviour is deliberate, and which bits of kernel functionality are 
accidental and might go away at any time. Right now, I have various 
scripts depending on this behaviour because there's absolutely no 
indication that I'm not supposed to be.

(Of course, I may have missed it somewhere - I've never been able to 
find terribly comprehensive documentation on WE)

> so what do you want from this 3rd state? rough guess based on what I
> think the desktop wants (so please correct/append)

Just to be clear: in this world view, "down" maps to "fully powered 
down", so this third state is a "low power consumption mode"? If so:

> In the third state you 
> * don't expect to get or send "regular" packets
> * don't have a dhcp lease or anything like that
> * you do expect to get link change notification [1]
> * you do expect to be able to scan for access points [2]

Yes, I think that's a fair summary. 

> open questions
> * what if you get a WOL event?

In an ideal world, I think the information would be passed to userspace 
and it would get to make the distinction. I appreciate that the hardware 
may have different ideas about what's appropriate...

> [1] What kind of latency would be allowed? Would an implementation be
> allowed to power up the phy say once per minute or once per 5 minutes to
> see if there is link? The implementation could do this progressively;
> first poll every X seconds, then after an hour, every minute etc.

Yeah, I guess that's a problem. From a user perspective, the 
functionality is only really useful if the latency is very small. I 
think where possible we'd want to power down the chip while keeping the 
phy up, but it would be nice to know how much power that would actually 
cost us.

(We have a similar issue when it comes to stuff like monitor hotplug - 
it's the sort of thing that many users are willing to accept losing some 
battery for, and there probably isn't a single right answer)
 
> [2] would it be permissible to temporarily power up the device on scan?
> Eg how frequently does the desktop expect to poll for scanning, and what
> kind of latency would be tolerable?

network-manager's behaviour when the interface is inactive is to scan 
every 2 minutes. I don't think latency is too much of an issue.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
