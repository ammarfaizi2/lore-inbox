Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTLaOBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 09:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTLaOBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 09:01:16 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:39652 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264961AbTLaOBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 09:01:15 -0500
Subject: question about BIO/request ordering / barriers
From: Christophe Saout <christophe@saout.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Content-Type: text/plain
Message-Id: <1072879267.22227.10.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Dec 2003 15:01:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm just digging through the device-mapper code and a question came up:

Are "intermediate block device drivers" (like device-mapper) allowed to
reorder BIOs?

I'm not talking about BIOs submitted from different threads at the same
time but BIOs submitted from the same thread sequentially, especially
writes.

That would mean that BIOs might be reordered around barriers which would
break potential users.

At the moment I suppose this shouldn't be an issue because I didn't find
a single user in the whole kernel that actually submits BIOs with
BIO_RW_BARRIER set via submit_bio/generic_make_request (journaling
filesystems are simply waiting until all writes are finished before
continueing, right?).

There are same cases (in device-mapper) where

a) writes get get suspended and queued for later submission where it is
not ensured that those writes are submitted before any other writes that
could possibly occur after the device gets resumed (generic dm code)
b) a stack (instead of a fifo) is used to queue requests and submit them
later (not yet included code)
c) writes can get queued but reads are directly passed through
(snapshotting code too)

Also, if DM recevices a barrier shouldn't this barrier be somehow sent
to all real devices instead of the one that the request is actually sent
to?


