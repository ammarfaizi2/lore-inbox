Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289309AbSAVOEw>; Tue, 22 Jan 2002 09:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289310AbSAVOEn>; Tue, 22 Jan 2002 09:04:43 -0500
Received: from 216-42-72-169.ppp.netsville.net ([216.42.72.169]:19156 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289309AbSAVOE3>; Tue, 22 Jan 2002 09:04:29 -0500
Date: Tue, 22 Jan 2002 09:03:28 -0500
From: Chris Mason <mason@suse.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <1965690000.1011708208@tiny>
In-Reply-To: <20020121230249.P4014@lynx.turbolabs.com>
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com>
 <3C4C20A2.9040009@namesys.com> <1780530000.1011633710@tiny>
 <3C4C5414.2090104@namesys.com> <1819870000.1011642257@tiny>
 <3C4C7D08.2020707@namesys.com> <1854570000.1011649986@tiny>
 <20020121230249.P4014@lynx.turbolabs.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, January 21, 2002 11:02:49 PM -0700 Andreas Dilger
<adilger@turbolabs.com> wrote:

[ snip ]

It seems like the basic features we are suggesting are very close, I'll try
one last time to make a case against the 'free_some_pages' call ;-)

> 
> The VM can make better _specific_ judgements when it needs to (e.g. free
> a DMA page or another specific page to allow a larger contiguous chunk of
> memory to be allocated), but in the cases where it just wants _some_
> page(s) to be freed, it should allow the FS to decide which one(s), if it
> cares.

I'd rather see the VM trigger a flush on a specific page, but tell the FS
it's OK to do broader actions if it wants to.  In the case of write
throttling, the FS doesn't know which page has been dirty the longest,
unless it starts maintaining its own lists.  The VM has all that
information, so it kicks the throttle or periodic write off with one
buffer, and lets the FS trigger other events because we aren't under huge
memory load.

The FS doesn't know how long a page has been dirty, or how often it gets
used, or anything other than this page is pinned and waiting for X event to
take place.  If we really can't get this info to the VM in a useful
fashion, that's one thing.  But if we can clue the VM in a little and put
the decision making there, I think the end result will be more likely to
clean the right page.  That does affect performance even when we're not
under heavy memory pressure.

-chris

