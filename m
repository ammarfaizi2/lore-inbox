Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277129AbRJLArD>; Thu, 11 Oct 2001 20:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277130AbRJLAqo>; Thu, 11 Oct 2001 20:46:44 -0400
Received: from pD4B9D6E9.dip.t-dialin.net ([212.185.214.233]:65298 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S277129AbRJLAqc> convert rfc822-to-8bit;
	Thu, 11 Oct 2001 20:46:32 -0400
Message-ID: <3BC63D38.AF65AAF5@baldauf.org>
Date: Fri, 12 Oct 2001 02:45:44 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: "'adilger@turbolabs.com'" <adilger@turbolabs.com>
CC: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'xuan--lkml@baldauf.org'" <xuan--lkml@baldauf.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: dynamic swap prioritizing
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9E013@ATL_MS1> <20011010095536.C10443@turbolinux.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"'adilger@turbolabs.com'" wrote:

> On Oct 10, 2001  11:23 -0400, Venkatesh Ramamurthy wrote:
> > > If this is to be generally useful, it would be good to find things
> > > like max sequential read speed, max sequential write speed, and max
> > > seek time (at least). Estimates for max sequential read speed and
> > > seek time could be found at boot time for each disk relatively
> > > easily, but write speed may have to be found only at runtime (or
> > > it could all be fed in to the kernel from user space from benchmarks
> > > run previously).
> >
> > Maybe we can find out the statistics for the first time (or when swap is
> > created) and store this information in the swap partition itself. This would
> > allow us to compute time consuming statistics only once. Also we need to
> > create new fields in the swap structure for this purpose.
>
> I'd rather just have the statistic data in a regular file for ALL disks,
> and then send it to the kernel via ioctl or write to a special file that
> the kernel will read from.  I don't think it is critical to have this
> data right at boot time, since it would only be used for optimizing I/O
> access and would not be required for a disk to actually work.
>
> Cheers, Andreas

Hey people,

why do you want to separate statistics data out? The statistics are not about disk
throughput, head seek times, etc. They are just about the time between "needing a
page" and "getting that page", which is very abstract. Let's call it the
swapin-delay. It does not only depend on disk-throughput and head seek times, but
also on "device business".

For every swap device, there is a "swap_business" data structure, which covers a
- average_swapin_delay
- average_swapin_delay_last_write_timestamp /* timestamp where swapin_delay was
last written */

There is a "swap_business_memory_timeout" kernel parameter (accessible via /proc)
which represents the length of a time interval from now into the past. This
interval is to be used as the time interval where gathered disk activity data
should be used for reasoning swap decisions of the future.

For every page fault which requires a page to be swapped in, a timestamp is
written to a datastructure covering the swapin process. When the page is ready
available in memory, a function is called which does following:
- compute the current_swapin_delay for the current swapin
- my_swap_device->average_swapin_delay = (current_swapin_delay * (now -
average_swapin_delay_last_write_timestamp) + my_swap_device->average_swapin_delay
* (average_swapin_delay_last_write_timestamp - (now -
swap_business_memory_timeout))/swap_business_memory_timeout;

There are some special cases like "no disk activity". In this case, swap_business
is not updated for that device. But maybe the reason for no disk activity is that
the disk is a swap disk and the values of "swap_business" where once so bad that
this device will not be considered anymore. That would be a "soft deadlock"...

On swapout, the "average_swapin_delay" fields of every "swap_business" data
structure of every swap device is compared against same field of other available
swap devices. According to these comparision, a decision is made where to do the
next swapout to.

Because that framework only can bring advantages if there are at least two swap
devices, it can be skipped for the one-swap-device-case (most setups do not have
more than one swap device, but maybe just because the 32MB or 64MB graphics card
(with plenty of mostly unused RAM) needs to be manually configured for swap...)

I hope that you get the concept more closer. I cannot see reasons why to create
such statistics in advance and feed them to the kernel somehow. For dynamic
systems, you need dynamic statistics, I think. And "the statistics", in fact, only
consist of two variables per swap device. Not something the kernel should not be
able to manage in reasonable time.

Of course, such a feature should be tested for real advantages

Xuân.


