Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbVKBVmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbVKBVmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbVKBVmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:42:03 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:46562 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965266AbVKBVmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:42:01 -0500
Subject: 2.6.14-rt4:  __get_nsec_offset() false positives
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20051030133316.GA11225@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 13:41:42 -0800
Message-Id: <1130967703.27168.503.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ingo,
	I just booted 2.6.14-rt4 and I'm getting lots of the
__get_nsec_offset() warnings where there isn't really a problem.

The main issue is that the clocksource may not be a TSC (acpi_pm in my
case), so the check to see if the cycle value ever goes backwards will
falsely trigger when the 24bit wide ACPI PM counter wraps.

To properly check for algorithmic inconsistencies, the checks should
probably be similar to what you had earlier inside
__get_monotonic_clock(), since at __get_nsec_offset() you really don't
have enough information to sort out if an inconsistency has occurred.

If we want to watch for hardware inconsistencies (like unsynced TSCs),
those checks really need to go inside the clocksource drivers
themselves. 

I'll write up a paranoid debug patch that provides similar checks for
both cases and include it in my patch set so you don't have to keep
forward porting your own versions. 

thanks
-john






