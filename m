Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbULNEPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbULNEPo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbULNEO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:14:29 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:27802 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261398AbULNEFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:05:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OJvY4xnjOEWA1X64cjdNhvYVNJPIi0Xt1PFxskyYbYuTGXWSUiZABpEeK1HaWvKga1hXdyZ2ZMSeXt9cJcnmIya08jz8MNXmHEryIfQyuVrADMvj6meZy/9XMgriZWc6fla/lkWGJQd8hiKQS0V7uknZh+iV5cqzeSOSZsVA7M0=
Message-ID: <29495f1d04121320052e347f70@mail.gmail.com>
Date: Mon, 13 Dec 2004 20:05:34 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Hans Kristian Rosbach <hk@isphuset.no>
Subject: Re: dynamic-hz
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1102942270.17225.81.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random>
	 <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org>
	 <1102936790.17227.24.camel@linux.local>
	 <20041213112229.GS6272@elf.ucw.cz>
	 <1102942270.17225.81.camel@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004 13:51:11 +0100, Hans Kristian Rosbach
<hk@isphuset.no> wrote:
> 
> 
> On Mon, Dec 13, 2004 at 12:22:29PM +0100, Pavel Machek wrote:
> > I tried defining HZ to 10 once, and there are some #if arrays in the
> > kernel that prevented me from doing that.
> >
> > Some drivers do timeouts based on jiffies; having HZ=1 may turn 20msec
> > timeout into 1sec, that could hurt a lot in the error case...
> 
> On Mon, Dec 13, 2004 at 03:25:21AM -0800, Andrew Morton wrote:
> > We still have 1000-odd places which do things like
> >        schedule_timeout(HZ/10);
> > which will now involve a runtime divide.  The propagation of msleep()
> > and ssleep() will reduce that a bit, but not much.
> 
> Shouldn't that be regarded as a bug/deprecated?
> 
> I'm not sure what the above "scedule_timeout(HZ/10)" is supposed to
> do, but the parameter it gets in 1000hz is "100" so I assume this
> is because we want to wait for 100ms, and in 1000hz that equals
> 100 cycles. Correct?

schedule_timeout() specifies a sleep in jiffies -- it's actually a
rather annoying interface for the very reason that it depends on the
value of HZ how *long* you actually will sleep for (in human time
units). So your assumption is incorrect, presuming the code author
knows what they are doing. They wish to sleep for 1/10 the number of
timer ticks in a second. What this translates to, though, clearly
depends on HZ. Thus

msleep{,_interruptible}(100);

would be far better to use (it calls schedule_timeout() correctly
[another thing not done often]). Also, if you look carefully at the
timer code, you'll notice that the x86 timer frequency is not actually
1000 Hz, it's actually less. Thus you run into issues with timer
intervals... But, in any case, specifying a timeout of 100 msecs is
different then specifying a timeout of 100 cycles on x86. I'm not sure
what it exactly translates to, but it will be more. Hence, you should
use msleep() not schedule_timeout() directly. Jiffies should not be
what you base your timing on; msecs & secs are easier and less likely
to be misused.

> then in the rest of the code we can use ex:
> schedule_timeout(varX*100) for 100ms no matter what hz is.

No, please don't. Use msleep() or msleep_interruptible(). Let the
conversion functions take care of the conversions.

> With hz=50 then the lowest ms is 20 for one tick though. And that
> might trigger problems with approximation at some point.
> varX would have to be decimal, and that might also be a problem?

No floating point in the kernel...

-Nish
