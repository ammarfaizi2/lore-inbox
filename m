Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSHBMcS>; Fri, 2 Aug 2002 08:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSHBMcS>; Fri, 2 Aug 2002 08:32:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16771 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S312558AbSHBMcO>;
	Fri, 2 Aug 2002 08:32:14 -0400
Date: Fri, 2 Aug 2002 18:05:13 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, akpm@zip.com.au
Subject: [PATCH] Bio Traversal Changes 
Message-ID: <20020802180513.A1802@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has been discussed before in principle on lkml and 
mentioned by Jens at the kernel summit. Here's some quick
information about the changes, and the latest patches
against 2.5.30, including bio and request documentation
updates.

Jens, biotr8 mostly just an update of biotr7 to 2.5.30, and
minor cleanups like the removal of the commented out debug 
printks I had kept around so far. 
The doc patch got updated a bit since last night - have 
also tried to modify request.txt in addition to biodoc.txt.


BIO traversal enhancements
--------------------------
- Pre-req for full BIO splitting infrastructure [Splits
  in the middle of a segment can also share the same vec]
- Pre-req for attaching a pre-built vector (not owned by block)
  to a bio (e.g for aio)  [Avoids certain subtle side-effects in 
  special cases]
- Pre-req for IDE mult-count PIO write fixes [Ability
  to traverse a bio partially for i/o submission without 
  effecting bio completion]

Patches are based on 2.5.30 (and will follow in subsequent
mails)

Many many thanks to Barthlomiej for helping out in review 
and testing, fixing several bugs in the generic code and 
using the bio walking routines in this patch to actually 
get  IDE PIO working (single and multi count) ! 

The patches must all be applied together to get a 
compiling and booting kernel on some h/w at least, so it 
might make sense to roll them up for submission to ensure 
that they are committed together.

01biotr8-blk.diff: Contains the core changes for bio traversal, 
including (a) avoidance of alteration of bv_offset/bv_len by
block (b) introduction of bi_voffset to help in splitting a 
bio via cloning, even when the split has to happen in the 
middle of a segment and (c) clean separation of submission and 
completion state for a request. The bio always reflects the
state of unfinished i/o, while the request structure also tracks
the state of unsubmitted i/o (these two may be different, 
e.g. for ide multi-count pio writes). A helper routine
process_that_request_first() is provided to enable drivers
to traverse a request for i/o submission without affecting
completion state. It also has a few fixes for partial
completion cases in end_that_request_first() (non error
cases).
[Andrew, I have uninlined blk_rq_next_segment() and 
process_that_request_first() as you'd suggested and moved 
them into ll_rw_blk.c]

02biotr8-blkusers.diff: Contains the modifications needed to
code that uses/accesses bio (e.g mm, filesystems) above blk.
Most of the changes ensure correct initialisation of the
bi_voffset field when building a bio. 
(BTW, Looking at the number of places that this touches, a 
helper for building a bio would seem to be good to have).

03biotr8-drivers.diff: Contains minimal modifications to
(some) drivers to compile/work with the changed bio 
traversal and mapping assumptions. It would not fix any 
other breakages that exist already in the drivers (e.g. 
doesn't fix any existing IDE problems, and doesn't 
touch LVM). 

Barthlomiej's patch for ATA PIO with IDE driver has 
the correct changes to get to a working version including 
some state machine fixes, and uses the bio traversal helper 
for i/o submission in a clean manner for PIO operations.

Modifications have also been made in cases like loop, 
floppy to either account for bi_voffset or to have a 
sanity check bugon if they get passed a bio which 
starts/ends in the middle of a segment, as a reminder to 
fix it up later. This would need to be completed, including 
extending to other drivers and appropriate testing to ensure 
compatibility. 

04biotr8-doc.diff: Contains the updates to Documentation/block
corresponding to the changes. Have taken the liberty to
update a few other parts of the doc that were strikingly 
obsolete.

Details:
=========

Introduces some new fields in bio and the request structure 
to help maintain traversal state.

Bio fields:
----------

bi_voffset: 

Offset relative to the start of the first page, which 
indicates where the bio really starts. In general before 
i/o starts this would be the same as bv_offset for the 
first vec (at bi_idx), but in the case of clone bio s where 
the bio may be split in the middle of a segment this could be 
different. As i/o progresses, now instead of changing any
of the bvec fields, bi_voffset is moved ahead instead.

The relative offset w.r.t to the start of the first vec
can be calculated using the macro bio_startoffset(bio)

bi_endvoffset: 

Offset relative to the last page which indicates
where the bio really ends. In general this would be the same
as bv_offset + bv_len for the last vec, but in the case of
clone bio s where a split piece ends in the middle of a 
segment, it could be different. This field is really used 
mainly for segment boundary and merge checks (it is more 
convenient than having to walk through the entire bio 
and use bi_size to determine the end just to determine
mergeability).

The macro bio_endoffset(bio) can be used calculate the
relative offset w.r.t to the bvec end where the bio
was broken up.

The remaining size to be transfered in the current bio
vec should be calculated using the bio_segsize() routine
(instead of accessing bv_len directly any more). This
takes care of adjusting the length for the above offsets.

Aside:
An alternative to bi_voffset being an absolute 
offset wrt to the start of the bvec page would be to
make it relative to bio_io_vec(bio)->bv_offset instead
(i.e. the value bio_startoffset() returns in the patch). A
similar change would then apply to bi_endvoffset. Then
the fields would be initialized to zero by default,
though it also would make the mergeability check macros 
a little longer, and possibly add a little extra computation 
during request mapping and end_that_request_first.

Request structure fields:
------------------------

The basic protocol followed all through is that the bio fields 
would always reflect the status w.r.t how much i/o remains
to be completed. On the other hand submission status would
only be maintained in the request structure. In most cases
of course, both move in sync (the generic end_request_first
code tries to handle that transparently by advancing the 
submission pointers if they are behind the completion pointers
as would happen in the case of drivers which don't modify
those themselves), but for things like IDE 
mult-count write, the submission counters/pointers may be
ahead of the completion pointers.  

The following fields have been added to help maintain
this distinction.

hard_bio
	the rq->bio field now reflects the next bio which
is to be submitted for i/o. Hence, the need for rq->hard_bio
which keeps track of the next bio to be completed (this
is the one used by end_that_request_first now, instead
of rq->bio)

nr_bio_segments
	this keeps track of how many more vecs remain 
to be submitted in the current bio (rq->bio). It is
used to compute the current index into rq->bio which
specifies the segment under submission. 
(rq_map_buffer for example uses this field to map
the right buffer)

nr_bio_sectors
	this keeps track of the number of sectors to
be submitted in the current bio (rq->bio). It can be
used to compute the remaining sectors in the current
segment in the situation when it is the last segment.

Now a subtle point about hard_cur_sectors. It reflects
the number of sectors left to be completed in the
_current_ segment under submission (i.e. the segment
in rq->bio, and _not_ rq->hard_bio). This makes it
possible to use it in rq_map_buffer to determine the
relative offset in the current segment w.r.t what 
the bio indices might indicate.

rq_map_buffer() is a macro that would be used to 
obtain a virtual address mapping corresponding to the
current segment of the buffer being submitted for i/o.
(It is expected to replace the use of private driver
versions of the same operation e.g. ide_map_buffer()

A new helper, process_that_request_first() has been 
introduced for updating submission state of the request 
without completing the corresponding bios. It can be used 
by code such as mult-count write which need to traverse
multiple bio segments for each chunk of i/o submitted,
where the chunk does not cover the entire request.


Regards
Suparna
