Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUCVNXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 08:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbUCVNXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 08:23:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44683 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261976AbUCVNXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 08:23:10 -0500
Date: Mon, 22 Mar 2004 14:23:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Heikki Tuuri <Heikki.Tuuri@innodb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040322132307.GP1481@suse.de>
References: <023001c4100e$c550cd10$155110ac@hebis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023001c4100e$c550cd10$155110ac@hebis>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22 2004, Heikki Tuuri wrote:
> 2. An 'atomic' file write in the OS does not solve the problem of partially
> written database pages in a power outage if the disk drive is not guaranteed
> to stay operational long enough to be able to write the whole page
> physically to disk. An InnoDB data page is 16 kB, and probably not
> guaranteed to be any 'atomic' unit of physical disk writes. However, in
> practice, half-written pages (either because of the OS or the disk) seem to
> be very rare.

There's no such thing as atomic writes bigger than a sector really, we
just pretend there is. Timing usually makes this true.

For bigger atomic writes, 2.4 SUSE kernel had some nasty hack (called
blk-atomic) to prevent reordering by the io scheduler to avoid partial
blocks from databases. For 2.6 it's much easier since you can just send
a 16kb write out as one unit. So you send out the db data page as 1
hardware request, which is pretty much as atomic as you can do it from
the OS point of view. As long as you avoid a big window between parts of
this data page, you've narrowed the window of breakage from many seconds
to miliseconds (maybe even 0, if drive platter inertia guarentees you
that the write will ensure the data is on platter).

-- 
Jens Axboe

