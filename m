Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267600AbUBTAQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUBTAQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:16:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:12766 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267608AbUBTAMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:12:37 -0500
Date: Thu, 19 Feb 2004 16:17:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Tridge <tridge@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <20040220000054.GA5590@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204853.GA4619@mail.shareable.org>
 <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org> <20040220000054.GA5590@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Jamie Lokier wrote:
> 
> Will your proposal eliminate Samba's positive cache as well?

Samba has to work on different kernels, so they'll have to have their own 
code anyway. Whether they want to turn it off or not if better 
alternatives are found is up to them. Right now it appears that what 
Tridge wants is a WNT dcache, and since he's not going to get it, I guess 
the whole discussion is moot.

> What I like about my idea is that no windows_equivalent_strncasecmp()
> needs to go into the kernel.  I.e. no need for a Samba-specific module.
> 
> The other thing I like is that DN_IGNORE_SELF would be useful for
> other applications too.

I agree. It might even be acceptable not as a new flag, but as a 
modification to existing behaviour. I can't imagine that a file manager is 
all that interested in seeing the changes it itself does be reported back 
to it. And I don't really know of any other uses of dnotify.

(That said, clearly it's better to just have a new flag, since that way 
there is no possibility of anything breaking).

On the other hand, even with a nice dnotify infrastructure, you simply
_cannot_ get absolute atomicity guarantees. Because by the time you
actually execute the "mv" operation, another process may create a new file
with the "same" name (ie different name, but comparing the same ignoring
case) on another CPU. By the time you get the dnotify, it's too late, and
the move will have happened, and undoing the operation (and hiding it from
the client) may well be impossible - possibly because another process
creating a file with the old name.

NOTE! Even an in-kernel implementation fundamentally cannot fix this race 
on something like NFS. So the in-kernel version would only help for local 
filesystems that the kernel has exclusive write access to.

			Linus
