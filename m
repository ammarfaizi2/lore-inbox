Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSIFBGc>; Thu, 5 Sep 2002 21:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318218AbSIFBGc>; Thu, 5 Sep 2002 21:06:32 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:36870 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318216AbSIFBGb>; Thu, 5 Sep 2002 21:06:31 -0400
Message-ID: <3D780027.13A5B3B@zip.com.au>
Date: Thu, 05 Sep 2002 18:08:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77D879.7F7A3385@zip.com.au> <15735.64356.246705.392224@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Andrew Morton <akpm@zip.com.au> writes:
> 
>      > I'm not sure what semantics we really want for this.  If we
>      > were to "invalidate" a mapped page then it would become
>      > anonymous, which makes some sense.
> 
>      > But if we want to keep the current "don't detach mapped pages
>      > from pagecache" semantics then we should test page->pte.direct
>      > rather than page_count(page).  Making that 100% reliable would
>      > be tricky because of the need for locking wrt concurrent page
>      > faults.
> 
> I believe that Linus is very much in favour of this latter
> approach. We had the 'anonymize page' semantics under 2.2.x, but they
> were changed in the 2.4.0-pre series.

hm.

> The problem is that NFS can clear your page cache at any
> moment. Things like out-of-order RPC calls etc. can trigger it. If
> your knee-jerk response is to anonymize all those pages that are
> referenced, you might end up with page aliasing (well - in practice
> not, since we do protect against that but Linus wasn't convinced).

Oh.  I thought this was a "purely theoretical" discussion because
it only pertains to directory data.   You seem to be saying that
NFS is doing this for S_ISREG pagecache also?

Again: what do you _want_ to do?  Having potentially incorrect pagecache
mapped into process memory space is probably not the answer to that ;)

Should we be forcibly unmapping the pages from pagetables?  That would
result in them being faulted in again, and re-read.
 
>      > The mapping's releasepage must try to clear away whatever is
>      > held at ->private.  If that was successful then releasepage()
>      > must clear PG_private, decrement
>      > page-> count and return non-zero.  If the info at ->private is not
>      > freeable, releasepage returns zero.  ->releasepage() may not
>      > sleep in
>      > 2.5.
> 
> Interesting. Our 'private data' in this case would be whether or not
> there is some pending I/O operation on the page. We don't keep it in
> page->private, but I assume that's less of a problem ;-)
> It's unrelated to the topic we're discussing, but having looked at it
> I was thinking that we might want to use it in order to replace the
> NFS 'flushd' daemon.  Currently the latter is needed mainly in order
> to ensure that readaheads actually do complete in a timely fashion
> (i.e. before we run out of memory).  Since try_to_release_page() is
> called in shrink_cache(), I was thinking that we might pass that buck
> on to releasepage()

That might work.  It's a bit of a hassle that ->releasepage() must
be nonblocking, but generally it just wants to grab locks, decrement
refcounts and free things.
 
> (btw: there's currently a bug w.r.t. that'. If I understand you
> correctly, the releasepage() thing is unrelated to page->buffers, but
> the call in shrink_cache() is masked by an 'if (page->buffers))

That would be in a 2.4 kernel?  In 2.4, page->buffers can only
contain buffers.  If it contains anything else the kernel will
die.
 
> Extending that idea, we might also be able to get rid of
> nfs_try_to_free_pages(), if we also make releasepage() call the
> necessary routines to flush dirty pages too...

->releasepage() should never succeed against a dirty page.  In fact
the VM shouldn't even bother calling it - there's a minor efficiency
bug there.

If your mapping has old, dirty pages then the VM will call your
->vm_writeback to write some of them back.  Or it will repeatedly
call ->writepage if you don't define ->vm_writeback.  That's the 
place to clean the pages.
