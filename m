Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271144AbTHCKMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271146AbTHCKMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:12:16 -0400
Received: from AMarseille-201-1-2-252.w193-253.abo.wanadoo.fr ([193.253.217.252]:28711
	"EHLO gaston") by vger.kernel.org with ESMTP id S271144AbTHCKMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:12:12 -0400
Subject: Re: IDE locking problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030803100447.GO7920@suse.de>
References: <1059900149.3524.84.camel@gaston>
	 <20030803100447.GO7920@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059905514.3514.111.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 12:11:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > would help making sure we don't get a request sneaking in ?
> 
> Hmm not really, there's still a chance that could happen.

Not too familiar with BIO here, but we would need some kind of
"dead" flag to cause a reject of any try to insert a new request
in the queue, don't you think ?

Then, IDE could do something like:

 - set dead flag
 - wait for all pending requests to drain (easy: insert a barrier
   in the queue and wait on it, with a hack for the barrier insertion
   to bypass the dead flag... ugh... maybe a blk_terminate_queue()
   doing all that would be helpful ?)
 - unregister blkdev
 - then tear down the queue (leaving the "empty" queue with the dead
   flag set, not just memset(...,0,...), so that any bozo keeping a
   reference to it will be rejected trying to insert request instead
   of trying to tap an uninitalized queue object

What do you think ?

Ben.


