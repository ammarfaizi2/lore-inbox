Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVBRTU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVBRTU0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVBRTU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:20:26 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:22434 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbVBRTUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:20:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iWkIHsMGmVxnSYuNDZzgtC7b7pTLMEdF5OBPV6dZr1fg+N7DXpLTvOHT7XNXutkClV6eMd1RUA09jmabhZiVJpv74MzWHPY28F3H8uJRFjFhQ6SryqCgMdYvFE368J0umkTpQ9R4srz/oXGxUhTe/ZU/Qcb+58KUhXeWXJ1sUZE=
Message-ID: <d120d5000502181120392a9a0f@mail.gmail.com>
Date: Fri, 18 Feb 2005 14:20:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Cc: Pavel Machek <pavel@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050218183936.GA2242@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050213004729.GA3256@stusta.de>
	 <047401c515bb$437b5130$0f01a8c0@max>
	 <20050218132651.GA1813@elf.ucw.cz>
	 <200502181436.01943.oliver@neukum.org>
	 <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz>
	 <d120d50005021810195f16ac0d@mail.gmail.com>
	 <20050218183936.GA2242@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 19:39:36 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Feb 18, 2005 at 01:19:08PM -0500, Dmitry Torokhov wrote:
> > On Fri, 18 Feb 2005 18:00:36 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > On Fri, Feb 18, 2005 at 05:01:53PM +0100, Pavel Machek wrote:
> > >
> > > > > > It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> > > > > > and it will not work on i386/APM, anyway. I still believe right
> > > > > > solution is to add input interface to ACPI. /proc/acpi/events needs to
> > > > > > die, being replaced by input subsystem.
> > > > >
> > > > > But aren't there power events (battery low, etc) which are not
> > > > > input events?
> > > >
> > > > Yes, there are. They can probably stay... Or we can get "battery low"
> > > > key.
> > >
> > > We even have an event class for that, EV_PWR in the input subsystem.
> >
> > I really really think this is wrong. Power management should be
> > possible without input layer. EV_PWR is fine for telling input devices
> > to do something, like enter lower power mode
> 
> Definitely not for this. The request to go to low power mode should come
> from the other side - the bus the device lives on.

Probably not. On the other hand input layer is kind of a
hyper-transport allowing to send messages to several devices at one
regardless of the bis they are reside on.
  
> 
> > and for sending _some_ requests to the PM system.
> 
> I don't think input devices themselves should be sending any requests to
> the PM system at all, they should just pass the events to the userspace
> and have that decide what to do with it.
> 
> Maybe a simple event handler like power.c for transforming key events to
> power change requests for embedded systems makes sense, but normally
> many more variables need to be taken into account, and thus userspace
> needs to decide.
> 

I never said it should go staringt into the core of ACPI and
performing some action. That hack to power.c that I did was
effectively sending message to acpid giving userspace a chance to make
decision and react to the request.

> > But input layer shoudl not be used as a generic transport. I mean
> > battery low, docking requests, etc has nothing to do with input.
> 
> Well, plugging in a power cord is a physical user action much like
> closing the lid is, much like pressing the power button is, much like
> pressing a key is.

What about power dying and my UPS switing on? I think it is out of
input layer, we need PM/system state messaging layer. It can be based
on acpi events and acpid or maybe kevents (but I don't like the idea
of needing kobjects for that).

Still power.c seems like the good place to hide all the ugliness and
glue between that new (or old) layer and input layer.

-- 
Dmitry
