Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUC3PgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUC3PgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:36:04 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:46606 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263733AbUC3Pfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:35:44 -0500
Message-ID: <40699843.7030005@techsource.com>
Date: Tue, 30 Mar 2004 10:54:43 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrea Arcangeli <andrea@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de>
In-Reply-To: <20040330110928.GR24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

> 
> 
> Here's a quickly done patch that attempts to adjust the value based on a
> previous range of completed requests. It changes ->max_sectors to be a
> hardware limit, adding ->optimal_sectors to be our max issued io target.
> It is split on READ and WRITE. The target is to keep request execution
> time under BLK_IORATE_TARGET, which is 50ms in this patch. read-ahead
> max window is kept within a single request in size.
> 
[snip]

Awesome patch!

One question I have is about how you are determining optimal request 
size.  You are basing this on the _maximum_ performance of the device, 
but there could be huge differences between min and max performance. 
Would it be better to compute optimal based on worst-case performance? 
Or averaged over time?

Idealy, we'd have a running average where one hit of worst-case will 
have an impact, but if that happens only once, it'll drop out of the 
average, and best-case events will be considered but tempered as well.

If we're going for real-time, then we want to avoid any latency over 
50ms.  In that case, we'd want to go based on worst-case, although it 
would still be good to let, say, an occasional hardware glitch which had 
slow response to not have permanent impact.

