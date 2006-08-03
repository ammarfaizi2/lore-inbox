Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWHCXxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWHCXxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWHCXxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:53:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8122 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751406AbWHCXxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:53:17 -0400
Date: Thu, 3 Aug 2006 19:53:04 -0400
From: Dave Jones <davej@redhat.com>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [2/2] Add the Elevator I/O scheduler
Message-ID: <20060803235304.GB7265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:03:19PM -0700, Nate Diller wrote:
 > This is the Elevator I/O scheduler.  It is a simple one-way elevator,
 > with a couple tunables for reducing latency or starvation.  It also
 > has a performance-oriented tracing facility to help debug strange or
 > specialized workloads.

Where are the numbers comparing this against other elevators,
showing why this is worth merging at all ?

 > +/****************
 > + *
 > + * Advantages of the Textbook Elevator Algorithms
 > + *  by Hans Reiser
 > + *
 > + * In people elevators, they ensure that the elevator never changes
 > + * direction before it reaches the last floor in a given direction to which
 > + * there is a request to go to it.  A difference with people elevators is
 > + * that disk drives have a preferred direction due to disk spin direction
 > + * being fixed, and large seeks are relatively cheap, and so we (and every
 > + * textbook) have a one way elevator in which we go back to the beginning 
 > > blah blah blah..

This huge writeup would probably belong more in Documentation/

 > +/*
 > + *    SSTF
 > + *
 > + * The SSTF feature was added on a whim.  It ignores the tunables, and
 > + * probably breaks tracing.  I didn't ever see it perform better than SCAN,
 > + * but who knows?
 > + */

Is this bit worth merging if its even of unknown use to its author ?

 > +#include <linux/kernel.h>
 > +#include <linux/fs.h>
 > +#include <linux/blkdev.h>
 > +#include <linux/elevator.h>
 > +#include <linux/bio.h>
 > +#include <linux/config.h>

config.h doesn't need an explicit include, its pulled in automatically by kbuild.

 > +#define is_head(e) ((e)->request == NULL)
 > +#define is_write(e) ((e)->request->flags & REQ_RW)
 > +#define req_rw(e) (is_write(e) ? 2 : 1)
 > +
 > +#define is_contig_prev(prev, start) (!is_head(prev) &&
 > ((prev)->request->sector + (prev)->request->nr_sectors == start))
 > +#define is_contig_next(start, next) (!is_head(next) && (start ==
 > (next)->request->sector))
 > +
 > +#define req_operlap(prev_start, prev_len, this_start) (prev_len &&
 > prev_start <= this_start && this_start < prev_start + prev_len)
 > +
 > +#define next_in_queue(e) (list_entry((e)->queue.next, struct el_req, 
 > queue))
 > +#define prev_in_queue(e) (list_entry((e)->queue.prev, struct el_req, 
 > queue))
 > +
 > +#define next_req_in_queue(e) (is_head(next_in_queue(e)) ?
 > next_in_queue(next_in_queue(e)) : next_in_queue(e))
 > +#define prev_req_in_queue(e) (is_head(prev_in_queue(e)) ?
 > prev_in_queue(prev_in_queue(e)) : prev_in_queue(e))
 > +
 > +#define next_contig(e) (list_entry((e)->contiguous.next, struct
 > el_req, contiguous))
 > +#define prev_contig(e) (list_entry((e)->contiguous.prev, struct
 > el_req, contiguous))
 > +
 > +#define is_first_in_op(e) (prev_contig(e)->start > e->start)
 > +#define is_last_in_op(e) (next_contig(e)->start < e->start)
 > +
 > +#define active_req(q) ((q)->rq.count[0] + (q)->rq.count[1])
 > +#define active_ops(el) ((el)->ops[0] + (el)->ops[1])
 > +
 > +#define sweep_sec(el) ((el)->sec_this_sweep[0] + (el)->sec_this_sweep[1])
 > +
 > +#define ops_count(el, req) ((el)->ops[req->flags & REQ_RW ? 1 : 0])
 > +#define sec_count(el, req) ((el)->sec[req->flags & REQ_RW ? 1 : 0])
 > +#define sweep_latency(el, req) ((el)->sweep_latency[(req)->flags &
 > REQ_RW ? 1 : 0])

You like your macros huh ? :)

 > +#define sprint(el) (printk(KERN_ALERT "\nsec <%6d,%6d>  ops <%2u,%3u>
 > req%4lu,  cov%6lluKi,  time%4lu,  lat <%5lu,%5lu>\n", \
 > +		el->sec_this_sweep[0], el->sec_this_sweep[1], \
 > +		el->ops_this_sweep[0], el->ops_this_sweep[1], \
 > +		el->req_this_sweep, \
 > +		(unsigned long long) ((el->head.start - 
 > el->first_sweep_sector) >> 10), \
 > +		jiffies - el->sweep_start_time, \
 > +		el->ops_this_sweep[0] ? el->sweep_latency[0] / 
 > el->ops_this_sweep[0] : 0, \
 > +		el->ops_this_sweep[1] ? el->sweep_latency[1] / 
 > el->ops_this_sweep[1] : 0))
 > +
 > +#define printel(el) (printk(KERN_ALERT "(%9lu)  %6lu %4lu  req
 > <%3u,%3u>  ops <%3u,%3u>  sec <%7u,%7u>\n", \
 > +		(unsigned long) el->head.start, jiffies - el->head_jiffies, \
 > +		jiffies - el->next_jiffies, el->q->rq.count[0], 
 > el->q->rq.count[1], \
 > +		el->ops[0], el->ops[1], el->sec[0], el->sec[1]) )

This makes my eyes hurt.  The naming seems clumsy too.
You're also only using them once afaics, so it's better to just
use these inline than to abstract this for no reason.

 > +#define contig_char(e) (list_empty(&e->contiguous) ? '0' : \
 > +			prev_contig(e)->start > e->start ? 'v' : \
 > +			next_contig(e)->start < e->start ? '^' : '|')
 > +
 > +#define printh(e) (printk(KERN_ALERT "(%9lu, %4lu)\n", (unsigned
 > long) e->start, 0ul))
 > +
 > +#define printr(e) (printk(KERN_ALERT "(%9lu, %4lu) %6lu  %p  %c  %c  
 > %c\n", \
 > +	(unsigned long) e->request->sector, e->request->nr_sectors, jiffies
 > - e->request->start_time, e->owner, \
 > +	((e->request->flags & REQ_RW) ? 'w' : 'r'), contig_char(e),
 > (e->request->flags & REQ_FAILFAST) ? 's' : 'a' ))
 > +
 > +#define printe(e) (is_head(e) ? printh(e) : printr(e))

Gah, more abstraction. Same comments as previous.

 > +#define REQ_DATA(req)	((struct el_req *) (req)->elevator_private)

These poor-mans typedefs also don't really make the code any easier
to read IMO, forcing the reader to jump around to find out what
the abstraction actually does.


 > +/*
 > + * This is similar to list_splice(), except it merges every item onto 
 > @list,
 > + * not excluding @head itself.  It is a noop if @head already immediately
 > + * preceeds @list.
 > + *
 > + * It really should go into list.h

Indeed it should.

 > +	/*
 > +	 * This check is for all the SCSI drivers, to make sure that the
 > +	 * request actually being submitted is the closest to the head.  The
 > +	 * IDE drivers, for historical reasons, tend to leave requests on
 > +	 * the queue until they have completed.  We check for these "head
 > +	 * active" situations with the REQ_STARTED flag, and ignore them.
 > +	 */
 > +#if EL_DEBUG
 > +	if (unlikely(!is_head(prev_in_queue(e)) && !(req->flags & 
 > REQ_STARTED)))
 > +		printk(KERN_ALERT "nate 0001: removing request out of 
 > elevator order\n");
 > +#endif

This smells fishy.

 > + * Fortunately, we get to define a device-specific congestion function.
 > + * This is fortunate because we have yet to find a case where we
 > + * benefit from any of the effects of being 'congested', so we just
 > + * turn it off.
 > + *
 > + * Read congestion just disables "optional" reads, from readahead and
 > + * fadvise and such, which is *very* wrong for our application.  Probably
 > + * I will implement dynamic tuning of ra_pages instead.
 > + *
 > + * Write congestion signals pdflush or FS specific flush code to stop
 > + * submitting pages, but really it's better to get a lot of pages at once.
 > + * The max_contig and max_write tunables should address writes-starve-reads
 > + * problems in our case.
 > + */
 > +static int congested(void *data, int rw_mask)
 > +{
 > +	return 0;
 > +}

This may be true for simple cases of just a few disks, but this could get
really messy for some hardware configurations.   Submitting more IO than we
can flush out in a reasonable manner is the path to OOM.

 > +config IOSCHED_ELEVATOR
 > +	tristate "Elevator I/O scheduler"
 > +	default y
 > +	---help---
 > +	  This is a simple BSD style one-way elevator.  It avoids the 
 > complexity
 > +	  of deadlines, and uses a limit on contiguous I/O sectors to keep 
 > things
 > +	  moving and reduce latency.
 > +
 > +config IOSCHED_EL_SSTF
 > +	bool "Alternate Heuristic: Shortest Seek Time First" if 
 > IOSCHED_ELEVATOR
 > +	default n
 > +	---help---
 > +	  Elevator normally uses the C-SCAN one-way elevator algorithm,
 > +	  which is useful in most situations to avoid queue congestion and
 > +	  request starvation.  In some cases, SSTF might be higher
 > +	  performance, particularly with certain localized workloads.
 > +
 > +	  If you don't know that you want this, you don't.

If this option is worth merging at all it would probably be better
off implemented as a runtime switch.  As it stands distro kernels for
example must choose one way over the other.


 > choice
 > 	prompt "Default I/O scheduler"
 > -	default DEFAULT_CFQ
 > +	default DEFAULT_AS
 
Ummm ?

 > 	  Select the I/O scheduler which will be used by default for all
 > 	  block devices.
 > 
 > 	config DEFAULT_AS
 > -		bool "Anticipatory" if IOSCHED_AS=y
 > +		bool "Anticipatory" if IOSCHED_AS
 > 
 > 	config DEFAULT_DEADLINE
 > -		bool "Deadline" if IOSCHED_DEADLINE=y
 > +		bool "Deadline" if IOSCHED_DEADLINE
 > 
 > 	config DEFAULT_CFQ
 > -		bool "CFQ" if IOSCHED_CFQ=y
 > +		bool "CFQ" if IOSCHED_CFQ

??

 > +	config DEFAULT_ELEVATOR
 > +		bool "Elevator" if IOSCHED_ELEVATOR

borked indentation (nitpicking now..)

 > 	config DEFAULT_NOOP
 > 		bool "No-op"
 > @@ -64,6 +98,7 @@ config DEFAULT_IOSCHED
 > 	default "anticipatory" if DEFAULT_AS
 > 	default "deadline" if DEFAULT_DEADLINE
 > 	default "cfq" if DEFAULT_CFQ
 > +	default "elevator" if DEFAULT_ELEVATOR
 > 	default "noop" if DEFAULT_NOOP

ditto.

 > diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/block/ll_rw_blk.c
 > linux-dput/block/ll_rw_blk.c
 > --- linux-2.6.18-rc1-mm2/block/ll_rw_blk.c	2006-07-18 
 > 15:00:44.000000000 -0700
 > +++ linux-dput/block/ll_rw_blk.c	2006-08-01 13:56:34.000000000 -0700
 > @@ -2895,6 +2895,7 @@ static int __make_request(request_queue_
 > 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
 > 			req->ioprio = ioprio_best(req->ioprio, prio);
 > 			drive_stat_acct(req, nr_sectors, 0);
 > +			elv_extended_request(q, req, el_ret, nr_sectors);
 > 			if (!attempt_back_merge(q, req))
 > 				elv_merged_request(q, req);

ditto

 > @@ -2922,6 +2923,7 @@ static int __make_request(request_queue_
 > 			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
 > 			req->ioprio = ioprio_best(req->ioprio, prio);
 > 			drive_stat_acct(req, nr_sectors, 0);
 > +			elv_extended_request(q, req, el_ret, nr_sectors);
 > 			if (!attempt_front_merge(q, req))
 > 				elv_merged_request(q, req);

ditto

 > @@ -2951,7 +2953,7 @@ get_rq:
 > 		blk_plug_device(q);
 > 	add_request(q, req);
 > out:
 > -	if (sync)
 > +/*	if (sync)*/
 > 		__generic_unplug_device(q);

Please explain ?

 > {
 > 	elevator_merge_fn *elevator_merge_fn;
 > 	elevator_merged_fn *elevator_merged_fn;
 > +	elevator_extended_req_fn *elevator_extended_req_fn;
 > 	elevator_merge_req_fn *elevator_merge_req_fn;

indentation again.

That's the stuff that jumped out at me. It could probably use a more
in-depth review from someone like Jens, but it'd be great to see numbers
to know whether it's even worth bothering to do so.

		Dave

-- 
http://www.codemonkey.org.uk
