Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318887AbSHEWKC>; Mon, 5 Aug 2002 18:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318890AbSHEWKC>; Mon, 5 Aug 2002 18:10:02 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:25002 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S318887AbSHEWJ4>;
	Mon, 5 Aug 2002 18:09:56 -0400
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
From: Chris Mason <mason@suse.com>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208052157040.1357-100000@pc40.e18.physik.tu-muenchen.de>
References: <Pine.LNX.4.44.0208052157040.1357-100000@pc40.e18.physik.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 18:14:39 -0400
Message-Id: <1028585680.24117.295.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 16:02, Roland Kuhn wrote:
> Hi!
> 
> On Mon, 5 Aug 2002, Roland Kuhn wrote:
> 
> > > So, on ftp.suse.com/pub/people/mason/patches/data-logging
> > > 
> > > Apply:
> > > 01-relocation-4.diff
> > > 02-commit_super-8.diff # this is the one you want, but it depends on 01.
> > > 
> > Okay, will try.
> > 
> > > And try again.  If that doesn't do it, try 04-write_times.diff (which
> > > doesn't depend on anything).
> > > 
> > Is there a documentation about what this patch does as a whole?
> > 
> Sorry, stupid question for the 04 one. What my brain wanted to say: The 
> patches 01 and 02 seem to aim at dirtying the super block less often. If 
> there is serious writing activity, will this lead to fewer but longer 
> commits? The problem with our current (kinda stupid) software is that 
> lower write() latency is more important than a few percent more 
> throughput.

01-relocation-4 deals with allowing reiserfs to use an external logging
device.  It isn't related to your problem, but 02-commit_super-8 is
diffed against it.

02-commit_super-8 does two things.  First it changes sync_supers() so
that it won't loop on a single filesystem while it's super is dirty. 
Before, if kupdate triggered a write_super call, and another FS writer
redirtied the super after write_super cleared it (but before it
returned), write_super gets called a second time.  Since a commit was
done for each write_super call, that gets expensive quickly.

Second, the patch adds a commit_super call, and changes sync() to use
that instead of write_super.  This allows the FS to skip the commit when
write_super is called.

This does lead to fewer commits and longer running transactions, but
does not increase the amount of time it takes the write() call to
complete.  It does increase the time between when you make a metadata
change and when that change actually goes to the disk.  

-chris


