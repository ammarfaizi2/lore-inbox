Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUAEQNq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUAEQNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:13:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:37531 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264887AbUAEQNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:13:41 -0500
Date: Mon, 5 Jan 2004 08:13:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040105132756.A975@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
References: <20040104000840.A3625@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org>
 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Andries Brouwer wrote:
> 
> You have this strange hangup concerning "enumerate", and then keep
> repeating to others that enumerating is impossible, and that therefore
> stable device numbers are impossible, and that consequently, since we
> cannot have stable device numbers expecting them to be stable is broken.

Right.

> It is an old misconception - I recall you telling me how many billion years
> an "ls /dev" would take with 64-bit device numbers.

No. When I talk abotu "enumerate", I do not mean "give numbers starting at
1". In the mathematical sense it means that you _can_ number them with
integers, not that it is necessarily a sequence from 1...n.

For example, PCI device slots are "enumerable". That doesn't mean that we
give them numbers 1..n, it only means that we can encode their address in
a single number. So if everything was a PCI slot, we could enumerate the
whole address space, and "stable" device numbers would be possible (they'd
be stable by _slot_, not by actual device, but that's good enough for some
people).

But the thing is, some things you simply _cannot_ number. For example, a
two-dimensional space is innumerable - you need more than one integer
number to look things up.  So is the set of real numbers (but not the set 
of fractions), etc etc.

It boils down to not how many devices there can be, but to whether there 
is any way to "walk the space of devices".

And there fundamentally isn't. And _that_ is the basic issue: if you
_cannot_ number a space, you cannot have a stable device number.

> No - I never advocated "find a device number by enumeration".
> Quite the opposite, I advocated "use a hash of the serial number
> as the device number of a disk". And more generally, "it is the
> driver's job to assign a device number".

There _is_ no such number as you are talking about. You are talking pure 
theory that has nothing to do with reality. There are no "serial numbers".

Don't you see? This is what "enumeration" is all about. You are assuming a 
model that simply DOES NOT EXIST. Your "serial numbers" are exactly what 
I'm talking about when I say "enumerate". Whenever you claim that a device 
has a "serial number", you literally claim that the device space is 
enumerable, and that is what I have been telling you from day one IS NOT 
TRUE!

Whether you then hash the serial number or not is totally irrelevant: an 
enumeration of hashes is still an enumeration.

Devices do not _have_ serial numbers. They are not enumerable. In other
words, they do not have some kind of explicit identity that we can use to
give them numbers. That is what "innumerable" MEANS, and that is why I 
have been harping on the issue.

Please. Where do you think those numbers would come from?

So I claim as an axiom for device numbering that devices are not
enumerable, and that this _fundamentally_ leads to the corollary that you 
cannot give them stable numbers. Not with hashes, not with _anything_. The 
best you can do is to _literally_ just give them some per-session unique 
integer that is simply the discovery ordering, nothing more.

> So it is not difficult at all to give this network attached storage
> a stable device number.

It is not only difficult, it is fundamentally _impossible_.

> And if one can, there is no reason not to do so.
> It may even allow udev to give stable names as well.

My point is that for the subset of devices that _do_ have serial numbers 
(and it is a subset, nothing more), udev can then use those serial numbers 
to have a stable pathname to the device. But it's a _pathname_, not a 
number.

And for devices that don't have serial numbers, udev can try to use other 
heuristics instead to give those stable names. Sometimes those other 
heuristics would be looking at the actual _content_ of the thing.

For example, if you wanted to, you could make udev do a cddb lookup on the
CD-ROM, and use that as the pathname, so that when you insert your
favorite audio disk, it will always show up in the same place, regardless 
of whether you put it in the DVD slot or the CD-RW drive. 

[ Yeah, that sounds like a singularly silly thing to do, but it's a good 
  example of something where there is no actual serial number, but you can 
  "identify" it automatically through its contents, and name it stably 
  according to that. ]

That is indeed the point of udev.  Doing things that the kenrel 
_obviously_ should not do.

			Linus
