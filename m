Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUH2VxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUH2VxL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268343AbUH2VxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:53:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:9103 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268342AbUH2Vw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:52:59 -0400
Date: Sun, 29 Aug 2004 14:50:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Hans Reiser <reiser@namesys.com>, flx@msu.ru, Paul Jackson <pj@sgi.com>,
       riel@redhat.com, ninja@slaphack.com, diegocg@teleline.es,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
 <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com>
 <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com>
 <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
 <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com>
 <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> A slew of cache coherency issues (and memory consumption on top of that).
> Rigth now we have a signle dentry tree for all fs instances, no matter
> how many times it and its subtrees are visible in the tree.  Which,
> obviously, avoids all that crap.  As soon as we start trying to have
> multiple trees over the same fs, we are in for a *lot* of fun.

Al, I think you should make the argument a bit more specific, because I 
doubt a lot of people understand just what the problems are with aliased 
names. Just a few examples of the problems involved will illuminate things 
very well, I think. People who haven't been intimate with the name caches 
probably simply don't understand why you worry so much.

I'll start out with some trivial examples, just to let Hans and others get
an idea about what the issues are. I think examples of problems are often 
better ways to explain them than the abstract issues themselves.

Aliases: let's say that you have filename "a" hard-linked to filename "b", 
and you have a directory structure of streams under there. So you have

	a/file1
	a/dir1/file2
	a/dir2/file3

and (through the hard-link with "b") you have aliases of all these same 
names available as "b/file1", "b/dir1/file2" etc).

Now, imagine that you have two processes doing

	mv a/dir1 a/dir2/newdir

and

	mv b/dir2 b/dir1/newdir

at the same time. Both of them MUST NOT SUCCEED, for pretty obvious 
reasons (you'd have moved two directories within each other, and now 
neither would be accessible any more).

How do you handle locking for this situation?

Another interesting case is what happens when you have looked up and cache
the filename "a/file1" and then another process does "rm b/file1". How do
you update the _other_ cached copy, since they had two different names,
but _both_ names went away at the same time. Also again, how do you handle
locking?

The general VFS layer has a lot of rules, and avoids these problems by
simply never having aliases between two directories. If the same directory
shows up multiple times (which can happen with bind mounts), they have the
exact same dentry for the directory, it's just found through two different
vfsmount instances. That's why vfsmounts exist - they allow the same name
cache entry to show up in different places at the same time.

So when we do a bind mount, and the same directory shows up under two
different names "a" and "b", and we do a "rm b/file1", it _automatically_
disappears from "a/file1" too, simply by virtue of "a" and "b" literally
being the same dentry. No aliasing ever happens, and this makes coherency
and locking much easier (which is not to say that they are trivial, but
they are pretty damn clear in comparison to the alternatives).

What Al (and others) worries about is that the reiser4 name handling has
_none_ of these issues figured out and protected against. You can protect 
against them by taking very heavy locks (you can trivially protect against 
all races by taking one large lock around any operation), but the fact is, 
that is just not an option for high-performance name lookup. 

These aliasing/locking rules need to be global and wll-though-out. Not 
just fix the two examples above, but be shown to be safe _in_general_. 

		Linus
