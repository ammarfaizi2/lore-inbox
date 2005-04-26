Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVDZXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVDZXpI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVDZXpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 19:45:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31736 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261849AbVDZXou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 19:44:50 -0400
Message-ID: <426ED1EC.80500@mvista.com>
Date: Tue, 26 Apr 2005 16:42:36 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ingo@mvista.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: del_timer_sync needed for UP  RT systems.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

In tracking down the failure of a system running the RT patch we have found a 
preemption between the time run_timer_list clears its spinlock and the call back 
function (in this case in posix-timers.c) gets its spinlock.  The bad news is 
that it is possible for the timer to be released at this point leaving the call 
back code with a pointer to a bogus timer.

This was/is possible, of course, in SMP systems and is why del_timer_sync() 
exists.  I suspect that del_timer_sync() needs to also do the "right thing" in 
UP RT systems.

This means removing the #ifdef CONFIG_SMP at about line 56 of kernel/timer.c 
thus setting up base->running_timer in all cases (or at least in SMP and RT 
cases) and also the #ifdef CONFIG_SMP around del_timer_sync() and, of course, 
the defines that redirect calls to these functions.

Does this make sense?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
