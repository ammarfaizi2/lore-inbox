Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbSIYHPV>; Wed, 25 Sep 2002 03:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261930AbSIYHPU>; Wed, 25 Sep 2002 03:15:20 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:42370 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S261929AbSIYHPT>;
	Wed, 25 Sep 2002 03:15:19 -0400
Date: Wed, 25 Sep 2002 00:20:26 -0700
From: Simon Kirby <sim@netnation.com>
To: Adam Goldstein <Whitewlf@Whitewlf.net>
Cc: linux-kernel@vger.kernel.org, Adam Bernau <adam.bernau@itacsecurity.com>,
       Adam Taylor <iris@servercity.com>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Message-ID: <20020925072026.GA9670@netnation.com>
References: <20020925052411.GA8951@netnation.com> <E46487E7-D053-11D6-BCD3-000502C90EA3@Whitewlf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E46487E7-D053-11D6-BCD3-000502C90EA3@Whitewlf.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 02:56:18AM -0400, Adam Goldstein wrote:

> Have added nodiratime, missed that one, and switched to ext2 for 
> testing... ;)
> It is still running high load, but seems only slightly better , but, i 
> will know more later.

Yes, nodiratime will only make a tiny difference.

> Using postfix on new server, not sure how to disable locking?

It's not locking you'd want to disable.  If anything, it's the
synchronous writes to disk of data which may or may not even need to go
to disk (eg: an email that gets delivered almost instantly and
subsequently removed from disk just after it was written).  The idea with
a journal, however, is that it can keep track of such emails sequentually
on disk rather than seeking all over the place, and write the ones that
will stick around later.  Your output rate is too low to be bounded by a
sequential write limit alone, especially on software RAID, so it's most
likely doing a lot of seeking while writing.

> Same with mysql.. can locking be disabled? how? safe?

Again, not locking, but fsync().  It's safe providing your machine never
crashes. :)  Of course, there's still a chance it can be corrupted
_with_ fsync() anyway, but the difference is the clients will get a
result beore it guarantees the data will be on disk.

First narrow down what is causing most of the writing activity.

> The site uses php heavily, everypage has php includes and mysql lookups
> (multiple languages, banner rotation, article rotation, etc...)

I see.  The cause of your CPU-wise load appears to be mostly the PHP under
mod_php (unless something else is running).  Those processes you showed
in top were running for so long that they were probably never going to
output anything (or at least the client wouldn't be there anymore), so it
looks like a code bug.  You should debug this.

> You can take a look at the site (ok netiquette?) http://delcampe.com 

It definitely seems slow. :)

> I will assume the combination of diratime, journaling, software raid, 
> mail locking and logging are a
> bad combination.... however, I have been finding many instances online 

Software RAID won't slow it down.  diratime won't make any noticeable
difference.  Logging is usually sequential.  Journalling _with_ mail
locking might be a concern, but more than likely you're just seeing the
result of fsync().  What sort of mail load do you have?  What about the
MySQL write load?

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
