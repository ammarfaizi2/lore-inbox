Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269648AbUHZUsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269648AbUHZUsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269636AbUHZUo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:44:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:54165 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269553AbUHZUnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:43:20 -0400
Date: Thu, 26 Aug 2004 13:40:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0408261315110.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Rik van Riel wrote:
> 
> Thinking about it some more, how would file managers and file chosers
> handle this situation ?

The same way they already handle it on other platforms that support it? By 
taking advantage of it..

People literally use this for icon and preview information, so some of the
stuff shows up very much in file managers. And I'd assume that a normal
double-click would just open the main file, and you can right-click for 
management information, including opening the file.

If you want an entity that acts as a directory, you create a directory. 

Directories don't go away - you still have S_ISDIR() and S_ISREG(), and 
they still return information. A file that has associated information is 
still a _file_, and people should treat it that way, it's just that it 
also has a list of named sub-streams. You can open it as a directory, but 
the stat information clearly says it is a file, and the "directory" view 
is very much associated with _that_ file.

I definitely don't think you want the file manager to act as if a named 
stream is exactly the same as a stand-alone file. They have all the same 
operations, but there's no question that there are differences too. 
Especially on a conceptual level - but for most filesystems there are 
likely real technical differences too.

For example, it's likely that most filesystems would _not_ allow linking 
of a named stream anywhere else. And you might not be able to change the 
permissions or date on the named stream either, since it may or may not 
have a separate date/permission thing from the container.

So don't believe that just because the named streams are _named_ like real 
files, that they suddenly have any existence beyond the container that 
they are part of.

There may be other limitations too - again depending on how the filesystem
actually implements named streams. It might not support more than one
level of naming, for example - so you might not be able to create a
directory structure within the named streams, for example.

In short: the fact that the VFS layer exposes the _capability_ to see the 
named streams as a full POSIX filesystem of its own does _not_ mean that 
the low-level filesystem necessarily allows the full possible semantics. 
So you shouldn't design your apps that know about named streams to think 
they are normal directories.

The directory thing is just a very powerful naming scheme, and one that 
fits into the existing UNIX model.

> Do we really want to have a file paradigm that's different
> from the other OSes out there ?

Different from what other OSes?

Last I looked, Windows, Solaris, and OSX all supported named streams. What 
other OS's are out there that you care about? 

In other words, this is _not_ a different paradigm from what others do.  
The discussion is whether we want to implement it at all, and more
importantly about syntactic issues (ie we clearly already implement
extended attributes, just with a much more limited syntactic power).

We don't have to go all the way. Solaris has "openat()", which is kind of 
a half-way there - not really directly available in the same namespace, 
but at least the result is available as a real file interface (as opposed 
to the Linux "xattr" interfaces that are _totally_ special-cased system 
calls).

In other words - the paradigm is already there. It's just that currently
it's pretty much unusable under Linux, because it requires so much
specialized knowledge that it's not worth it to modify existing apps. And
the interfaces are really very limited, so even if you _do_ end up using 
the specialized Linux interfaces, you can't actually do a lot of what you 
might want to do.

			Linus
