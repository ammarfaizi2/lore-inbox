Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312616AbSCZTPd>; Tue, 26 Mar 2002 14:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312626AbSCZTPY>; Tue, 26 Mar 2002 14:15:24 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16704 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312616AbSCZTPU>; Tue, 26 Mar 2002 14:15:20 -0500
Date: Tue, 26 Mar 2002 20:15:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap bug with drivers that adjust vm_start
Message-ID: <20020326201502.J13052@dualathlon.random>
In-Reply-To: <20020325230046.A14421@redhat.com> <20020326174236.B13052@dualathlon.random> <20020326135703.B25375@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 01:57:03PM -0500, Benjamin LaHaise wrote:
> On Tue, Mar 26, 2002 at 05:42:36PM +0100, Andrea Arcangeli wrote:
> > However if the patch is needed it means the ->mmap also must do the
> > do_munmap stuff by hand internally, which is very ugly given we also did
> > our own do_munmap in a completly different region (the one requested by
> > the user).
> 
> At least my own code checks for that and fails if there is a mapping 
> already placed at the fixed address it needs to use.  If we're paranoid, 

Ok, so it's safe.

> we could BUG() on getting a vma back from the new find_vma_prepare call.

yes, it sounds a good idea to verify there's no other mapping in the way
of the relocation (until a better fix is implemented), it's a slow path
so we won't hurt performance.

> 
> > Our do_munmap should not happen if we place the mapping
> > elsewhere. If possible I would prefer to change those drivers to
> > advertise their enforced vm_start with a proper callback, the current
> > way is halfway broken still. BTW, which are those drivers, and why they
> > needs to enforce a certain vm_start (also despite MAP_FIXED that they
> > cannot check within the ->mmap callback)?
> 
> Video drivers, others that require specific alignment (4MB pages for 
> example).  Historically, the mmap call has been the hook for doing this, 
> hence the comment in do_mmap from davem.  Unless there's a really good 
> reason for changing the hook, I don't see doing so as providing much 
> benefit other than making source compatibility hard.

The good reason, is that currently we're literally corrupting the
userspace with the senseless do_munmap call in the add<->addr+len area
before the ->mmap lowlevel callback. And such an munmap is certainly not
required to maintain source and binary compatibility (otherwise it would
be insane in the first place :).

Andrea
