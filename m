Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWJWT6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWJWT6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWJWT6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:58:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:16345 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030185AbWJWT6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:58:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=nMyZt3oknoLf/dUkCYGVvnPp+cYoBoUSDSfxVjGGfs011vJfARZ26mpy5iHN+U2BCALUCV0BcdutCnY8AuCKRrjvBBPky37n650hUE8DjaxB+uvHFmrDemk+neWp31Htm+tGDtPbHMBka0bwVeNNxMZf2QsHJVq5woXpceJYaTY=
Subject: Re: Battery class driver.
From: Richard Hughes <hughsient@gmail.com>
To: Dan Williams <dcbw@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>
In-Reply-To: <1161631091.16366.0.camel@localhost.localdomain>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Mon, 23 Oct 2006 20:58:29 +0100
Message-Id: <1161633509.4994.16.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 15:18 -0400, Dan Williams wrote:
> Adding Richard Hughes and David Zeuthen, since they will actually have
> to talk to your batter class and driver.

Cool, thanks.

> On Mon, 2006-10-23 at 19:32 +0100, David Woodhouse wrote:
> > At git://git.infradead.org/battery-2.6.git there is an initial
> > implementation of a battery class, along with a driver which makes use
> > of it. The patch is below, and also viewable at 
> > http://git.infradead.org/?p=battery-2.6.git;a=commitdiff;h=master;hp=linus
> > 
> > I don't like the sysfs interaction much -- is it really necessary for me
> > to provide a separate function for each attribute, rather than a single
> > function which handles them all and is given the individual attribute as
> > an argument? That seems strange and bloated.
> > 
> > I'm half tempted to ditch the sysfs attributes and just use a single
> > seq_file, in fact.

I can't comment on the kernel implementation side of it much, but see
below.

> > The idea is that all batteries should be presented to userspace through
> > this class instead of through the existing mess of PMU/APM/ACPI and even
> > APM _emulation_.

Ohh yes. This would make the battery code in HAL so much better. There
is so much legacy crud for batteries that we have to wade through in
HAL. A battery kernel class is a very good idea IMO.

> > I think I probably want to make AC power a separate 'device' too, rather
> > than an attribute of any given battery. And when there are multiple
> > power supplies, there should be multiple such devices. So maybe it
> > should be a 'power supply' class, not a battery class at all?

No, I think the distinction between batteries and ac_adapter is large
enough to have different classes of devices. You may have many
batteries, but you'll only ever have one ac_adapter. I'm not sure it's
an obvious abstraction to make.

> > Comments? 

How are battery change notifications delivered to userspace? I know acpi
is using the input layer for buttons in the future (very sane IMO), so
using sysfs events for each property changing would probably be nice.

Comments on your patch:

> +#define BAT_INFO_TEMP2		(2) /* °C/1000 */
Temperature expressed in degrees C/1000? - what if the temperature goes
below 0? What about just using mK (kelvin / 1000) - I don't know what is
used in the kernel elsewhere tho. Also, are you allowed the ° sign in
kernel source now?

> +#define BAT_INFO_CURRENT	(6) /* mA */
Can't this also be expressed in mW according to the ACPI spec?

> +#define BAT_STAT_FIRE		(1<<7)
I know there is precedent for "FIRE" but maybe CRITICAL or DANGER might
be better chosen words. We can reserve the word FIRE for when the faulty
battery really is going to explode...

Richard.

> > commit 42fe507a262b2a2879ca62740c5312778ae78627
> > Author: David Woodhouse <dwmw2@infradead.org>
> > Date:   Mon Oct 23 18:14:54 2006 +0100
> > 
> >     [BATTERY] Add support for OLPC battery
> >     
> >     Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> > 
> > commit 6cbec3b84e3ce737b4217788841ea10a28a5e340
> > Author: David Woodhouse <dwmw2@infradead.org>
> > Date:   Mon Oct 23 18:14:14 2006 +0100
> > 
> >     [BATTERY] Add initial implementation of battery class
> >     
> >     I really don't like the sysfs interaction, and I don't much like the
> >     internal interaction with the battery drivers either. In fact, there
> >     isn't much I _do_ like, but it's good enough as a straw man.
> >     
> >     Signed-off-by: David Woodhouse <dwmw2@infradead.org>


