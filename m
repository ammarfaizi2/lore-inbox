Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTESNYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 09:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTESNYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 09:24:52 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:28686 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id S262464AbTESNYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 09:24:51 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200305191337.h4JDbf311387@oboe.it.uc3m.es>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <1053297297.28446.18.camel@imladris.demon.co.uk> from David Woodhouse
 at "May 18, 2003 11:34:58 pm"
To: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 19 May 2003 15:37:41 +0200 (MET DST)
Cc: ptb@it.uc3m.es, William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Woodhouse wrote:"
> To be honest, if any programmer is capable of committing this error and
> not finding and fixing it for themselves, then they're also capable, and
> arguably _likely_, to introduce subtle lock ordering discrepancies which
> will cause deadlock once in a blue moon.
> 
> I don't _want_ you to make life easier for this hypothetical programmer.
> 
> I want them to either learn to comprehend locking _properly_, or take up
> gardening instead.

Let's quote the example from rubini & corbet of the sbull block device
driver. The request function ends like so:


        spin_unlock_irq (&io_request_lock);
        spin_lock(&device->lock);

    /* Process all of the buffers in this (possibly clustered) request.  */
        do {
            status = sbull_transfer(device, req);
        } while (end_that_request_first(req, status, DEVICE_NAME));
        spin_unlock(&device->lock);
        spin_lock_irq (&io_request_lock);
        end_that_request_last(req);
    }
    device->busy = 0;
}


Notice that he runs end_that_request_first outside the io_request_lock
and end_that_request_last under the lock. Do you know which is right?
(if any :-).

And he takes a device lock before calling the "transfer" routine.
Yes, he's ok because his transfer function is trivial and doesn't
take the lock, but anyone following his recipe is heading for
trouble.

Peter
