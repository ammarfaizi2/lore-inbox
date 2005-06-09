Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVFIXdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVFIXdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVFIXdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:33:20 -0400
Received: from fmr21.intel.com ([143.183.121.13]:43997 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262429AbVFIXdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:33:07 -0400
Date: Thu, 9 Jun 2005 16:32:16 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Wiegley <jeffw@cyte.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@muc.de>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: amd64 cdrom access locks system
Message-ID: <20050609163216.A18636@unix-os.sc.intel.com>
References: <42A64556.4060405@cyte.com> <20050608052354.7b70052c.akpm@osdl.org> <42A861F8.9000301@cyte.com> <20050609160045.69c579d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050609160045.69c579d2.akpm@osdl.org>; from akpm@osdl.org on Thu, Jun 09, 2005 at 04:00:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 04:00:45PM -0700, Andrew Morton wrote:
> Jeff Wiegley <jeffw@cyte.com> wrote:
> >
> > warning: many lost ticks.
> > Your time source seems to be instable or some driver is hogging interupts
> > rip default_idle+0x24/0x30
> > Falling back to HPET
> > divide error: 0000 [1] PREEMPT
> > ...
> > RIP: 0010:[<ffffffff80112704>] <ffffffff80112704>{timer_interrupt+244}
> 
> The timer code got confused, fell back to the HPET timer and then got a
> divide-by-zero in timer_interrupt().  Probably because variable hpet_tick
> is zero.
> 
> - It's probably a bug that the cdrom code is holding interrupts off for
>   too long.
> 
>   Use hdparm and dmesg to see whether the driver is using DMA.  If it
>   isn't, fiddle with it until it is.
> 
> - It's possibly a bug that we're falling back to HPET mode just because
>   the cdrom driver is being transiently silly.
> 
> - It's surely a bug that hpet_tick is zero after we've switched to HPET mode.
> 
> 
> 
> 
> Please test this workaround:
> 

Only reason I can see for hpet_tick to be zero is when there was some error 
in hpet_init(), and we start using PIT. But, later we try to fallback to an 
uninitilized HPET. 

Can you look at your dmesg before the hang and check what timer is getting used?
The dmesg line will look something like this...

time.c: Using ______ MHz ___ timer.

Thanks,
Venki

