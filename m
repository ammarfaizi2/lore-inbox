Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWGaWp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWGaWp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWGaWp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:45:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:18263 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751424AbWGaWp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:45:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HI9t2LzOoO/NBqJhbMFcD5n1ZwBlk2ccP7EXqjJXoZ5Z3Ra1FODTZEWj7rTcyoDmLFRgPzcQRWQdcboSibB8/YLKdqspr0MYOtZJsU6JEzGKrtqSJ/ZvbYk1WkxWj6MzDSJoPYKTPv2t4yt9CORlHZNawwYTx7Uw6NIcma2nMIw=
Message-ID: <41840b750607311545h72cd5b1dq730c35b084c43db7@mail.gmail.com>
Date: Tue, 1 Aug 2006 01:45:27 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: linux-thinkpad@linux-thinkpad.org, LKML <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: [ltp] Re: Generic battery interface
In-Reply-To: <20060731183719.GB22081@creature.apm.etc.tu-bs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727232427.GA4907@suse.cz> <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	 <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
	 <20060731113735.GA22081@creature.apm.etc.tu-bs.de>
	 <41840b750607310818j7ab2dcddpcb7a14b9a8f10871@mail.gmail.com>
	 <20060731183719.GB22081@creature.apm.etc.tu-bs.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Please do a Reply to All. I've restored the mailing list CCs.

On 7/31/06, Michael Olbrich <michael.olbrich@gmx.net> wrote:
> On Mon, Jul 31, 2006 at 06:18:12PM +0300, Shem Multinymous wrote:
> > On 7/31/06, Michael Olbrich <michael.olbrich@gmx.net> wrote:
> > >Hmmm, that looks good for most cases. But how would you handle
> > >starting/stoping laoding/draining the battery?
> > >That usually results in values jumping from/to 0. A gui would want to
> > >show such a change immediately while otherwise keeping a slow update
> > >rate. Maybe some kind of threshhold parameter? "send an input-ready
> > >immediatelly if the value changes by more than x%".
> >
> > Changes by more than x% compared to what?
> >
> > The value at the time of the ioctl()? This might completely miss a
> > change that happened between the previous read() and the ioctl().
> >
> > The value at the time of the last read()? Then the kernel
> > driver+infrastructure will need to keep track of the latest readout
> > done by each app. That's pretty heavy.
> >
> > So what semantics make sense?
>
> Well, the kernel is polling the hardware and caches the last value for
> O_NONBLOCKing anyway. So we already have two values to compare.

It's caching *one* value, not one value per polling app  (i.e., opened file).
Also, if querying the hardware is very cheap, the driver is at freedom
to do that instead of caching.


> And keeping the latest readout for each app isn't that heavy. After all
> we already have to keep track of the timeouts for each app.

The timeouts bookkeeping will normally be done by some infrastructure,
and can often be (in principle) be optimized to less than on value per
app. Also, it's just one timestamp. By contrast, what you're asking
for requires explicit handling by every driver, and the attribute
value may take significant amount of storage -- per app.


> Another way to handle this:
> A lot of applications are interrested in changes. It would be perfectly
> reasonable for a poll() to block for over 1 minute while the value
> fluctuates with changes less than e.g. 1%. As soon as the change
> (compared to the last readout) exceds this threshhold poll() returns
> immediatelly. This could of course be combined with the proposed
> timeouts.

The app can do this itself by polling and checking the value, with a
(not too) small value of dupeq.min_wait. In the case of a
polling-based data source, the resulting hardware queries and timer
interrupts are exactly the same as an in-kernel implementation which
does the polling and comparions itself. If the data source is
event-based then the comparison in userspace does have a drawback: the
comparions are done just dupeq.min_wait apart even if the event rate
happens to be higher. Can you think of a case where this matters?

  Shem
