Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTL3VsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbTL3VsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:48:06 -0500
Received: from intra.cyclades.com ([64.186.161.6]:32209 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265110AbTL3VsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:48:02 -0500
Date: Tue, 30 Dec 2003 19:46:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Daniel Tram Lux <daniel@starbattle.com>, steve@drifthost.com
Cc: Linus Torvalds <torvalds@osdl.org>, James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set released
In-Reply-To: <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
Message-ID: <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet> <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel, Steve,

Linus believes the reason for the "no DRQ after issuing WRITE" (and
further problems caused by it) is the too small timeout used in
ide_wait_stat().

Can you guys please change this line in include/linux/ide.h

#define WAIT_DRQ        (5*HZ/100)      /* 50msec - spec allows up to 20ms */

to

#define WAIT_DRQ	(5*HZ/50)

And check if that makes the problem go away?

On Tue, 30 Dec 2003, Linus Torvalds wrote:

> I suspect that anything in IDE that uses that idiotic "local_irq_set()"
> macro is just broken, and should be rewritten to explicitly enable
> interrupts. As it is, the code is just incredibly _strange_, and it
> actually enables interrupts at all the wrong places.
>
> Anyway, in ide_wait_stat(), the "timeout" value is always either
> "WAIT_DRQ" (5*HZ/100) or it is "WAIT_READY" (3*HZ/100). And look at
> WAIT_READY a bit more:
>
> 	#if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
> 	#define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very slow */
> 	#else
> 	#define WAIT_READY      (3*HZ/100)      /* 30msec - should be instantaneous */
> 	#endif /* CONFIG_APM || CONFIG_APM_MODULE */
>
> I bet that the _real_ problem is this. That "3*HZ/100" value is just too
> damn short. It has already been increased to 5*HZ for anything that has
> APM enabled, but anybody who doesn't use APM gets a _really_ short
> timeout.
>
> My suggestion: change the non-APM timeout to something much larger. Make
> it ten times bigger, rather than leaving it at a value that us so small
> that a single interrupt could make a difference..
>
> In fact, right now a single timer interrupt on 2.4.x is the difference
> between waiting 20ms and 30ms. That's a _big_ relative difference.

Small correction: people are not hitting the WAIT_READY (they are hitting
the problem from ide-disk.c, which uses WAIT_DRQ). But still...

