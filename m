Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTDVWAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTDVWAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:00:37 -0400
Received: from fmr02.intel.com ([192.55.52.25]:61414 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263897AbTDVWAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:00:34 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263A2C@orsmsx116.jf.intel.com>
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
Date: Tue, 22 Apr 2003 11:46:31 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Karim Yaghmour [mailto:karim@opersys.com]
> 
> "Perez-Gonzalez, Inaky" wrote:
> > However, in relayfs that problem is shifted, unless I am missing
> > something. For what I know, so far, is that you have to copy the
> > message to the relayfs buffer, right? So you have to generate the
> > message and then copy it to the channel with relay_write(). So
> > here is kue's copy_to_user() counterpart.
> 
> OK, so you are claiming that memcpy() == copy_to_user()?

Not ==, although you cannot deny that they do basically the same: 
copy memory. 

copy_to_user() has to do some more gymnastics in the process, 
but basically, the bulk is the same [at least by reading the 
asm of __copy_user() in usercopy.c and __memcpy() in string.h 
-- it is kind of different, but in function is/should
be the same - bar that copy_to_user() might sleep due to 
paging-in and preemption and who knows what else].
 
> [If nothing else, please keep in mind that the memcpy() in question
> is to an rvmalloc'ed buffer.]

Good issue for caching ...

> Maybe I'm just old fashioned, but I usually want to provide a
> logging function with a pointer and a size parameter, and I want
> whatever I'm passing to it be placed in a secure repository where
> my own code couldn't touch it even if it went berserk.

That is a good point, that brought me yesterday night to the following
doubt. How do you guarantee integrity of the data when reading with
mmap. In other words, if I am just copying the mmap region, how do
I know that what I am copying is safe enough, that it is not being
modified by CPU #2, for example? (because user space and kernel space
will not share the locks, at most, user space can look at a couple of
markers that identify the bottom and the top of the "safe" buffer,
but there is not way to get both of them atomically). Also, if it
is a circular buffer, is there a way for the user space to know
when did it wrap around? I still don't get how mmap works all this
out (or is the buffer being moved under the user space's feet?)

> Again, you are making assumptions regarding the usage of your mechanism.
> With relayfs, dropping a channel (even one that has millions upon millions
> of events) requires one rvfree().

Well, we all have to make certain assumptions, other wise we'd be
having philosophical discussions about the squareness of the circle
for ever an ever in a for(;;) loop. 

> Sorry, you don't get to see b, c, g, h, and i because something
> changed in the system and whatever wanted to send those over isn't
> running anymore. Maybe I'm just off the chart, but I'd rather see
> the first list of events.

As I explained below, you don't _have_to_ drop it; however, in some
cases, it makes sense to drop it because it is meaningless anyway (ie
the device-plugged message - why would I want the userspace to check
it if I know there is no device - so I recall it). Errors are another
matter, and you don't want to recall those.

This is different from running out of space. Like it or not, if you 
have a circular buffer with limited space and you run out ... moc!
you loose, drop something somewhere to make space for it. This is not
a kue limitation, this is a property of buffers: they fill up.

Now, if you want to make it resizable, that understands Japanese and
does double loops followed by a nose dive and a vertical climb up, 
well, that's up to the client of the API. And I didn't want to 
constraint the gymnastics that the client could do to handle a buffer.

> > However, there are two different concepts here. One is the event
> > that you want to send and recall it if not delivered by the time
> > it does not make sense anymore (think plug a device, then remove
> > it). The other want is the event you want delivered really badly
> > (think a "message" like "the temperature of the nuclear reactor's
> > core has reached the high watermark").
> 
> I'm sorry, but the way I see printk() is that once I send something
> to it, it really ought to show up somewhere. Heck, I'm printk'ing
> it. If I plugged a device and the driver said "Your chair is
> on fire", I want to know about it whether the device has been
> unplugged later or not.

I would say this case, printk(), would fit in my second example,
doesn't it? ... this is one message you want delivered, not recalled.

> > As I mentioned before, this kind-of-compensates-but-not-really
> > with the fact of having to generate the message and then copy
> > it to the channel.
> 
> That's the memcpy() == copy_to_user() again.

Please note the "kind-of-compensates-but-not-really"; then refer
to my first paragraph. 

> Nevertheless, if you want to measure scalability alone, try
> porting LTT to kue, and try running LMbench and co. LTT is very
> demanding in terms of buffering (indeed, I'll go a step further and
> claim that it is the most demanding application in terms of
> buffering) and already runs on relayfs.

Got it, thanks :)

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
