Return-Path: <linux-kernel-owner+w=401wt.eu-S932966AbWLSWKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbWLSWKq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933030AbWLSWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:10:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43857 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932966AbWLSWKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:10:44 -0500
Date: Tue, 19 Dec 2006 17:10:26 -0500 (EST)
Message-Id: <20061219.171026.115904158.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 0/8] rqbased-dm: request-based device-mapper
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working on device-mapper multipath (dm-multipath).
This patch set adds a new hook for device-mapper below I/O scheduler
and enables mapping at request level instead of bio level.
The patch could be a basis of better dynamic load balancing.

This patch set is preliminary tested on active-active 2 paths storage.
But the patch set still needs work and is not ready for inclusion.
I'm posting it because I'd like to get comments about high-level
design before going further in details.

The list below is the items which I'd especially like to get comments.

For block layer maintainer and developers:
  This patch set has 2 block layer changes below.
    - Changed blk_get_request() to allow calls from interrupt context
      so that queue's request_fn can use it.  (PATCH 1/8)
      (*) The behaviour of CFQ (or other scheduler which depends on
          "current") may be affected when blk_get_request() is called
          in interrupt context, because "current" is not the process
          which issue the original request.
    - Added new "end_io_first" hook to __end_that_request_first()
      and struct request.  (PATCH 2/8)
  And I'm thinking about:
    - Moving blk_clone_rq() to ll_rw_blk.c from dm.c. (PATCH 7/8)
  Are these acceptable changes?

For dm maintainer and developers:
    - About splitting 'map' method into 'prep_map' and 'map'.
    - About I/O spanning across targets.
  Please see "Possible discussion items" section below for details.

This patch set should be applied on top of 2.6.19.1.


====================================================================
Background
=-=-=-=-=-=

Current device-mapper is bio-based and dm-multipath has some issues
below.

  - Because hook for I/O mapping is above block layer __make_request(),
    contiguous bios can be mapped to different underlying devices
    and these bios aren't merged into a request.
    Dynamic load balancing could happen this situation, though
    it has not been implemented yet.
    Therefore, I/O mapping after bio merged is needed for better
    dynamic load balancing.

  - There is no feature of error code (sense key) escalation
    to device-mapper from SCSI layer, though storage dependent error
    code handling is needed for some storages.
    Though there was a patch piggybacking error code to struct bio,
    it was rejected and the comment at the time was "struct request
    would be better if this feature is implemented."

To resolve the issues, the block layer (request-based) multipath
patch was posted by Mike Christie before.
(http://marc.theaimsgroup.com/?l=linux-scsi&m=115520444515914&w=2)

Though Mike's patch added new block layer device for multipath and
didn't have device-mapper interface, I modified his patch to be used
from dm-multipath.


=====================================================================
Design Overview
=-=-=-=-=-=-=-=-=

Overview of the request-based device-mapper patch:
  - Mapping is done in a unit of struct request, instead of struct bio.
  - Hook for I/O mapping is at request_fn after merging and sorting by
    I/O scheduler, instead of make_request_fn.
  - Hook for I/O finishing is at end_that_request_*, instead of bio_endio.
  - Whether the dm device is bio-based or request-based is specified
    at device creation by ioctl parameter.
  - Keep user interface same (table/message/status).
  - Any dm/md devices can be stacked on request-based dm device.
    Request-based dm device *cannot* be stacked on bio-based dm device.
  - Use block device queue instead of multipath target's internal queue.
  - Currently no work is done for hw_handler.
    Mike Christie is moving them to scsi layer.
  - Difference in the target driver methods:
      current (bio-based)       this patch (request-based)
      ----------------------------------------------------------
      map                       prep_map (decides target device)
                                map      (translate cloned request)

      end_io                    end_io_first (error check)
                                end_io       (free memory/retry)

Expected benefit:
  - better load balancing
  - affinity to I/O scheduler
  - user space tools need minimum change
  - could be a basis of error code escalation feature


=====================================================================
Possible discussion items
=-=-=-=-=-=-=-=-=-=-=-=-=-=

About splitting 'map' method into 'prep_map' and 'map'
-------------------------------------------------------
In current bio-based dm, clone of bio is made in dm core and
passed to target's map function.
Whereas in request-based dm, clone of request must be gotten
from mapped underlying device's queue.

So I added prep_map function for targets to decide devices
to which the I/O should be directed in advance so that dm core
can get clone of request before map function call.
Though I think this prep_map approach is the best way,
I'd like to get comments if you have any other ideas.


About I/O spanning across targets
----------------------------------
Currently, splitting of I/O spanning across targets has not
implemented yet, but it should be needed.
There are 2 ways to implement it:
  1). Do in request_fn (request level splitting)
  2). Do in make_request_fn (bio level splitting)

Request level splitting is difficult because:
  - Need to split bios in the request too
  - There is an assumption in block layer that request finishes
    from head to tail in order.  If the request is splitted and
    the latter half finishes first, it breaks this assumption.
    Changing it will require major modification in block layer.

Bio level splitting can be done in the following way:
  - Create dm_make_request() and set it for make_request_fn
  - Like what dm_request() currently does, dm_make_request() will
    split bio and clone.  NO_MERGE flag is set for the cloned bio
    so that it can't be merged again in the generic __make_request().
  - The cloned bio is taken over to the I/O scheduler of the mapped
    device by calling __make_request() for it as same as bio not
    spanning targets.
  - When the cloned bio is returned, end_io hook function is called
    and wait for finishing all splitted clones.
    (This is like current clone_endio() implementation.)

So I think bio level splitting is better.
What do you think about?


=====================================================================
TODO
=-=-=

o Support I/O spanning across targets (dm core)
o Support noflush suspend (dm core)
o Support HW handler for path changing (multipath)


Thanks in advance,
Kiyoshi Ueda

