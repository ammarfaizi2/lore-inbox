Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVAGRJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVAGRJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVAGRJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:09:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:52642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbVAGRJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:09:23 -0500
Date: Fri, 7 Jan 2005 09:09:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501070837410.17078@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0501070850310.2272@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru> <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
 <Pine.LNX.4.58.0501070837410.17078@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Davide Libenzi wrote:
> 
> I don't know which kind of poison Larry put in your glass when you two 
> met, but it clearly worked :=)

Oh, Larry introduced the notion of "splice()" to me at least five years
ago, so whatever he put in that glass was quite slow-acting. At the time I
told him to forget it - I thought it intriguing, but couldn't see any
reasonable way to do it.

And to be honest, my pipes aren't really what Larry's "splice()" was: his 
notion was more of a direct "fd->fd" thing, with nothing in between. That 
was what I still consider unworkable. 

The problem with splicing two file descriptors together is that it needs
for them to agree on the interchange format, and these things tend to be
very expensive from an interface angle (ie the format has to _exactly_
match the "impedance" at both ends, since any conversion would make the
whole exercise pointless - you'd be better off just doing a read and a
write).

And note that the "format" is not just the actual data transfer thing, but
the rules about what to do with partial reads, partial writes, file
offsets, streams _without_ file offsets etc etc). And that's really what
the pipe generalization does: it decouples all the format things into an
intermediate thing that is very unambiguous, and has none of those issues.

The pipe approach also decouples things in another way: a true "splice()"  
needs all entities to participate in the new world order for it to be
useful. It shares that brokenness with "sendfile()", which to some degree
exemplifies the problems with splice() (sendfile ends up being a very very
specialized uni-directional form of Larry's splice()). But realizing that 
pipes _are_ the conduit and that they already exist and work with very old 
interfaces suddenly means that the new splice() can be incrementally 
useful.

So it took me five years to think about other things, until an actual
approach that would work and make sense from an implementation standpoint
worked.

What made me think about this particular thing is that I really thought a
lot of things want to just mmap the data, but do not actually want to go
to the expense of finding virtual addresses, handling the virtual->
physical translation at each stage. A lot of things just want to access
the buffers, _without_ the user-visible mapping. User-visibility is not
only expensive, it ends up being an impossible interface for many things
(memory mapping has page granularity, something that simply isn't true for
a lot of devices).

So in many ways, think of the new pipes as a "buffer mapping". Nothing
else. It's a way to carry arbitrary buffers along in a secure manner.

			Linus
