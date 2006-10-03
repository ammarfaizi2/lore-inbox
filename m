Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWJCNxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWJCNxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 09:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWJCNxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 09:53:17 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:55188 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750838AbWJCNxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 09:53:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=i7dqKXkq7oMmKueP4YdvpNPtZ20BjTDbA7kKvQooPtVSCXODunaXaiowwcEU6S3fY3ls4pAEpMITd4gghs5/hkfiUAG/UD+LTGMm5idcayMo/Ie7V7mLw4vzKVqyhuBpBRx8iu5fewts/6FWjRoiG43TBpFn6M3ankNZA2bnr0Q=  ;
From: David Brownell <david-b@pacbell.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [patch 02/23] GTOD: persistent clock support, core
Date: Tue, 3 Oct 2006 06:53:11 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610030653.12411.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Implement generic timekeeping suspend/resume accounting by introducing 
> the read_persistent_clock() interface. This is an arch specific 
> function that returns the seconds since the epoch using the arch 
> defined battery backed clock.

I remain unclear what's expected to happen when there IS no such
architcture-defined clock ... but where the system itself still
has one, e.g. a board may access one through I2C or SPI once IRQs
are working normally.

You'll recall that I had pointed out that the drivers/rtc framework
provides CONFIG_RTC_HCTOSYS, which already unifies quite a lot of
the "persistent" clocks in the way you described above, but without
that nasty requirement of working without IRQs enabled.


> +/**
> + * read_persistent_clock -  Return time in seconds from the persistent clock.
> + *
> + * Weak dummy function for arches that do not yet support it.
> + * Returns seconds from epoch using the battery backed persistent clock.
> + * Returns zero if unsupported.
> + *
> + *  XXX - Do be sure to remove it once all arches implement it.

But not all architectures **CAN** support this notion ...


> + */
> +unsigned long __attribute__((weak)) read_persistent_clock(void)
> +{
> +       return 0;
> +}
> +
>
>  /* 
>   * timekeeping_init - Initializes the clocksource and common timekeeping values
>   */
>  void __init timekeeping_init(void)
>  {
>         unsigned long flags;
> +       unsigned long sec = read_persistent_clock();

... and timekeeping_init() is called before I2C or SPI could be used,
since IRQs aren't enabled yet and accessing those busses can't be
done in general without IRQs enabled.


> @@ -774,13 +801,23 @@ static int timekeeping_suspended;
>  static int timekeeping_resume(struct sys_device *dev)
>  {
>         unsigned long flags;
> +       unsigned long now = read_persistent_clock();

Again: sys_device resume() is called with IRQs disabled, which
prevents access to many systems' persistent clocks.  In fact,
after posting this example patch

  http://marc.theaimsgroup.com/?l=linux-kernel&m=115600629813751&w=2

I never heard anything more from you on this issue.  Given this
particular patch (in $SUBJECT) should I assume you're going to
just ignore the issues whereby RTCs ("persistent clocks") can't
always meet the no-IRQs-needed assumptions being made here?  Or
address isssues like using pointer-to-function instead of using
linker tricks?

  http://marc.theaimsgroup.com/?l=linux-kernel&m=115600629825461&w=2

Those class suspend/resume hooks are now merged to kernel.org, by
the way, so that example patch is now pretty much deployable.

- Dave

