Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTB1B5F>; Thu, 27 Feb 2003 20:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbTB1B5F>; Thu, 27 Feb 2003 20:57:05 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:26202 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S261364AbTB1B5E>;
	Thu, 27 Feb 2003 20:57:04 -0500
Date: Thu, 27 Feb 2003 17:57:00 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Mike Anderson <andmike@us.ibm.com>
Subject: Re: 2.5.62-mm2 slow file system writes across multiple disks
Message-ID: <20030227175700.A26302@beaverton.ibm.com>
References: <20030224120304.A29472@beaverton.ibm.com> <20030224135323.28bb2018.akpm@digeo.com> <20030224174731.A31454@beaverton.ibm.com> <20030224204321.5016ded6.akpm@digeo.com> <20030225112458.A5618@beaverton.ibm.com> <20030226004454.2bfd8deb.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030226004454.2bfd8deb.akpm@digeo.com>; from akpm@digeo.com on Wed, Feb 26, 2003 at 12:44:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 12:44:54AM -0800, Andrew Morton wrote:

> Does the other qlogic driver exhibit the same thing?

OK I finally tried out the qlogic driver on the same 10 drives, actually
with scsi-misc-2.5 (2.5.63).

The qlogic is OK performance wise - as Mike pointed out, it sets a lower
queue depth; and even though it sets can_queue higher than the feral, the
qlogic driver software queues where in the same case the feral would give
us a host busy (i.e. queuecomand returns 1).

andmike> Well the qlogic provided driver should exhibit slightly different
andmike> behavior as its per device queue depth is 16 and the request ring count
andmike> is 128.
andmike> 
andmike> The feral driver is currently running a per device queue of 63 and a
andmike> request ring size of 64. (if I am reading the driver correctly?). When
andmike> the request count is exceeded I believe it should return a 1 to the call
andmike> of queuecommand. Can you tell if scsi_queue_insert is being called.

As Mike implies, the feral driver is setting can_queue too high, so in
addition to large queue depth affects, I am also hitting scsi host busy
code paths - yes, it is calling scsi_queue_insert. The host busy code is
not meant to be hit so often, and likely leads to lower performance.

So the feral driver needs lower can_queue (and/or queueing changes) and
lower queue_depth limits.

> Does writeout to a single disk exhibit the same thing?

No, single disk IO performance is OK (with queue depth/TCQ 63 and
can_queue 744), so the too high can_queue with host busy's is probably
hurting performance than the high queue_depth.

> > The larger queue depths can be nice for disk arrays with lots of cache and
> > (more) random IO patterns.
> 
> So says the scsi lore ;)  Have you observed this yourself?  Have you
> any numbers handy?

No and no :(

I'm not sure if the disk arrays we have available have enough memory to
show such affects (I assume standard disk caches are not large enough to
have much of an affect).

-- Patrick Mansfield
