Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265279AbSJXS1T>; Thu, 24 Oct 2002 14:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265576AbSJXS1S>; Thu, 24 Oct 2002 14:27:18 -0400
Received: from [195.223.140.120] ([195.223.140.120]:1848 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265279AbSJXS1Q>; Thu, 24 Oct 2002 14:27:16 -0400
Date: Thu, 24 Oct 2002 20:33:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: chrisl@vmware.com
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021024183327.GS3354@dualathlon.random>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024175718.GA1398@vmware.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 10:57:18AM -0700, chrisl@vmware.com wrote:
> 			if ((gfp_mask & __GFP_FS) && writepage) {
> +                               unsigned long flags = page->flags;
> 
> 				ClearPageDirty(page);
> 				SetPageLaunder(page);
> 				page_cache_get(page);
> 				spin_unlock(&pagemap_lru_lock);
> 
> -				writepage(page);
> +				if (writepage(page))
> +					page->flags = flags;
> 
> 				page_cache_release(page);
> 
> 				spin_lock(&pagemap_lru_lock);
> 				continue;
>                         }

side note, you should use atomic bitflag operations here or you risk to
lose a bit set by another cpu between the read and the write. you
basically meant SetPageDirty() if writepage fails. That is supposed to
happen in the lowlevel layer (like in fail_writepage) but the problem
here is that this isn't ramfs, and block_write_full_page could left
locked in ram lots of pages if it would disallow these pages to be
discared from the vm.

> > A few fixes have been discussed.  One way would be to allocate
> > the space for the page when it is first faulted into reality and
> > deliver SIGBUS if backing store for it could not be allocated.
> 
> I am not sure how the user program handle that signal...
> 
> >  
> > Ayup.  MAP_SHARED is a crock.  If you want to write to a file, use write().
> > 
> > View MAP_SHARED as a tool by which separate processes can attach
> > to some shared memory which is identified by the filesystem namespace.
> > It's not a very good way of performing I/O.
> 
> That is exactly the case for vmware ram file. VMware only use it to share
> memory. Those are the virtual machine's memory. We don't want to write
> it back to disk and we don't care what is left on the file system because
> when vmware exit, we will throw the guest ram data away just like a real
> machine power off ram will lost. We are not talking about machine using
> flash ram :-). 
> 
> It is kswapd try to flush the data and it should take response to handle
> the error. If it fail, one thing it should do is keep the page dirty
> if write back fail. At least not corrupt memory like that.
> 
> If we can deliver the error to user program that would be a plus.
> But this need to be fix frist.

as said this cannot be fixed easily in kernel, or it would be trivial to
lockup a machine by filling the fs changing the i_size of a file and by
marking all ram in the machine dirty in the hole, the vm must be allowed
to discard those pages and invaliding those posted writes. At least
until a true solution will be available you should change vmware to
preallocate the file, then it will work fine because you will catch the
ENOSPC error during the preallocation. If you work on shmfs that will be
very quick indeed.

Andrea
