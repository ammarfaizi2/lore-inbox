Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbULCI52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbULCI52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 03:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbULCI52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 03:57:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:7873 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262089AbULCI5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 03:57:25 -0500
Date: Fri, 3 Dec 2004 00:56:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: johnstul@us.ibm.com, herbert@13thfloor.at, linux-kernel@vger.kernel.org
Subject: Re: do_posix_clock_monotonic_gettime() returns negative nsec
Message-Id: <20041203005646.077e2e34.akpm@osdl.org>
In-Reply-To: <41B02749.70900@mvista.com>
References: <20041203020357.GA28468@mail.13thfloor.at>
	<1102042850.13294.43.camel@cog.beaverton.ibm.com>
	<41B02749.70900@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
>  > George: You have any comment?
> 
>  Two, in fact.  First, the result here is the sum of wall_to_monotonic and 
>  getnstimeofday().  If nsec < 0, one or more of these must be also.  Both of 
>  these values are SUPPOSED to be normalized.

As Herbert points out, hpet_time_init() and time_init() and who knows what
else do:

	wall_to_monotonic.tv_sec = -xtime.tv_sec;
	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;

And this:

 * The current time 
 * wall_to_monotonic is what we need to add to xtime (or xtime corrected 
 * for sub jiffie times) to get to monotonic time.  Monotonic is pegged at zero
 * at zero at system boot time, so wall_to_monotonic will be negative,
 * however, we will ALWAYS keep the tv_nsec part positive so we can use
 * the usual normalization.

So I assume the bug is that time_init() is failing to normalise
wall_to_monotonic?
