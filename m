Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUC1SI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUC1SI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:08:28 -0500
Received: from mail.shareable.org ([81.29.64.88]:61842 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262238AbUC1SIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:08:23 -0500
Date: Sun, 28 Mar 2004 19:08:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328180809.GB1087@mail.shareable.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328175436.GL24370@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Sorry, but I cannot disagree more. You think an artificial limit at
> the block layer is better than one imposed at the driver end, which
> actually has a lot more of an understanding of what hardware it is
> driving?  This makes zero sense to me. Take floppy.c for instance, I
> really don't want 1MB requests there, since that would take a minute
> to complete. And I might not want 1MB requests on my Super-ZXY
> storage, because that beast completes io easily at an iorate of
> 200MB/sec.

The driver doesn't know how fast the drive is either.

Without timing the drive, interface, and for different request sizes,
neither the block layer _nor_ the driver know a suitable size.

> I absolutely refuse to put a global block layer 'optimal io
> size' restriction in, since that is the ugliest of policies and
> without having _any_ knowledge of what the hardware can do.

But the driver doesn't have _any_ knowledge of what the I/O scheduler
wants.  1MB requests may be a cut-off above which there is negligable
throughput gain for SATA, but those requests may be _far_ too large
for a low-latency I/O scheduling requirement.

If we have a high-level latency scheduling constraint that userspace
should be able to issue a read and get the result within 50ms, or that
the average latency for reads should be <500ms, how does the SATA
driver limiting requests to 1MB help?  It depends on the attached drive.

The fundamental problem here is that neither the driver nor the block
layer have all the information needed to select optimal or maximum
request sizes.  That can only be found by timing the device, perhaps
every time a request is made, and adjusting the I/O scheduling and
request splitting parameters according to that timing and high-level
latency requirements.

>From that point of view, the generic block layer is exactly the right
place to determine those parameters, because the calculation is not
device-specific.

-- Jamie
