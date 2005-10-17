Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVJQXiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVJQXiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVJQXiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:38:00 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:65171 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751391AbVJQXh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:37:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=kBocM+WRec+FswV/ZCm287Qq95i4Oma8GgTcUEK63x6cFvjY7IPRQz7yPG1dffGjPAES8r+6byEWC3B35DnQg9ChaxE4pY9VJdUmroW14E+aH0m+eRGbuUjHivIAp+AHGhcLMNs6rociOWVFyE0QVhgm+jc+QmhKuu6xZI8oVhI=
Subject: Re: [RFC] page lock ordering and OCFS2
From: Badari Pulavarty <pbadari@gmail.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20051017222051.GA26414@tetsuo.zabbo.net>
References: <20051017222051.GA26414@tetsuo.zabbo.net>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 16:37:20 -0700
Message-Id: <1129592240.23632.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 15:20 -0700, Zach Brown wrote:
> I sent an ealier version of this patch to linux-fsdevel and was met with
> deafening silence.  I'm resending the commentary from that first mail and am
> including a new version of the patch.  This time it has much clearer naming
> and some kerneldoc blurbs.  Here goes...
> 
> --
> 
> In recent weeks we've been reworking the locking in OCFS2 to simplify things
> and make it behave more like a "local" Linux file system.  We've run into an
> ordering inversion between a page's PG_locked and OCFS2's DLM locks that
> protect page cache contents.  I'm including a patch at the end of this mail
> that I think is a clean way to give the file system a chance to get the
> ordering right, but we're open to any and all suggestions.  We want to do the
> cleanest thing.
> 
> OCFS2 maintains page cache coherence between nodes by requiring that a node
> hold a valid lock while there are active pages in the page cache.  The page
> cache is invalidated before a node releases a lock so that another node can
> acquire it.  While this invalidation is happening new locks can not be acquired
> on that node.  This is equivalent to a DLM processing thread acquiring
> PG_locked during truncation while holding a DLM lock.  Normal file system user
> tasks come to the a_ops with PG_locked acquired by their callers before they
> have a chance to get DLM locks.
> 
> We talked a little about modifying the invalidation path to avoid waiting for
> pages that are held by an OCFS2 path that is waiting for a DLM lock.  It seems
> awfully hard to get right without some very nasty code.  The truncation on lock
> removal has to write back dirty pages so that other nodes can read it -- it
> can't simply skip these pages if they happened to be locked.
> 
> So we aimed right for the lock ordering inversion problem with the appended
> patch.  It gives file systems a callback that is tried before page locks are
> acquired that are going to be passed in to the file system's a_ops methods.
> 
> So, what do people think about this?  Is it reasonable to patch the core to
> help OCFS2 with this ordering inversion?

Sorry for the "deafening silence" on fs-devel. I was trying to see
what exactly I need and how to combine with what you are trying to
do, before I reply. Unfortunately, I don't understand your lock
inversion problem well enough :(

I was looking at ext3 pagelock, trasaction ordering. I wanted
a way to reverse the ordering to support writepages() cleanly.
I guess what you are proposing could be used (in a weird way) to
that, except that I need the support in different places (callers
of writepage, writepages). BTW, I wasn't comfortable touching VFS
locking just of ext3 purpose :(

Thanks,
Badari

