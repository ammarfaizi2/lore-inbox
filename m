Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130868AbRBTW6x>; Tue, 20 Feb 2001 17:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRBTW6n>; Tue, 20 Feb 2001 17:58:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35332 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130868AbRBTW6Z>;
	Tue, 20 Feb 2001 17:58:25 -0500
Date: Tue, 20 Feb 2001 23:58:13 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: plugging in 2.4. Does it work?
Message-ID: <20010220235813.B811@suse.de>
In-Reply-To: <200102202241.f1KMftG31691@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102202241.f1KMftG31691@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Tue, Feb 20, 2001 at 11:41:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20 2001, Peter T. Breuer wrote:
>  int my_end_request(struct request *req) {
>    unsigned long flags; int dequeue = 0;
>    spin_lock_irqsave(&io_request_lock, flags);
>    if (!req->errors) {
>      while (req->nr_sectors > 0) {
>        printk( KERN_DEBUG "running end_first on req with %d sectors\n",
>               req->nr_sectors);
>        if (!end_that_request_first (req, !req->errors, DEVICE_NAME))
>          break;
>      }
>    }
>    printk( KERN_DEBUG "running end_first on req with %d sectors\n",
>             req->nr_sectors);
>    if (!end_that_request_first (req, !req->errors, DEVICE_NAME)) {
>      printk( KERN_DEBUG "running end_last on req with %d sectors\n",
>               req->nr_sectors);
>      end_that_request_last(req);
>      dequeue = 1;
>    }
>    spin_unlock_irqrestore(&io_request_lock, flags);
>    return dequeue;
>  }

Forgot to mention that the above doesn't make much sense at all. If
there are no errors, you loop through ending all the buffers. Then
you fall through and end the the first (non-existant) chunk? And
end_that_request_first does not need to hold the io_request_lock,
you can move that down to protect end_that_request_last.

-- 
Jens Axboe

