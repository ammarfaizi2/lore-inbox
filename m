Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288757AbSA3HkY>; Wed, 30 Jan 2002 02:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288759AbSA3HkN>; Wed, 30 Jan 2002 02:40:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30980 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288757AbSA3HkB>;
	Wed, 30 Jan 2002 02:40:01 -0500
Message-ID: <3C57A1A9.E31CDB13@zip.com.au>
Date: Tue, 29 Jan 2002 23:32:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Re: [reiserfs-dev] Re: Note describing poordcache  
 utilization under high memory pressure
In-Reply-To: <3C56FE14.15EA248E@zip.com.au> <Pine.LNX.4.44.0201300113120.25123-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Tue, 29 Jan 2002, Andrew Morton wrote:
> 
> > Andreas Dilger wrote:
> > >
> > > But if it is unused and not recently referenced, there is little benefit
> > > in keeping it around, is there?
> >
> > In all of this, please remember that all caches are not of
> > equal value-per-byte.  A single page contains 32 dentries,
> > and can thus save up to 32 disk seeks.  It's potentially
> > a *lot* more valuable than a (single-seek) pagecache page.
> 
> Or it might equally well be 32 contiguous directory entries that you
> scanned over to get to the file you wanted.

The `scanned over' entries will be retained in the pagecache,
not in the dentry cache.

> If it's 32 hot items, as a
> page it's going to be aged significantly less than one equally hot
> pagecache page, so I don't think we need to worry about that too much.

Sure they're LRU at present and we could use the referenced bit
in their backing page in the future.

But what we do *not* want to do is to reclaim memory "fairly" from
all caches.  The value of a cached page should be measured in terms
of the number of seeks required to repopulate it.  That's all.

Andrea's as-yet-unmerged VM patch is much more aggressive about
shrinking the inode and dentry caches.  From reading the code, I
have a bad feeling that these caches will shrivel to zilch as soon 
as we come under a bit of memory pressure.  If so, this could 
represent significant imbalance.    But this is speculation - I
have not yet tested for this, nor looked at the code closely, and
I probably shan't until it's put up for merging.

-
