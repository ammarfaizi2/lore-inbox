Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVHYAZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVHYAZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHYAZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:25:11 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52207 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932417AbVHYAZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:25:10 -0400
Message-ID: <430D0FDA.3060201@mvista.com>
Date: Wed, 24 Aug 2005 17:24:58 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
Subject: Incorrect CLOCK_TICK_RATE in 2.6 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CLOCK_TICK_RATE	is used by the kernel to compute LATCH, TICK_NSEC and 
tick_nsec.  This latter is used to update xtime each tick.  TICK_NSEC is 
then used to compute (at compile time) the conversion constants needed 
to convert to/from jiffies from/to timespec and timeval (and others).

The problem is that, if the timer being used is either Cyclone or HPET, 
the wrong CLOCK_TICK_RATE is used.  This means that systems using these 
interrupt sources will be doing a) incorrect update of xtime and b) 
incorrect conversion of jiffies.  Since these two values will track each 
other this will not be seen by simple gettimeofday(); 
sleep();gettimeofday() tests, but will be seen as a system clock drift 
(without NTP) or with NTP, a somewhat high drift rate (to the point of 
loosing sync at HZ=1000).

The fact that the user/ system chooses the clock to use at boot time and 
can change the clock after boot means that it is not possible to pin 
down CLOCK_TICK_RATE at compile time.  However, since the computation of 
TICK_NSEC and the conversion constants is rather involved it is clear 
that we REALLY do want to compute these at compile time.

The suggested solution is to a) set up a structure with the default 
(clock of choice at config time) conversion constants in it at compile 
time.  Then b) at clock init time, populate the structure with the 
proper constants for the given clock.  These can be computed at compile 
time, but from the correct  CLOCK_TICK_RATE for the given clock. 
Switching to a fall back clock would also require an update of this 
structure.

Commits?
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
