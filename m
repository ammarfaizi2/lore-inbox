Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVKKMfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVKKMfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 07:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKKMfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 07:35:19 -0500
Received: from tim.rpsys.net ([194.106.48.114]:44186 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750715AbVKKMfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 07:35:18 -0500
Subject: Re: sharpsl_pm: using milivolts instead of custom units?
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051111120300.GA29251@elf.ucw.cz>
References: <20051111120300.GA29251@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 12:35:12 +0000
Message-Id: <1131712513.7794.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 13:03 +0100, Pavel Machek wrote:
> Hi!
> 
> It seems to me that sharpsl.c is using some very custom units:
> 
> #define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
> #define SHARPSL_CHARGE_ON_TEMP         0xe0  /* 2.9V */
> #define SHARPSL_CHARGE_ON_ACIN_HIGH   0x9b  /* 6V */
> #define SHARPSL_CHARGE_ON_ACIN_LOW    0x34  /* 2V */
> #define SHARPSL_FATAL_ACIN_VOLT        182   /* 3.45V */
> #define SHARPSL_FATAL_NOACIN_VOLT      170   /* 3.40V */
> 
> ...what are they? Unfortunately collie uses very different units:

They're raw values as provided by the ADC. Collie will have a different
ADC and hence different raw values. There's no real need to convert them
to mV and back again all the time.

> #ifdef CONFIG_SA1100_COLLIE
> struct battery_thresh spitz_battery_levels_noac[] = {
>         { 368, 100},
>         { 358,  25},
>         { 356,   5},
>         {   0,   0},
> ...
> 
> ...so it could get very confusing. Would it be feasible to convert to
> mV as soon as possible and have all constants in milivolts? I realize
> they may be slightly different for different models, but they should
> at least be comparable.

The battery levels are totally different between the models and each is
going to need a levels translation table as its an extremely none linear
decay curve. Using ADC values here makes a lot of sense as that's as
granular as the information ever gets and you don't start to lose
accuracy anywhere with rounding.

I still think you've much bigger problems to worry about as this code is
heavily PXA biased and is going to need a lot of changes to work on the
SA1100. Its why I've put it in mach-pxa rather than common and a
separate driver for collie based on this code might be easier.

Richard

