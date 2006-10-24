Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWJXRTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWJXRTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 13:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWJXRTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 13:19:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:18341 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965172AbWJXRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 13:19:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=mw+6Rx+1qxcnA7TA0T6lvnfP/Gf0rSnXJDsGK8s2NBSpg1eW6EtZIksGxDAvzkwAn+MpGk/V/7G+SPx7WiyZqBfoavFG4oJB7PTb5RHhaQP+6j57ayEOdZAWgI/DF4hLnYxEvMnbRp4a4Vd6AOsNgaOxnGqkJLB6MUZur9EXXdQ=
Subject: Re: Battery class driver.
From: Richard Hughes <hughsient@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>
In-Reply-To: <1161636514.27622.30.camel@shinybook.infradead.org>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 24 Oct 2006 18:18:48 +0100
Message-Id: <1161710328.17816.10.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 21:48 +0100, David Woodhouse wrote:
> On Mon, 2006-10-23 at 20:58 +0100, Richard Hughes wrote:
> > No, I think the distinction between batteries and ac_adapter is large
> > enough to have different classes of devices. You may have many
> > batteries, but you'll only ever have one ac_adapter. I'm not sure it's
> > an obvious abstraction to make.
> 
> ∃ machines with more than one individual AC adapter. Which want
> individual notification when one of them goes down.
> 
> You're right that they don't necessarily fit into the 'battery' class,
> but I'm not entirely sure if it's worth putting them elsewhere, because
> the information about them is usually available in the same place as the
> information about the batteries, at least in the laptop case.

Sure, makes sense I guess.

> The simple case of AC adapters, where we have only 'present' or
> 'absent', is a subset of what batteries can do. If you have more
> complicated monitoring, then it's _also_ going to bear a remarkable
> similarity to what you get from batteries -- you'll be able to monitor
> temperatures, voltage, current, etc. So they're not _that_ much out of
> place in a 'power supply' class.

Sure, psu could be a nice class. We would need buy-in from ACPI, APM and
PMU maintainers to avoid just creating *another* standard that HAL has
to read.

> It makes _less_ sense, imho, to have 'ac present' as a property of a
> battery -- which is what I've done for now.

Agree.

> > How are battery change notifications delivered to userspace? I know acpi
> > is using the input layer for buttons in the future (very sane IMO), so
> > using sysfs events for each property changing would probably be nice.
> 
> For selected properties, yes. I wouldn't want it happening every time
> the current draw changes by a millivolt but for 'battery removed' or 'ac
> power applied' events it makes some sense.

Maybe still send events for large changes, like > whole % changes in
value. Then HAL hasn't got to poll at all.

> For sane hardware where we get an interrupt on such changes, that's fine
> -- but I'm wary of having to implement that by making the kernel poll
> for them; especially if/when there's nothing in userspace which cares. 

HAL and gnome-power-manager? There should only be a few changing values
on charging and discharging, and one every percentage point change isn't
a lot.

> > Comments on your patch:
> > 
> > > +#define BAT_INFO_TEMP2		(2) /* °C/1000 */
> > Temperature expressed in degrees C/1000? - what if the temperature goes
> > below 0? 
> 
> It's signed.

Sure, n/p.

> > What about just using mK (kelvin / 1000) - I don't know what is
> > used in the kernel elsewhere tho. Also, are you allowed the ° sign in
> > kernel source now?
> 
> Welcome to the 21st century.

Fair play. :-)

> > > +#define BAT_INFO_CURRENT	(6) /* mA */
> > Can't this also be expressed in mW according to the ACPI spec?
> 
> No, it can't. The Watt is not a unit of current.

Ahh, current as in electron flow, rather than current power use,
apologies.

> I intended the ACPI 'present rate' to map to the 'charge_rate' property,
> which is why we have the 'charge_unit' property. I don't like that much,
> but it seems necessary unless we're going to do something like separate
> 'charge_rate_mA' and 'charge_rate_mW' properties.

Not sure how to best do this for the kernel - maybe just expose the
value and the format separately. In HAL we normalise the rate to mWh
anyway using the rate in mAh and reported voltage.

> Actually, I suspect that on reflection I would prefer that latter
> option. DavidZ?
> 
> > > +#define BAT_STAT_FIRE		(1<<7)
> > I know there is precedent for "FIRE" but maybe CRITICAL or DANGER might
> > be better chosen words. We can reserve the word FIRE for when the faulty
> > battery really is going to explode...
> 
> Yes, feasibly. I don't quite know what the 'destroy' bit in the OLPC
> embedded controller is supposed to mean, and 'FIRE' seemed as good as
> anything else.

Then maybe just set present to false as a destroyed battery isn't much
use anyway...

Richard.


