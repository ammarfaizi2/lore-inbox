Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUKLKHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUKLKHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 05:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUKLKHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 05:07:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2568 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262238AbUKLKHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 05:07:37 -0500
Date: Fri, 12 Nov 2004 11:07:32 +0100
From: Willy Tarreau <willy@w.ods.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_PM_TIMER is slow
Message-ID: <20041112100732.GA12845@alpha.home.local>
References: <Pine.LNX.4.61.0411112143200.1846@twinlark.arctic.org> <20041112060413.GF783@alpha.home.local> <Pine.LNX.4.61.0411112208180.24919@twinlark.arctic.org> <20041112070611.GA12474@alpha.home.local> <Pine.LNX.4.61.0411112339100.24919@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411112339100.24919@twinlark.arctic.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 11:43:14PM -0800, dean gaudet wrote:
 > >         do {
> > >                 v1 = inl(pmtmr_ioport);
> > >                 v2 = inl(pmtmr_ioport);
> > >                 v3 = inl(pmtmr_ioport);
> > >         } while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
> > >                         || (v3 > v1 && v3 < v2));
> > 
> > Just a thought : have you tried to check whether it's the recovery time
> > after a read or read itself which takes time ?
> 
> each read is ~0.8us ... the loop only runs once.

OK, but here, 2 of these 3 reads are done after another one.
For example, does it change anything to add something like this :

do {
   volatile int slow;
   v1 = inl(pmtr_ioport);
   for (slow = 500; slow--;);
   v2 = inl(pmtr_ioport);
   for (slow = 500; slow--;);
   v3 = inl(pmtr_ioport);
} while ...

If it does not change anything, then it means that there is a recovery
time after a read, which would imply that the 3 back-to-back reads are
more harmful than it seems.

> > Other thought : is it possible to memory-map this timer to avoid the slow
> > inl() on x86 ?
> 
> that's how the even newer HPET works ... but not all systems have HPET.

OK, thanks for the info, I didn't know about that.

Regards,
Willy

