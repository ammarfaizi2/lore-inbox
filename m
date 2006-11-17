Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424827AbWKQAvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424827AbWKQAvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424828AbWKQAvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:51:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62942 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424827AbWKQAva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:51:30 -0500
Date: Fri, 17 Nov 2006 11:50:52 +1100
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>,
       David Chinner <dgc@sgi.com>
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Message-ID: <20061117005052.GK11034@melbourne.sgi.com>
References: <200611160912.51226.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611160912.51226.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 09:12:49AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> The following two patches introduce a mechanism that should allow us to
> avoid suspend-related corruptions of XFS without the freezing of bdevs which
> Pavel considers as too invasive (apart from this, the freezing of bdevs may
> lead to some undesirable interactions with dm and for now it seems to be
> supported for real by XFS only).

Has this been tested and proven to fix the problem with XFS? It's
been asserted that this will fix XFS and suspend, but it's
not yet been proven that this is even the problem.

I think the problem is a race between sys_sync, the kernel thread
freeze and the xfsbufd flushing async, delayed write metadata
buffers resulting in a inconsistent suspend image being created.
If this is the case, then freezing the workqueues does not
fix the problem. i.e:

suspend				xfs
-------				---
sys_sync completes
				xfsbufd flushes delwri metadata
kernel thread freeze
workqueue freeze
suspend image start
				async I/O starts to complete
suspend image finishes
				async I/O all complete

The problem here is the memory image has an empty delayed write
metadata buffer queue, but the I/O completion queue will be missing
some (or all) of the I/O that was issued, and so on resume we have
a memory image that still thinks the I/Os are progress but they
are not queued anywhere for completion processing.

Hence after a successful resume after the above occurred on suspend,
we can have a filesystem that is potentially inconsistent, and it
will almost certainly hang soon after activity starts again on it
because we cannot push the tail of the log forwards due to the lost
buffers.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
