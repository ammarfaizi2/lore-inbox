Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263249AbTCUCkd>; Thu, 20 Mar 2003 21:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbTCUCkc>; Thu, 20 Mar 2003 21:40:32 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:49598 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S263249AbTCUCj4>; Thu, 20 Mar 2003 21:39:56 -0500
Date: Thu, 20 Mar 2003 18:50:46 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: george anzinger <george@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
Message-ID: <20030321025045.GX2835@ca-server1.us.oracle.com>
References: <3E7A59CD.8040700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7A59CD.8040700@mvista.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 04:16:13PM -0800, george anzinger wrote:
> Define CLOCK_MONOTONIC to be the same as
> (gettimeofday() + wall_to_monotonic).
> ...
> Both clocks will tick at the same rate, even under NTP corrections.
> The conversion is a simple (well almost simple) add.
> Both clocks will have the same resolution.

	The issue for CLOCK_MONOTONIC isn't one of resolution.  The
issue is one of accuracy.  If the monotonic clock is ever allowed to
have an offset or a fudge factor, it is broken.  Asking the monotonic
clock for time must always, without fail, return the exact, accurate
time since boot (or whatever sentinal time) in the the units monotonic
clock is using.  This precludes gettimeofday().
	If the system is delayed (udelay() or such) by a driver or 
something for 10 seconds, then you have this (assume gettimeofday is
in seconds for simplicity):

1    gettimeofday = 1000000000
2    driver delays 10s
3    gettimeofday = 1000000000
4    timer notices lag and adjusts
5    gettimeofday = 1000000010

	In the usual case, if a program calls gettimeofday() between 3
and 4, the program gets the wrong time.  For most programs, this doesn't
matter.  CLOCK_MONOTONIC is designed for those uses where it absolutely
matters.  If an application queries CLOCK_MONOTONIC at 3.5, it must
return 1000000010, not 1000000000.

Joel
-- 

"A narcissist is someone better looking than you are."  
         - Gore Vidal

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
