Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTDQUw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTDQUw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:52:26 -0400
Received: from fmr01.intel.com ([192.55.52.18]:56557 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261885AbTDQUwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:52:23 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C2630D5@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'karim@opersys.com'" <karim@opersys.com>
Cc: "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
Date: Thu, 17 Apr 2003 14:03:47 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Karim Yaghmour [mailto:karim@opersys.com]
> 
> "Perez-Gonzalez, Inaky" wrote:
> > But you don't need to provide buffers, because normally the data
> > is already in the kernel, so why need to copy it to another buffer
> > for delivery?
> 
> There is no copying going on. As with kue, you have to have a
> packaged structure somewhere to send to the recipient. As per
> your code:
> +       _m4 = kmalloc (sizeof (*_m4), GFP_KERNEL);
> +       memcpy (_m4, &m4, sizeof (m4));
> +       _m4->kue.flags = KUE_KFREE;
> +       kue_send_event (&_m4->kue);
> 
> _m4 and m4 are placeholders that must exist before being queued,
> there's just no way around that. 

Yep, that is the point, and it is small enough (5 ulongs) that 
it can be embedded anywhere without being of high impact and 
having to allocate it [first example that comes to mind is
for sending a device connection message; you can embed a short
message in the device structure and query that for delivery;
no buffer, no nothing, the data straight from the source].

I didn't want to use buffers for all the reasons people has
exposed. They involve allocation of space, somehow [inside
of the buffer for example] and there is a time when you
have to start dropping things. When kue you can avoid that
when your messages are embedded in your dat structs [provided
you keep them small, if they are huge, well, you loose -
that is a conceptual limitation].

> When the channel buffer is mmap'ed in the user-process' address space,
> all that is needed is a write() with a pointer to the buffer for it
> to go to storage. There is zero-copying going on here.

That's a nice thing of your approach; kue cannot do mmap().

> Plus, kue uses lists with next & prev pointers. That simply won't
> scale if you have a buffer filling at the rate of 10,000 events/s.

Well, the total overhead for queuing an event is strictly O(1),
bar the acquisition of the queue's semaphore in the middle [I
still hadn't time to finish this and post it, btw]. I think it
is pretty scalable assuming you don't have the whole system 
delivering to a single queue.

Total is four lines if I unfold __kue_queue(), and the list_add_tail()
is not that complex. That's versus relay_write(), that I think is the
equivalent function [bar the extra goodies] is more complex
[disclaimer: this is just looking over the 030317 patch's shoulder,
I am in kind of a rush - feel free to correct me here].

> Also, at that rate, you simply can't wait on the reader to read
> events one-by-one until you can reuse the structure where you
> stored the data to be read.

That's the difference. I don't intend to have that. The data 
storage can be reused or not, that is up to the client of the
kernel API. They still can reuse it if needed by reclaiming the
event (recall_event), refilling the data and re-sending it.

That's where the send-and-forget method helps: provide a 
destructor [will replace the 'flags' field - have it cooking
on my CVS] that will be called once the event is delivered 
to all parties [if not NULL]. Then you can implement your 
own recovery system using a circular buffer, or kmalloc or
whatever you wish.

> relayfs) and the reader has to read events by the thousand every
> time.

The reader can do that, in user space; as many events as
fit into the reader-provided buffer will be delivered.

> > This is where I think relayfs is doing too much, and that is the
> > reason why I implemented the kue stuff. It is very lightweight
> > and does almost the same [of course, it is not bidirectional, but
> > still nobody asked for that].
> 
> relayfs is there to solve the data transfer problems for the most
> demanding of applications. Sending a few messages here and there
> isn't really a problem. Sending messages/events/what-you-want-to-call-it
> by the thousand every second, while using as little locking as possible
> (lockless-logging is implemented in the case of relayfs' buffer handling
> routines), and providing per-cpu buffering requires a different beast.

Well, you are doing an IRQ lock (relay_lock_channel()), so it is not
lockless. Or am I missing anything here? Please let me know, I am
really interested on how to reduce locking in for logging to the 
minimal.

Thanks,

BTW: I am going to be out of town from five minutes from now until
Monday ... not that I don't want to keep reading :)

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
