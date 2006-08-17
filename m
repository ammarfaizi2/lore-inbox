Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWHQFrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWHQFrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWHQFrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:47:46 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:22636 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932438AbWHQFrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:47:45 -0400
From: David Brownell <david-b@pacbell.net>
To: johnstul@us.ibm.com
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever clock
Date: Wed, 16 Aug 2006 22:47:41 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608162247.41632.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         Almost every arch has some form of persistent clock (CMOS, RTC, etc)
> which is normally used at boot time to initialize xtime and
> wall_to_monotonic. As part of the timekeeping consolidation, I propose
> the following generic interface to the arch specific persistent clock:

Hmm, this seems to ignore the RTC framework rather entirely, which
seems to me like the wrong implementation approach.  You'd likely have
noticed that if you had supported a few ARM boards.  :)

Here's a fairly common scenario for an embedded system:  the battery
backed clock is accessed through I2C or SPI, rather than an ISA style
direct register access, so it's not accessible until after those driver
stacks have initialized.

Or similarly, the SOC family may have a powerful RTC ("arch specific")
with alarm and system wakeup capabilities, but it may not be the system's
battery backed clock ... so that RTC would be initialized from another one,
which is accessed using I2C/SPI/etc.  (RTCs integrated on SOCs evidently
have a hard time being as power-miserly as the discrete ones.)

The approach in this patch doesn't seem to play well with those scenarios,
because it expects to do timekeeping setup long before the system's RTC is
necessarily going to be available ... and doesn't have an answer for those
cases where the RTC is unavailable before e.g. late_initcall().

I'd be more interested in something that improves on CONFIG_RTC_HCTOSYS,
and for example addresses the need to update the system wall time from
such RTCs after resume, not just at boot time.

- Dave

