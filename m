Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVBROM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVBROM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 09:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVBROMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 09:12:38 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:25985 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261208AbVBROMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 09:12:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KG1j9jDs1Klln68a9T1q6S3IYbT1mTa1cncTrp6KzMKd4g5zcW9bfpV1CMkLJWyW1I5XIDVr8v2xYdxdQxaqzoqLl1zXw/8MBipbp4qOFYZaE6qdYSosEFC2RG3iLLtn0YhI72/gvpPPLzgBwshMB/hev5AKoRNk+mSXu1kL7vE=
Message-ID: <d120d50005021806121af06d85@mail.gmail.com>
Date: Fri, 18 Feb 2005 09:12:31 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Cc: Richard Purdie <rpurdie@rpsys.net>, Vojtech Pavlik <vojtech@suse.cz>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050218132651.GA1813@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050213004729.GA3256@stusta.de>
	 <Pine.LNX.4.56.0502141756220.7398@pentafluge.infradead.org>
	 <20050214193438.GB7763@ucw.cz> <20050218122217.GA1523@elf.ucw.cz>
	 <047401c515bb$437b5130$0f01a8c0@max>
	 <20050218132651.GA1813@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 14:26:51 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> 
> > >> > CONFIG_INPUT_POWER was enabled - but it is nowhere possible to enable
> > >> > this option.
> > >>
> > >> That was written a long time ago before the new power management went
> > >> in.
> > >> On PDA's there is a power button and suspend button. So this was a hook
> > >> so that the input layer could detect the power/suspend button being
> > >> presses and then power down or turn off the device. Now that the new
> > >> power
> > >> management is in what should we do?
> > >
> > >Change power.c to generate power events like ACPI does, most likely.
> >
> >
> > There was some recent discussion of this on linux-input. It was basically
> > agreed that the input system should pass the request on to ACPI and/or apm
> > and Dmitry Torokhov (cc'd) proposed a patch that did this. His patch needed
> > to be slightly modified to work with arm apm, the final result being:
> >
> > http://www.rpsys.net/openzaurus/2.6.11-rc4/input_power-r1.patch
> >
> > I can confirm this works well on arm with apm enabled.
> 
> It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,

Yes, power.c is an aggregator that transports power events from the
input system into whatever power scheme is in use, so there will
always be a lot of ifdefs unless we will invent grand unified power
interface with userspace. I wonder if we could use kevents.

> and it will not work on i386/APM, anyway.

We could add fix i386 APM case but it looks like most people are
concentrating on ACPI.

> I still believe right
> solution is to add input interface to ACPI. /proc/acpi/events needs to
> die, being replaced by input subsystem.

There are many more events from ACPI that are not related to input, so
we need to keep it. Still, I can see buttons converted to input
devices which bind to power.c and then transmit requests to acpid
through /acpi/proc/event.

-- 
Dmitry
