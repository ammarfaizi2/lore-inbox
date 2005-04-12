Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVDLM66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVDLM66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVDLM6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:58:30 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:5729 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262425AbVDLMwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:52:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=dUdctdA/eQTc9HPfdUXwbxZ2kJlJ5n2IvqAHP3sd0lM/kKeM/nW4iiROl/CypE33IqDnRdKsWGAAxfgP06CeW5J6MQ0VYl8r3nO69g4L7+7dJ8ny+3yGjYXi9NOY/FhrcNgMTn1OohbU4ml7vSoCW6srGU3q1f8Pds9IDUxs0Y0=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH scsi-misc-2.6 00/07] scsi: requeue path consolidation
Message-ID: <20050412125219.88E5C1F6@htj.dyndns.org>
Date: Tue, 12 Apr 2005 21:52:21 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello again, guys.

 This is the last patchset and assumes that all previous patchsets are
applied.  This patchset conolidates requeue paths such that all
requeue after command issue goes through scsi_requeue_command().
Requeueing due to unifinished bytes goes through
scsi_requeue_command_reprep() and due to error through
scsi_retry_command().

 This is the last patchset before the new implementation of scsi
device state model.  New state model is complete now and ready to be
splitted & submitted.  As soon as these patchsets are settled, I'll
post the new device model patchset.

[ Start of patch descriptions ]

01_scsi_requeue_make_requeue_command_public.patch
	: update and make public scsi_requeue_command()

	This patch makes the following changes to
	scsi_requeue_command() and make the function public.

	* remove redundant argument @q
	* remove REQ_DONTPREP clearing
	* add state/owner setting

	A new inline function scsi_requeue_command_reprep() is defined
	and used for the original users of scsi_requeue_command().

	Using a wrapper function for reprep cases is suggested by
	Christoph Hellwig.

02_scsi_requeue_use_scsi_requeue_command_in_scsi_retry_command.patch
	: make scsi_retry_command() use scsi_requeue_command()

	scsi_retry_command() orignally used scsi_queue_insert() for
	requeueing.  This patch makes it use scsi_retry_command()
	instead.  Adding a call to scsi_device_unbusy() is sufficient
	and the change also makes scsi_retry_command() symmetric with
	scsi_finish_command() in how it unbusies the command.  Also as
	there's nothing to return, make the function void.

03_scsi_requeue_use_scsi_retry_command_instead_of_scsi_queue_insert.patch
	: replace scsi_queue_insert() usages with scsi_retry_command()

	There are two users of scsi_queue_insert() left now.  One in
	scsi_softirq() and the other in scsi_eh_flush_done_q().  The
	only additional functionality of scsi_queue_insert() used is
	setting device_blocked on ADD_TO_MLQUEUE case in
	scsi_softirq().

	Open code device_blocked setting and replace
	scsi_queue_insert() with scsi_retry_command() in both cases.

04_scsi_requeue_remove_scsi_queue_insert.patch
	: remove scsi_queue_insert()

	scsi_queue_insert() now has no user left.  Kill it.

05_scsi_requeue_move_init_cmd_errh.patch
	: move scsi_init_cmd_errh() from request_fn to prep_fn.

	As now all non-reprepped requeue goes through
	scsi_retry_command() which clears sense buffer, there's no
	need to call scsi_init_cmd_errh() in scsi_request_fn().  Move
	scsi_init_cmd_errh() to scsi_prep_fn().

06_scsi_requeue_reset_result.patch
	: add cmd->result clearing

	cmd->result wasn't cleared on requeue or reprep.  Clear it.

07_scsi_requeue_consolidate_setup_cmd_retry_calls_in_eh.patch
	: consolidate scsi_cmd_retry() calls

	scsi_setup_cmd_retry() is needed because scsi eh may alter
	scsi_cmnd to issue eh commands.  Consolidate calls to
	scsi_setup_cmd_retry() to one place in scsi_eh_flush_done_q().
	This change makes scsi_retry_command() more symmetrical with
	scsi_finish_command().

[ End of patch descriptions ]

 Thanks a lot.

