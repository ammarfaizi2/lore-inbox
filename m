Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUILXEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUILXEM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUILXEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:04:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:36012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263770AbUILXEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:04:06 -0400
Date: Sun, 12 Sep 2004 16:03:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <Pine.LNX.4.58.0409122319550.20080@skynet>
Message-ID: <Pine.LNX.4.58.0409121552430.13491@ppc970.osdl.org>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet>  <1094853588.18235.12.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409110137590.26651@skynet> <1094912726.21157.52.camel@localhost.localdomain>
 <Pine.LNX.4.58.0409122319550.20080@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Sep 2004, Dave Airlie wrote:
> 
> I think yourself and Linus's ideas for a locking scheme look good, I also
> know they won't please Jon too much as he can see where the potential
> ineffecienes with saving/restore card state on driver swap are, especailly
> on running fbcon and X on a dual-head card with different users.

Now, how much do you actually really need to restore/save?

Yes, intelligent restore/save means that there needs to be independent
memory management, but I thought that was the long-term plan _anyway_, no?  
And once you have reasonably intelligent memory management, you really
only need to save/restore the engine state, if even that (ie it should be
enough to just "idle" the engine).

Now, I'll agree that getting a good MM that solves peoples issues is a
huge problem. Much harder that some little locks. But on the other hand,
it really should be able to be largely card-agnostic, I sincerely hope.

And once you have some way to manage memory allocations between different
clients, saving/restoring card state really shouldn't be problematic. You 
make the rule be that everybody has to be able to re-create their caches 
(as with the locks, the cache manager would obviously have to have a 
callback), and you should never be in the position where you have to 
really save/restore any video memory contents at all.

(Yes, and if your working set ends up being bigger than your video ram, 
you won't perform well, but that's pretty fundamental regardless of number 
of clients or how they communicate).

The MM is still fairly complex, especially wrt areas that are "busy"  
(the client may be able to re-create them, but if the currently executing
_engine_ has pointers to it, the cache obviously can't be thrown away).  

Many of those things might be simplified by having fairly strict rules
("you can do video memory garbage collection only when the engine is
idle"), otherwise you'll need to have some complex infrastructure to keep
track of which areas are used by which commands...

			Linus
