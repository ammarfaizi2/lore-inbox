Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTAATwK>; Wed, 1 Jan 2003 14:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTAATwK>; Wed, 1 Jan 2003 14:52:10 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:61962 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262789AbTAATwH>; Wed, 1 Jan 2003 14:52:07 -0500
Date: Wed, 1 Jan 2003 20:00:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: RFC/Patch - Implode devfs
Message-ID: <20030101200032.A29992@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
References: <200301011913.LAA02338@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301011913.LAA02338@baldur.yggdrasil.com>; from adam@yggdrasil.com on Wed, Jan 01, 2003 at 11:13:02AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 11:13:02AM -0800, Adam J. Richter wrote:
> >I wonder whether some code uses struct devfs_entry * directly, at least
> >I was tempted to do so in the scsi midlayer.
> 
> 	Thankfully, struct devfs_entry* is an opaque pointer.

I know.  IMHO it's still preferable to use struct devfs_entry * over
devfs_handle_t like all the devfs mess does.  This would work when
devfs_handle_t suddenly points to something else.

The
> struct is only defined in fs/devfs/base.c.  Searching with
> "find . -name '*.[ch]' | xargs grep -w devfs_entry" indicates
> that everyone declares devfs_handle_t instead of "struct devfs_entry*",
> so that's not a problem either.

OK.

> 	Your question prompted me to do a little bit of research.
> I believe the list of routines that my reduced devfs does not
> implement is as follows:
> 
> devfs_get_handle
> devfs_get_handle_from_inode
> devfs_set_file_size
> devfs_get_info
> devfs_set_info
> devfs_get_parent
> devfs_get_first_child
> devfs_get_next_sibling
> devfs_get_name
> devfs_register_tape
> devfs_unregister_tape
> devfs_alloc_major
> devfs_dealloc_major
> devfs_alloc_devnum
> devfs_dealloc_devnum
> 
> 	Storing this list in /tmp/names and grepping for these
> identifiers shows only a small number of hits:

<snip>

At least the devfs_set_* / devfs_get_* can be removed easily when
leaving the sn1 stuff danling.  But I already discussed that with
the responsible persons.

> >Is it supposed to work out of the box on previously (and for 2.4 use)
> >non-devfs systems?  I still don't plan to use devfs, but such an effort
> >is really worth some debugging help..
> 
> 	Thanks for the encouragement.

So is the answer yes or no now? :)

> >Why do you want to allocate it statically?
> 
> 	A few fields could be initialized statically.  A few bytes
> would be saved from memory allocation overhead.  Cache locality would
> improve infinitesemally.  If all one-instance filesystems are changed
> to do this, it will eliminate one memory allocation failure branch in
> fs/super.c.  Perhaps the same could be done with the root inode.  I
> know this is pretty marginal and might end up adding more complexity
> than it would save.  It's at the bottom of my TODO (or "to try") list.

Hmm.  I don't think it's worth the effort, but if you can do it without
introducing major ugliness you have my vote.

