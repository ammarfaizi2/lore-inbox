Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVATAMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVATAMe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVATAMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:12:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:19613 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262012AbVATABp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:01:45 -0500
Date: Wed, 19 Jan 2005 16:01:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <20050119190119.GA10429@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0501191546210.8178@ppc970.osdl.org>
References: <200501070313.j073DCaQ009641@hera.kernel.org>
 <20050107034145.GI9636@holomorphy.com> <Pine.LNX.4.58.0501062222500.2272@ppc970.osdl.org>
 <Pine.LNX.4.58.0501062236060.2272@ppc970.osdl.org> <20050119162902.GA20656@work.bitmover.com>
 <Pine.LNX.4.58.0501190843220.8178@ppc970.osdl.org> <20050119190119.GA10429@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jan 2005, Larry McVoy wrote:
> 		
> See how more generic that is?  Pipes are just one source/sink but 
> everything else needs to play as well.  How are you going to 
> implement a socket sending data to a file without the VM nonsense
> and the extra copies?

Heh. This is exactly why I originally told you it is undoable - because 
your model implies a O(M x N) complexity, where everybody has to agree on 
how to push things to everybody else. 

The thing that made me so excited about the pipes is exactly that the 
pipes is what finally made me see how to actually _implement_ kind of what 
you wanted. Instead of a "everything to everything" thing that has O(n²) 
complexity, it's a "everything to a pipe", where the pipe ends up being 
the common medium for things to talk to each other.

So you have an extra level of indirection, but it also means that now the
interface complexity is purely linear - everybody needs to know how to
accept data from (and push data to) a pipe, but they do _not_ need to know
how to do it to anything else.

I agree that it's not what you described, and one of my first emails 
describing it even said so, but I now notice that you weren't cc'd on 
that one (I tried to cc you on some others, but not the whole discussion):

   "...

    And to be honest, my pipes aren't really what Larry's "splice()" was: his 
    notion was more of a direct "fd->fd" thing, with nothing in between. That 
    was what I still consider unworkable. 

    The problem with splicing two file descriptors together is that it needs
    for them to agree on the interchange format, and these things tend to be
    very expensive from an interface angle (ie the format has to _exactly_
    match the "impedance" at both ends, since any conversion would make the
    whole exercise pointless - you'd be better off just doing a read and a
    write).

    ..."

so what makes the pipes special is that they are the "impedance matcher". 

For example, absolutely _none_ of the regular file IO stuff wants to work 
with page fragments: it's all very much about whole-page stuff in the page 
cache, and that is how it has to be, considering the semantics of a 
coherent mmap etc. 

So your notion of having all the subsystems natively use a common format 
just never struck me as workable, because they very fundamentally do _not_ 
want work with the same kind of data structures, and forcing them to just 
didn't seem valid.  So I ignored splice as unworkable.

So think of my "splice" as giving you credit through the name, but at the
same time it definitely is something different (and in my opinion a lot
more workable). If you object to the name, I can call it "wire()" instead,
which was somebody elses suggestion, but I thought you might appreciate 
the name even if it isn't _really_ what you want ;)

		Linus
