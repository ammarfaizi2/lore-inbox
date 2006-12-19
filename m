Return-Path: <linux-kernel-owner+w=401wt.eu-S932521AbWLSAyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWLSAyf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWLSAyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:54:35 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:22422 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932521AbWLSAye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:54:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=EN9UBRCNWOkhB7P+5qbooLs8oVuoQps4WhSb1iDn6P3tldKduyAouN/cxZOCWLT1iF1vywDxqz5lyC6qFbp0NxS8cT3xzY4kyvI/da68c6/HFXI8+16yRGORb0Tg/RVlAuiXeqAKge0KfEB9zHFiTdZuftAz8nN23QlKAl15wJg=  ;
X-YMail-OSG: etN6u5IVM1kKbOzR5KwewHBPnsLdVv4zpbqTBHzOTx.uvAwciuzMp_G31rG_b.Y6zPkx3k2DIptW5LhlPUP0i84j4KJPKgnDiGxghHJaHbRGhODDvEqdHL8NiOrg_glFyT_uMYKn9ouDg3EbU.ILjBkOAR8R25X5EHXoMQxl9k9bgsfxcopPHMFKXCcJ
From: David Brownell <david-b@pacbell.net>
To: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: [PATCH] RTC classdev: Add sysfs support for wakeup alarm (r/w)
Date: Mon, 18 Dec 2006 16:54:29 -0800
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org
References: <1866913935.20061217213036@gmail.com> <200612172028.58665.david-b@pacbell.net> <256202025.20061219015824@gmail.com>
In-Reply-To: <256202025.20061219015824@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612181654.30864.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Monday 18 December 2006 3:58 pm, Paul Sokolovsky wrote:
> Monday, December 18, 2006, 6:28:58 AM, you wrote:
> > On Sunday 17 December 2006 11:30 am, Paul Sokolovsky wrote:
> 
> >>     Small battery-powered systems, like PDAs, need a way to be
> >> suspended most of the time and woken up just from time to time to
> >> process pending tasks. 
> 
> > Sounds like you're thinking of this from a userspace perspective...
> 
> > Could you share some examples of such "pending tasks"?
> 
>   Well, the actual usecase, which triggered me to hack that, was a
> need to write a "burn out" test script for suspend/resume for a
> battery-powered ARM device (PDA), which would do suspend/resume cycle
> thousands of times. And wakeup alarm is obvious, if not only, source of
> automated resume events.

I like how you think ... SCRIPTED TESTING for suspend/resume!!
Can you clone yourself?  Soon, and massively?  :)

Though I confess I've used that example myself.  I think if you scan LKML
you'll find an "rtcwake" program (userspace) I've used on several different
ARMs (not PXA though), and even x86 PCs (using a new RTC driver, but getting
the usual headaches from ACPI S3 resume failures on most systems).


>   Of course, I started by trying existing solutions - e.g. there's an
> "atd" implementation which uses /dev/rtc, but I found it having awful
> latency (>2s), then I tried to write simple C app to set alarm via
> ioctl(), just to find alarm IRQs are shutdown on its exit.
> 
>   But anyway, I'm that kind of guy who think that debugging and
> diagnostics are important things for *production* system,

You'd find violent agreement from anyone who's spent time trying
to support all this fancy technology.  Heck, even toasters have
problems sometimes.


> >> Obvious way to achieve this is to use timer, or 
> >> alarm, wakeup. Unfortunately, this matter is bit confusing in Linux.
> >> There's only one "good" "supported" way to set alarm - via ioctl() on
> >> an RTC device fd. Unfortunately, this alarm is not persistent - as soon
> >> as fd is closed, alarm id discharged.
> 
> > I don't think that's true in general.  Most RTCs don't even care
> > whether userspace did an open() or close().  I see the S3C one does,
> > and that explicitly leaves the alarm active. 
> 
> > But I see that only the SA1100/PXA and SH RTCs turn off all IRQs
> > after RTC_WKALM_* requests ... that's a distinct minority.
> 
>   Oh my! I couldn't even think this can be idiosyncrasy of specific
> implementation. Oh, what a world... ;-)

Yeah, just think how bad it was _before_ the RTC class framework
existed.   I think I counted at least half a dozen implementations,
with minimal API overlap.

One thing we're missing now is RTC conformance tests.  They'd have
turned up some of these issues pretty quickly, if thery were at all
good.

 
> > So judging implementations as votes ... only two implementations
> > that implement the RTC_WKALM_* call follow that rule, and most
> > don't.  However, a few implementations ignore rtc_wkalrm.enabled,
> > or otherwise mistreat that flag (e.g. rtc-ds1553 doesn't disable
> > AIE when enabled==0), so it's clear there are some issues there.
> 
> > My vote would be that closing the FD should not turn off the alarm.
> > It's supposed to be a one-shot deal anyway.
> 
>   I would agree with such behavior. But what's clear that the
> behavior, whatever it is, should be consistent across implementations,
> or its just a mess ;-(.

Yep.  I've been known to submit patches to improve that, even ones
to the RTC framework.  :)

 
> > And also, that someone audits the drivers/rtc code to make sure that
> > alarm-capable drivers handle the rtc_wkalrm.enabled flag correctly;
> > your patch sort of presumes that will happen, anyway.
> 
>   Yes, I mentioned, that for PXA/SA, my patch becomes actually useful
> only after applying your patch (plus, with fixed TODO: here's what
> I applied to handhelds.org tree:
> http://handhelds.org/cgi-bin/cvsweb.cgi/linux/kernel26/drivers/rtc/rtc-sa1100.c.diff?r1=1.5&r2=1.6&f=h
> ).
> 
>   That of course doesn't mean sysfs alarm support patch depends on
> rtc-sa1100.c patch in any way (it's just PXA/SA won't actually wake up,
> but sysfs patch for showing/storing alarm properties obviously doesn't
> depend on any specific implementation).

Hmm, you're in a position to test, so I may send you an update to try.

That patch you applied looks right to me -- why don't you forward it
to Alessandro as a bugfix for 2.6.20-rc2, and save me the effort?

 
> >> Implement "alarm" attribute group for RTC classdevs. At this time,
> >> add "since_epoch", "wakeup_enabled", and "pending" attributes. First
> >> two support both read and write.
> 
> > I think you shouldn't add this group unless the RTC has methods
> > to read and write the alarm; there are RTCs that don't have that
> > feature.
> 
> > Also, I'd rather see a much simpler interface.  Like a single
> > "alarm" attribute.  It would display as the empty string unless
> > it was enabled, in which case the alarm time wouhd show.  To
> > disable it, write an empty string; to enable an alarm, just write
> > a valid time (in the future).  The other parameters aren't needed;
> > "wakeup" is PM infrastructure (/sys/devices/.../power/wakeup),
> > since it's easy to have an alarm that's not wakeup-capable.
> 
>   Yes, both of these are, or may be, true. That was really a draft,
> initial version. I probably don't have knowledge/resources to make it
> "right", but it would be nice if it prompted someone with more
> experience/resources to tweak in such support, as well as the problems
> outlined above...

You have enough knowledge to implement those suggestions though,
that seems clear to me.  :)

- Dave

