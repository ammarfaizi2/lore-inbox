Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSAaUuw>; Thu, 31 Jan 2002 15:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291290AbSAaUum>; Thu, 31 Jan 2002 15:50:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291287AbSAaUu0>;
	Thu, 31 Jan 2002 15:50:26 -0500
Message-ID: <3C59AC5C.6B6C6066@zip.com.au>
Date: Thu, 31 Jan 2002 12:43:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Roger Larsson <roger.larsson@norran.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Errors in the VM - detailed
In-Reply-To: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net> <200201312024.g0VKORD19223@mailf.telia.com>,
		<200201312024.g0VKORD19223@mailf.telia.com> <20020131212909.T5301@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> That will trigger _all the time_ even on a moderately busy machine.
> Checking if tossing away read-ahead is the issue is probably better
> tested with just increasing the request slots. Roy, please try and change
> the queue_nr_requests assignment in ll_rw_blk:blk_dev_init() to
> something like 2048.
> 

heh.  Yep, Roger finally nailed it, I think.

Roy says the bug was fixed in rmap11c.  Changelog says:


rmap 11c:
  ...
  - elevator improvement                                  (Andrew Morton)

Which includes:

-       queue_nr_requests = 64;
-       if (total_ram > MB(32))
-               queue_nr_requests = 128;                                                                 +       queue_nr_requests = (total_ram >> 9) & ~15;     /* One per half-megabyte */
+       if (queue_nr_requests < 32)
+               queue_nr_requests = 32;
+       if (queue_nr_requests > 1024)
+               queue_nr_requests = 1024;


So Roy is running with 1024 requests.

The question is (sorry, Roy): does this need fixing?

The only thing which can trigger it is when we have
zillions of threads doing reads (or zillions of outstanding
aio read requests) or when there are a large number of
unmerged write requests in the elevator.  It's a rare
case.

If we _do_ need a fix, then perhaps we should just stop
using READA in the readhead code?  readahead is absolutely
vital to throughput, and best-effort request allocation
just isn't good enough.

Thoughts?

-
