Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934285AbWKUBqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934285AbWKUBqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 20:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933079AbWKUBqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 20:46:43 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:42332 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965978AbWKUBql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 20:46:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=qlVKb0jiUY0BVrW1QokJNEqifYBCFH888Tun58heJ+ZEr6haxba5807G8GFB5DQDkgIYvVSELvN3WkMNk82WKYjFTJN02F2InGo0UmqPBEAbilg4S3BVDchxowiX3vaZ0IcCsuwWlfy9vSpxgu639TmgEXHhvVFs83zCF75UcqA=  ;
X-YMail-OSG: _GSdQZgVM1kZ5OiFjQr3Js35UAXOj6Lm8T7.C4Bz6PyudHwjn16NmBiIWj2uBlGF090MtiifeY1lQUwcmC5qv_myPS9C91TqV.5WD8QVSdwwCLhW9zcSzMHNeCjU.tOaQ2mlWcJo3Mq9R.2H2zIHWm2_y8uWmdGx_1M-
From: David Brownell <david-b@pacbell.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2.6.19-rc6 2/6] rtc-sa1100 tweaks
Date: Mon, 20 Nov 2006 17:46:35 -0800
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, rpurdie@rpsys.net
References: <200611201014.41980.david-b@pacbell.net> <200611201019.53906.david-b@pacbell.net> <20061120224832.GE26791@flint.arm.linux.org.uk>
In-Reply-To: <20061120224832.GE26791@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201746.36761.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 2:48 pm, Russell King wrote:
> On Mon, Nov 20, 2006 at 10:19:53AM -0800, David Brownell wrote:
> > Minor updates to rtc-sa1100: report whether the alarm is enabled, remove
> > duplicate procfs reporting of that factoid, and stick a FIXME at a place
> > where alarms should be enabled (but aren't).
> 
> I think you're rather confused about alarms, but you're going to tell
> me that it's me who is no doubt, so I'm not sure why I'm bothering to
> write this mail.

Because you think it likely that more than one person is confused,
and you're 100% certain that will continue unless someone like you
asks a question to help sort it out?  :)


> The pre-rtc-lib user API was as follows:

There were actually several such APIs.  Most tried to act like
the drivers/char/rtc.c driver (/dev/rtc on a PC), but of course
not all RTCs are at heart MC146818 clones.

ARM is as usual a rich source of counter-examples, with varying
capabilities; and it has its own RTC API, now being more or less
replaced by the generic framework.  (I only see Integrator left
in terms of in-tree callers.)

 
> - ALM_SET - sets the time of the alarm, does not enable or disable
>             current alarm settings
> - AIE_ON - enables alarm interrupts
> - AIE_OFF - disables alarm interrupts

Agreed; that's what the PC "rtc.c" did, and most drivers did a good
job of emulating those parts.

One thing that seemed to vary between drivers though:  just what an
"alarm setting" is.  A MC146818 supports only HH:MM:SS alarms, but
any of those fields can be wildcards.  Lots of drivers implemented
that without the wildcard functionality.  Some also handled DD-MON,
or DD-MON-YEAR specifiers.

I believe that for Linux today, that wildcard functionality is in
the "nonportable behavior" category.


> - WKALM_SET - sets the wake up alarm, enables wake up alarm, indicates
>               whether wake up alarm is pending

Sort of.  Semantics varied a lot.

Near as I can tell, WKALM_SET joined us with IA64 and the "efirtc.c"
driver (/dev/efirtc on IA64) which **DOES NOT** implement the other
calls above ... and implemented WKALM_SET by punting directly to EFI
firmware.  Ditto its sibling WKALM_GET.

(The arch/arm/common/rtctime.c code seems to have come about four
years after the efirtc.c driver, and defined *different* semantics
for those calls ...)


Now, I happened to look up what EFI said about the semantics of those
firmware requests.  Summarizing its manual, the two RTC calls are:

   SET ... takes a YYYY-MON-DD HH:MM:SS date and an enable flag,
	which affects "wakeup" (including power on)
   GET ... returns the above, plus a "irq pending" flag, which is
	cleared by calling SET with enable=false (and date=ignored)

The original definition of the WKLAM_* ioctls on Linux was operationally,
with respect to EFI firmware.


> So, alrm->enabled indicates _independently_ of the alarm interrupt whether
> this should cause a wakeup, as per the SA1100 driver.

Not according to the EFI docs.  There is no other way to enable an alarm,
and there is no way to enable an alarm that doesn't do system wakeup.
They're joined at the hip, and there's no such notion as AIE_ON.


>		 Whether a wakeup 
> can occur with or without AIE_ON is implementation defined.

See above ... a program expecting /dev/rtc0 and /dev/efirtc to act
the same would justifiably say it's a bug if WKALM_SET wasn't a
one-stop-shopping solution for setting and activating the alarm.


> Now, if the new RTC library treats this differently, then /it's/ changing
> the userspace API and is therefore buggy.

As shown above, it's not changing WKALM_SET ... at least in the way
you described, since AIE_ON has always been implicit there.  It's
quite possible that folk implementing that call in the ARM framework
were not implementing those original semantics ("therefore buggy").


So it's arguable just how that call should be implemented.  The
original definition seems clear, and that's what I've tried to use;
although that whole "pending" thing does not make sense to me if
there are real IRQs.

It seemed to me that the consensus about how to implement WKLALM_SET
(judging just by votes in drivers/rtc/*.c drivers) is:  (a) it's a
combination of ALM_SET plus either AIE_ON or AIE_OFF, as with EFI;
(b) unlike ALM_SET, it supports alarms more than 24 hours in the
future; and (c) system wakeup, or lack thereof, is orthogonal to the
basic alarm functionality.


> Note also that _lots_ of drivers don't support these new weird
> device_set_wakeup_enable() and device_may_wakeup() calls - it seems
> that there's an exercise for someone to go through and add a load of
> device_set_wakeup_enable()

Wakeup is only relevant for PM-enabled platforms, and there aren't all
that many PM-enabled platforms in the first place.  And among those,
there are darn few that support wakeup events sanely ... with PCs
solidly in the "does not support wakeup" category.

Initialization of wakeup-capable devices should device_init_wakeup().

Probably the best example of how to do that is in the at91rm9200 code,
where many drivers -- CF, MMC, USB host, USB peripheral, RTC, and
more -- are all wakeup-enabled.


> 		before we go trying to use device_may_wakeup() 
> on those devices.  I'm not presently sure what they're supposed to do
> or achieve.

Drivers should use device_may_wakeup() to decide whether they should
enable their wakeup capabilities.  By default the answer is "yes" if
the hardware allows it.  Userspace can change that, and would do so
for two basic reasons:

   (1) It might not work correctly on a given system, even when it
       looks to the kernel as if it should.  Maybe some switch wore
       out; I have a USB mouse that lies about being wakeup-capable.

   (2) Drivers can usually save more power if they don't have to be
       wakeup-capable.  If disabling a few wakeup event sources were
       to save 20 mA battery power, that could be very critical in
       the effort to get another few hours out of a charge.

Plus of course just not wanting a particular thing to be a wakeup
event ... maybe inserting an MMC or CF card isn't such a big deal
on one system as it is on another.

- Dave

