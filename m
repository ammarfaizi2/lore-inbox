Return-Path: <linux-kernel-owner+w=401wt.eu-S1752880AbWLRE3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbWLRE3F (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 23:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbWLRE3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 23:29:05 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:36271 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752892AbWLRE3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 23:29:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=F2fQmo2oQvj5wSVHuPOft+/skgMI6fG5O7iUyrC9ri7sWt3LrDg74hAFQ5kkFcKpfpOaDgj3pblWaHSV8JVNEsmjefZNonztZryAqdizN3ztpp/BI8okpuAZFkUaSrxof0brV3wilEEkHrRbkpVoFtkdNUBOQ9YQ4rorjaddNGE=  ;
X-YMail-OSG: 7qYIZGUVM1l9Czivpqeb0K_AP3cpXj_Yl6O6iy_NQFgkmsecKFahmf.CNlFCXFKn_g27SLL2.Z4yRlL3_t4bVP5TD6kLRjsJ.QHPLBKBiyPKh2_P4Dmbj7aV0MW1qgEWrMeRGlr7.pn8UU5xCg6Ez64pj6.vLxFANE5AG6t4dtKNe0pF09RU6S75k58i
From: David Brownell <david-b@pacbell.net>
To: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: [PATCH] RTC classdev: Add sysfs support for wakeup alarm (r/w)
Date: Sun, 17 Dec 2006 20:28:58 -0800
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org,
       Richard Purdie <rpurdie@rpsys.net>
References: <1866913935.20061217213036@gmail.com>
In-Reply-To: <1866913935.20061217213036@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612172028.58665.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 December 2006 11:30 am, Paul Sokolovsky wrote:

>     Small battery-powered systems, like PDAs, need a way to be
> suspended most of the time and woken up just from time to time to
> process pending tasks. 

Sounds like you're thinking of this from a userspace perspective...

Could you share some examples of such "pending tasks"?  I suspect
beaconing once or twice a second in a wireless network isn't quite
what you mean, although it fits your description.  On some Linux
platforms with dynamic tick support, Linux can enter suspend modes
between periodic wakeups needed for such beaconing.


> Obvious way to achieve this is to use timer, or 
> alarm, wakeup. Unfortunately, this matter is bit confusing in Linux.
> There's only one "good" "supported" way to set alarm - via ioctl() on
> an RTC device fd. Unfortunately, this alarm is not persistent - as soon
> as fd is closed, alarm id discharged.

I don't think that's true in general.  Most RTCs don't even care
whether userspace did an open() or close().  I see the S3C one does,
and that explicitly leaves the alarm active. 

But I see that only the SA1100/PXA and SH RTCs turn off all IRQs
after RTC_WKALM_* requests ... that's a distinct minority.

So judging implementations as votes ... only two implementations
that implement the RTC_WKALM_* call follow that rule, and most
don't.  However, a few implementations ignore rtc_wkalrm.enabled,
or otherwise mistreat that flag (e.g. rtc-ds1553 doesn't disable
AIE when enabled==0), so it's clear there are some issues there.

My vote would be that closing the FD should not turn off the alarm.
It's supposed to be a one-shot deal anyway.

And also, that someone audits the drivers/rtc code to make sure that
alarm-capable drivers handle the rtc_wkalrm.enabled flag correctly;
your patch sort of presumes that will happen, anyway.  And hmm, it'd
be good to have rtctest.c (in Documentation/rtc.txt) test for that...
it doesn't actually use RTC_WKALM_* calls, so it's too easy for folk
to goof up their implementations.


> Formal part
> ===========
> 
> Implement "alarm" attribute group for RTC classdevs. At this time,
> add "since_epoch", "wakeup_enabled", and "pending" attributes. First
> two support both read and write.

I think you shouldn't add this group unless the RTC has methods
to read and write the alarm; there are RTCs that don't have that
feature.

Also, I'd rather see a much simpler interface.  Like a single
"alarm" attribute.  It would display as the empty string unless
it was enabled, in which case the alarm time wouhd show.  To
disable it, write an empty string; to enable an alarm, just write
a valid time (in the future).  The other parameters aren't needed;
"wakeup" is PM infrastructure (/sys/devices/.../power/wakeup),
since it's easy to have an alarm that's not wakeup-capable.

- Dave




