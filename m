Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVBBA1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVBBA1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 19:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVBBA1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 19:27:48 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:7140 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262194AbVBBA1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 19:27:42 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: ncunningham@linuxmail.org
Cc: Tim Bird <tim.bird@am.sony.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1107302640.13413.62.camel@desktop.cunninghams>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <41FFFD4F.9050900@am.sony.com>
	 <1107298089.2040.184.camel@cog.beaverton.ibm.com>
	 <1107299672.13413.25.camel@desktop.cunninghams>
	 <1107300730.2040.195.camel@cog.beaverton.ibm.com>
	 <1107302640.13413.62.camel@desktop.cunninghams>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 16:27:35 -0800
Message-Id: <1107304056.2040.212.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 11:04 +1100, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2005-02-02 at 10:32, john stultz wrote:
> > interesting, I wasn't aware of the suspend/copy/resume process that
> > occurs for suspend-to-disk. The thing I don't quite get is why are the
> > resume methods called before we really suspend to disk?
> 
> We call the suspend and resume methods because the suspend is supposed
> to achieve atomicity, and the resume is necessary for us to be able to
> write the image. (Remember that these calls are invoked as part of the
> drivers_suspend and drivers_resume code). Until recently the
> sysdev_suspend and resume methods weren't called and things did still
> work, but that was an omission and we did then run into time issues.

Ah! Ok, thanks for the summary.

> > > > I've only lightly tested the suspend code, but on my system I didn't see
> > > > very much drift appear. Regardless, it should be better then what the
> > > > current suspend/resume code does, which doesn't keep any sub-second
> > > > resolution across suspend.
> > > 
> > > My question is, "Is there a way we can get sub-second resolution without
> > > waiting for the start of a new second four times in a row?" I'm sure
> > > there must be.
> > 
> > Well, I'm not sure what else we could use for the persistent clock, but
> > I'd be happy to change the read/set_persistent_clock function to use it.
> 
> Is it possible to still use the persistent clock, but do the math for
> the portions of seconds?

I'm not sure what you mean? Given the patch Tim just sent, it seems the
issue is the CMOS only gives us second resolution, so we try to increase
our accuracy by aligning the reads so we return when the second changes.
We can avoid the read-alignment which speeds things up, but introduces
up to a second worth of drift. If that's ok, then the trade off is worth
it.

Alternative persistent clocks like the efi clock might provide better
resolution and could then avoid this issue. Although I don't know for
sure.

thanks
-john


