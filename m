Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUDFX1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbUDFX1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:27:48 -0400
Received: from main.gmane.org ([80.91.224.249]:64705 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264066AbUDFX1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:27:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: High CPU temp on Athlon MP w/ recent 2.6 kernels
Date: Tue, 6 Apr 2004 23:27:37 +0000 (UTC)
Message-ID: <slrnc76f79.s2s.psavo@varg.dyndns.org>
References: <20040406193649.GA13257@sommrey.de> <200404061626.37714.gene.heskett@verizon.net> <20040406204545.GA15946@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joerg Sommrey <jo@sommrey.de>:
> On Tue, Apr 06, 2004 at 04:26:37PM -0400, Gene Heskett wrote:
>> 
>> But join the 70C club, that AMD athlon keeps itself at a medium simmer 
>> full time.  Mine has been running 67-72C for 3 years now.  Strangly, 
>> shutting down setiathome doesn't cool it by more than a couple 
>> degrees C.  And, its got a $50 all copper Glaciator cooler on it, 
>> heavy heavy heavy.
>
> That's not quite my point.  I am not afraid of running my athlons at
> 70C.  I just don't want to.  With Debian Woody they ran at <40C, which
> is impressing IMHO.  An upgrade to Sarge raised the temp for about 5K,
> which is still very cool.  This temperature didn't change when I
> upgraded to an early 2.6 kernel.  Just after 2.6.3-mm4 there was this
> jump for 10K that I just do not understand.  It doesn't hurt the athlons
> but seems unnecessary to me.

At least on A7M266-D lmsensors read thermal sensors very wrong. I
haven't got time to contact devs with that, but I do know for sure that
amd76x_pm really does make cooling calls, even in 2.6.5-rc3-mm3
(There should be /sys/devices/pci0000\:00/0000\:00\:00.0/C2_cnt file,
which tells how many times has amd76x_pm really made the disconnection call).

One issue is that from some kernel version amd76x_pm's idle() is called
upto 3.5x times more often when there's some audio activity. So in
effect number of calls to default_idle() jumps from 1100Hz to 3800Hz.
(this is reproducible with 'rhytmbox' -application, but not with xmms.
AFAIK my xmms uses OSS emulation and rhytmbox is native alsa.)

Ahem. Could you actually try:
echo 3 > /sys/devices/pci0000\:00/0000\:00\:00.0/lazy_idle

This could help gaining 5-8°C. HZ changed from 100 to 1000 in 2.6, so
amd76x_pm old default doesn't apply overly well here. 

There's some funniness going on with this tunable. It doesn't really
affect how many times/second we call amd76x_pm.idle(), but rather how
easily we go into sleep (no sleep if both CPU's aren't idle).
With lazy_idle at 3 I get bad distortions with bttv card. with 3000 they
disappear, but so does the thermal throttling :)

(Sorry for lack of coherence right now)

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

