Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTD2URd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 16:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbTD2URd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 16:17:33 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:43409 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S261624AbTD2URb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 16:17:31 -0400
Message-Id: <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Apr 2003 13:29:41 -0700
To: Greg KH <greg@kroah.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over
  HCI USB.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20030429041535.GA2093@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:15 PM 4/28/2003, Greg KH wrote:
>On Mon, Mar 24, 2003 at 09:03:28PM +0000, Linux Kernel Mailing List wrote:
>> ChangeSet 1.971.22.2, 2003/03/24 13:03:28-08:00, maxk@qualcomm.com
>> 
>>       [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
>>       URB and buffer managment rewrite.
>
>Max, you need to be very careful with this:
I know ;-)

>> +struct _urb *_urb_alloc(int isoc, int gfp)
>> +{
>> +     struct _urb *_urb = kmalloc(sizeof(struct _urb) +
>> +                             sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
>> +     if (_urb) {
>> +             memset(_urb, 0, sizeof(*_urb));
>> +             _urb->urb.count = (atomic_t)ATOMIC_INIT(1);
>> +             spin_lock_init(&_urb->urb.lock);
>> +     }
>> +     return _urb;
>> +}
>
>You aren't calling usb_alloc_urb() and:
>
>> +struct _urb *_urb_dequeue(struct _urb_queue *q)
>> +{
>> +     struct _urb *_urb = NULL;
>> +        unsigned long flags;
>> +        spin_lock_irqsave(&q->lock, flags);
>> +     {
>> +             struct list_head *head = &q->head;
>> +             struct list_head *next = head->next;
>> +             if (next != head) {
>> +                     _urb = list_entry(next, struct _urb, list);
>> +                     list_del(next); _urb->queue = NULL;
>> +             }
>> +     }
>> +     spin_unlock_irqrestore(&q->lock, flags);
>> +     return _urb;
>> +}
>
>You aren't calling usb_free_urb() as you are embedding a struct urb
>within your struct _urb structure.  Any reason you can't use a struct
>urb * instead and call the usb core's functions to create and return 
>a urb ?
I didn't want to do two allocations (one for struct _urb and one for struct urb).

>Otherwise any changes to the internal urb structures, and the
>usb_alloc_urb() and usb_free_urb() functions will have to be mirrored
>here in your functions, and I know I will forget to do that :)
How about 

static inline urb_init(urb)
{
        urb->xx = YY;
        ...
}

urb_alloc() 
{
        urb = kmalloc()
        urb_init(urb);
}

?

>Other than that, it's nice to see Bluetooth SCO support for Linux, very
>nice job.
Thank you.

I was actually going to ask you guys if you'd be interested in generalizing this _urb_queue() 
stuff that I have for other drivers. Current URB api does not provide any interface for 
queueing/linking/etc of URBs in the _driver_ itself. Things like next, prev, etc are used in 
the HCD. So if driver submits bunch of different URBs (and potentially multiple URBs of the 
same type like hci_usb does) it has to implement its own lists, arrays and stuff. I used to 
use SKBs for URB queues but struct sk_buff is to big for that simple task.

Max

