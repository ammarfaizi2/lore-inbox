Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265573AbSJXRuo>; Thu, 24 Oct 2002 13:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265575AbSJXRuo>; Thu, 24 Oct 2002 13:50:44 -0400
Received: from bozo.vmware.com ([65.113.40.131]:28420 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S265573AbSJXRul>; Thu, 24 Oct 2002 13:50:41 -0400
Date: Thu, 24 Oct 2002 10:57:18 -0700
From: chrisl@vmware.com
To: Andrew Morton <akpm@digeo.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, chrisl@gnuchina.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021024175718.GA1398@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB7B11B.9E552CFF@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 01:36:43AM -0700, Andrew Morton wrote:
> 
> Yup.  If the kernel cannot write back your MAP_SHARED page due to
> ENOSPC it throws your data away.
> 
> The alternative would be to allow you to pin an arbitrary amount of
> unpageable memory.

I know the error handling in mmaped memory is poor. But I am not talking
about that one. There are two place the mmaped memory can flush back
to disk. The one you are talking about is filemap_fdatasync() in filemap.c.
It will be called when try to unmmap or sync back to the disk. It at least
check the err when writepage fail. But it still clear the page dirty anyway,
looks bad to me.

The one I am complaining about is in vmscan.c, when kswapd try to
shink the cache. Correct me if I am wrong. kswapd will flush some mmaped
page back to disk to release some page from page cache. Even when
write page fail. Kernel will still do:

ClearPageDirty(page);
SetPageLaunder(page);

for that page. So this page will be able to used by other process.
When it have a missing page fault, it will read back the WRONG
data from the disk and cause a memory corruption.

So I am expecting something like tihs:

			if ((gfp_mask & __GFP_FS) && writepage) {
+                               unsigned long flags = page->flags;

				ClearPageDirty(page);
				SetPageLaunder(page);
				page_cache_get(page);
				spin_unlock(&pagemap_lru_lock);

-				writepage(page);
+				if (writepage(page))
+					page->flags = flags;

				page_cache_release(page);

				spin_lock(&pagemap_lru_lock);
				continue;
                        }

> 
> A few fixes have been discussed.  One way would be to allocate
> the space for the page when it is first faulted into reality and
> deliver SIGBUS if backing store for it could not be allocated.

I am not sure how the user program handle that signal...

>  
> Ayup.  MAP_SHARED is a crock.  If you want to write to a file, use write().
> 
> View MAP_SHARED as a tool by which separate processes can attach
> to some shared memory which is identified by the filesystem namespace.
> It's not a very good way of performing I/O.

That is exactly the case for vmware ram file. VMware only use it to share
memory. Those are the virtual machine's memory. We don't want to write
it back to disk and we don't care what is left on the file system because
when vmware exit, we will throw the guest ram data away just like a real
machine power off ram will lost. We are not talking about machine using
flash ram :-). 

It is kswapd try to flush the data and it should take response to handle
the error. If it fail, one thing it should do is keep the page dirty
if write back fail. At least not corrupt memory like that.

If we can deliver the error to user program that would be a plus.
But this need to be fix frist.

Chris


