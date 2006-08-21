Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWHUNtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWHUNtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWHUNtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:49:22 -0400
Received: from brick.kernel.dk ([62.242.22.158]:19770 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030467AbWHUNtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:49:21 -0400
Date: Mon, 21 Aug 2006 15:51:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: David Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Message-ID: <20060821135132.GG4290@suse.de>
References: <20060815230050.GB51703024@melbourne.sgi.com> <17635.60378.733953.956807@cse.unsw.edu.au> <20060816231448.cc71fde7.akpm@osdl.org> <20060818001102.GW51703024@melbourne.sgi.com> <20060817232942.c35b1371.akpm@osdl.org> <20060818070314.GE798@suse.de> <p73hd0998is.fsf@verdi.suse.de> <17640.65491.458305.525471@cse.unsw.edu.au> <20060821031505.GQ51703024@melbourne.sgi.com> <17641.24478.496091.79901@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17641.24478.496091.79901@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21 2006, Neil Brown wrote:
> Jens:  Was it s SuSE kernel or a mainline kernel on which you
>    experienced this slowdown with an external USB drive?

Note that this was on the old days, on 2.4 kernels. It was (and still
is) a generic 2.4 problem, which is quite apparent when you have larger
slow devices. Larger, because then you can have a lot of dirty memory in
flight for that device. The case I most often saw reported was on
DVD-RAM atapi or scsi devices, which write at 3-400kb/sec. An external
usb hard drive over usb 1.x would be almost as bad, I suppose.

I haven't heard any complaints for 2.6 in this area for a long time.

> Then we just need to deal with the case where the some of the queue
> limits of all devices exceeds the dirty threshold....
> Maybe writeout queues need to auto-adjust their queue length when some
> system-wide situation is detected.... sounds messy.

Queue length is a little tricky, so it's basically controlled by two
parameters - nr_requests and max_sectors_kb. Most SATA drives can do
32MiB requests, so in theory a system that sets max_sectors_kb to
max_hw_sectors_kb and retains a default nr_requests of 128, can see up
to 32 * (128 * 3) / 2 == 6144MiB per disk in flight. Auch. By default we
only allow 512KiB per requests, which brings us to a more reasonable
96MiB per disk.

But these numbers are in no way tied to the hardware. It may be totally
reasonable to have 3GiB of dirty data on one system, and it may be
totally unreasonable to have 96MiB of dirty data on another. I've always
thought that assuming any kind of reliable throttling at the queue level
is broken and that the vm should handle this completely.

-- 
Jens Axboe

