Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVASR4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVASR4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVASRwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:52:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38439
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261804AbVASRtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:49:02 -0500
Date: Wed, 19 Jan 2005 18:48:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@suse.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119174858.GB12647@dualathlon.random>
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119171323.GB14545@atomide.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 38 12 CD 76 E4 82 94 AF 02 0C 0F FA E1 FF 55 9D 9B 4F A5 9B
X-Cpushare-SSL-MD5-Cert: ED A5 F2 DA 1D 32 75 60 5E 07 6C 91 BF FC B8 85
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:13:23AM -0800, Tony Lindgren wrote:
> HZ=100 does not allow improving the idle loop much further
> from what we have. We should be able to take advantage of the
> longer idle/sleep periods inbetween the skipped ticks.

OTOH servers aren't just doing idle power saving, if you're computing
wasting 1% of your cpu isn't always desiderable.

You'd need to trap into add_timer to make it a truly dynamic timer, only
then it would obsolete the HZ=100. So if there's no timer you run at
HZ=100, while if there's some timer pending in the next 10 timer queues
you run at HZ=1000.

The main problem I can see with your patch is the accuracy issue with
the system time. I couldn't fix the algorithm you're depending on to get
accurate system time, and I can guarantee such algorithm never worked
accurately here and worst of all it doesn't printk anything (which is
why it doesn't printk for your patch), so you only see system time go in
the future at an excessive rate (minutes per hour IIRC).

Pavel posted the cli/sti script, that should allow to reproduce the
inaccuracy of the algorithm. I had to set HZ=100 by hand to workaround
the usb modem irq latency that is about 3/4 msec.

Once in a while such algorithm overstates the number of ticks that have
been missed, and so the system time goes 1msec in the future when that
happens. I still suspect there might be a bug in such code though.
There's an unfixable window between the latch read and the tsc
read where an error can happen, but as long as the window is below
0.5msec, it should always be possible to regenerate the accurate timing
with the current algo, but in practice it fails to be accurate...
