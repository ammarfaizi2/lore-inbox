Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263648AbUJ2XNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbUJ2XNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbUJ2XII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:08:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:39849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262045AbUJ2XEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:04:22 -0400
Date: Fri, 29 Oct 2004 16:08:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buffered I/O slowness
Message-Id: <20041029160827.4dc29c3f.akpm@osdl.org>
In-Reply-To: <200410291046.48469.jbarnes@engr.sgi.com>
References: <200410251814.23273.jbarnes@engr.sgi.com>
	<200410291046.48469.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> ...
> o one thread on one large volume using buffered I/O + filesystem
>   read (1 thread, one volume, 131072 blocks/request) avg: ~931 MB/s
>   write (1 thread, one volume, 131072 blocks/request) avg: ~908 MB/s
> 
> I'm intentionally issuing very large reads and writes here to take advantage 
> of the striping, but it looks like both the readahead and regular buffered 
> I/O code will split the I/O into page sized chunks?

No, the readahead code will assemble single BIOs up to the size of the
readahead window.  So the single-page-reads in do_generic_mapping_read()
should never happen, because the pages are in cache from the readahead.

>  The call chain is pretty 
> long, but it looks to me like do_generic_mapping_read() will split the reads 
> up by page and issue them independently to the lower levels.  In the direct 
> I/O case, up to 64 pages are issued at a time, which seems like it would help 
> throughput quite a bit.  The profile seems to confirm this.  Unfortunately I 
> didn't save the vmstat output for this run (and now the fc switch is 
> misbehaving so I have to fix that before I run again), but iirc the system 
> time was pretty high given that only one thread was issuing I/O.
> 
> So maybe a few things need to be done:
>   o set readahead to larger values by default for dm volumes at setup time
>     (the default was very small)

Well possibly.  dm has control of queue->backing_dev_info and is free to
tune the queue's default readahead.

>   o maybe bypass readahead for very large requests?
>     if the process is doing a huge request, chances are that readahead won't
>     benefit it as much as a process doing small requests

Maybe - but bear in mind that this is all pinned memory when the I/O is in
flight, so some upper bound has to remain.

>   o not sure about writes yet, I haven't looked at that call chain much yet
> 
> Does any of this sound reasonable at all?  What else could be done to make the 
> buffered I/O layer friendlier to large requests?

I'm not sure that we know what's going on yet.  I certainly don't.  The
above numbers look good, so what's the problem???

Suggest you get geared up to monitor the BIOs going into submit_bio(). 
Look at their bi_sector and bi_size.  Make sure that buffered I/O is doing
the right thing.
