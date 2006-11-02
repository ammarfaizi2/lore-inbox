Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752843AbWKBNwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbWKBNwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbWKBNwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:52:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:21743 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1752330AbWKBNwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:52:00 -0500
Subject: Re: [PATCH 001 of 6] md: Send online/offline uevents when an md
	array starts/stops.
From: Kay Sievers <kay.sievers@vrfy.org>
To: Neil Brown <neilb@suse.de>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <17737.58737.398441.111674@cse.unsw.edu.au>
References: <20061031164814.4884.patches@notabene>
	 <1061031060046.5034@suse.de> <20061031211615.GC21597@suse.de>
	 <3ae72650611020413q797cf62co66f76b058a57104b@mail.gmail.com>
	 <17737.58737.398441.111674@cse.unsw.edu.au>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 14:51:56 +0100
Message-Id: <1162475516.7210.32.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 23:32 +1100, Neil Brown wrote:
> On Thursday November 2, kay.sievers@vrfy.org wrote:
> > On 10/31/06, Greg KH <gregkh@suse.de> wrote:
> > > On Tue, Oct 31, 2006 at 05:00:46PM +1100, NeilBrown wrote:
> > > > This allows udev to do something intelligent when an
> > > > array becomes available.
> > > >
> > > Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > I don't agree with this, and asked several times to change this to
> > "change" events, like device-mapper is doing it to address the same
> > problem. Online/offline is not supported by udev/HAL and will not work
> > as expected. Please fix this.
> 
> I don't remember who suggested "online/offline",

It was probably the first version of the patch for device-mapper which
we got into SLE10, but it changed to "change" in the upstream kernel,
after we all met at OLS and talked about it.

> and I don't remember
> you suggesting "change", but my memory isn't what it used to be(*), so you
> probably did.

It was in the Czech Republic, but we got a few beers... :) And in the
"virtual md devices" conversation.

> Is there some document somewhere that explains exactly what each of
> the kobject_actions are meant to mean and how they can be
> interpreted?

No, there isn't. The thing is, that "online/offline" need to be always
symmetric in it's order. There can't be two "online" events without an
"offline" event. We decided at OLS for the device-mapper events, that we
can't be sure, that there will always be "online/offline" sequences and
can't be sure to make them always match the right sequence. Therefore we
decided to go for a simple "change", and let userspace find out the
current state of the device if needed.

> Anyway, I am happy to change it.  What exactly do you want?
> KOBJ_CHANGE both when the array is activated and when it is
> deactivated?  Or only when it is activated?

We couldn't think of any use of an "offline" event. So we removed the
event when the device-mapper device is suspended.

> Should ONLINE and OFFLINE remain and CHANGE be added, or should they
> go away?

The current idea is to send only a "change" event if something happens
that makes it necessary for udev to reinvestigate the device, like
possible filesystem content that creates /dev/disk/by-* links.

Finer grained device-monitoring is likely better placed by using the
poll() infrastructure for a sysfs file, instead of sending pretty
expensive uevents. 

Udev only hooks into "change" and revalidates all current symlinks for
the device. Udev can run programs on "online", but currently, it will
not update any /dev/disk/by-* link, if the device changes its content.

> If they remain, should CHANGE come before or after ONLINE (and
> OFFLINE)?

> I must admit that it feels more like an ONLINE/OFFLINE event than a
> CHANGE event to me, but they are just words after all.

Yeah, "online/offline" sounds nice, but it will get messy, if you have a
case where you don't need to go offline, but still want to notify a
change ... :)

> What does udev/HAL do with ONLINE/OFFLINE?  Could it be changed to do
> "the right thing" for ONLINE? (Not implying that it should be, just
> wanting to understand as much of the picture as possible).

Sure, it's just software, it definitely could be made to match on
anything. It's just that "change" already works fine today. :)

Thanks,
Kay


