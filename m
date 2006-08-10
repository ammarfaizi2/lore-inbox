Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161353AbWHJPcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161353AbWHJPcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWHJPcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:32:19 -0400
Received: from thunk.org ([69.25.196.29]:5810 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161350AbWHJPcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:32:18 -0400
Date: Thu, 10 Aug 2006 11:31:50 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/9] sector_t format string
Message-ID: <20060810153150.GB21801@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809234019.c8a730e3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:40:19PM -0700, Andrew Morton wrote:
> On Wed, 09 Aug 2006 18:20:43 -0700
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> > 
> > Define SECTOR_FMT to print sector_t in proper format
> > 
> > ...
> >
> >  #define HAVE_SECTOR_T
> >  typedef u64 sector_t;
> > +#define SECTOR_FMT "%llu"
> 
> We've thus-far avoided doing this.  In fact a similar construct in
> device-mapper was recently removed.
> 
> Unlike many other attempts, this one appears to be correct (people usually
> get powerpc wrong, due to its u64=unsigned long).
> 
> That being said, I'm not really sure we want to add this.  It produces
> rather nasty-looking source code and thus far we've just used %llu and we've
> typecasted the sector_t to `unsigned long long'.  That happens in a lot of
> places in the kernel and perhaps we don't want to start innovating in ext4
> ;)
> 
> That also being said...  does a 32-bit sector_t make any sense on a
> 48-bit-blocknumber filesystem?  I'd have thought that we'd just make ext4
> depend on 64-bit sector_t and be done with it.

Ext4 will support a 48-bit blocknumber format for extents, but I do
want to make ext4 suitable as a general purpose filesystem, and 32-bit
systems will be around for I fear far longer than people might wish.
So while I agree that we shouldn't go _too_ far out of our way to make
things efficient on 32-bit systems, if it's not that much work to
support a 32-bit sector_t, we ought to do it.

So how about a compromise?  We allow for a 32-bit sector_t in ext4,
but we drop the SECTOR_FMT, and rely on %llu and typecasts in
printk's.  Then the only other extra hair in the filesystem code will
be a mount-time check to make sure we don't try to mount a large
filesystem on system with a 32-bit sector_t.

						- Ted
