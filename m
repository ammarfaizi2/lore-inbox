Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSGHRuw>; Mon, 8 Jul 2002 13:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSGHRuv>; Mon, 8 Jul 2002 13:50:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23045 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316831AbSGHRuu>; Mon, 8 Jul 2002 13:50:50 -0400
Date: Mon, 8 Jul 2002 10:52:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Levon <levon@movementarian.org>
cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@conectiva.com.br>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
In-Reply-To: <20020708113928.GA80073@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0207081039390.2921-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jul 2002, John Levon wrote:
>
> > I'd rather have some generic hooks (a notion of a "profile buffer" and
> > events that cause us to have to synchronize with it, like process
> > switches, mmap/munmap - oprofile wants these too), and some generic helper
> > routines for profiling (turn any eip into a "dentry + offset" pair
> > together with ways to tag specific dentries as being "worthy" of
> > profiling).
>
> How do you see such dentry names being exported to user-space for the
> profiling daemon to access ? The current oprofile scheme is, um, less
> than ideal ...

Ok, I'll outline my personal favourite interface, but I'd also better
point out that while I've thought a bit about what I'd like to have and
how it could be implemented in the kernel, I have _not_ actually tried any
of it out, much less thought about what the user level stuff really needs.

Anyway, here goes a straw-man:

 - I'd associate each profiling event with a dentry/offset pair, simply
   because that's the highest-level thing that the kernel knows about and
   that is "static".

 - I'd suggest that the profiler explicitly mark the dentries it wants
   profiled, so that the kernel can throw away events that we're not
   interested in. The marking function would return a cookie to user
   space, and increment the dentry count (along with setting the
   "profile" flag in the dentry)

 - the "cookie" (which would most easily just be the kernel address of the
   dentry) would be the thing that we give to user-space (along with
   offset) on profile read. The user app can turn it back into a filename.

Whether it is the original "mark this file for profiling" phase that saves
away the cookie<->filename association, or whether we also have a system
call for "return the path of this cookie", I don't much care about.
Details, details.

Anyway, what would be the preferred interface from user level?

		Linus

