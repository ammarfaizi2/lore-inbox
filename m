Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWGEWE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWGEWE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 18:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWGEWE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 18:04:28 -0400
Received: from colin.muc.de ([193.149.48.1]:14088 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S964926AbWGEWE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 18:04:27 -0400
Date: 6 Jul 2006 00:04:25 +0200
Date: Thu, 6 Jul 2006 00:04:25 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
Message-ID: <20060705220425.GB83806@muc.de>
References: <20060701150430.GA38488@muc.de> <20060703172633.50366.qmail@web50109.mail.yahoo.com> <20060703184836.GA46236@muc.de> <1151962114.16528.18.camel@localhost.localdomain> <20060704092358.GA13805@muc.de> <1152007787.28597.20.camel@localhost.localdomain> <20060704113441.GA26023@muc.de> <1152137302.6533.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152137302.6533.28.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 11:08:21PM +0100, Alan Cox wrote:
> Ar Maw, 2006-07-04 am 13:34 +0200, ysgrifennodd Andi Kleen:
> > > > Giving a consistent sysfs interface is a bit harder, but I suppose one 
> > > > could change the code to provide pseudo banks for enable/disable too.
> > > > However that would be system specific again, so a default "all on/all off" 
> > > > policy might be quite ok.
> > > 
> > > I think we need the basic consistent sysfs case. Whether that is
> > 
> > What should i do?

s/i/it/ of course.

Basically what I asked for is what you think that sysfs interface
should do.

You want a single error / no error knob? 

The problem is that anything more detailed requires knowledge of the
specific hardware.

The single knob on standard MCE would be 

for i in /sys/devices/system/machinecheck/*/bank*
	echo 0 > $i
done

(or 0xfffffffffffffffff to turn everything on) 

What else?


What we identified as missing is a unified way for all hardware
to report how many errors and on which DIMMs. I think I can easily
add that to mcelog (it would already report it, but in a CPU
specific format) 

> 
> Well personally I would favour the MCE logging stuff staying in because
> its clearly small, compact and enough for many users, and the EDAC stuff
> hooking that feed somehow so that people who want the detail and the

As far as I can figure out there is no more detail offered by it at least
for K8.  All the information that is given by the Northbridge is in the MCE
and the rest for the DIMM topology is in SMBIOS (or could be read from user 
space if really needed) 

I went through a similar development myself BTW. When I wrote
the first Opteron machine check handler for 2.4 I also coded
access to the PCI device and read the registers there.
But later i realized that it's useless because the CPU shadows
all these registers into the regular machine check MSRs. So you
can just get it with a portable handler from there. When I redid
the handler i threw it all out.

Now you seem to want to add it in again ... 

Regarding non K8 x86-64 it would need more research, but I hop
they also dump everything into the MSRs.

> 
> As to filtering and control of the banks - that can always be done by
> filtering what is handed down from the MCE code if I understand it right
> so can be left in the EDAC side.

I think that should be done in user space.

-Andi
