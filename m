Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269228AbUHZQyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269228AbUHZQyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269215AbUHZQud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:50:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:37049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269219AbUHZQtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:49:33 -0400
Date: Thu, 26 Aug 2004 09:48:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826163234.GA9047@delft.aura.cs.cmu.edu>
Message-ID: <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
 <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org>
 <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net>
 <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org>
 <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org>
 <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Jan Harkes wrote:
> 
> (btw. the same could be implemented completely in userspace, for
> instance in glibc. Whenever an open call gets an EISDIR error, simply
> retry the open, but this time with /_contents appended).

Yes, and no - just to make it obvious before people jump on this, a lot of 
things can be prototyped in user space with things like this, but once you 
have to deal with races and mixed tool environments, user space suddenly 
doesn't work so well any more.

I think Jan understands this distinction, I just wanted to make sure 
everybody else is aware of the _one_ thing that kernel land does well:

 - safely synchronize globally visible data structures

That's quite fundamental. 99% of what a kernel does is exactly that. TCP
would be in user space too, if it wasn't for _exactly_ this issue. A lot
of people think that kernels are about hardware access, and yes, that's
the other 99% of the picture (I see the _big_ picture, remember?), but the 
"safe access to common data" is really very fundamental.

The kernel is literally the thing that makes sure that you don't have -
and _cannot_ have - user programs that confuse each other by modifying 
data unsynchronized.

For example, a filesystem is really nothing but a way to access a disk in 
a controlled manner - it's not so much about hardware access, as it is 
about maintaining a coherent view of how some shared data (disk or 
whatever) is maintained. 

Same goes for caches. We could cache things in user space, but if you want 
to _share_ your caches (so that you don't have to re-load them for every 
new application), you need some entity that manages those shared data 
structures in a secure manner. In other words, you need the kernel.

The same goes for something like a "container file". Whether you see it as
"dir-as-file" or "file-as-dir" (and I agree with Jan that the two are
totally equivalent), the point of having the capability in the kernel is
not that the operations cannot be done in user space - the point is that
they cannot be done in user space _safely_. The kernel is kind of the
thing that guarantees that everybody follows the rules.

Imagine the security problems if a set-uid program were to (unwittingly) 
depend on a user-space library that implements what Jan's prototype 
library would do? Races galore, since a user-space implementation wouldn't 
have _any_ way to do tests like the above atomically. 

		Linus
