Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCQUyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCQUyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVCQUyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:54:20 -0500
Received: from alog0156.analogic.com ([208.224.220.171]:39058 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261174AbVCQUxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:53:51 -0500
Date: Thu, 17 Mar 2005 15:51:25 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Coywolf Qi Hunt <coywolf@lovecn.org>
cc: "Peter W. Morreale" <peter_w_morreale@hotmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel memory limits?
In-Reply-To: <4239E4CC.7050007@lovecn.org>
Message-ID: <Pine.LNX.4.61.0503171532340.23212@chaos.analogic.com>
References: <BAY101-F3858D9AE9F3222CAB9AB3CC1490@phx.gbl>
 <Pine.LNX.4.61.0503171401030.22694@chaos.analogic.com> <4239E4CC.7050007@lovecn.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Coywolf Qi Hunt wrote:

> linux-os wrote:
>> On Thu, 17 Mar 2005, Peter W. Morreale wrote:
>> 
>>> (I did not see this addressed in the FAQs...)
>>> 
>>> How much physical memory can the 2.4.26 kernel address in kernel context 
>>> on x86?
>>> 
>> 
>> All of it.
>> 
>>> What about DMA memory?
>>> 
>> 
>> All of it, too. The old DMA controller(s) could only address 16 MB
>> because that's all the page-registers allowed. Bus-mastering DMA
>> off the PCI/Bus has no such limitation. Most have DMA controllers
>> that use scatter-lists so RAM doesn't even have to be contiguous,
>> only properly allocated (in pages) and nailed down with no caching.
>> 
>
> Kernel Image itself resides at physical address 1M. Is this kernel image
> area a hole to the old DMA range? Thanks.
>

No. DMA doesn't "know" about holes and it also doesn't "know"
about the CPU. The DMA controller(s) require the bus address of
RAM. Knowing that address, i.e., the physical to virtual mapping,
the DMA controllers can overwrite a kernel and anything else just
fine. For instance, one of the common PCI/Bus interface controllers
is the PLX PCI-9656BA. It can read or write to/from anywhere as
long as it is aligned properly. There is no protection possible
from a DMA controller. If it's been programmed to overwrite
your kernel, it will!

Some old motherboards may not map the RAM controller to all the bits
on the PCI/Bus, but that problem was fixed when people started using
AGP screen boards (the screen BIOS must be in low memory and it is
read out of the board).

Since DMA always bypasses any cache, if the CPU is expected to
access anything in the RAM just written by DMA, either that
address area must be set to non-cached or the cache(s) must be
flushed.

If you use a busmaster with scatter/gather, you can DMA to/from
RAM that is not contiguous. You just set up the scatter-list
properly and away you go. This is sometimes useful for buffers
that are contiguous when addressed in virtual mode, but are
obtained from paged-RAM scattered all over the place. The pages
need to be "reserved" so they are not stolen by the pager and
then they need to be set to no-cache so the DMA activity can
actually be "seen" by the CPU.

>
> 	Coywolf
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
