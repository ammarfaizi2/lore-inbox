Return-Path: <linux-kernel-owner+w=401wt.eu-S965201AbXAJWtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbXAJWtb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbXAJWtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:49:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965164AbXAJWta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:49:30 -0500
Date: Wed, 10 Jan 2007 18:06:27 -0500 (EST)
Message-Id: <20070110.180627.41627650.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Cc: dm-devel@redhat.com, j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 0/3] blk_end_request: full I/O completion handler
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens and device driver maintainers,

I would like to make block interface to hook in before completing
each chunk of request (for errors) to allow request-based multipath.
The first approach was to add a new hook in __end_that_request_first().
  - http://marc.theaimsgroup.com/?l=linux-scsi&m=115520444515914&w=2
  - http://marc.theaimsgroup.com/?l=linux-kernel&m=116656637425880&w=2
However, Jens pointed out that redesigning ->end_io() as a full
completion handler would be better:

On Thu, 21 Dec 2006 08:49:47 +0100, Jens Axboe <jens.axboe@oracle.com> wrote:
> Ok, I see what you are getting at. The current ->end_io() is called when
> the request has fully completed, you want notification for each chunk
> potentially completed.
> 
> I think a better design here would be to use ->end_io() as the full
> completion handler, similar to how bio->bi_end_io() works. A request
> originating from __make_request() would set something ala:
.....
> instead of calling the functions manually. That would allow you to get
> notification right at the beginning and do what you need, without adding
> a special hook for this.

So I made a tentative patch based on Jens' suggestion.
Are the interface and the design acceptable for block layer and
device drivers, though a little bit big modification of device drivers
is needed to take this approach?

What is changed:
  o blk_end_request() is a helper for drivers to call a full completion
    handler (req->end_io) for the request.
    (end_that_request_* are no longer used from outside of the handlers.)
  o If blk_end_request() returns 0, the request is completed.
    If blk_end_request() returns 1, the request isn't completed and
    the caller should decide reactions for it.
  o __make_request() sets blk_end_io() in req->end_io
  o Added some templates to existing req->end_io users so they can be
    full completion handler.

The interface of blk_end_request():
  o About the 4th argument (int locked)
    blk_end_request() has to get a queue lock before it calls
    end_that_request_last().  On the other hand, some callers need to
    call blk_end_request() with the lock held.
    Callers can tell blk_end_request() by this argument whether a queue
    lock needs to be held in blk_end_request().

  o About the 5th and the 6th arguments (int (callback)(void *), void *arg)
    Most of callers do caller-specific work between
    end_that_request_{first,chunk} and end_that_request_last.
    Callers now pass a callback for such work by these arguments.

    By using the callback feature, critical sections protected by
    single queue lock might need to be divided.
    (e.g. In scsi_end_request(), blk_queue_end_tag() and
          end_that_request_last() was protected by 1 spinlock but 
          1 spinlock is used for each call. See PATCH#3)
    If it can't be divided, the caller has to get the lock before
    calling blk_end_request(), though it may have performance affects.

    To cover callers which wants to call only __end_that_request_first()
    like PIO mode in cdrom_newpc_intr(), the callback can return int value.
    If the return value is non 0, blk_end_request() returns 1 immediately
    without the request completion. (See cdrom_newpc_intr() in PATCH#3)

If this is acceptable approach, I will break down, clean up and repost
the patch.

Thanks,
Kiyoshi Ueda

