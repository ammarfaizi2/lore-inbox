Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWFANRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWFANRV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWFANRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:17:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23557 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964895AbWFANRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:17:21 -0400
Date: Thu, 1 Jun 2006 15:19:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com
Subject: NCQ performance (was Re: [rfc][patch] remove racy sync_page?)
Message-ID: <20060601131921.GH4400@suse.de>
References: <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447CF252.7010704@rtr.ca> <20060531061110.GB29535@suse.de> <447D923B.1080503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447D923B.1080503@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Mark Lord wrote:
> Jens Axboe wrote:
> >
> >NCQ helps us with something we can never fix in software - the
> >rotational latency. Ordering is only a small part of the picture.
> 
> Yup.  And it also helps reduce the command-to-command latencies.
> 
> I'm all for it, and have implemented tagged queuing for a variety
> of device drivers over the past five years (TCQ & NCQ).  In every
> case people say.. wow, I expected more of a difference than that,
> while still noting the end result was faster under Linux than MS$.
> 
> Of course with artificial benchmarks, and the right firmware in
> the right drives, it's easier to create and see a difference.
> But I'm talking more life-like loads than just a multi-threaded
> random seek generator.

Ok, I decided to rerun a simple random read work load (with fio), using
depths 1 and 32. The test is simple - it does random reads all over the
drive size with 4kb block sizes. The reads are O_DIRECT. The test
pattern was set to repeatable, so it's going through the same workload.
The test spans the first 32G of the drive and runtime is capped at 20
seconds.

Now of course this is truly an artificial work load, however it's still
interesting from the POV of what NCQ can potentially do for you. If you
want something specific run, let me know and I can quickly do so (eg
write through cache random writes).

sda:    Maxtor 7B300S0
sdb:    Maxtor 7L320S0
sdc:    SAMSUNG HD160JJ
sdd:    HDS725050KLA360 (Hitachi 500GB drive)

drive           depth           KiB/sec         diff
----------------------------------------------------
sda              1              397
sda             32              685             +72%
sdb              1              397
sdb             32              525             +32%
sdc              1              372
sdc             32              511             +37%
sdd              1              489
sdd             32              942             +92%

fio file used, modify depth and device name, of course:

[/dev/sdd]
size=32g
ioengine=libaio
iodepth=32
rw=randread
bs=4k
timeout=20
direct=1

-- 
Jens Axboe

