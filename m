Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbULMMzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbULMMzC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbULMMxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:53:34 -0500
Received: from linux2.isphuset.no ([213.236.237.186]:24199 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S262252AbULMMv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:51:26 -0500
Subject: Re: dynamic-hz
From: Hans Kristian Rosbach <hk@isphuset.no>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041213112229.GS6272@elf.ucw.cz>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <20041213030237.5b6f6178.akpm@osdl.org>
	 <1102936790.17227.24.camel@linux.local>  <20041213112229.GS6272@elf.ucw.cz>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1102942270.17225.81.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Dec 2004 13:51:11 +0100
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hk@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 12:22:29PM +0100, Pavel Machek wrote:
> I tried defining HZ to 10 once, and there are some #if arrays in the
> kernel that prevented me from doing that.
> 
> Some drivers do timeouts based on jiffies; having HZ=1 may turn 20msec
> timeout into 1sec, that could hurt a lot in the error case...

On Mon, Dec 13, 2004 at 03:25:21AM -0800, Andrew Morton wrote:
> We still have 1000-odd places which do things like
>        schedule_timeout(HZ/10);
> which will now involve a runtime divide.  The propagation of msleep()
> and ssleep() will reduce that a bit, but not much.

Shouldn't that be regarded as a bug/deprecated?

I'm not sure what the above "scedule_timeout(HZ/10)" is supposed to
do, but the parameter it gets in 1000hz is "100" so I assume this
is because we want to wait for 100ms, and in 1000hz that equals
100 cycles. Correct?

If so, I guess this calculation would fix that problem, but I guess
this is also what Andrew referred to as the extra runtime division?

wait-ms/(1000/hz) = hz-to-wait
100/(1000/1000) = 100 == 100ms
100/(1000/100)  = 10  == 100ms
100/(1000/50)   = 5   == 100ms

It would of course be optimized to something like this:
wait-ms/ms-per-hz

What about this:
At startup time we set a global variable based on hz:
varX = HZ/1000;

then in the rest of the code we can use ex:
schedule_timeout(varX*100) for 100ms no matter what hz is.

With hz=50 then the lowest ms is 20 for one tick though. And that
might trigger problems with approximation at some point.
varX would have to be decimal, and that might also be a problem?

I think that extremists will push the limits on these settings,
and that failure due to wrong timouts or other similar things
would generate unwanted noise on LKML.

I think I'm just stating about the obvious now, am I not?

-HK

