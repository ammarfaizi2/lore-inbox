Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbTD3E3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 00:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTD3E3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 00:29:23 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:48534 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S262031AbTD3E3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 00:29:21 -0400
Date: Tue, 29 Apr 2003 21:55:03 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update.  Support
 for SCO over HCI USB.
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Message-id: <3EAF5727.7050501@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
 <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Krasnyansky wrote:
> 
> Basically I'd like to have same kind of API that we have for SKB without
> an overhead of SKBs.

I'd also like to see most of the per-request invocation costs
shrink.  You seem to be focussing on the queueing parts of
SKB-ness, yes?  The lifecycles aren't that close; and other
parts of the SKB and URB models are different too.

Inside USB, "usbcore" and the HCDs are already working with
queues of URBs associated with each endpoint.

The USB device drivers can't do that as easily, since core/HCD
owns the urb->urb_list field after usb_submit_urb() and before
the completion callback is issued.  Much like the next layer
owns the SKB after you hand it off...


> Here is what I've done for Bluetooth HCI USB driver.
> 
> struct _urb_queue {
>         struct list_head head;
>         spinlock_t       lock;
> };
> 
> struct _urb {
>         struct list_head  list;
>         struct _urb_queue *queue;
 >         struct urb        urb;

Those fields (reordered) are like sk_buff_head and sk_buff.
How much of that is "needed here" vs. "SKBs work like that"?

Today those spinlocks are driver-specific, and urb->context
(or urb->hcpriv) seems to have been enough of a queue head
backpointer for most drivers.  The notable omission is
the lack of a list_head for device drivers to use even
after an URB has been submitted -- a lifecycle state that
SKBs don't have.


>         int               type;
>         void              *priv;
> };


How would "priv" differ from the current per-request state,
urb->context (for device driver) or urb->hcpriv (for HCD)?

I've also been interested in seeing something like skb->cb[].
HCDs could use that as pre-allocated per-request memory,
avoiding per-request heap allocations.


> It's now easy to do things like
>         _urb_queue_tail(&pending_q, _urb);
>         usb_urb_submit(&_urb->urb);
> and
>         while (_urb = _urb_dequeue(&pending_q))
>                 usb_unlink_urb(&_urb->urb);

Those resemble the kinds of primitives I might want to see
in a Linux 2.7 USB API ... focussed on the endpoint (queue),
rather than making the core/HCD layers do extra work to
figure out what queue is involved.  And ideally general
enough that device drivers would work the same way.

That first pair is pretty much what any HCD does today,
except that the endpoint's queue is hidden/internal and
the second step is "feed it to the hardware!".

The second is pretty much what usbcore (now) does when it
shuts down an endpoint's queue.  But again, that queue
is hidden/internal.  Caller needs to ensure the hardware is
not working on the queue during that loop, and there are
some other synchronization issues too.

- Dave



> etc
> 
> Max
> 
> 




