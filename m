Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUFGI43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUFGI43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 04:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUFGI43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 04:56:29 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:42954 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261939AbUFGI40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 04:56:26 -0400
Date: Mon, 7 Jun 2004 10:56:25 +0200
From: bert hubert <ahu@ds9a.nl>
To: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: BUG in ht-aware scheduler/nice in 2.6.7-rc2 on dual xeon
Message-ID: <20040607085625.GA11276@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, kernel@kolivas.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con, Ingo, List,

I'm overjoyed with decent ht-aware scheduling in 2.6.7-rc2 and it does
mostly the right thing. However, the 'nice' work by Con shows some slight
problems.

Please find attached program 'eat-time.cc'. Make sure not to compile it with
-O which might confuse things as this program basically does nothing.

Run it without arguments to determine the speed of 1 cpu, it outputs a
number (megaloops/second). Then start it with that number as a parameter:

Sample:

$ ./eat-time
592
$ ./eat-time 592
99%
99%
100%
etc

Now starting four of these at the same time gives the desired result:

$ ./eat-time 592 & ./eat-time 592 & ./eat-time 592 & ./eat-time 592
50%
50%
50%
50% 
etc

This however:

$ ./eat-time 592 & ./eat-time 592 & 
100%
99%
In another xterm:
$ nice -n +19 ./eat-time 592 & nice -n +19 ./eat-time 592
5%
5%
5%

Fails sometimes, with all processes getting 50%. The above 'screenshot' is
from the working and expected situation, which happens most of the time.

When it goes wrong, top shows me that Cpu0 and Cpu1 are 100% user, while
Cpu2 and Cpu3 are both 100% nice.  The niced processes show up in top as
PRiority 39, the unniced ones (NI = 0) as PR 25.

I've also seen it that Cpu2 and Cpu3 are 100% busy, and 0 and 1 are 100%
nice.

I'd say this situation happens once every 5 or 8 invocations, and perhaps
somewhat more when first starting the niced processes.

Perhaps related, when running the above 'nice -n +19' line on its own, I see
all CPUs getting load over time, the two processes are wandering. After a
while they settle down, only to go on wandering again some time later, also
touching configurations where a physical cpu suddenly hosts two processes.

Without nice, two processes get firmly pegged to different physical CPUs.

Anything I can do to help resolve this, just yell.

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
