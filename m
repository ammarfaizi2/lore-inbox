Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269029AbUI2U4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269029AbUI2U4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUI2U4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:56:36 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:45451 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S269029AbUI2U42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:56:28 -0400
Message-ID: <415B2178.7060907@am.sony.com>
Date: Wed, 29 Sep 2004 13:56:24 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henry Margies <henry.margies@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is there a problem in timeval_to_jiffies?
References: <20040909154828.5972376a.henry.margies@gmx.de>	<20040912163319.6e55fbe6.henry.margies@gmx.de>	<20040915203039.369bb866.rddunlap@osdl.org>	<414962DF.5080209@mvista.com>	<20040916200203.6259e113.henry.margies@gmx.de>	<4149F56E.50406@mvista.com> <20040917115502.33831479.henry.margies@gmx.de>
In-Reply-To: <20040917115502.33831479.henry.margies@gmx.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henry Margies wrote:
> Right? But for arm, with a jiffie size of 10000000, it is much
> more easier. And that is why I don't understand why an one second
> interval is converted to 101 jiffies (on arm).
...
> I agree. But then, why adding one jiffie to every interval? If
> there is no latency, the timer should appear right at the
> beginning of a jiffie. For x86 you are right, because 10 jiffies
> are less then 10ms. But for arm, 1 jiffie is precisely 10ms. 

How does the computer "know" that the timer is at the beginning
of the jiffy?  By definition, Linux (without HRT support) has
no way of dealing with sub-jiffy resolution for timers.

Maybe a graphic (ascii-graphic) will help:

tick 1 ---------------------




tick 2 ---------------------
schedule point A ->


schedule point B ->
tick 3 ---------------------




tick 4 ---------------------




tick 5 ---------------------


Let's say, that at point A, you ask for a 20 millisecond timer.
(2 jiffies, on ARM).  You think you are asking for a timer to fire
on tick 4 (20 milliseconds after tick 2), but Linux can't
distinguish point A from point B.  In order to avoid
the situation where someone scheduled a 20 millisecond timer
at point B, and had it fire on tick 4 (only 10 milliseconds
later), Linux adds one jiffy to the expiration time.
Both timers (set at point A or point B) would fire
on tick 5.  For the A timer, this makes it 30 milliseconds
(or, jiffies plus one) later, which looks pretty bad.
For the B timer, the interval would be close to 20
milliseconds, which looks pretty good.

If you are rescheduling one-shot timers immediately
after they fire, you should 'undershoot' on the time
interval, to hit the tick boundary you want, based
on the jiffy resolution of your platform.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
