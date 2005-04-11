Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVDKDqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVDKDqH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVDKDqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:46:06 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:61763 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261678AbVDKDpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:45:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=UIbRzPfsXCW/Sl1MIxIYHFrwcd0X1WST2asnnfFkLVVkLswx3BkA6FMdfnqWUELV/y5AUYhNUC2nrJLqd63cIihIS2PqSzqQ97L6gTTdZg7LwA2xBra/Wh8CVU6chCx0HbgOV6LQjQrc6+CKXApVyduikj3LkEL3+2cBW430iTQ=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH scsi-misc-2.6 00/04] scsi: clear REQ_SPECIAL/REQ_SOFTBARRIER usages
Message-ID: <20050411034451.B75F3870@htj.dyndns.org>
Date: Mon, 11 Apr 2005 12:45:37 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

 This patchset is split up of REQ_SPECIAL update patches (#01-02) of
previous patchset posted on March 31.  Explicit setting of
REQ_SOFTBARRIER in scsi_init_io() is added.

 This patchset makes REQ_SPECIAL mean that the request is a special
request and REQ_SOFTBARRIER setting explicit.

 Previously, REQ_SPECIAL duplicately meant the request has been
prepp'ed by SCSI midlayer and/or the request is a special request.
This left special requests handling in the midlayer subtley
inconsistent.

 Also, the setting of REQ_SPECIAL was done by the block layer using
blk_insert_request() mostly but sometimes by the SCSI midlayer (when
returning BLK_PREP_DEFER from scsi_prep_fn()).  blk_insert_request()
was used for two different purposes.

 * enqueue special requests
 * turn on REQ_SPECIAL|REQ_SOFTBARRIER and call blk_requeue_request().

 The second somewhat unobvious feature of blk_insert_request() is used
only by SCSI midlayer and SCSI midlayer depended on it to set
REQ_SOFTBARRIER.  Unfortunately, when the SCSI midlayer sets
REQ_SPECIAL explicitly (sg allocation failure path) it didn't set
REQ_SOFTBARRIER, creating a *highly* unlikely but still existing dead
lock condition caused by allowing reorder of a request which has its
cmd allocated.  IMHO, this proves the subtlety of current situation.

 This patch makes SCSI midlayer use blk_requeue_request() for
reqeueuing and setting of REQ_SOFTBARRIER explicit.

 To prevent more misuses, the last patch in this patchset remove
requeue feature from blk_insert_request().  Requeueing should be done
with blk_requeue_request() not blk_insert_request().


[ Start of patch descriptions ]

01_scsi_REQ_SPECIAL_semantic_scsi_init_io.patch
	: replace REQ_SPECIAL with REQ_SOFTBARRIER in scsi_init_io()

	scsi_init_io() used to set REQ_SPECIAL when it fails sg
	allocation before requeueing the request by returning
	BLKPREP_DEFER.  REQ_SPECIAL is being updated to mean special
	requests and we need to set REQ_SOFTBARRIER for half-prepp'ed
	requests.  So, replace REQ_SPECIAL with REQ_SOFTBARRIER.

02_scsi_REQ_SPECIAL_semantic_scsi_queue_insert.patch
	: make scsi_queue_insert() use blk_requeue_request()

	scsi_queue_insert() used to use blk_insert_request() for
	requeueing requests.  This behavior depends on the unobvious
	behavior of blk_insert_request() setting REQ_SPECIAL and
	REQ_SOFTBARRIER when requeueing.  This patch makes
	scsi_queue_insert() use blk_requeue_request() and explicitly
	set REQ_SOFTBARRIER.  As REQ_SPECIAL now means special
	requests, the flag is not set on requeue.

	Note that scsi_queue_insert() now calls scsi_run_queue()
	itself, and the prototype of the function is added right above
	scsi_queue_insert().  This is temporary, as later requeue path
	consolidation patchset removes scsi_queue_insert().  By adding
	temporary prototype, we can do away with unnecessary changes.

03_scsi_REQ_SPECIAL_semantic_scsi_requeue_command.patch
	: make scsi_requeue_request() use blk_requeue_request()

	scsi_requeue_request() used to use blk_insert_request() for
	requeueing requests.  This behavior depends on the unobvious
	behavior of blk_insert_request() setting REQ_SPECIAL and
	REQ_SOFTBARRIER when requeueing.  This patch makes
	scsi_requeue_request() use blk_requeue_request() and
	explicitly set REQ_SOFTBARRIER.  As REQ_SPECIAL now means
	special requests, the flag is not set on requeue.

04_scsi_blk_insert_request_no_requeue.patch
	: remove requeue feature from blk_insert_request()

	blk_insert_request() has a unobivous feature of requeuing a
	request setting REQ_SPECIAL|REQ_SOFTBARRIER.  SCSI midlayer
	was the only user and as previous patches removed the usage,
	remove the feature from blk_insert_request().  Only special
	requests should be queued with blk_insert_request().  All
	requeueing should go through blk_requeue_request().

[ End of patch descriptions ]


 This patchset completes preparation for scsi_request_fn()
reimplementation patchset.  As it seemed better to clear up requeue
paths inside scsi_request_fn() first, requeue path consolidation
patchset follows scsi_request_fn() reimplementation patchset.

 Thanks a lot.

