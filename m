Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUAFSxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUAFSxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:53:20 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:26005 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264879AbUAFSxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:53:19 -0500
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: johnstul@us.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040106090521.4a7ad2a0.akpm@osdl.org>
References: <1073405053.2047.28.camel@mulgrave>
	<20040106081947.3d51a1d5.akpm@osdl.org> <1073406369.2047.33.camel@mulgrave>
	 <20040106090521.4a7ad2a0.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Jan 2004 12:53:10 -0600
Message-Id: <1073415191.2047.63.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-06 at 11:05, Andrew Morton wrote:
> No, it was much simpler in my case: log_buf_len_setup() was accidentally
> enabling interrupts early in boot and we were taking a timer interrupt
> while holding a write lock on xtime_lock.  sched_clock() was requiring a
> read lock and boom.

Voyager has no APIC local timer equivalent, so I rebroadcast the timer
tick to all CPUs.  However, the local tick is done in this thread with
the xtime_lock held as write and it can trigger the scheduler load
balancing, which needs to call sched_clock()....boom.

All in all, this does show that the xtime sequence lock is a bit too
fragile.  It also seems to show that we should redo the subarch timer
hooks if we want to make the sequence locks work.

I think there should be two hooks: one called holding the xtime write
lock for doing clock adjustment specific things and the other called
after we've released the xtime write lock.

James


