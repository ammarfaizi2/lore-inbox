Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUCQUCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUCQUCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:02:22 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:28804 "EHLO smtp02.uc3m.es")
	by vger.kernel.org with ESMTP id S262020AbUCQUCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:02:19 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200403172002.i2HK2GV10366@oboe.it.uc3m.es>
Subject: floppy driver 2.6.3 question
To: paul@paulbristow.net
Date: Wed, 17 Mar 2004 21:02:16 +0100 (MET)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In the 2.6.3 floppy driver, when the driver is asked to revalidate by
kernel check_disk_change (after the latter asks and the floppy signalled
media_changed), the floppy driver constructs a read bio for the first
block and submits it via submit_bio, and waits for completion of the
bio.

However, the bio's embedded completion only signals back if the
submitted bio was successful, as far as I can tell:


static int floppy_rb0_complete(struct bio *bio, unsigned int bytes_done, int err)
{
	if (bio->bi_size)
		return 1;

	complete((struct completion*)bio->bi_private);
	return 0;
}

Note that if the bi_size is nonzero, we return without signalling. Now
bi_size starts out nozero

    bio.bi_size = size;

but I _think_ bi_size is zeroed along the way somewhere in end_request
(who knows?) if all goes well, so that nonzero means we still have more
to do in this bio. So if things go badly, completion is never signalled
and the submitted read is waited for forever? (and the result is never
tested).

	submit_bio(READ, &bio);
	generic_unplug_device(bdev_get_queue(bdev));
	process_fd_request();
	wait_for_completion(&complete);

	__free_page(page);

My reading therefore is that we cannot do revalidation until we are
sure that the floppy is there. If we feel sure, but are wrong, the 
test read of the first block will hang during the revalidation.

media_changed is tested using poll_drive(0,0). It's triggered by
kernel check_disk_change, which is run in open on the device.
Therefore I feel that opens may hang if the floppy is not there
when we think it is, such as if we yank it out just after it has been
polled, or if the floppy has bad sectors, or something like that.

Can somebody clear up my worry/confusion over how floppy_rb0_complete
can be correct to sometimes not signal completion?  How can it risk
leaving us waiting forever?  How can it even be called when the bio is
not yet complete?  And if the bio is ended when not complete, don't we
want to know about it, because then we will be able to say that the
floppy is not there, or is invalid? Surely we don't want to wait!?




Peter


