Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269814AbUIDFKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269814AbUIDFKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 01:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbUIDFKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 01:10:46 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:52453 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269780AbUIDFK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 01:10:29 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Date: Sat, 4 Sep 2004 15:03:57 +1000
User-Agent: KMail/1.7
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Helge Hafting <helge.hafting@hist.no>, "Theodore Ts'o" <tytso@mit.edu>,
       Jeremy Allison <jra@samba.org>, Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
References: <200409031917.i83JHodv010368@laptop11.inf.utfsm.cl>
In-Reply-To: <200409031917.i83JHodv010368@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041504.00112.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2004 05:17, Horst von Brand wrote:
> Stuart Young <cef-lkml@optusnet.com.au> said:
> > Hence why I was suggesting the idea of disposable data in streams. As
> > long as people KNOW it's disposable, but useful to keep around as it cuts
> > down the time needed to do stuff, then apps will start to pick up
> > transporting streams properly. Least then (hopefully) no real information
> > will get lost that is important. Once transporting streams becomes
> > commonplace, then perhaps streams can be used for more useful things.
>
> How will you prevent people putting the "real" data under some random
> stream, "just because it is a prettier name"?

This is a function of exporting something complex like file streams through a 
namespace like 'file-as-directory'. As soon as you start putting complex 
things like file streams through an 'easy to use' interface, you will get 
people using it in ways you don't expect. Sure, it has to be useful, and 
relatively easy, but you don't need to make it insanely so.

And if it's all considered volatile, the only ones that NEED to know about it 
are system admins, power users and programmers, all of which have a much 
higher chance of understanding a complex object like a file stream.

> (Yes, I've seen Windows users 
> exporting everything because they found the folder + hand icon
> prettier...).  Short answer: You can't. And if you did, then it would be
> (another) hell to go through when you start using streams for "useful
> data".

Interesting you should say that. Pretty much every stream in Windows at the 
moment is considered to be volatile, as the information could be lost in a 
transfer to a networked machine or filesystem that is not stream enabled. 
Once Windows NT and Win98/ME are 'out of the picture', and FAT* filesystems 
vanish, this sort of behaviour could possibly be expected to change. Notice 
that it's a timeframe over about 5 yrs that they've been (almost silently) 
doing this already. They'll have much the same problem. Since I seriously 
doubt that streams are going to pop up in Linux overnight, with all the app 
support that this entails, we'll have the benefit of seeing just how the 
behemoth handles it, and be able to learn from their mistakes.

Of note on this, the ability to create/manipulate/read/etc streams should 
almost certainly require it's own set of ACL's beyond blindly assuming that 
the standard permissions/ACL's can cover it as is. Document creators should 
be able to create/manipulate a stream, but a searching service does not 
necessarily need to do more than read it. You could even have the ability to 
access or write to a stream other than the default covered by a capability.

> > The point of such information in my examples is that a stream can store
> > information in a particular format (ie: an index) that is common to one
> > indexing app/library.
>
> Great. Now you just need to convince everybody and Aunt Tillie to use that
> same format.

Welcome to standardisation. And in fact it's not so much necessary that 
everyone uses the same index format, as long as the same index format is used 
on one machine. In fact, it's not even that necessary, as each index format 
could use it's own stream to store it's version of the information. Yes it's 
duplication, but who isn't already used to that? (KDE/Gnome, vi/emacs, 
ext3/XFS/reiser/etc). You choose the format for the job, and by personal 
preference. If the apps don't support the format you want, you just lose 
whatever abilities the format gains you, but at least you don't lose the raw 
data.

> >                       Such an index can be used by ANY app that knows the
> > index format to search the document. This is almost exactly what MS will
> > do (if they haven't done it already) with the File Indexing Service. As
> > it's ONE library, then any new user app that creates data can add index
> > creation by adding one library. And any app that wants to search these
> > indexes would need only to add one library, not every library for every
> > format that it wants to search. It's essentially an n^2 vs 2n problem.
>
> Doable if you can just go and force a format/stream layout/application
> suite on each and every user. Won't happen in Linux (and I'm happy for
> that).

As above.

My personal view of streams (if we MUST have it under Linux, and I'm in no way 
at all convinced of that fact) is that it should in many ways be like 
journaling or hash trees in ext3. They're useful functions, but they are not 
'necessary' to the actual storage of data. Sure, they make it easy (and in 
some cases significantly easier) to recover or access data, but they are 
features that do not ultimately stop you using the core of the filesystem, 
it's main objective, which is storing data.

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
