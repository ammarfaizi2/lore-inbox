Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWJWUse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWJWUse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWJWUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:48:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58806 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751382AbWJWUsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:48:33 -0400
Subject: Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Richard Hughes <hughsient@gmail.com>
Cc: Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>
In-Reply-To: <1161633509.4994.16.camel@hughsie-laptop>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Oct 2006 21:48:33 +0100
Message-Id: <1161636514.27622.30.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 20:58 +0100, Richard Hughes wrote:
> No, I think the distinction between batteries and ac_adapter is large
> enough to have different classes of devices. You may have many
> batteries, but you'll only ever have one ac_adapter. I'm not sure it's
> an obvious abstraction to make.

∃ machines with more than one individual AC adapter. Which want
individual notification when one of them goes down.

You're right that they don't necessarily fit into the 'battery' class,
but I'm not entirely sure if it's worth putting them elsewhere, because
the information about them is usually available in the same place as the
information about the batteries, at least in the laptop case.

The simple case of AC adapters, where we have only 'present' or
'absent', is a subset of what batteries can do. If you have more
complicated monitoring, then it's _also_ going to bear a remarkable
similarity to what you get from batteries -- you'll be able to monitor
temperatures, voltage, current, etc. So they're not _that_ much out of
place in a 'power supply' class.

It makes _less_ sense, imho, to have 'ac present' as a property of a
battery -- which is what I've done for now.

> How are battery change notifications delivered to userspace? I know acpi
> is using the input layer for buttons in the future (very sane IMO), so
> using sysfs events for each property changing would probably be nice.

For selected properties, yes. I wouldn't want it happening every time
the current draw changes by a millivolt but for 'battery removed' or 'ac
power applied' events it makes some sense.

For sane hardware where we get an interrupt on such changes, that's fine
-- but I'm wary of having to implement that by making the kernel poll
for them; especially if/when there's nothing in userspace which cares. 

> Comments on your patch:
> 
> > +#define BAT_INFO_TEMP2		(2) /* °C/1000 */
> Temperature expressed in degrees C/1000? - what if the temperature goes
> below 0? 

It's signed.

> What about just using mK (kelvin / 1000) - I don't know what is
> used in the kernel elsewhere tho. Also, are you allowed the ° sign in
> kernel source now?

Welcome to the 21st century.

> > +#define BAT_INFO_CURRENT	(6) /* mA */
> Can't this also be expressed in mW according to the ACPI spec?

No, it can't. The Watt is not a unit of current.

I intended the ACPI 'present rate' to map to the 'charge_rate' property,
which is why we have the 'charge_unit' property. I don't like that much,
but it seems necessary unless we're going to do something like separate
'charge_rate_mA' and 'charge_rate_mW' properties.

Actually, I suspect that on reflection I would prefer that latter
option. DavidZ?

> > +#define BAT_STAT_FIRE		(1<<7)
> I know there is precedent for "FIRE" but maybe CRITICAL or DANGER might
> be better chosen words. We can reserve the word FIRE for when the faulty
> battery really is going to explode...

Yes, feasibly. I don't quite know what the 'destroy' bit in the OLPC
embedded controller is supposed to mean, and 'FIRE' seemed as good as
anything else.

-- 
dwmw2

