Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVASWKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVASWKD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVASWIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:08:23 -0500
Received: from gprs215-106.eurotel.cz ([160.218.215.106]:18575 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261929AbVASWGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:06:44 -0500
Date: Wed, 19 Jan 2005 23:06:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119220637.GA7513@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119171106.GA14545@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > As this patch is related to the VST/High-Res timers, there
> > > are probably various things that can be merged. I have not
> > > yet looked at what all could be merged.
> > > 
> > > I'd appreciate some comments and testing!
> > 
> > Good news is that it does seem to reduce number of interrupts. Bad
> > news is that time now runs faster (like "sleep 10" finishes in ~5
> > seconds) and that I could not measure any difference in power
> > consumption.
> 
> Thanks for trying it out. I have quite accurate time here on my
> systems, and sleep works as it should. I wonder what's happening on
> your system? If you have a chance, could you please post the results
> from following simple tests?

Unpatched 2.6.11-rc1:

root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -b tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done | uniq
PCI: Setting latency timer of device 0000:00:11.5 to 64
19 Jan 22:53:20 ntpdate[7943]: step time server 195.113.144.238 offset 0.013070 sec
19 Jan 22:53:36 ntpdate[8169]: step time server 195.113.144.238 offset -0.005736 sec
19 Jan 22:53:51 ntpdate[8427]: step time server 195.113.144.238 offset -0.010292 sec
19 Jan 22:54:06 ntpdate[8647]: step time server 195.113.144.238 offset -0.045055 sec
19 Jan 22:54:21 ntpdate[8889]: step time server 195.113.144.238 offset 0.054865 sec
Wed Jan 19 22:54:31 CET 2005
Wed Jan 19 22:54:41 CET 2005
Wed Jan 19 22:54:41 CET 2005
Wed Jan 19 22:54:42 CET 2005
Wed Jan 19 22:54:43 CET 2005
Wed Jan 19 22:54:44 CET 2005
Wed Jan 19 22:54:45 CET 2005
Wed Jan 19 22:54:46 CET 2005
Wed Jan 19 22:54:47 CET 2005
Wed Jan 19 22:54:48 CET 2005
Wed Jan 19 22:54:49 CET 2005
Wed Jan 19 22:54:50 CET 2005
Wed Jan 19 22:54:51 CET 2005
Wed Jan 19 22:54:52 CET 2005
Wed Jan 19 22:54:53 CET 2005
Wed Jan 19 22:54:54 CET 2005
Wed Jan 19 22:54:55 CET 2005
Wed Jan 19 22:54:56 CET 2005

On patched 2.6.11-rc1:

[Heh, clock is two times too fast, perhaps that makes ntpdate fail? -- yes.

root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -b tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done | uniq
PCI: Setting latency timer of device 0000:00:11.5 to 64
dyn-tick: Enabling dynamic tick timer
dyn-tick: Timer using dynamic tick
19 Jan 22:59:16 ntpdate[1363]: no server suitable for synchronization found
19 Jan 22:59:25 ntpdate[1364]: no server suitable for synchronization found
19 Jan 22:59:34 ntpdate[1365]: no server suitable for synchronization found
19 Jan 22:59:42 ntpdate[1366]: no server suitable for synchronization found
19 Jan 22:59:51 ntpdate[1367]: no server suitable for synchronization found
Wed Jan 19 22:59:51 CET 2005
Wed Jan 19 23:00:01 CET 2005
Wed Jan 19 23:00:01 CET 2005
Wed Jan 19 23:00:02 CET 2005
Wed Jan 19 23:00:03 CET 2005
Wed Jan 19 23:00:04 CET 2005
Wed Jan 19 23:00:05 CET 2005
Wed Jan 19 23:00:06 CET 2005
Wed Jan 19 23:00:07 CET 2005
Wed Jan 19 23:00:08 CET 2005
Wed Jan 19 23:00:09 CET 2005
Wed Jan 19 23:00:10 CET 2005

I used -t 10 to force it to work. Notice that clock is two times too fast.

root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -t 10 tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done |
uniq
PCI: Setting latency timer of device 0000:00:11.5 to 64
dyn-tick: Enabling dynamic tick timer
dyn-tick: Timer using dynamic tick
19 Jan 23:03:27 ntpdate[20782]: step time server 195.113.144.238 offset -45.355081 sec
19 Jan 23:03:38 ntpdate[20784]: step time server 195.113.144.238 offset -9.592768 sec
19 Jan 23:03:47 ntpdate[20786]: step time server 195.113.144.238 offset -12.048951 sec
19 Jan 23:04:00 ntpdate[20788]: step time server 195.113.144.238 offset -8.273278 sec
19 Jan 23:04:08 ntpdate[20790]: step time server 195.113.144.238 offset -12.240673 sec
Wed Jan 19 23:04:18 CET 2005
Wed Jan 19 23:04:28 CET 2005
Wed Jan 19 23:04:28 CET 2005
Wed Jan 19 23:04:29 CET 2005
Wed Jan 19 23:04:30 CET 2005
Wed Jan 19 23:04:31 CET 2005
Wed Jan 19 23:04:32 CET 2005
Wed Jan 19 23:04:33 CET 2005
Wed Jan 19 23:04:34 CET 2005
Wed Jan 19 23:04:35 CET 2005
Wed Jan 19 23:04:36 CET 2005
Wed Jan 19 23:04:37 CET 2005
Wed Jan 19 23:04:38 CET 2005
Wed Jan 19 23:04:39 CET 2005
Wed Jan 19 23:04:40 CET 2005

Anything else I should try?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
