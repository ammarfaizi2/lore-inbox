Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVATCHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVATCHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVATCHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:07:15 -0500
Received: from mail.inter-page.com ([207.42.84.180]:33297 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261828AbVATCGx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:06:53 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <linux@horizon.com>, <linux-kernel@vger.kernel.org>
Cc: <lm@bitmover.com>, <torvalds@osdl.org>
Subject: RE: Make pipe data structure be a circular list of pages, rather than
Date: Wed, 19 Jan 2005 18:06:41 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAbARnqxcVXUGZGgXNdpYSWQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20050119211250.13528.qmail@science.horizon.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

The below (sorry about the Outlook style includes, work _requires_ outlook 8-() is
why I previously mentioned the STREAMS implementation from SVR4 (and so Solaris etc).

Every interface point has a pointer to its peer, a pair of queues and a put()
routine.  Every message is in two or more pieces, the message header and the message
buffer/buffers (read real data pages).

So the "participating interface" requirement is really that the device be able to
expose a data structure consisting of four pointers that their peer can point to.

The "message types" for the messages passing around are all contained in the message
header structures.  These headers have all the reference counting and
disposal/cleanup hook procedures (pointers) along with the references to the actual
data.  This means that you could have a stock pool (from the slab cache) of these
headers for moving plain data around, and "magical devices" could use specialty
message headers with the necessary disposal elements or necessary "extra data" in
them.

All the devices in any kind of chain/mux/pipe/whatever arrangement pass messages to
their peers by invoking peer->put(message) [in OOD parlance, really probably
(*peer)(peer,message) in straight C].  And modules can be induced into the
chain/mux/pipe/whtever at runtime. The target put() procedure decides to copy or
reference-increment the message and put it on it's receive queue or process it
immediately.  At no time does any member of a STREAMS structure need to know any
details about the workings of their peers.

In the abstract, most communications would have message headers referring to blocks
of normal memory.  Some devices could send out messages that reference their PCI
mapped memory or whatever, and all _that_ device would have to do to mesh with the
system is to replace the cleanup function pointer with one appropriate to its need.
When the message has gone as far as it is going to go, its reference count drops to
zero and it gets cleaned up.

Unget can be done with some queue insertion/manipulation.  There is no pull() as
every target is either hot-processed or queued.  Flow control takes place when a
put() procedure returns a no-space-for-message indication.

If you absolutely _must_ know if the data was actually consumed by the target (and I
could argue that this is virtually never the case as things get lost in error-induced
pipe tear-down all the time) it would only be necessary to add a "cursor" member to
the message header and, at destruction time, see if the cursor had been advanced to
"use up" the data.

One could even have message headers that know they are dealing with

Now the message header is Linus' "impedance matcher" interface, transport is really
just about knowing your peer, calling put(), and doing reference counting.

There were a lot of (IMHO) mistakes in the STREAMS design, but the programming
document (previously referenced in this thread) covers a lot of the same message
typing and management questions that are being raised here.

While I can see that the fit between Linux and SVR4 STREAMS wouldn't be identical, a
good bit of the pipe-fitting (to pun 8-) and operation definitions would be.

(I'll go back to lurking now... 8-)

Rob White,
Casabyte, Inc.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of linux@horizon.com
lm@bitmover.com wrote:

The main infrastructure hassle you need to support this *universally*
is the unget() on "character devices" like pipes and network sockets.
Ideally, it would be some generic buffer front end that could be used
by the device for normal data as well as the special case.
 
Ooh.  Need to think.  If there's a -EIO problem on one of the file
descriptors, how does the caller know which one?  That's an argument for
separate pull and push (although the splice() library routine still
has the problem).  Any suggestions?  Does userland need to fall
back on read()/write() for a byte?



