Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUAARSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 12:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUAARSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 12:18:30 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:65189 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264527AbUAARS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 12:18:27 -0500
Subject: Possibly wrong BIO usage in ide_multwrite
From: Christophe Saout <christophe@saout.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1072977507.4170.14.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 18:18:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was just investigating where bio->bi_idx gets modified in the kernel.

I found these lines in ide-disk.c in ide_multwrite (DMA off, TASKFILE_IO
off):

> if (++bio->bi_idx >= bio->bi_vcnt) {
>     bio->bi_idx = 0;
>     bio = bio->bi_next;
> }

(rq->bio also gets changed but it's protected by the scratch buffer)

I think changing the bi_idx here is dangerous because
end_that_request_first needs this value to be unchanged because it
tracks the progress of the bio processing and updates bi_idx itself.

And bio->bi_idx = 0 is probably wrong because the bio can be submitted
with bio->bi_idx > 0 (if the bio was splitted and there are clones that
share the bio_vec array, like raid or device-mapper code).

If it really needs to play with bi_idx itself care should be taken to
reset bi_idx to the original value, not to zero.

I wasn't able to trigger a problem though, I don't know why exactly,
perhaps there are paths in __end_that_request_first that are not
interested in bi_dx. I still think there is something wrong with it.


