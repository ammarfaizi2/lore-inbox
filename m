Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUAFWHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAFWHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:07:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265350AbUAFWHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:07:09 -0500
Message-ID: <3FFB316A.6000004@zytor.com>
Date: Tue, 06 Jan 2004 14:06:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: thockin@Sun.COM
CC: Mike Waychison <Michael.Waychison@Sun.COM>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com> <20040106215018.GA911@sun.com>
In-Reply-To: <20040106215018.GA911@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> On Tue, Jan 06, 2004 at 01:01:46PM -0800, H. Peter Anvin wrote:
> 
>>Finally, throwing out the daemon is a huge step backwards.  Most of the
>>problems with autofs v3 (and to a lesser extent v4) are due to the
>>*lack* of state in userspace (the current daemon is mostly stateless);
>>putting additional state in userspace would be a benefit in my experience.
> 
> Can you maybe share some details?  I think this deign moves MORE state to
> userspace (expiry aside).  The "state" in kernel is really mostly sent back
> to userspace.  No more passing pipes into the kernel (state) or tracking the
> pgid of the daemon (state).
> 

If you want to fire up a new daemon, all that state that was supposed to
be kept in userspace has to be reconstructed.  That means the kernel has
to have all that information; this would include stuff like what kind of
umount policy you want for each key entry (the current daemon doesn't do
that because it doesn't have the proper state.)

>>Pardon me for sounding harsh, but I'm seriously sick of the oft-repeated
>>idiocy that effectively boils down to "the daemon can die and would lose
>>its state, so let's put it all in the kernel."  A dead daemon is a
>>painful recovery, admitted.  It is also a THIS SHOULD NOT HAPPEN
>  
> But it *does* happen.

I don't believe it happens on any significant degree in cases where you
wouldn't have a kernel panic if you put the stuff in the kernel, *or* a
careless system admininistrator killed it.  In fact, I suspect it's
virtually all the latter.

>>condition.  By cramming it into the kernel, you're in fact making the
>>system less stable, not more, because the kernel being tainted with
>>faulty code is a total system malfunction; a crashed userspace daemon is
> 
> I don't think this design crams anything into the kernel.  It doesn't put a
> whole lot more into the kernel than is currently in there (expiry and new
> mount stuff, aside).  All the work still happens in userland.
> 
> The daemon as it stands does NOT handle namespaces, does NOT handle expiry
> well, and is a pretty sad copy of an old design.

First of all, I'll be blunt: namespaces currently provide zero benefit
in Linux, and virtually noone uses them.  I have discussed this with
Linus in the past, and neither one of us see namespaces as being worth
jumping though hoops to support.  That being said, it's doable by either
having different daemons for different namespaces (useful for policy) or
by having them gain access to the requisite namespaces.

Second, what you say about the state of the daemon is obviously true.
autofs v3 was developed on Linux 2.0 which had a vastly different VFS,
and it has by and large bitrotted.  Furthermore, at that point Linux
didn't support threading in any useful way, which meant that keeping the
appropriate state the in daemon was too painful -- hence the largely
stateless design with its associated problems.

>>"merely" a messy cleanup.  In practice, the autofs daemon does not die
>>unless a careless system administrator kills it.  It is a non-problem.
> 
> I have some customers I'd love to send to you, if you really think that's
> true.

As root, I can kill the system too by doing "cat /dev/zero > /dev/mem".
 If you do stupid shit as root you're dead.  What's the news?

	-hpa

