Return-Path: <linux-kernel-owner+w=401wt.eu-S933198AbWLaQoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933198AbWLaQoj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 11:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933199AbWLaQoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 11:44:39 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:43384 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933198AbWLaQoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 11:44:38 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 31 Dec 2006 11:39:09 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
cc: Folkert van Heusden <folkert@vanheusden.com>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
In-Reply-To: <1167572735.20929.750.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0612311118490.13153@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain> 
 <200612302149.35752.vda.linux@googlemail.com> 
 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain> 
 <1167518748.20929.578.camel@laptopd505.fenrus.org>  <20061231133902.GA13521@vanheusden.com>
 <1167572735.20929.750.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006, Arjan van de Ven wrote:

> On Sun, 2006-12-31 at 14:39 +0100, Folkert van Heusden wrote:
> > > > i don't see how that can be true, given that most of the definitions
> > > > of the clear_page() macro are simply invocations of memset().  see for
> > > > yourself:
> > > *MOST*. Not all.
> > > For example an SSE version will at least assume 16 byte alignment, etc
> > > etc.
> >
> > What about an if (adress & 15) { memset } else { sse stuff }
> > or is that too obvious? :-)
>
> it's only one example. clear_page() working only on a full page is a
> nice restriction that allows the implementation to be optimized
> (again the x86 hardware that had a hardware page zeroer comes to
> mind, the hw is only 4 years old or so... and future hw may have it
> again)
>
> clear_page() is more restricted than memset(). And that's good, it
> allows for a more focused implementation. Otherwise there'd be no
> reason to HAVE a clear_page(), if it just was a memset wrapper
> entirely.

(just one more note about this, then i'll stop dragging it out.  i
didn't mean to get this long-winded about it.)

arjan, you and i actually agree on this.  i fully accept that the idea
of a "clear_page()" call might or should have extra semantics,
compared to the more simple and direct "memset(...,0,PAGE_SIZE)" call
(such as alignment requirements, for example). my observation is
simply that this is not what is currently happening.

consider, for example, how many calls there are to clear_page() in the
drivers directory:

  $ grep -rw clear_page drivers

not that many.  now how many calls are there of the memset variety?

  $ grep -Er "memset(.*0, ?PAGE_SIZE)" drivers

i can't believe that at least *some* of those memset() calls couldn't
be re-written as clear_page() calls.  and that's just for the
drivers/ directory.

  sure, clear_page() might have extra semantics.  but if that's the
case, and those semantics happen to be in play, i'm suggesting that
not only *can* one use clear_page() at that point, one *should* use
it.

  put another way, if a given situation is appropriate for a call to
clear_page(), then that's what should be used.  because if one sees
instead a call to an equivalent memset(), that might suggest that
there's something *preventing* the use of clear_page() -- that it's
not appropriate.  and, really, there's no need to be unnecessarily
confusing.

  this is just another example of the basic kernel infrastructure
defining lots of useful features (ARRAY_SIZE, etc.) and lots of
programmers not using them for one reason or another.  in this
situation with clear_page(), the semantics of that call should be
defined clearly and, when the situation arises, i think that call
should be used unless there's a clear reason *not* to.  it just makes
the code easier to read.

  and on that note, i'll let this one go.  others are free to follow
up.

rday




