Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVIIVls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVIIVls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVIIVlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:41:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64690 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030367AbVIIVlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:41:47 -0400
Date: Fri, 9 Sep 2005 14:41:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, Reiserfs-Dev@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: List of things requested by lkml for reiser4 inclusion (to
 review)
Message-Id: <20050909144142.0f96802f.akpm@osdl.org>
In-Reply-To: <4321C806.60404@namesys.com>
References: <200509091817.39726.zam@namesys.com>
	<4321C806.60404@namesys.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> ...
>
> Do I remember right that the submission
> deadline is a week from Monday for 2.6.14 inclusion?

Next week, supposedly.

But something like a brand new filesystem can go in pretty much any time,
as long as it compiles.  Because it can't break anyone's current setup.

Brand new filesystems which also require monkeying with the core VFS aren't
quite that straightforward though.

> This is supposed to be a bullet list, so I don't list here the line by
> line minor code improvements sent to us, most of which were
> incorporated, but let me take a moment to thanks those who donated them.

Guys, you should know by now not to send 1021-column emails :(

> 1. pseudo files or "...." files
> 

>   disabled.  It remains a point of (extraordinary) contention as to
> whether it can be fixed, we want to keep the code around until we can
> devote proper resources into proving it can be (or until we fail to prove
> it can be and remove it).  We don't want to delay the rest of the code for
> that proof, but we still think it can be done (by several different ways of
> which we need to select one and make it work.) Let us postpone contention
> on this until the existence of a patch that cannot crash makes contention
> purposeful, shall we?

I'd prefer that unused code simply not be present in the tree, sorry.

> 
> 
> 2. dependency on 4k stack turned off
> 
>    removed as requested

So it all runs OK with 4k stacks now?

> 3. remove conditional variable code, use wait queues instead.
> 
> not done.  There are times when reduced functionality aids debugging. 
> kcond is (literally) textbook code.  We don't care enough to fight much for
> it, but akpm, what is your opinion?  Will remove if akpm asks us to.

kcond is only used in a couple of places.  One looks like it could use
complete() and the other is a standard wait-for-something-to-do kernel
thread loop, which we open-code without any fuss in lots of places
(kjournald, loop, pdflush, etc).  So yes, I'd be inclined to remove kcond
please.

Also, it would be better to use the kthread API rather than open-coding
kernel_thread() calls.  If you think that reiser4 needs additional ways of
controlling kernel threads then feel free to enhance the kthread API.

> 6.  remove type safe lists and type safe hash queues.
>
> not done, it is not clear that the person asking for this represents a
> unified consensus of lkml.  Other persons instead asked that it just be
> moved out of reiser4 code into the generic kernel code, which implies they
> did not object to it.  There are many who like being type safe.  Akpm, what
> do you yourself think?

The type-unsafety of existing list_heads gives me conniptions too.  Yes,
it'd be nice to have a type-safe version available.

That being said, I don't see why such a thing cannot be a wrapper around
the existing list_head functions.  Yes, there will be some ghastly
C-templates-via-CPP stuff, best avoided by not looking at the file ;)

We should aim for a complete 1:1 relationship between list_heads and
type-safe lists.  So people know what they're called, know how they work,
etc.  We shouldn't go adding things called rx_event_list_pop_back() when
everyone has learned the existing list API.

Of course, it would have been better to do this work as a completely
separate kernel feature rather than bundling it with a filesystem.  If this
isn't a thing your team wants to take on now then yes, I'd be inclined to
switch reiser4 to list_heads.


> 
> 7. remove fs/reiser4/lib.h:/div64_32.
> 
>    is being replaced by the linux one.
> 
> 8.  Remove all assertions because they clutter the code and make it hard to read
> 
> 
> We think this person was not an experienced security specialist,

We think this person didn't submit a patch to remove the 124 assertions
from ext3 ;)   Keep the assertions.

