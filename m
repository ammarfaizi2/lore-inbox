Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWJYOmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWJYOmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWJYOmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:42:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:60568 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751722AbWJYOmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:42:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aSwQsqoyycsr84FQLNSuHav4RR9fYNp743to85/k21hZVs78zX6VI0hznjkOxBwsCyhag2UTydDYquowJasor/GlymkaCRtUpV7IT0kRhRBa41x1Q75e8dysSCmX3rhypLSL9cRTxE/YnS4+zXg03Z6SBECojDQVJAqm9wJALQk=
Message-ID: <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
Date: Wed, 25 Oct 2006 16:42:35 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: "Richard Hughes" <hughsient@gmail.com>, "Dan Williams" <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       "David Zeuthen" <davidz@redhat.com>,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <1161778296.27622.85.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/06, David Woodhouse <dwmw2@infradead.org> wrote:
> If you can summarise the bits I've missed in the meantime that would be
> wonderfully useful

OK. Looking at the current git snapshot:

current_now is missing.

time_remainig should be split into:
  time_to_empty_now
  time_to_empty_avg
  time_to_full
or even
  time_to_empty_now
  time_to_empty_avg
  time_to_full_now
  time_to_full_avg

s/charge_count/cycle_count/, that's the standard name and used by the SBS spec.

Why the reversed order, for example, in design_charge vs. charge_last?
Following hwmon style, I think it should be
s/design_charge/charge_design/
s/manufacture_date/date_manufactured/
s/first_use/date_first_used/
s/design_voltage/voltage_design/

s/charge_last/charge_last_full/ seems less ambiguous.

s/^charge$/charge_left/ follows SBS and seems better.

And, for the reasons I explained earlier, I strongly suggest not using
the term "charge" except when referring to the action of charging.
Hence:
s/charge_rate/rate/;  s/charge/capacity/

It would be nice to have power_{now,avg}, always in mW regardless of
the capacity units.

I take it you don't want to deal with battery control actions for now.


> > > one of the things I plan is to remove 'charge_units' and provide both
> > > 'design_charge' and 'design_energy' (also {energy,charge}_last,
> > > _*_thresh etc.) to cover the mWh vs. mAh cases.
> >
> > You can't do this conversion, since the voltage is not constant.
> > Typically the voltage drops when the charge goes down, so you'll be
> > grossly overestimating the available energy it. And the effect varies
> > with battery chemistry and condition.
>
> Absolutely. I don't want to do the conversion -- I want to present the
> raw data. I was just a question of whether I provide 'capacity' and
> 'units' properties, or whether I provide 'capacity_mWh' and
> 'capacity_mAh' properties (only one of which, presumably, would be
> available for any given battery). Likewise for the rates, thresholds,
> etc.

I think using one set of files and units string makes more sense, for
several reasons:
Reduces the number of attributes and kernel code duplication.
Can handle weird power sources that use other units.
Simpler userspace code. One can do
$ cd /sys/foo; echo `cat capacity_left` out of `cat capacity_last`
`cat capaity_units` left.
instead of checking multiple sets of files for valid values.

The great majority of apps don't care about the physical values, but
just need something that they can parse as a relative quantity and
something to show the user. The generic units scheme provides both. We
have current_*, voltage etc. for those that do care, but there's no
need to duplicate the whole set of _thresholds, _last_full, _design
etc.

  Shem
