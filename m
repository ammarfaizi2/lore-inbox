Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbQL1PDH>; Thu, 28 Dec 2000 10:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129692AbQL1PC5>; Thu, 28 Dec 2000 10:02:57 -0500
Received: from hermes.mixx.net ([212.84.196.2]:61713 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129614AbQL1PCq>;
	Thu, 28 Dec 2000 10:02:46 -0500
Message-ID: <3A4B4E62.237DC3C5@innominate.de>
Date: Thu, 28 Dec 2000 15:29:54 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012271717230.14052-100000@duckman.distro.conectiva> <87d7eded2d.fsf@atlas.iskon.hr> <3A4A758F.98EBC605@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic wrote:
>
> Rik van Riel <riel@conectiva.com.br> writes:
>
> > On Mon, 25 Dec 2000, Dan Aloni wrote:
> > > On 25 Dec 2000, Zlatko Calusic wrote:
> > >
> > > > Speaking of page_launder() I just stumbled upon two oopsen today on
> > > > the UP build. Maybe it could give a hint to someone, I'm not that good
> > > > at Oops decoding.
> > >
> > > I've decoded the Oops I got, and found that the problem is in
> > > vmscan.c:line-605, where page->mapping is NULL and a_ops gets
> > > resolved and dereferenced at 0x0000000c.
> >
> > The code assumes that every page which has the PG_dirty
> > bit set also has page->mapping set to a valid value.
> >
> > The BUG() people are getting confirms that this assumption
> > is not necessarily true and the VM work that's going on will
> > most likely make it not be true either in some cases.
> >
> > The (trivial) patch below should fix this problem...
> >
> Looking at the patch, I'm practically sure it will cure the symptoms.
> But I'm still slightly worried about those pages we skip in
> there. Maybe we should at least try to discover what are those pages,
> and then maybe it will become obvious what we need (or not) to do with
> them.
>
> Some strategic printk()s could probably give us some clue.

Between line 573 and 594 the page can have 1 user and be unlocked, so it
can be removed by invalidate_inode_pages, and the mapping will be
cleared here:
http://innominate.org/~graichen/projects/lxr/source/mm/filemap.c?v=v2.3#L98

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
