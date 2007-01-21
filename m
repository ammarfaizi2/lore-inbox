Return-Path: <linux-kernel-owner+w=401wt.eu-S1751831AbXAVBAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbXAVBAV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 20:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbXAVBAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 20:00:21 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:48898 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751831AbXAVBAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 20:00:19 -0500
Message-ID: <45B3F192.8090203@panasas.com>
Date: Mon, 22 Jan 2007 01:04:50 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       open-iscsi@googlegroups.com, Daniel.E.Messinger@seagate.com,
       Liran Schour <LIRANS@il.ibm.com>, Benny Halevy <bhalevy@panasas.com>
Subject: [RFC 0/6] bidi support: block, SCSI, and iSCSI layers
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2007 23:04:28.0639 (UTC) FILETIME=[80B766F0:01C73DB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 6 (large) patches that introduce support
for bidirectional requests in the kernel.
Since all this is going to interfere with everyone's
work, let us all comment on the implementation, naming,
and future directions. (or forever hold your peace).

The submitted work is against linux-2.6-block tree of
2007/01/15. It compiles with make allmodconfig in both
i386 and x86_64, and it boots and runs on my x86_64
test machines. The target kernel is able to compile a
Linux-kernel, burn and read cd, and pass iSCSI and OSD
tests. OSD tests are the ones who exercise BIDI I/O.

Patches summary:
1. data direction
	- add support for enum dma_data_direction in struct request
	  in preparation to full bidi support.
	- removed rq_data_dir() and added other APIs for querying request's direction.
	- fix usage of rq_data_dir() and peeking at req->cmd_flags & REQ_RW to using
	  new api.
	- clean-up bad usage of DMA_BIDIRECTIONAL and bzero of "black" requests,
	  to use the new blk_rq_init_unqueued_req()

2. request_io_part
	- extract io related fields in struct request into struct request_io_part
	  in preparation to full bidi support.
	- use new API for accessing the new sub-structure

3. bidi request
	- add one more request_io_part member for bidi support in struct request.
	- add block layer API functions for mapping and accessing bidi data buffers
	  and for ending a block request as a whole (end_that_request_block())

4. bidi-scsi
	- add bidi support at the scsi layer
	- new scsi api functions to generate bidi capable requests
	  (scsi_execute_bidi{,_async})
	- new scsi api for accessing scsi_cmnd_buff (similar to request_io_part
	  but not yet implemented as a sub-structure)

5. varlen cdb
	- add support for variable length (or just longer than 16 bytes) SCSI CDBs
	- add scsi device type for OSD devices (will be separated in actual patchset)

6. iscsi bidi varlen
	- add support for bidi and variable length commands at the iscsi layer
	  for the tcp transport. (will also be separated and sent through the open-iscsi project)

--------------------------------------------------------------------------------------------
Developer comments: (long, can be skipped)
1. This part borrows from struct scsi_cmnd use of an enum dma_data_direction member, to keep
everything the same.

1.A. It could be done in a more backward compatible way but it was a good chance for some clean-up
  (see the mess with BIO flags that used to be the same but no longer are). I also believe
  that two ways to describe the same thing will always come to haunt you later.

1.B. Speaking of which, the PCI_DMA_XXX constants are a pain being the same constants but #defined and
  untyped. It confused me in my bidi-bug hunting and it seems I'm not the only one.
  I would suggest boldly inverting enum dma_data_direction from its active-low DMA logic and
  change its name to just enum data_direction. Then, define the PCI_DMA_XXX constants as a new enum,
  and accept that new enum at all the dma_XXX mapping APIs, instead of the current u32. Note
  that this is cardinal now because bidirectional means __different_things__ in struct request
  and in DMA (or memory) mapping. the first means bidirectional access to __same__ buffer, the later
  means __two_sets__ of buffers at one request. (each buffer mapped for uni-directional access).

2. Separation of IO members into two sub structures: There are 2 possible approaches here and each approach
can have a few implementations.

2.A. First approach is to keep everything backward compatible and have a bidi sub-structure on the side.
  This approach can be seen in the attached patch for bidi support in SCSI layer. It keeps the patch to
  a minimum but is hell on readability & maintenance. It also puts a performance penalty on users like iscsi
  who wants to use a generic bidi-api.

2.B. Second approach is what is seen here. Separate all I/O members to a sub-structure, craft an
  API to access each part and a UNI api that wants to access buffers knowing they are uni-
  directional.

3.C. The second approach can be implemented as I did it: one member for uni/bidi-write and second
  for bidi-read or alternatively, using one sub-structure for "read" and another for "write". I hope
  I have built it in  such a way that this choice is merely an "implementation detail" only concerning
  the block layer and hidden behind proper access functions.

3.D. I have currently decided on the first approach for performance reasons, since 99.99% of kernel
  is uni-directional (only exception is proposed iscsi). What will be in the future? I'm not sure,
  If most bus protocols are like iSCSI (and SCSI) where there is a clear separation, and concurrency,
  between write and read states. then second approach will be the logical choice. Or maybe it is all
  exact same programming safe the toggle of a direction bit in a register, then the first approach
  wins. In any way the second approach needs a code change.
Boaz, I don't know what to do with this paragraph... I'm not sure I understand what you mean here...

3.E. One more thing I want to comment on this patch is that most changes are indications of old/badly
  coded drivers. There are plenty of good BIO and block/request APIs for proper IO access and
  advancement. There is no real need in the kernel today to directly access these members (And
  most new code does not). All these drivers need to be cleaned up.

4. SCSI layer: This is mostly the bidi implementation I sent 2 months ago but now simplified
  since the actual bidi support is done in struct request so what's left is more of an API addition. I have
  kept it like this so people can see the "backward compatible" approach for implementing bidi support.
  I must warn here, going the above "request" way, will produce a much bigger patch than all above 4 put together.
  Which is not a bad thing, only that I would like to do it one at a time, sort of sneak it in more slowly.
  (and also let people comment on what they like better).

4.A. The bidi API is just there to serve IBM's OSD driver and is not a must. One can bypass scsi-lib
  and just queue a bidi request in a generic way and if that device happens to be SCSI than it will all
  just work. But on the other hand there is nothing bad in an API that makes everything nice &
  easy.

4.B. TODO: Implementation of bidi residual count.

4.C. TODO: API change (and clean-up) of the done function on the async route. In my opinion the API should
  receive a request pointer and user will extract any info he needs.

5. OSD && Varlen.

5.A. This patch implements support for variable length cdbs and large (>16) vendor specific commands. The
  actual support is at the request level, and is used by the SCSI API. Unlike regular commands
  a user of this fixture needs to keep the command's memory buffer valid until the end of the request execution.
  just like it does with its read/write and sense buffers.

5.B. Includes also a 2 liner to support OSD type SCSI devices.

6. iSCSI bidi support.
  It is given here as an example of a bidi/varlen-cdb supporting SCSI transport and driver.
  The actual patch will go through the open-iscsi project, after the appropriate SCSI and block
  support for bidi will exist in the kernel. At which time it will be broken into 3 separate patches.

6.A. Side note: The iSCSI tests pass only when I comment out line 1643 in libiscsi.c at
  iscsi_conn_start() function. (second if). This is an old issue with iscsi tests and the iscsitarget
  project. I will send a separate e-mail about this to the open-iscsi mailing list.


Boaz

