Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTDVFxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 01:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbTDVFxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 01:53:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43395 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262964AbTDVFxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 01:53:43 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16036.56177.468912.341132@lepton.softprops.com>
Date: Tue, 22 Apr 2003 01:04:33 -0500
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C263841@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C263841@orsmsx116.jf.intel.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky writes:
 > 
 > > From: Karim Yaghmour [mailto:karim@opersys.com]
 > > 
 > > Consider the following:
 > > 1) kue_read() has a while(1) which loops around and delivers messages
 > > one-by-one (to the best of my understanding of the code you posted).
 > 
 > That's right.
 > 
 > > Hence, delivery time increases with the number of events. In contrast,
 > > relayfs can deliver tens of thousands of events in a single shot.
 > 
 > Sure, I agree with that - it is the price to pay for less code and
 > not having to copy on the kernel side. As I mentioned before to Tom,
 > I don't think that in the long run the overhead will be that much,
 > although it is true it will be very dependent on the average size of 
 > the messages and how many you deliver. If we are delivering two-byte
 > messages at 1M/second rate, the effectivity rate goes down, and with
 > it the scalability.
 > 
 > However, in relayfs that problem is shifted, unless I am missing 
 > something. For what I know, so far, is that you have to copy the
 > message to the relayfs buffer, right? So you have to generate the
 > message and then copy it to the channel with relay_write(). So
 > here is kue's copy_to_user() counterpart.
 > 
 > If there were a way to reserve the space in relayfs, so that then
 > I can generate the message straight over there, that scalability
 > problem would be gone.
 > 

In relayfs, the event can be generated directly into the space
reserved for it - in fact this is exactly what LTT does.  There aren't
two separate steps, one 'generating' the event and another copying it
to the relayfs buffer, if that's what you mean.

[snip]
 > 
 > > > That's the difference. I don't intend to have that. The data
 > > > storage can be reused or not, that is up to the client of the
 > > > kernel API. They still can reuse it if needed by reclaiming the
 > > > event (recall_event), refilling the data and re-sending it.
 > > 
 > > Right, but by reusing the event, older data is thereby destroyed
 > > (undelivered). Which comes back to what I (and others) have been
 > > saying: kue requires the sender's data structures to exist until
 > > their content is delivered.
 > 
 > That's it, that is the principle of a circular buffer. AFAIK, you
 > have the same in relayfs. Old stuff gets dropped. Period. And the
 > sender's data structures don't really need to exist forever,
 > because the event is self-contained. The only part that might
 > be a problem is the destructor [if for example, you were a module,
 > the destructor code was in the module and the module unloaded 
 > without recalling pending events first - the kind of thing
 > you should never do; either use a non-modular destructor or make
 > sure the module count is not decreased until all the events have
 > been delivered or recalled ... simple to do too]
 > 

Well, I'm not sure I understand the details of kue all that well, so
let me know if I'm missing something, but for kue events to really be
self-contained, wouldn't the data need to be copied into the event
unless the data structure containing them was guaranteed to exist
until the event was disposed of one way or another?  And even if the
backing data structure was guaranteed to exist, wouldn't it need to be
static (unchanging) for the data to mean the same thing when it was
delivered as when it was logged?  If the data needs to be copied to
the event to make it self-contained, then you're actually doing 2
copies per event - the first to the event, the second the
copy_to_user().  I'm not sure how much would be necessary in normal
usage, but if you're doing a lot of kmalloc()/kfree() to contain the
events, that's another potentialy large source of overhead.

By contrast, relayfs is worst-case (and best-case) single copy
into the relayfs buffer, which is allocated/freed once during its
lifetime.

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

