Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131246AbQK2Mf3>; Wed, 29 Nov 2000 07:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131355AbQK2MfT>; Wed, 29 Nov 2000 07:35:19 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:47826 "EHLO
        d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
        id <S131246AbQK2MfB> convert rfc822-to-8bit; Wed, 29 Nov 2000 07:35:01 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C12569A6.00425037.00@d12mta07.de.ibm.com>
Date: Wed, 29 Nov 2000 12:56:44 +0100
Subject: plug problem in linux-2.4.0-test11
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
I experienced disk hangs with linux-2.4.0-test11 on S/390 and after
some debugging I found the cause. It the new method of unplugging
block devices that doesn't go along with the S/390 disk driver:

/*
 * remove the plug and let it rip..
 */
static inline void __generic_unplug_device(request_queue_t *q)
{
        if (!list_empty(&q->queue_head)) {
                q->plugged = 0;
                q->request_fn(q);
        }
}

The story goes like this: at start the request queue was empty but
the disk driver was still working on an older, already dequeued
request. Someone plugged the device (q->plugged = 1 && queue on
tq_disk). Then a new request arrived and the unplugging was
started. But before __generic_unplug_device was reached the
outstanding request finished. The bottom half of the S/390 disk
drivers always checks for queued requests after an interrupt,
starts the first and dequeues some of the requests on the
request queue to put them on its internal queue. You could argue
that it shouldn't dequeue request if q->plugged == 1. On the other
hand why not, before the disk has nothing to do. Anyway the result
was that when the unplug routine was finally reached list_empty
was true. In that case q->plugged will not be cleared! The device
stays plugged. Forever.

The following implementation works:

/*
 * remove the plug and let it rip..
 */
static inline void __generic_unplug_device(request_queue_t *q)
{
        q->plugged = 0;
        if (!list_empty(&q->queue_head))
                q->request_fn(q);
}

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
