Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264302AbTDKGxz (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 02:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTDKGxz (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 02:53:55 -0400
Received: from palrel13.hp.com ([156.153.255.238]:22745 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264302AbTDKGxy (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 02:53:54 -0400
Date: Fri, 11 Apr 2003 00:05:36 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304110705.h3B75aQt026081@napali.hpl.hp.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: too much timer simplification...
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to me that this changeset:

  http://linux.bkbits.net:8080/linux-2.5/diffs/kernel/timer.c@1.48

may have gone a little too far.

What I'm seeing is that if someone happens to arm a periodic timer at
exactly 256 jiffies (as ohci happens to do on platforms with HZ=1024),
then you end up getting an endless loop of timer activations, causing
a machine hang.

The problem is that __run_timers updates base->timer_jiffies _before_
running the callback routines.  If a callback re-arms the timer at
exactly 256 jiffies, add_timers() will reinsert the timer into the
list that we're currently processing, which of course will cause the
timer to expire immediately again, etc., etc., ad naseum...

I'll leave it as an exercise to the readers to come up with the proper
patch.  (The old code looked fine to me.  My cheesy quick workaround
is to round up 256 ticks to 257 ticks; might not make the soft RT
folks too happy though... ;-)

	--david
