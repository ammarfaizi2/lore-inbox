Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318913AbSHEWnQ>; Mon, 5 Aug 2002 18:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318915AbSHEWnQ>; Mon, 5 Aug 2002 18:43:16 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:43789 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318913AbSHEWnP>; Mon, 5 Aug 2002 18:43:15 -0400
Date: Tue, 6 Aug 2002 00:46:50 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Chris Mason <mason@suse.com>
Cc: Oleg Drokin <green@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
In-Reply-To: <1028585680.24117.295.camel@tiny>
Message-ID: <Pine.LNX.4.44.0208060030150.1357-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Aug 2002, Chris Mason wrote:

> 01-relocation-4 deals with allowing reiserfs to use an external logging
> device.  It isn't related to your problem, but 02-commit_super-8 is
> diffed against it.
> 
> 02-commit_super-8 does two things.  First it changes sync_supers() so
> that it won't loop on a single filesystem while it's super is dirty. 
> Before, if kupdate triggered a write_super call, and another FS writer
> redirtied the super after write_super cleared it (but before it
> returned), write_super gets called a second time.  Since a commit was
> done for each write_super call, that gets expensive quickly.
> 
> Second, the patch adds a commit_super call, and changes sync() to use
> that instead of write_super.  This allows the FS to skip the commit when
> write_super is called.
> 
> This does lead to fewer commits and longer running transactions, but
> does not increase the amount of time it takes the write() call to
> complete.  It does increase the time between when you make a metadata
> change and when that change actually goes to the disk.  
> 
Ahh, thanks! This sounds like a good idea to me, hopefully your patch will 
be accepted despite the fact that Alan is busy doing other things ;-)

Coming back to the issue: applying these patches increased the throughput
by about 20% :-) Now it takes about 100sec instead of 120sec to write a
2GB file. Tomorrow I will try it without the write_times part, to see how 
much that does.

But more important: the hiccups are more seldom and sometimes shorter than 
before. With plain 2.4.19 I would hit it about twice per minute (I have 
not measured it), now it happens only after two minutes when writing 1M 
chunks at 20MB/s. The longest seen so far was also about 4 seconds, 
though.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

