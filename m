Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263911AbTDVXVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 19:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTDVXVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 19:21:11 -0400
Received: from opersys.com ([64.40.108.71]:32013 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S263911AbTDVXVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 19:21:08 -0400
Message-ID: <3EA5D024.9728E1A6@opersys.com>
Date: Tue, 22 Apr 2003 19:28:36 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: Re: [patch] printk subsystems
References: <A46BBDB345A7D5118EC90002A5072C780C263A2C@orsmsx116.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[The CC list has been trimmed]

"Perez-Gonzalez, Inaky" wrote:
> copy_to_user() has to do some more gymnastics in the process,
> but basically, the bulk is the same [at least by reading the
> asm of __copy_user() in usercopy.c and __memcpy() in string.h
> -- it is kind of different, but in function is/should
> be the same - bar that copy_to_user() might sleep due to
> paging-in and preemption and who knows what else].

The difference between copy_to_user() and memcpy() is not a
minor detail. There is a reason why relayfs does its things the
way it does.

> That is a good point, that brought me yesterday night to the following
> doubt. How do you guarantee integrity of the data when reading with
> mmap. In other words, if I am just copying the mmap region, how do
> I know that what I am copying is safe enough, that it is not being
> modified by CPU #2, for example?
[snip]

"Use the source, Luke."

> As I explained below, you don't _have_to_ drop it; however, in some
> cases, it makes sense to drop it because it is meaningless anyway (ie
> the device-plugged message - why would I want the userspace to check
> it if I know there is no device - so I recall it). Errors are another
> matter, and you don't want to recall those.

OK, so you are suggesting we start making a difference in the kernel
between those printks which are "optional" and those that are
"compulsory"? Interested kernel developers are free to voice their
interest at any time now ...

> This is different from running out of space. Like it or not, if you
> have a circular buffer with limited space and you run out ... moc!
> you loose, drop something somewhere to make space for it. This is not
> a kue limitation, this is a property of buffers: they fill up.

I wasn't interested in teaching anyone about buffering basics. The point
I was making is that different buffering schemes have different behaviors
in regards to overflow. IMNSHO I think the drop-the-oldest behavior
is preferable to the drop-whatever-has-gone-away behavior. But maybe
that's just me.

> Now, if you want to make it resizable, that understands Japanese and
> does double loops followed by a nose dive and a vertical climb up,
> well, that's up to the client of the API. And I didn't want to
> constraint the gymnastics that the client could do to handle a buffer.

Well, if we're talking about "double loops followed by a nose dive"
we're certainly not going anywhere. I'll leave it to other LKML
subscribers to decided wether automatically resizeable buffers are
of interest.

> > I'm sorry, but the way I see printk() is that once I send something
> > to it, it really ought to show up somewhere. Heck, I'm printk'ing
> > it. If I plugged a device and the driver said "Your chair is
> > on fire", I want to know about it whether the device has been
> > unplugged later or not.
> 
> I would say this case, printk(), would fit in my second example,
> doesn't it? ... this is one message you want delivered, not recalled.

What I've been trying to say here is that there are no two kinds of
printk. printk is printk and it ought to behave the same in all
instances.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
