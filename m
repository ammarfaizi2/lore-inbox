Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271082AbTHCIm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 04:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271089AbTHCIm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 04:42:57 -0400
Received: from AMarseille-201-1-2-252.w193-253.abo.wanadoo.fr ([193.253.217.252]:8487
	"EHLO gaston") by vger.kernel.org with ESMTP id S271082AbTHCIm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 04:42:56 -0400
Subject: IDE locking problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059900149.3524.84.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 10:42:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan & Bart !

While fixing my hotswap media-bay IDE controller for 2.6, I found
a locking problem with IDE (again ? :) in ide_unregister_hw. Basically
the problem is that it calls blk_cleanup_queue(), which is unsafe to
call with a lock held (it will call flush_workqueue() at one point).
Other side effect, flush_workqueue() will re-enable IRQs, thus allowing
us to get an IRQ while holding the spinlock -> double lock, but that's
just a side effect of calling flush_workqueue in that context.

So the call to blk_cleanup_queue() shall be moved outside of the
spinlock. I don't know much about the BIO details, is it possible
to first unregister_blkdev, then only call blk_cleanup_queue() ? That
would help making sure we don't get a request sneaking in ?

Ben.


