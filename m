Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTDVDuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 23:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTDVDuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 23:50:15 -0400
Received: from fmr02.intel.com ([192.55.52.25]:25566 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262894AbTDVDuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 23:50:10 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263841@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'karim@opersys.com'" <karim@opersys.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
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
Date: Mon, 21 Apr 2003 21:02:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Karim Yaghmour [mailto:karim@opersys.com]
> 
> Consider the following:
> 1) kue_read() has a while(1) which loops around and delivers messages
> one-by-one (to the best of my understanding of the code you posted).

That's right.

> Hence, delivery time increases with the number of events. In contrast,
> relayfs can deliver tens of thousands of events in a single shot.

Sure, I agree with that - it is the price to pay for less code and
not having to copy on the kernel side. As I mentioned before to Tom,
I don't think that in the long run the overhead will be that much,
although it is true it will be very dependent on the average size of 
the messages and how many you deliver. If we are delivering two-byte
messages at 1M/second rate, the effectivity rate goes down, and with
it the scalability.

However, in relayfs that problem is shifted, unless I am missing 
something. For what I know, so far, is that you have to copy the
message to the relayfs buffer, right? So you have to generate the
message and then copy it to the channel with relay_write(). So
here is kue's copy_to_user() counterpart.

If there were a way to reserve the space in relayfs, so that then
I can generate the message straight over there, that scalability
problem would be gone.

> 2) by having to maintain next and prev pointers, kue consumes more
> memory than relayfs (at least 8 bytes/message more actually, on a
> 32-bit machine.) For large messages, the impact is negligeable, but
> the smaller the messages the bigger the overhead.

True; I would say most messages are going to be at least 30 
something bytes in length. I don't think there is like an 
estimated average of the messages size, right?

> 3) by having to go through the next/prev pointers, accessing message
> X requires reading all messages before it. This can be simplified

Not really, because access is sequential, one shot. Once you have
read it, there it goes. So you always keep a pointer to the next
msg that you are going to read.

> are used. [Other kue calls are also handicapped by similar problems,
> such as the deletion of the entire list.]

Yes, this is hopelessly O(N), but creation or deletion of an entire
list is not such a common thing (I would say that otherwise would
imply some design considerations that should be revised in the
system). 

Same thing goes for the closure of a file descriptor, that has
to go over the list deciding who to send to the gallows. Need to
work on that though.

> > That's the difference. I don't intend to have that. The data
> > storage can be reused or not, that is up to the client of the
> > kernel API. They still can reuse it if needed by reclaiming the
> > event (recall_event), refilling the data and re-sending it.
> 
> Right, but by reusing the event, older data is thereby destroyed
> (undelivered). Which comes back to what I (and others) have been
> saying: kue requires the sender's data structures to exist until
> their content is delivered.

That's it, that is the principle of a circular buffer. AFAIK, you
have the same in relayfs. Old stuff gets dropped. Period. And the
sender's data structures don't really need to exist forever,
because the event is self-contained. The only part that might
be a problem is the destructor [if for example, you were a module,
the destructor code was in the module and the module unloaded 
without recalling pending events first - the kind of thing
you should never do; either use a non-modular destructor or make
sure the module count is not decreased until all the events have
been delivered or recalled ... simple to do too]

However, there are two different concepts here. One is the event
that you want to send and recall it if not delivered by the time
it does not make sense anymore (think plug a device, then remove
it). The other want is the event you want delivered really badly
(think a "message" like "the temperature of the nuclear reactor's
core has reached the high watermark").

First one is the kind of event you would want to plug into the
data structures (or not, you might also kmalloc() it) and then,
when it stops making sense, recall it.

Second one, you don't care what happens after you are not there.
The code just had to set it on its way home.

The key is that the client of the API can control that behavior.

> Right, but then you have 2 layers of buffering/queing instead
> of a single one.

No, I just have one buffering/queuing, because I still had to 
generate the message to put it somewhere. And I generate it 
directly to what is going to be delivered.

> Right, but kue has to loop through the queue to deliver the messages
> one-by-one. The more messages there are, the longer the delivery time.
> Not to mention that you first have to copy it to user-space before
> the reader can do write() to put it to permanent storage. With relafys,
> you just do write() and you're done.

As I mentioned before, this kind-of-compensates-but-not-really
with the fact of having to generate the message and then copy
it to the channel.

I think that at this point it'd be interesting to run something
like a benchmark [once I finish the destructor code], however,
it is going to be fairly difficult to test both implementations
in similar grounds. Any ideas?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
