Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292817AbSCEXGo>; Tue, 5 Mar 2002 18:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293064AbSCEXGc>; Tue, 5 Mar 2002 18:06:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:48690 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292817AbSCEXFL>; Tue, 5 Mar 2002 18:05:11 -0500
Date: Wed, 6 Mar 2002 00:05:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020306000532.N20606@dualathlon.random>
In-Reply-To: <20020305161032.F20606@dualathlon.random> <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva> <20020305192604.J20606@dualathlon.random>, <20020305192604.J20606@dualathlon.random>; <20020305183053.A27064@fenrus.demon.nl> <3C8518AE.B44AF2D5@zip.com.au> <20020306000314.M20606@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020306000314.M20606@dualathlon.random>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 12:03:14AM +0100, Andrea Arcangeli wrote:
> On Tue, Mar 05, 2002 at 11:12:46AM -0800, Andrew Morton wrote:
> > Arjan van de Ven wrote:
> > > 
> > > On Tue, Mar 05, 2002 at 07:26:04PM +0100, Andrea Arcangeli wrote:
> > > 
> > > > Another approch would be to add the pages backing the bh into the lru
> > > > too, but then we'd need to mess with the slab and new bitflags, new
> > > > methods and so I don't think it's the best solution. The only good
> > > > reason for putting new kind of entries in the lru would be to age them
> > > > too the same way as the other pages, but we don't need that with the bh
> > > > (they're just in, and we mostly care only about the page age, not the bh
> > > > age).
> > > 
> > > For 2.5 I kind of like this idea. There is one issue though: to make
> > > this work really well we'd probably need a ->prepareforfreepage()
> > > or similar page op (which for page cache pages can be equal to writepage()
> > > ) which the vm can use to prepare this page for freeing.
> > 
> > If we stop using buffer_heads for pagecache I/O, we don't have this problem.
> > 
> > I'm showing a 20% reduction in CPU load for large reads.  Which is a *lot*,
> > given that read load is dominated by copy_to_user.

BTW, I noticed one of my last my email was a private reply so I'll
answer here too for the buffer_head pagecache I/O part:

Having persistence on the physical I/O information is a good thing, so
you don't need to resolve logical to physical block at every I/O and bio
has a cost to setup too. The information we carry on the bh isn't
superflous, it's needed for the I/O so even if you don't use the
buffer_head you will still need some other memory to hold such
information, or alternatively you need to call get_block (and serialize
in the fs) at every I/O even if you've plenty of ram free. So I don't
think the current setup is that stupid, current bh only sucks for the
rawio and that's fixed by bio.

Andrea
