Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbTDUPtY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTDUPtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:49:24 -0400
Received: from opersys.com ([64.40.108.71]:24070 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261521AbTDUPtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:49:22 -0400
Message-ID: <3EA4149E.776C2FA7@opersys.com>
Date: Mon, 21 Apr 2003 11:56:14 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: Re: [patch] printk subsystems
References: <A46BBDB345A7D5118EC90002A5072C780C2630D5@orsmsx116.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Others have addressed several points already, I just want to come
back to the scalability issues to make my point clear:

"Perez-Gonzalez, Inaky" wrote:
> Well, the total overhead for queuing an event is strictly O(1),
> bar the acquisition of the queue's semaphore in the middle [I
> still hadn't time to finish this and post it, btw]. I think it
> is pretty scalable assuming you don't have the whole system
> delivering to a single queue.

Consider the following:
1) kue_read() has a while(1) which loops around and delivers messages
one-by-one (to the best of my understanding of the code you posted).
Hence, delivery time increases with the number of events. In contrast,
relayfs can deliver tens of thousands of events in a single shot.

2) by having to maintain next and prev pointers, kue consumes more
memory than relayfs (at least 8 bytes/message more actually, on a
32-bit machine.) For large messages, the impact is negligeable, but
the smaller the messages the bigger the overhead.

3) by having to go through the next/prev pointers, accessing message
X requires reading all messages before it. This can be simplified
with relayfs if: a) equal-sized messages are used, b) sub-buffers
are used. [Other kue calls are also handicapped by similar problems,
such as the deletion of the entire list.]

> > Also, at that rate, you simply can't wait on the reader to read
> > events one-by-one until you can reuse the structure where you
> > stored the data to be read.
> 
> That's the difference. I don't intend to have that. The data
> storage can be reused or not, that is up to the client of the
> kernel API. They still can reuse it if needed by reclaiming the
> event (recall_event), refilling the data and re-sending it.

Right, but by reusing the event, older data is thereby destroyed
(undelivered). Which comes back to what I (and others) have been
saying: kue requires the sender's data structures to exist until
their content is delivered.

> That's where the send-and-forget method helps: provide a
> destructor [will replace the 'flags' field - have it cooking
> on my CVS] that will be called once the event is delivered
> to all parties [if not NULL]. Then you can implement your
> own recovery system using a circular buffer, or kmalloc or
> whatever you wish.

Right, but then you have 2 layers of buffering/queing instead
of a single one.

> > relayfs) and the reader has to read events by the thousand every
> > time.
> 
> The reader can do that, in user space; as many events as
> fit into the reader-provided buffer will be delivered.

Right, but kue has to loop through the queue to deliver the messages
one-by-one. The more messages there are, the longer the delivery time.
Not to mention that you first have to copy it to user-space before
the reader can do write() to put it to permanent storage. With relafys,
you just do write() and you're done.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
