Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTESNdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 09:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTESNdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 09:33:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64735 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262470AbTESNdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 09:33:08 -0400
Date: Mon, 19 May 2003 15:45:50 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: David Woodhouse <dwmw2@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030519134550.GA812@suse.de>
References: <1053297297.28446.18.camel@imladris.demon.co.uk> <200305191337.h4JDbf311387@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305191337.h4JDbf311387@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19 2003, Peter T. Breuer wrote:
> "David Woodhouse wrote:"
> > To be honest, if any programmer is capable of committing this error and
> > not finding and fixing it for themselves, then they're also capable, and
> > arguably _likely_, to introduce subtle lock ordering discrepancies which
> > will cause deadlock once in a blue moon.
> > 
> > I don't _want_ you to make life easier for this hypothetical programmer.
> > 
> > I want them to either learn to comprehend locking _properly_, or take up
> > gardening instead.
> 
> Let's quote the example from rubini & corbet of the sbull block device
> driver. The request function ends like so:
> 
> 
>         spin_unlock_irq (&io_request_lock);
>         spin_lock(&device->lock);
> 
>     /* Process all of the buffers in this (possibly clustered) request.  */
>         do {
>             status = sbull_transfer(device, req);
>         } while (end_that_request_first(req, status, DEVICE_NAME));
>         spin_unlock(&device->lock);
>         spin_lock_irq (&io_request_lock);
>         end_that_request_last(req);
>     }
>     device->busy = 0;
> }
> 
> 
> Notice that he runs end_that_request_first outside the io_request_lock
> and end_that_request_last under the lock. Do you know which is right?
> (if any :-).

Both are right, as it so happens.

> And he takes a device lock before calling the "transfer" routine.
> Yes, he's ok because his transfer function is trivial and doesn't
> take the lock, but anyone following his recipe is heading for
> trouble.

In 2.5, the device lock most likely would be the queue lock as well so
no confusion there. But what are you talking about? I'd assume that the
device lock must be held in the transfer function, why else would you
grab it in the first place in the function you quote? Please, if you are
going to find examples to support the recursive locking idea, find some
decent ones...

I think you are trying to make up problems that do not exist. I'd hate
to see recursive locks being used just because someone can't be bothered
to write to code correctly (recursive locks have its uses, the one you
are advocating definitely isn't one). Recursive locks are _not_ a remedy
for someone who doesn't understand locking or isn't capable enough to
design his locking correctly. Period.

-- 
Jens Axboe

