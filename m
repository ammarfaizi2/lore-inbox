Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132654AbQK3HfL>; Thu, 30 Nov 2000 02:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132656AbQK3HfC>; Thu, 30 Nov 2000 02:35:02 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:44686 "EHLO
        bacchus-int.veritas.com") by vger.kernel.org with ESMTP
        id <S132654AbQK3Hev>; Thu, 30 Nov 2000 02:34:51 -0500
Date: Thu, 30 Nov 2000 12:32:01 +0530 (IST)
From: V Ganesh <ganesh@veritas.com>
Message-Id: <200011300702.MAA26287@vxindia.veritas.com>
To: linux-kernel@vger.kernel.org
Cc: linux-LVM@EZ-Darmstadt.Telekom.de, mingo@redhat.com
Subject: [bug] infinite loop in generic_make_request()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ed to maintainers of md and lvm]

hi,
in generic_make_request(), the following code handles stacking:

do {
       q = blk_get_queue(bh->b_rdev);
       if (!q) {
                        printk(...)
                        buffer_IO_error(bh);
                        break;
       }
} while (q->make_request_fn(q, rw, bh));

however, make_request_fn may return -1 in case of errors. one such fn is
raid0_make_request(). this causes generic_make_request() to loop endlessly.
lvm returns 1 unconditionally, so it would also loop if an error occured in
lvm_map(). other bdevs might have the same problem.
I think a better mechanism would be to mandate that make_request_fn ought
to call bh->b_end_io() in case of errors and return 0.

ganesh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
