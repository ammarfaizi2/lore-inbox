Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVASN50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVASN50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 08:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVASN5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 08:57:11 -0500
Received: from alog0324.analogic.com ([208.224.222.100]:10624 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261724AbVASN4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 08:56:13 -0500
Date: Wed, 19 Jan 2005 08:56:00 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Robert White <rwhite@casabyte.com>
cc: "'john stultz'" <johnstul@us.ibm.com>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: New Linux System time proposal
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAo+V6scX9e0yTLGWCQJDW1QEAAAAA@casabyte.com>
Message-ID: <Pine.LNX.4.61.0501190834340.10191@chaos.analogic.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAo+V6scX9e0yTLGWCQJDW1QEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Robert White wrote:

> I thought it was not at all unusual to miss a jiffy here or there due
> to interrupt
> locking/latency; plus jiffies is expressed with respect to the value
> of HZ so you
> would need to do some deviding in there somewhere.
>

Makes no difference. The idea is that jiffies __never__ gets changed,
ever.


> Where HZ has been adjusted up, or on slower embedded boxes where
> interrupts could be
> blocked longer, you would lose time.
>

No difference. We should never touch the count in the master timer,
jiffies. Never, never, ever.

> Or are you not talking about real-word time?
>

That's what I said. When you need to read real-world time,
you read the sum of bootime, time_adj, and jiffies. The
time is read in the most natural dimension, not necessarily
microsconds, it could be micro-croak-farts, a number dimension
that results in the least number of lossy conversions.

Boot time is read from the RTC (or other hardware clock) upon
boot and never changed. Jiffies starts at 0 upon boot. Time_adj
starts at 0 upon boot, but once the system is up it gets adjusted
when the machine is set to some outside reference. This parameter
is the only element that is ever adjusted. This is the only
element that ever needs to be protected with a lock. It can
certainly be dynamically adjusted (like adjtime) as well, but
that's some other variables.


Currently, if you do:


extern void gettimeofday(void *);	// Phony, yes
int main()
{
     int foo[0x10];
     for(;;)
         gettimeofday(foo); 
}

An ordinary user can slow the system time about 10 seconds per
hour doing this! I don't know if this qualifies as a DOS, but
it isn't "nice".

> Rob White,
> Casabyte, Inc.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
