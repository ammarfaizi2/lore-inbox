Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbTFCKGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 06:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTFCKGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 06:06:52 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:19027 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264882AbTFCKGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 06:06:51 -0400
Date: Tue, 3 Jun 2003 03:20:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Counter-kludge for 2.5.x hanging when writing to block device
Message-Id: <20030603032034.20202091.akpm@digeo.com>
In-Reply-To: <20030603100255.GJ482@suse.de>
References: <200306030848.h538mwE22282@freya.yggdrasil.com>
	<20030603091018.GI482@suse.de>
	<20030603030023.69d39d6e.akpm@digeo.com>
	<20030603100255.GJ482@suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2003 10:20:18.0163 (UTC) FILETIME=[BB1FFC30:01C329B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
>  > b) it should check that there are still requests in flight after parking
>  >    itself on the waitqueue rather than relying on the timeout.
> 
>  This is important, would be much nicer to pass in the backing dev. This
>  is a big problem, imho. It's broken right now.

The throttling is not really a per-device concept.  It is a "global"
concept.

If a process has written to a really slow device and has encountered
throttling due to exceeded dirty memory limits, we _do_ want to wake that
process up (to reevaluate the system state) if a bunch of writes terminate
against a fast device.

There is a fixed amount of system memory which the administrator has
dedicated to buffering of dirty-and-writeback data and I believe that not
discriminating between different bandwidth devices will give the overall
lowest latency.  This may be wrong, and maybe we do want to throttle tasks
which write to slow devices more heavily.

Or place the device's nominal bandwidth in the backing_dev_info, account
for dirty memory on a per-queue basis and limit the permissible amount of
dirty memory against slower devices.  That's probably not too hard to do
but I'm not sure that the combination of slow and fast devices both under
heavy writeout at the same time is common enough to justify it.

