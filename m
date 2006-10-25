Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWJYRvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWJYRvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 13:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWJYRvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 13:51:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161001AbWJYRvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 13:51:40 -0400
To: Martin Peschke <mp3@de.ibm.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, Jens Axboe <jens.axboe@oracle.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com>
	<20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com>
	<20061024162050.GK4281@kernel.dk> <453E79D1.6070703@cfl.rr.com>
	<453E9368.9070405@de.ibm.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 25 Oct 2006 13:50:52 -0400
In-Reply-To: <453E9368.9070405@de.ibm.com>
Message-ID: <y0mvem8thc3.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Peschke <mp3@de.ibm.com> writes:

> [...]  The tricky question is: is event processing, that is,
> statistics data aggregation, better done later (in user space), or
> immediately (in the kernel). Both approaches exist: blktrace/btt vs.
> gendisk statistics used by iostat, for example. [...]

I would put it one step farther: the tricky question is whether it's
worth separating marking the state change events ("request X
enqueued") from the action to be taken ("track statistics", "collect
trace records").

The reason I brought up the lttng/marker thread here was because that
suggests a way of addressing several of the problems at the same time.
This could work thusly: (This will sound familiar to OLS attendees.)

- The blktrace code would adopt a generic marker mechanism such as
  that (still) evolving within the lttng/systemtap effort.  These
  markers would replace calls to inline functions such as
      blk_add_trace_bio(q,bio,BLK_TA_QUEUE);
  with something like
      MARK(blk_bio_queue,q,bio);

- The blktrace code that formats and manages trace data would become a
  consumer of the marker API.  It would be hooked up at runtime to
  these markers.  When the events fire, the tracing backend receiving
  the callbacks could do the same thing it does now.  (With the
  markers dormant, the cost should not be much higher than the current
  (likely (!q->blk_trace)) conditional.)

- The mp3 statistics code would be an alternate backend to these same
  markers.  It could be activated or deactivated on the fly (to let
  another subsystem use the markers).  The code would maintain statistics
  in its own memory and could present the data on /proc or whatnot, the
  same way as today.

- Additional backends would be immediately possible: lttng style
  tracing or even fully programmable systemtap probing / analysis
  could all be dynamically activated without further kernel patches or
  rebooting.

>From a user's point of view, it could be the best of all worlds: easy
to get a complete trace for detailed analysis, easy to retain plain
statistics for simple monitoring, easy to do something more elaborate
if necessary.

- FChE
