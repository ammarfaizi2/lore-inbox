Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVASW7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVASW7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVASW7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:59:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11002 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261955AbVASW7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:59:25 -0500
Message-ID: <41EEE648.2010309@mvista.com>
Date: Wed, 19 Jan 2005 14:59:20 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@suse.cz>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random>
In-Reply-To: <20050119174858.GB12647@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Jan 19, 2005 at 09:13:23AM -0800, Tony Lindgren wrote:
> 
>>HZ=100 does not allow improving the idle loop much further
>>from what we have. We should be able to take advantage of the
>>longer idle/sleep periods inbetween the skipped ticks.
> 
> 
> OTOH servers aren't just doing idle power saving, if you're computing
> wasting 1% of your cpu isn't always desiderable.
> 
> You'd need to trap into add_timer to make it a truly dynamic timer, only
> then it would obsolete the HZ=100. So if there's no timer you run at
> HZ=100, while if there's some timer pending in the next 10 timer queues
> you run at HZ=1000.
> 
> The main problem I can see with your patch is the accuracy issue with
> the system time. I couldn't fix the algorithm you're depending on to get
> accurate system time, and I can guarantee such algorithm never worked
> accurately here and worst of all it doesn't printk anything (which is
> why it doesn't printk for your patch), so you only see system time go in
> the future at an excessive rate (minutes per hour IIRC).
> 
> Pavel posted the cli/sti script, that should allow to reproduce the
> inaccuracy of the algorithm. I had to set HZ=100 by hand to workaround
> the usb modem irq latency that is about 3/4 msec.
> 
> Once in a while such algorithm overstates the number of ticks that have
> been missed, and so the system time goes 1msec in the future when that
> happens. I still suspect there might be a bug in such code though.
> There's an unfixable window between the latch read and the tsc
> read where an error can happen, but as long as the window is below
> 0.5msec, it should always be possible to regenerate the accurate timing
> with the current algo, but in practice it fails to be accurate...
> -
I don't think you will ever get good time if you EVER reprogramm the PIT.  That 
is why the VST patch on sourceforge does NOT touch the PIT, it only turns off 
the interrupt by interrupting the interrupt path (not changing the PIT).  This 
allows the PIT to be the "gold standard" in time that it is designed to be.  The 
wake up interrupt, then needs to come from an independent timer.  My patch 
requires a local APIC for this.  Patch is available at 
http://sourceforge.net/projects/high-res-timers/

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

