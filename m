Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUIFBc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUIFBc4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 21:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUIFBc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 21:32:56 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:7184 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S267378AbUIFBcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 21:32:53 -0400
Date: Mon, 6 Sep 2004 11:32:26 +1000 (EST)
From: Tim Connors <tconnors+linuxkernel1094371411@astro.swin.edu.au>
X-X-Sender: tconnors@radium.ssi.swin.edu.au
To: Mike Jagdis <mjagdis@eris-associates.co.uk>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: why do i get "Stale NFS file handle" for hours?
In-Reply-To: <413B3CBD.1000304@eris-associates.co.uk>
Message-ID: <Pine.LNX.4.53.0409061114420.31394@radium.ssi.swin.edu.au>
References: <chdp06$e56$1@sea.gmane.org>  <1094348385.13791.119.camel@lade.trondhjem.org>
  <413A7119.2090709@upb.de>  <1094349744.13791.128.camel@lade.trondhjem.org>
  <413A789C.9000501@upb.de> <1094353267.13791.156.camel@lade.trondhjem.org>
 <slrn-0.9.7.4-19971-22570-200409051803-tc@hexane.ssi.swin.edu.au>
 <413B3CBD.1000304@eris-associates.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004, Mike Jagdis wrote:

> Tim Connors wrote:
> > I will update one directory with rsync from one host,
>
> You mean rsync to the server and change files directly on the fs rather
> than through an NFS client?

No - the server is behind a firewall. Just an ordinary nfs client.

> > and then try, a
> > little later on, to operate on that directory from another host. Every
> > now and then, from a single host only, a few files in that tree will
> > get stale filehandles - an ls of that directory will mostly be fine
> > apart from those files. They will also be fine from any other machine.
>
> Yeah, that's what happens... Clients that had the file open are liable
> to get ESTALE. Stale file handles stick around until unmount. As long as
> they're around automount will consider the mount busy and not expire it
> (but you can unmount manually or killall -USR1 automountd).

Yep - that has been the case normally (when the entire mount went stale),
we'd just restart the automounter.

You almost hit the nail on the head with regards to the problem - this
last happened a week ago, and I seem to remember 6 files getting ESTALE.
But only 2 of those would have likely been open on the host where they
went stale, at any time near when they went stale (if they were open at
all), if I am remembering things right. Unless an `ls -lA --color` counts
as "opening" (they weren't symlinks, just normal files, so I doubt it).

What is strange, is I was able to make them "unstale" simply by clearing
cache - allocating a large block of ram, and ensuring buffers and cached
went to something very small. I didn't need to restart the automounter at
all. Then, I could `ls` the directory fine, and could `cat` the files
fine.

I'm afraid that the intermittent nature of this problem is going to make
it hard for me to reproduce though!

I take it the files go stale (normally) because sillyrename only happens
when 1 host tries to delete while the same host has the file open, so the
server doesn't know that a client still has it open, and if the inode just
happens to be allocated by something new, then the server has no choice
but to say "bugger off"? I thought I had seen in the past that you could
delete a file from one host, have another host still be using the file,
and it would do the sillyrename, and the client would continue to use the
file just fine - probably was on a Sun, come to think of it -- does it's
equivalent of sillyrename keep track of who has what open?

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
"Meddle not in the affairs of cats, for they are subtle, and will
piss on your computer."                             - Jeff Wilder
