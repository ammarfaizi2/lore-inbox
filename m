Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbTIFIJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 04:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbTIFIJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 04:09:15 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:3742 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265179AbTIFIJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 04:09:12 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dale Harris <rodmur@maybe.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030906040904.GM29466@maybe.org>
References: <20030906040904.GM29466@maybe.org>
Message-Id: <1062835714.824.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 06 Sep 2003 10:08:34 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: compile problems on PPC for 2.6.0-test4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-06 at 06:09, Dale Harris wrote:
> This is a PowerBook G4, debian unstable, gcc-2.95.4
> 
> A couple of compile warnings errors:
> 
>   CC      drivers/macintosh/via-pmu.o
> drivers/macintosh/via-pmu.c: In function `powerbook_sleep_grackle':
> drivers/macintosh/via-pmu.c:2465: warning: integer overflow in expression
> drivers/macintosh/via-pmu.c: In function `powerbook_sleep_Core99':
> drivers/macintosh/via-pmu.c:2557: warning: integer overflow in expression

It's barking on mdelay(5000) which is a debug thing (when you pass
'fake_sleep' to the kernel, it will stop 5 seconds in there then wakeup
instead of letting the PMU shut the CPU down, it's useful for debugging
driver sleep code.

It shoud not be failing on this though:

#define mdelay(n) (\
	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))

The __builtin_constant_p(5000) && (5000)<=5 test should fail thus
turning into a loop of udelay(1000). Your gcc seems to be screwing
it up. What version are you using ?
 
>   CC      drivers/net/sungem.o
> drivers/net/sungem.c:2444: duplicate initializer
> drivers/net/sungem.c:2444: (near initialization for
> `gem_ethtool_ops.get_link')
> make[3]: *** [drivers/net/sungem.o] Error 1
> make[2]: *** [drivers/net] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/usr/src/linuxppc-2.6'

The current bk snapshot I have here doesn't have a problem at this line.
> 
> Also the planb video 4 linux driver doesn't seem to be compiling either.
> I failed to save the error messages.  

I'll check that out, thanks.

Ben.


