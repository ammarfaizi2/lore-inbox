Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279321AbRJWID2>; Tue, 23 Oct 2001 04:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279320AbRJWIDT>; Tue, 23 Oct 2001 04:03:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7668 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S279319AbRJWIDN>; Tue, 23 Oct 2001 04:03:13 -0400
Message-ID: <3BD52454.218387D9@mvista.com>
Date: Tue, 23 Oct 2001 01:03:32 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How should we do a 64-bit jiffies?
In-Reply-To: <1164.1003813848@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 22 Oct 2001 08:12:24 -0700,
> george anzinger <george@mvista.com> wrote:
> >I am working on POSIX timers where there is defined a CLOCK_MONOTONIC.
> >The most reasonable implementation of this clock is that it is "uptime"
> >or jiffies.  The problem is that it is most definitely not MONOTONIC
> >when it rolls back to 0 :(  Thus the need for 64-bits.
> 
> If you want to leave existing kernel code alone so it still uses 32 bit
> jiffies, just maintain a separate high order 32 bit field which is only
> used by the code that really needs it.  On 32 bit machines, the jiffie
> code does
> 
>   old_jiffies = jiffies++;
>   if (jiffies < old_jiffies)
>         ++high_jiffies;
> 
> You will need a spin lock around that on 32 bit systems, but that is
> true for anything that tries to do 64 bit counter updates on a 32 bit
> system.  None of your suggestions will work on ix86, it does not
> support atomic updates on 64 bit fields in hardware.

As it turns out I already have a spinlock on the update jiffies code. 
The reason one would want to use a 64-bit integer is that the compiler
does a MUCH better job of the ++, i.e. it just does an add carry.  No
if, no jmp.  I suppose I need to lock the read also, but it is not done
often and will hardly ever block.

I am beginning to think that defining a u64 and casting, i.e.:

#define jiffies (unsigned long volitial)jiffies_u64

is the way to go.

George
