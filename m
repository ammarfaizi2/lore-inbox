Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbSLTAlI>; Thu, 19 Dec 2002 19:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267661AbSLTAlI>; Thu, 19 Dec 2002 19:41:08 -0500
Received: from chaos.ao.net ([205.244.242.21]:7342 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S267632AbSLTAlH>;
	Thu, 19 Dec 2002 19:41:07 -0500
Message-Id: <200212200049.gBK0n5NS016297@chaos.ao.net>
To: linux-kernel@vger.kernel.org
Subject: raid5 multi-drive-failure and recovery?
Date: Thu, 19 Dec 2002 19:49:05 -0500
From: Dan Merillat <harik@chaos.ao.net>
X-Bayes-Status: No, probability=0.000
X-Bayes-Debug: , hack:0.010, sectors:0.990, sectors:0.990, EIO:0.010, kernel:0.010, Dec:0.010, --Dan:0.010, unusable:0.010, kernel:0.010, bh:0.018, md:0.019, failed:0.034, failed:0.034, IO:0.040, archives:0.043
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a problem.  Two drives in my array developed bad sectors at
the same time.  They're in completely different places, but I can't
read the disk because md simply fails out both of them, and marks the
array unusable.

Now, I can either buy new drives and dd the raw partition over, or I
can hack the kernel to make it a bit smarter about unrecoverable
reads.

Obviously, if I have raid5_error not mark the drive bad, it will hammer
away on it, failing over and over.  My thought was to let the read
fail, catch it in raid5_end_read_request then tag the stripe_head
with the device that's failed.  If one has already failed, return
EIO.   This way further reads on the stripe_head will go to the parity
disk (until it's eventually freed.  One IO error per stripe isn't too
harsh a price to pay for disaster recovery)

in 2.4.20, I'm at raid5.c:421 where we're about to call md_error.
What happens to the bh from that point?  Obviously, it's not up-to-date,
so when 1 drive fails how does it get re-issued to be pulled from a parity
drive to reconstruct it?

Please CC me, I read via the archives.

Thanks,

--Dan



Obviously, this would ONLY be for recovery in the face of bad sectors.
As quickly as possible the bad drives need to be replaced
