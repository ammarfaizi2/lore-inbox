Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTD2VxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTD2VxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:53:00 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:925 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S261767AbTD2Vw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:52:58 -0400
Message-Id: <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Apr 2003 15:04:53 -0700
To: David Brownell <david-b@pacbell.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update.
  Support for SCO over HCI USB.
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3EAEF11B.4070000@pacbell.net>
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:39 PM 4/29/2003, David Brownell wrote:

>> I was actually going to ask you guys if you'd be interested
>> in generalizing this _urb_queue() stuff that I have for
>> other drivers. Current URB api does not provide any interface
>> for queueing/linking/etc of URBs in the _driver_ itself.
>
>I only saw fragments of the original patch -- could you be just
>a bit more specific?
>
>If you're suggesting adding some "struct list_head" into
>"struct urb" for exclusive use of the interface's driver
>(instead of urb_list, which is for usbcore/hcd) ... I'd
>agree that'd be a good thing.
>
>In fact I recently got around to adding that to the
>"gadget side" analogue of an URB.  For much the same
>kind of reasons as you mentioned.

Basically I'd like to have same kind of API that we have for SKB without
an overhead of SKBs.
Here is what I've done for Bluetooth HCI USB driver.

struct _urb_queue {
        struct list_head head;
        spinlock_t       lock;
};

struct _urb {
        struct list_head  list;
        struct _urb_queue *queue;
        int               type;
        void              *priv;
        struct urb        urb;
};

struct _urb *_urb_alloc(int isoc, int gfp);
static inline void _urb_free(struct _urb *_urb);
static inline void _urb_queue_init(struct _urb_queue *q);
static inline void _urb_queue_head(struct _urb_queue *q, struct _urb *_urb);
static inline void _urb_queue_tail(struct _urb_queue *q, struct _urb *_urb);
static inline void _urb_unlink(struct _urb *_urb);
struct _urb *_urb_dequeue(struct _urb_queue *q);

_urb is an ugly name I know but I couldn't come up with the better one :)

It's now easy to do things like
        _urb_queue_tail(&pending_q, _urb);
        usb_urb_submit(&_urb->urb);
and
        while (_urb = _urb_dequeue(&pending_q))
                usb_unlink_urb(&_urb->urb);
etc

Max

