Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUBSQEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267321AbUBSQEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:04:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:56285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267325AbUBSQEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:04:21 -0500
Date: Thu, 19 Feb 2004 08:09:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: tridge@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <20040219081027.GB4113@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402171859570.2686@home.osdl.org> <4032D893.9050508@zytor.com>
 <Pine.LNX.4.58.0402171919240.2686@home.osdl.org> <16435.55700.600584.756009@samba.org>
 <Pine.LNX.4.58.0402181422180.2686@home.osdl.org> <Pine.LNX.4.58.0402181427230.2686@home.osdl.org>
 <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
 <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Jamie Lokier wrote:
> 
> Linus, while I agree with you wholeheartedly on everything else in
> this thread - how can Samba only do that lookup ONCE per name if a
> client is issuing many requests for non-existent opens or stats?

While I'm not willing to push case insensitivity deep into the
filesystems, I _am_ willing to entertain the notion of an extra flag to a
dcache entry that the regular VFS operations ignore (apart from clearing
it when they change anything and having to flush them under some
circumstances), which would basically be "this dentry has been judged
unique in a case-insensitive environment".

So assuming nobody else is touching the directory, the case-insensitive 
special module could create these kinds of dentries to its hearts content 
when it does a lookup.

> Example: A client has a search path for executables or libraries.
> 
> Each time SomeThing.DLL is looked up by the client, it will issue an
> open() for each entry in the path, until it finds the file it wants.
> 
> For each request, Samba must readdir() every directory in the path
> until the file is found.
> 
> If a directory doesn't change between requests, Samba can use dnotify
> to cache the negative lookups.
> 
> However, if any change occurs in a directory, or if the directory is
> not dnotify-capable, Samba is not allowed to cache these negative
> results: It has to do the readdir() for _every_ request.

But this is exactly what I _am_ willing to entertain: have some limited 
special logic inside the kernel (but outside the VFS layer proper), that 
allows samba to use special interfaces that avoids this.

For example, the rule can be that _any_ regular dentry create will 
invalidate all the "case-insensitive" dentries. Just to be simple about 
it. But if samba is the only thing that accesses a certain directory (or 
the directory is not written to, like / and /usr etc usually behave), the 
"windows hack" interface will be able to populate it with its fake 
dentries all it wants.

Or something like this. Basically, I'm convinced that the problem _can_ be 
solved without going deep into the VFS layer. Maybe I'm wrong. But I'd 
better not be, because we're definitely not going to screw up the VFS 
layer for Windows.

			Linus
