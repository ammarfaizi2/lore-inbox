Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQL1Pga>; Thu, 28 Dec 2000 10:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130555AbQL1PgU>; Thu, 28 Dec 2000 10:36:20 -0500
Received: from hermes.mixx.net ([212.84.196.2]:64018 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129906AbQL1PgR>;
	Thu, 28 Dec 2000 10:36:17 -0500
Message-ID: <3A4B563C.DAE31010@innominate.de>
Date: Thu, 28 Dec 2000 16:03:24 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001227235533.T21944@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.10.10012271626040.10569-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 27 Dec 2000, Philipp Rumpf wrote:
> 
> > On Wed, Dec 27, 2000 at 03:41:04PM -0800, Linus Torvalds wrote:
> > > It must be wrong.
> > >
> > > If we have a dirty page on the LRU lists, that page _must_ have a mapping.
> >
> > What about pages with a mapping but without a writepage function ? or pages
> > whose writepage function fails ?  The current code seems to simply put the
> > page onto the active list in that case, which seems just as wrong to me.
> 
> ramfs. It doesn't have a writepage() function, as there is no backing
> store.
> 
> > > The bug is somewhere else, and your patch is just papering it over. We
> > > should not have a page without a mapping on the LRU lists in the first
> > > place, except if the page has anonymous buffers (and such a page cannot
> >
> > So is there any legal reason we could ever get to page_active ?  Removing
> > that code (or replacing it with BUG()) certainly would make page_launder
> > more readable.
> 
> Apart from the "we have no backing store", there is no legal reason to put
> it back on the active list that I can see.

It's logical that PageDirty should never be get for ramfs, and a ramfs
page should never have buffers on it.  With this and Chris's anon_space
mapping can we replace the check for null ->writepage with BUG?  With
the anon_space mapping we should be able to do the same ford for
->mapping.

Though these things aren't strictly bugs, having to check multiple paths
for everything is slowing us down in picking off the fluff.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
