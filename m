Return-Path: <linux-kernel-owner+w=401wt.eu-S932332AbWLRX63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWLRX63 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWLRX63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:58:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:54211 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332AbWLRX62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:58:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=VOmh1MZ/IVAzTJmy/JFpsEhodgvATkJepRsOUVGa43mUVSXyIsNtBmEzr8fQdeVoTZ9lehH911BrpTVCsnXwtJ3ttNixNQNIMXehEBhkc2zLbgg80VIVp4cl60jkzSlYlOPSxsDu3znfcRHF/2XZvPgk+P8ym68b1ZXy2wxUhwQ=
Date: Tue, 19 Dec 2006 01:58:24 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <256202025.20061219015824@gmail.com>
To: David Brownell <david-b@pacbell.net>
CC: Alessandro Zummo <alessandro.zummo@towertech.it>,
       <kernel-discuss@handhelds.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RTC classdev: Add sysfs support for wakeup alarm (r/w)
In-Reply-To: <200612172028.58665.david-b@pacbell.net>
References: <1866913935.20061217213036@gmail.com> <200612172028.58665.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Monday, December 18, 2006, 6:28:58 AM, you wrote:

> On Sunday 17 December 2006 11:30 am, Paul Sokolovsky wrote:

>>     Small battery-powered systems, like PDAs, need a way to be
>> suspended most of the time and woken up just from time to time to
>> process pending tasks. 

> Sounds like you're thinking of this from a userspace perspective...

> Could you share some examples of such "pending tasks"?

  Well, the actual usecase, which triggered me to hack that, was a
need to write a "burn out" test script for suspend/resume for a
battery-powered ARM device (PDA), which would do suspend/resume cycle
thousands of times. And wakeup alarm is obvious, if not only, source of
automated resume events.

  Of course, I started by trying existing solutions - e.g. there's an
"atd" implementation which uses /dev/rtc, but I found it having awful
latency (>2s), then I tried to write simple C app to set alarm via
ioctl(), just to find alarm IRQs are shutdown on its exit.

  But anyway, I'm that kind of guy who think that debugging and
diagnostics are important things for *production* system, so such
sysfs alarm support just as precious as /proc/interrupts and /proc/dma
(ah, ARM Linux maintainer declined to fix broken /proc/dma support for
ARM, I forgot ;-( ).

[]

>> Obvious way to achieve this is to use timer, or 
>> alarm, wakeup. Unfortunately, this matter is bit confusing in Linux.
>> There's only one "good" "supported" way to set alarm - via ioctl() on
>> an RTC device fd. Unfortunately, this alarm is not persistent - as soon
>> as fd is closed, alarm id discharged.

> I don't think that's true in general.  Most RTCs don't even care
> whether userspace did an open() or close().  I see the S3C one does,
> and that explicitly leaves the alarm active. 

> But I see that only the SA1100/PXA and SH RTCs turn off all IRQs
> after RTC_WKALM_* requests ... that's a distinct minority.

  Oh my! I couldn't even think this can be idiosyncrasy of specific
implementation. Oh, what a world... ;-)

> So judging implementations as votes ... only two implementations
> that implement the RTC_WKALM_* call follow that rule, and most
> don't.  However, a few implementations ignore rtc_wkalrm.enabled,
> or otherwise mistreat that flag (e.g. rtc-ds1553 doesn't disable
> AIE when enabled==0), so it's clear there are some issues there.

> My vote would be that closing the FD should not turn off the alarm.
> It's supposed to be a one-shot deal anyway.

  I would agree with such behavior. But what's clear that the
behavior, whatever it is, should be consistent across implementations,
or its just a mess ;-(.

> And also, that someone audits the drivers/rtc code to make sure that
> alarm-capable drivers handle the rtc_wkalrm.enabled flag correctly;
> your patch sort of presumes that will happen, anyway.

  Yes, I mentioned, that for PXA/SA, my patch becomes actually useful
only after applying your patch (plus, with fixed TODO: here's what
I applied to handhelds.org tree:
http://handhelds.org/cgi-bin/cvsweb.cgi/linux/kernel26/drivers/rtc/rtc-sa1100.c.diff?r1=1.5&r2=1.6&f=h
).

  That of course doesn't mean sysfs alarm support patch depends on
rtc-sa1100.c patch in any way (it's just PXA/SA won't actually wake up,
but sysfs patch for showing/storing alarm properties obviously doesn't
depend on any specific implementation).

>   And hmm, it'd
> be good to have rtctest.c (in Documentation/rtc.txt) test for that...
> it doesn't actually use RTC_WKALM_* calls, so it's too easy for folk
> to goof up their implementations.


>> Formal part
>> ===========
>> 
>> Implement "alarm" attribute group for RTC classdevs. At this time,
>> add "since_epoch", "wakeup_enabled", and "pending" attributes. First
>> two support both read and write.

> I think you shouldn't add this group unless the RTC has methods
> to read and write the alarm; there are RTCs that don't have that
> feature.

> Also, I'd rather see a much simpler interface.  Like a single
> "alarm" attribute.  It would display as the empty string unless
> it was enabled, in which case the alarm time wouhd show.  To
> disable it, write an empty string; to enable an alarm, just write
> a valid time (in the future).  The other parameters aren't needed;
> "wakeup" is PM infrastructure (/sys/devices/.../power/wakeup),
> since it's easy to have an alarm that's not wakeup-capable.

  Yes, both of these are, or may be, true. That was really a draft,
initial version. I probably don't have knowledge/resources to make it
"right", but it would be nice if it prompted someone with more
experience/resources to tweak in such support, as well as the problems
outlined above...

> - Dave



-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

