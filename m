Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVDJTvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVDJTvp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 15:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVDJTvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 15:51:44 -0400
Received: from mail.linux-mips.org ([62.254.210.162]:58861 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S261593AbVDJTvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 15:51:22 -0400
Date: Sun, 10 Apr 2005 20:51:20 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: James Chapman <jchapman@katalix.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ds1337 4/4
Message-ID: <20050410195120.GA5422@linux-mips.org>
References: <20050407231904.GE27226@orphique> <FxPJVIPZ.1112958526.4787880.khali@localhost> <20050408123545.GA4961@orphique> <4256C315.3000902@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4256C315.3000902@katalix.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 06:44:53PM +0100, James Chapman wrote:
> > The only reason I can think
> >about is when suspending device, so it is likely pm job. /sys entry
> >might help as well, but I do not see any point making driver more
> >complicated and bigger just to make someone else happy.
> 
> Why not add a new /sys entry for it? Is there a generic battery charge 
> control /sys API?

I do not know about any and I do not think it would be usefull here. How
would you convert value passed by API into register value? Driver has no
chance to know about hardware design.

> >Golden rule is: implement features as needed :)
> 
> But when adding code, try to cover all reasonable cases, otherwise we'll 
> see patches from people trying to add platform specific ifdefs in here.

I'd like to, but simply do not have enough informations to do it. In other
worlds I still do not know what is reasonable here.

> >>Also, arbitrarily picking one of the 6 possible charging modes just
> >>because it matches your board is a bad idea. It looks like a value which
> >>should be set on a per-board basis, rather than picked randomly by the
> >>user, so as to avoid accidental hardware breakage.
> >
> >
> >Well free to provide that way, so far I'm the only user so I did what is
> >usefull for me [*]. Everyone is welcome to change it to more generic
> >way.
> 
> I agree with Jean. You should provide an API for this. Don't take 
> shortcuts just because you were the first to support the chip. It'll be 
> more useful to others if you provide a way to set a value per platform.

That's not about taking any shortcuts, that's about finding sane API. When
time shows it wrong and it will need change people will complain about
compatibility. See my questions about API bellow [*].

Based on your and Jean's input, following so far sounds reasonable:
Create "charge" sysfs entry for ds1339 when it is detected. Do not write
any value to Trickle Charge register, until its value is written to this
entry.

> >I was running test overnight and didn't meet any single case when this
> >happen. Perhaps device also needs to see start condition?
> 
> Just because it runs overnight doesn't mean there's no bug.

Agree, but with probability near the certainty I can tell that device works
a bit differently than described in datasheet. Anyway, new 100% reliable
test is done, so it could be eventually used if ds1339 support finds its
way into driver.

> >>Also, 0x00 is a possible value for both the seconds count and the battery
> >>register, so you could miss a DS1339 at times.
> >>
> >>One possible check to start with would be on the value of the additional
> >>register itself. It has only 7 possible values. (...) 
> >
> >
> >Eh? Register is 8bit, that's 256 combinations.
> 
> Reserved bits have fixed values that you can test for.

Think about this register as about NVRAM address. It can have any value,
but only certain values will enable charge.

[*] Now lets forget ds1339, there are few things I'd like to know about
this driver.

How are you using this driver? There is non-static function
ds1337_do_command which expects id. How do you know which id belongs
to which chip? Do you actually have machine with more than one ds1337?
Chip has fixed address, so only one can hang on one bus (am I right?)
Also it is unlikely that machine will have more that one RTC. The only
exception which comes on mind are NUMA systems which have one RTC per
node. Anything else? Why date format returned/expected by this driver
differs from other drivers?

Thanks in advance,
	ladis

PS. I'm sorry about some formulations I used in earlier mails. I was
overworked and tired and that affected my otherwise (hopefully) good
decorum :)
