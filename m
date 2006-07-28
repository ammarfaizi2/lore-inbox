Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWG1DaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWG1DaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWG1DaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:30:05 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:5803 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751077AbWG1DaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:30:04 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Paul Mackerras <paulus@samba.org>
Cc: Andi Kleen <ak@suse.de>, Neil Horman <nhorman@tuxdriver.com>,
       a.zummo@towertech.it, jg@freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <17609.21005.415970.234577@cargo.ozlabs.ibm.com>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <p73bqrc5rbu.fsf@verdi.suse.de>
	 <17609.21005.415970.234577@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Organization: OLPC
Date: Thu, 27 Jul 2006 23:29:48 -0400
Message-Id: <1154057388.10570.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only awkward thing about the current interfaces is that you have to
go from seconds and microseconds, to milliseconds, but only really when
you represent time to X clients, which requires a bit of 64 bit of
math...    It is true that since you have two values in the timeval
structure, the update might require some sort of locking, which could be
a performance lose; but there are other simple solutions to that (e.g.
simple ring representations where you rely on the store of an index
value to be atomic without requiring full locks and increment the index
after updating both values, but a simple memory barrier), but those
implementation tricks should be hidden behind an interface, and not
exposed to application programmers..

In theory, that conversion to milliseconds only actually has to be done
if the time is (significantly) different.

I can't forsee that this is a big deal on (most of) today's machines.
Last I looked, the CPU runs the same speed in kernel mode as user
mode ;-).

On the other hand, the idea of a one off Linux specific "oh, there is
this magic file you mmap, and then you can poke at a magic location",
strikes me as a one-off hack, and that Linux would be better off
spending the same effort to speed up the general interface (which might
very well do this mmap trick trick behind the scenes, as far as I'm
concerned).

The difference is one is a standard, well known interface, which to an
application programmer has very well defined semantics; the other, to be
honest, is a kludge, which may expose applications to too many details
of the hardware.  For example, exact issues of cache coherency and
memory barriers differ between machines.
                                Regards,
                                    - Jim


If it's to be a kludge, it might as well be a X driver kludge (which is
where we put it in the '80's).




On Fri, 2006-07-28 at 09:53 +1000, Paul Mackerras wrote:
> Andi Kleen writes:
> 
> > No, no, it's wrong. They should use gettimeofday and the kernel's job
> > is to make it fast enough that they can. 
> 
> Not necessarily - maybe gettimeofday's seconds + microseconds
> representation is awkward for them to use, and some other kernel
> interface would be more efficient for them to use, while being as easy
> or easier for the kernel to compute.  Jim, was that your point?
> 
> Paul.
-- 
Jim Gettys
One Laptop Per Child


