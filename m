Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbVISWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbVISWRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbVISWRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:17:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34773
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932683AbVISWRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:17:04 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 20 Sep 2005 00:17:12 +0200
Message-Id: <1127168232.24044.265.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 15:03 -0700, Christoph Lameter wrote:
> On Mon, 19 Sep 2005 tglx@linutronix.de wrote:
> 
> > sources. Another astonishing implementation detail of the current time 
> > keeping is the fact that we get the monotonic clock (defined by POSIX as 
> > a continous clock source which can not be set) by subtracting a variable 
> > offset from the real time clock, which can be set by the user and 
> > corrected by NTP or other mechanisms.
> 
> The benefit or drawback of that implementation depends which time is more 
> important: realtime or monotonic time. I think the most used time value is 
> realtime and not monotonic time. Having the real time value in xtime 
> saves one addition when retrieving realtime. 

Thats only partially true. 

Granted, the most used time in user space is clock_realtime
(gettimeofday() / clock_gettime(CLOCK_REALTIME). 

But do we really want to discuss one add instruction ?

The most used time in kernel space is clock_monotonic. 
Thats partially a result of the rather odd POSIX specs regarding
relative CLOCK_REALTIME timers. 

Also the basic prerequisite for for high resolution timers is a fast and
simple access to clock_monotonic rather than to a backward corrected
clock_realtime representation. 

Kernel code speed in hot pathes must have precedence over code executed
on behalf of userspace if its not completely out of bounds. One add/sub
is definitely not.

We should rather ask glibc people why gettimeofday() / clock_getttime()
is called inside the library code all over the place for non obvious
reasons.

tglx


