Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbWJKXDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbWJKXDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWJKXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:03:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161201AbWJKXDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:03:35 -0400
Date: Wed, 11 Oct 2006 16:03:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
Message-Id: <20061011160328.f3e7043a.akpm@osdl.org>
In-Reply-To: <1160606911.5973.36.camel@localhost.localdomain>
References: <1160596462.5973.12.camel@localhost.localdomain>
	<20061011142646.eb41fac3.akpm@osdl.org>
	<1160606911.5973.36.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 15:48:31 -0700
john stultz <johnstul@us.ibm.com> wrote:

> > Wouldn't it be better to fix the livelock?  What's causing it?
> 
> I spent a few days trying to narrow this down, and I haven't been able
> to do so to my satisfaction.
> 
> At this point, my suspicion is that because the PIT io-read is very slow
> (~18us), and done while holding a lock. It would be possible that one
> cpu calling gettimeofday would do the following:
> 
> grab xtime sequence read lock
> grab i8253 spin lock
> do port io (very slow)
> release i8253 spin lock
> realize xtime has been grabed and repeat
> 
> While another cpu does the following after in a timer interrupt:
> Grabs xtime sequence write lock
> spins trying to grab i8253 spin lock
> 
> Assuming the first thread can reacquire the i8253 lock before the
> second, you could have both threads potentially spinning forever.

Is there any actual need to hold xtime_lock while doing the port IO?  I'd
have thought it would suffice to do

	temp = port_io
	write_seqlock(xtime_lock);
	xtime = muck_with(temp);
	write_sequnlock(xtime_lock);

?
