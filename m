Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVBAXco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVBAXco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVBAXck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:32:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:15064 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262179AbVBAXcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:32:15 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: ncunningham@linuxmail.org
Cc: Tim Bird <tim.bird@am.sony.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1107299672.13413.25.camel@desktop.cunninghams>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <41FFFD4F.9050900@am.sony.com>
	 <1107298089.2040.184.camel@cog.beaverton.ibm.com>
	 <1107299672.13413.25.camel@desktop.cunninghams>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 15:32:09 -0800
Message-Id: <1107300730.2040.195.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 10:14 +1100, Nigel Cunningham wrote:
> Hi John and Tim.
> 
> On Wed, 2005-02-02 at 09:48, john stultz wrote:
> > > I didn't scan for all uses of read_persistent_clock, but
> > > in my experience get_cmos_time() has a latency of up to
> > > 1 second on x86 because it synchronizes with the rollover
> > > of the RTC seconds.
> > 
> > I believe you're right. Although we don't call read_persistent_clock()
> > very frequently, nor do we call it in ways we don't already call
> > get_cmos_time(). So I'm not sure exactly what the concern is.
> 
> Tim and I talked about this at the recent CELF conference. I have a
> concern in that suspend-to-disk calls the suspend methods and then
> (after the atomic copy) the resume methods. Since the copy usually takes
> < 1s, and the suspend and resume methods both make two calls to
> get_coms_time, that's an average of 1.5s per suspend call and 1.5s per
> resume call - but if the copy does take next to no time (as normal),
> it's really 1.5s + 2s = 3.5s average just for getting the time. I
> believe Tim has similar issues in code he is working on. It's a concern
> if your battery is running out and you're trying to hibernate!

Well, counting the atomic copy in the "3.5s average just for getting the
time" doesn't quite seem fair, but I think I understand. Its
interesting, I wasn't aware of the suspend/copy/resume process that
occurs for suspend-to-disk. The thing I don't quite get is why are the
resume methods called before we really suspend to disk?


> > I've only lightly tested the suspend code, but on my system I didn't see
> > very much drift appear. Regardless, it should be better then what the
> > current suspend/resume code does, which doesn't keep any sub-second
> > resolution across suspend.
> 
> My question is, "Is there a way we can get sub-second resolution without
> waiting for the start of a new second four times in a row?" I'm sure
> there must be.

Well, I'm not sure what else we could use for the persistent clock, but
I'd be happy to change the read/set_persistent_clock function to use it.

thanks
-john

