Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTDVSuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTDVSuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:50:18 -0400
Received: from fmr01.intel.com ([192.55.52.18]:19433 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263357AbTDVSuM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:50:12 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263A3B@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Tom Zanussi'" <zanussi@us.ibm.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>
Subject: RE: [patch] printk subsystems
Date: Tue, 22 Apr 2003 12:02:09 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Tom Zanussi [mailto:zanussi@us.ibm.com]
> 
> In relayfs, the event can be generated directly into the space
> reserved for it - in fact this is exactly what LTT does.  There aren't
> two separate steps, one 'generating' the event and another copying it
> to the relayfs buffer, if that's what you mean.

In this case, what happens if the user space, through mmap, copies
while the message is half-baked (ie, from another CPU) ... won't it
be inconsistent?

> Well, I'm not sure I understand the details of kue all that well, so
> let me know if I'm missing something, but for kue events to really be
> self-contained, wouldn't the data need to be copied into the event
> unless the data structure containing them was guaranteed to exist
> until the event was disposed of one way or another?

Yes, you have to guarantee the existence of the event data structures
(the 'struct kue', the embedded 'struct kue_user' and the event data
itself); if they are embedded into another structure that will dissa-
pear, you can choose to:

(a) recall the event [if it is recallable or makes sense to do so]
(b) dynamically allocate the event header and data, generate it 
    into that dynamic space.
(c) dynamically allocate and copy [slow]

(this works now; however, once I finish the destructor code, it
will give you the flexibility to use other stuff than just kmalloc()).

You can play many tricks here, but that depends on your needs,
requirements and similar stuff.

> backing data structure was guaranteed to exist, wouldn't it need to be
> static (unchanging) for the data to mean the same thing when it was
> delivered as when it was logged?  If the data needs to be copied to

Of course; I am assuming the client knows that (this is a must for
static allocation, similar in problem to when you give out an string
from inside your code). If the client is not willing to do that, it
has to dynamically allocate and provide a destructor.

> the event to make it self-contained, then you're actually doing 2
> copies per event - the first to the event, the second the
> copy_to_user().

That I do in the (c) case; not in the (b) case. In most situations
you shall be able to choose how to do it [and I guess most sensible
people would choose (b)].

> By contrast, relayfs is worst-case (and best-case) single copy
> into the relayfs buffer, which is allocated/freed once during its
> lifetime.

Sure; I'd just like to know how are you maintaining consistency for
the mmap stuff.


Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
