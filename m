Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUEJK7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUEJK7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 06:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264631AbUEJK7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 06:59:22 -0400
Received: from ltgp.iram.es ([150.214.224.138]:6017 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S264628AbUEJKxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 06:53:11 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 10 May 2004 12:52:30 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org
Subject: Re: get_cmos_time() takes up to a second on boot
Message-ID: <20040510105230.GA14104@iram.es>
References: <409C2CBA.8040709@am.sony.com> <Pine.LNX.4.58.0405071908060.3271@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405071908060.3271@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 07:15:53PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 7 May 2004, Tim Bird wrote:
> > 
> > What is the downside of disabling this
> > synchronization with the clock edge?
> 
> It might not matter any more, but if I remember correctly, the real 
> problem was that we used to always write back the time to the CMOS clock 
> too, and then booting a few times and consistently getting the time wrong 
> the same way made the clock drift quite noticeably.
> 
> These days, I think we do the write-back only if we use an external clock 
> (NTP), so we probably _could_ just remove the synchronization at 
> read-time (removing it at write-time doesn't sound like a good idea).

Indeed, it is necessary at write-time. Note that from my experience
most RTC are not very accurate, as if the first 10 to 12 stages
of the 32768 Hz divider were unaffected by the writes: with 10 msec 
jiffies I often see the time jump by a few tens of milliseconds
at boot from ntpdate (I have reference clocks on the same LAN, with
errors only exceptionally above 1 millisecond and the RTC is only written 
from the kernel every 11 minutes, _never_ from the shutdown scripts).

> 
> Does anybody remember better?
> 
> > 1 second of variability is unnacceptable
> > when you're requirement is to boot in
> > .5 seconds.  :)
> 
> Heh. And yes, it could be handled other ways (you could check the cmos
> busy-waiting).

Fine. But boot time below one second are fundamentally incompatible
with avoiding/minimzing time jumps after user mode has started, which 
is what worries me. Well, unless you have better RTC with subsecond
fields, that is.

> 
> > Would it be bad to disable this synchronization
> > completely?  How about just during boot?
> 
> I don't think we should necessarily disable the synchronization, but we
> could certainly make it optional for cases that don't care about it. We
> might even make the default be "don't care about the read
> synchronization".

I'm for one againt dropping the synchronization and even making the
default not to synchronize, I'd rather see this as an option under
the embedded subset for the people who really want fast boot time.
Anybody not booting from ROM/Flash/MTD (the overwhelming majority AFAICS) 
won't ever notice the time lost in synchronizing with the RTC edge, 
especially if it's not done by busy waiting.

	Regards,
	Gabriel
