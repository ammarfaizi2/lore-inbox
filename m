Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTBHAnD>; Fri, 7 Feb 2003 19:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbTBHAnD>; Fri, 7 Feb 2003 19:43:03 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:40926 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266932AbTBHAnC>; Fri, 7 Feb 2003 19:43:02 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20030208001844.GA20849@wotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
	 <p73ptq3bxh6.fsf@oldwotan.suse.de>
	 <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com>
	 <20030208001844.GA20849@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1044665441.18670.106.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Feb 2003 16:50:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 16:18, Andi Kleen wrote:
> Anyways my point stands - get_cycles should be only used when no
> wall time is needed, so I see no reason to complicate it and slow
> it down with external timers.

Because it (or some similar form) is needed. The hangcheck timer code
needs a method for reading a hard clock. 

I've talked it over with Joel and it became obvious that there was no
efficient and clean way to get do_gettimeofday to appropriately handle
the situation where we loose 60 seconds worth of ticks. Thus Joel needs
raw access to a hardware clock, so he used get_cycles() and
loops_per_jiffy to calculate a time interval. 

However this doesn't work on systems w/o a synced TSC, so by simply
making get_cycles() indirect to the TSC or cyclone implementation allows
it to do the right thing. It only minorly (extra pointer dereference and
call) affects non summit based boxes and returns (albeit slowly)
non-random values on summit based boxes. 

Now maybe if you'd really rather not change get_cycles, hangcheck_timer
could instead use a different interface to do the same indirection.
Would you have any gripes with that?

thanks for the feedback.
-john




