Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUAFRF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUAFRF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:05:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:30856 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264542AbUAFRFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:05:19 -0500
Date: Tue, 6 Jan 2004 09:05:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
Message-Id: <20040106090521.4a7ad2a0.akpm@osdl.org>
In-Reply-To: <1073406369.2047.33.camel@mulgrave>
References: <1073405053.2047.28.camel@mulgrave>
	<20040106081947.3d51a1d5.akpm@osdl.org>
	<1073406369.2047.33.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Tue, 2004-01-06 at 10:19, Andrew Morton wrote:
> > Hm, OK.  I hit the same deadlock when running with the "don't require TSCs
> > to be synchronised in sched_clock()" patch from -mm.  The fix for that is
> > below.  I shall accelerate it.
> 
> Actually, I think we need to know why this is happening, since the use
> of these sequence locks is growing.

That would be nice.  Can you get a backtrace?

> On voyager I just put it down to HZ
> == 1000 being a bit much for my old pentium 66MHz processors, but if
> you've seen it on a much faster processor, that would tend to indicate
> there's some other problem at work here.

No, it was much simpler in my case: log_buf_len_setup() was accidentally
enabling interrupts early in boot and we were taking a timer interrupt
while holding a write lock on xtime_lock.  sched_clock() was requiring a
read lock and boom.

