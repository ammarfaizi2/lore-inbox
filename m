Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSIFAoJ>; Thu, 5 Sep 2002 20:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSIFAoJ>; Thu, 5 Sep 2002 20:44:09 -0400
Received: from mons.uio.no ([129.240.130.14]:51178 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318182AbSIFAoI>;
	Thu, 5 Sep 2002 20:44:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15735.64356.246705.392224@charged.uio.no>
Date: Fri, 6 Sep 2002 02:48:36 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D77D879.7F7A3385@zip.com.au>
References: <3D77C8B7.1534A2DB@zip.com.au>
	<15735.52512.886434.46650@charged.uio.no>
	<3D77D879.7F7A3385@zip.com.au>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     > I'm not sure what semantics we really want for this.  If we
     > were to "invalidate" a mapped page then it would become
     > anonymous, which makes some sense.

     > But if we want to keep the current "don't detach mapped pages
     > from pagecache" semantics then we should test page->pte.direct
     > rather than page_count(page).  Making that 100% reliable would
     > be tricky because of the need for locking wrt concurrent page
     > faults.

I believe that Linus is very much in favour of this latter
approach. We had the 'anonymize page' semantics under 2.2.x, but they
were changed in the 2.4.0-pre series.

The problem is that NFS can clear your page cache at any
moment. Things like out-of-order RPC calls etc. can trigger it. If
your knee-jerk response is to anonymize all those pages that are
referenced, you might end up with page aliasing (well - in practice
not, since we do protect against that but Linus wasn't convinced).

     > The mapping's releasepage must try to clear away whatever is
     > held at ->private.  If that was successful then releasepage()
     > must clear PG_private, decrement
     > page-> count and return non-zero.  If the info at ->private is not
     > freeable, releasepage returns zero.  ->releasepage() may not
     > sleep in
     > 2.5.

Interesting. Our 'private data' in this case would be whether or not
there is some pending I/O operation on the page. We don't keep it in
page->private, but I assume that's less of a problem ;-)
It's unrelated to the topic we're discussing, but having looked at it
I was thinking that we might want to use it in order to replace the
NFS 'flushd' daemon.  Currently the latter is needed mainly in order
to ensure that readaheads actually do complete in a timely fashion
(i.e. before we run out of memory).  Since try_to_release_page() is
called in shrink_cache(), I was thinking that we might pass that buck
on to releasepage()

(btw: there's currently a bug w.r.t. that'. If I understand you
correctly, the releasepage() thing is unrelated to page->buffers, but
the call in shrink_cache() is masked by an 'if (page->buffers))

Extending that idea, we might also be able to get rid of
nfs_try_to_free_pages(), if we also make releasepage() call the
necessary routines to flush dirty pages too...

Cheers,
  Trond
