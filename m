Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbTEHWnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTEHWnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:43:41 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:59114 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S262222AbTEHWnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:43:37 -0400
Message-Id: <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 08 May 2003 15:55:59 -0700
To: David Brownell <david-b@pacbell.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. 
  Support for SCO over HCI USB.
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3EAF5727.7050501@pacbell.net>
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
 <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

(sorry for not replying right away)

At 09:55 PM 4/29/2003, David Brownell wrote:
>Max Krasnyansky wrote:
>>Basically I'd like to have same kind of API that we have for SKB without
>>an overhead of SKBs.
>
>I'd also like to see most of the per-request invocation costs
>shrink.  You seem to be focussing on the queueing parts of
>SKB-ness, yes?  
Yes.

>The lifecycles aren't that close; and other
>parts of the SKB and URB models are different too.
Totally.

>Inside USB, "usbcore" and the HCDs are already working with
>queues of URBs associated with each endpoint.
>
>The USB device drivers can't do that as easily, since core/HCD
>owns the urb->urb_list field after usb_submit_urb() and before
>the completion callback is issued.  Much like the next layer
>owns the SKB after you hand it off...
Yep. That's exactly what I'd like to address.

>>Here is what I've done for Bluetooth HCI USB driver.
>>struct _urb_queue {
>>        struct list_head head;
>>        spinlock_t       lock;
>>};
>>struct _urb {
>>        struct list_head  list;
>>        struct _urb_queue *queue;
>
>Those fields (reordered) are like sk_buff_head and sk_buff.
>How much of that is "needed here" vs. "SKBs work like that"?
If we want to provide urb_queue(),urb_dequeue(),etc then we'd
need all of the above. 

>Today those spinlocks are driver-specific, and urb->context
>(or urb->hcpriv) seems to have been enough of a queue head
>backpointer for most drivers.  
I'd say it's enough for the drivers that submit only 1 or 2 request 
types and one URB per request. Drivers that use bulk queening and/or have
to deal with multiple requests have to implement some infrastructure to
keep track of it's own URBs.

>The notable omission is the lack of a list_head for device drivers to use even
>after an URB has been submitted -- a lifecycle state that
>SKBs don't have.
I guess just adding another 'struct list_head', usable by the drivers, to the 'struct urb' 
is probably enough. However like I mentioned above if we want to provide urb_queue()
and friends we'd need 'struct urb_queue' or something similar.

>>        int               type;
>>        void              *priv;
>>};
>
>
>How would "priv" differ from the current per-request state,
>urb->context (for device driver) or urb->hcpriv (for HCD)?
Oh, it's something that was useful in my driver. We don't have to add another priv.

>I've also been interested in seeing something like skb->cb[].
>HCDs could use that as pre-allocated per-request memory,
>avoiding per-request heap allocations.
Yes yes yes :). And for drivers too. That were my _urb->type and stuff would go.

>>It's now easy to do things like
>>        _urb_queue_tail(&pending_q, _urb);
>>        usb_urb_submit(&_urb->urb);
>>and
>>        while (_urb = _urb_dequeue(&pending_q))
>>                usb_unlink_urb(&_urb->urb);
>
>Those resemble the kinds of primitives I might want to see
>in a Linux 2.7 USB API ... focussed on the endpoint (queue),
>rather than making the core/HCD layers do extra work to
>figure out what queue is involved.  And ideally general
>enough that device drivers would work the same way.
>
>That first pair is pretty much what any HCD does today,
>except that the endpoint's queue is hidden/internal and
>the second step is "feed it to the hardware!".
>
>The second is pretty much what usbcore (now) does when it
>shuts down an endpoint's queue.  But again, that queue
>is hidden/internal.  Caller needs to ensure the hardware is
>not working on the queue during that loop, and there are
>some other synchronization issues too.

Do you think we can add this 
        struct urb {
                ...
                struct list_head drv_list;
                char drv_cb[X];
                char hcd_cb[X]; 
                ...
        };
now though ?

Max

