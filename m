Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUBPUYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265821AbUBPUYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:24:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:43655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265817AbUBPUXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:23:50 -0500
Date: Mon, 16 Feb 2004 12:23:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Lehmann <pcg@schmorp.de>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040216200321.GB17015@schmorp.de>
Message-ID: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Marc Lehmann wrote:
> 
> > I'm saying that "the kernel talks bytestreams".
> 
> And I am saying that this is not good, which is my sole point.

Fair enough. 

However, that's where the unix philosophy comes in. The unix philosophy 
has always been to not try to understand the data that the user passes 
around - and that "everything is a bytestream" is very much encoded in the 
basic principles of how unix should work.

That agnosticism has a lot of advantages. It literally means that the
basic operating system doesn't set arbitrary limitations, which means that
you can do things that you couldn't necessarily otherwise easily do.

It does mean that you can do "strange" things too, and it does mean that 
user space basically has a lot of choice in how to interpret those byte 
streams.

And yes, it can cause confusion. You don't like the confusion, so you 
argue that it shouldn't be allowed. It's a valid argument, but it's an 
argument that assumes that choice is bad.

If you want to _force_ everybody to use UTF-8, then yes, the kernel could 
enforce that readdir() would never pass through a broken UTF-8 string, and 
all the path lookup functions also would never accept a broken string. It' 
snot technically impossible to to, although it would add a certain amount 
of pain and overhead.

But the thing is, not everyone uses UTF-8. The big distributions have only 
recently started moving to UTF-8, and it will take _years_ before UTF-8 is 
ubiquotous. And even then it might be the wrong thing to disallow clever 
people from doing clever things. Encoding other information in filenames 
might be proper for a number of applications.

> And I'd say such a kernel would be highly useful, as it would standardize
> the encoding of filenames, just as unix standardizes on "mostly ascii"
> (i.e. the SuS).

It would also be very painful, since it would mean that when you mount an 
old disk, you may be totally unable to read the files, because they have 
filenames that such a kernel would never accept.

> > The kernel is _agnostic_ in what it does.
> 
> No, it's not. If at all, the kernel specifies a specially-interpreted
> (ascii sans / and \0) byte-stream, as you say yourself.
> 
> However, just as with URLs (which are byte-streams, too), byte-streams are
> useless to store text. You need bytestreams + known encoding.

You don't "need" a known encoding. The kernel clearly doesn't need one. 
It's a container, and the encoding comes from the outside. 

And that's what I mean by agnostic - you can make your own encoding. 

Most of the time (but not always) these days UTF-8 is the only sane 
encoding to use. But let people do what they want to do.

Choice is _inherently_ good. Trying to force a world-view is bad. You 
should be able to tell people what they should do to avoid confusion ("use 
UTF-8"), but you should not _force_ them to that if they have good reasons 
not to (and "backwards compatibility" is a better reason than just about 
anything else).

> But you are saying that you have to feed UTF-8 into the kernel, which is
> not the case either.

No. I'm saying that
 (a) "if you want to use complex character sets"
then 
 (b) "you really have to use UTF-8"
to talk to the kernel.

Note the two parts. You're hung up on (b), while I have tried to make it 
clear that (a) is a prerequisite for (b).

Not everybody cares about (a). There are still people who use extended 
ASCII, simply because they DO NOT CARE about complex character sets. And 
if they don't care, and (a) isn't true, then (b) has no meaning any more.

(In all fairness, some people will disagree with (b) even when (a) is true
and like things like UCS-2. Those people are crazy, but I guess I'd just
mention that possibility anyway).

And this is why I say that the kernel only cares about byte streams, and
having it filter to only accept proper UTF-8 sequences would be a horribly
bad idea. Because it _assumes_ (a). That's what "making policy" is all
about. The kernel should not assume that everybody cares about complex
character sets.

This may change, btw. I'm nothing if not pragmatic. In another twenty
years, maybe everybody _literally_ uses complex character sets, and this
whole discussion is totally silly, and the kernel may enforce UTF-8 or
Klingon or whatever. At some point assumptions become _so_ ingrained that
they are no longer policy any more, they are just "fact".

		Linus
