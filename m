Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVJQXS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVJQXS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVJQXS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:18:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751377AbVJQXSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:18:25 -0400
Date: Mon, 17 Oct 2005 16:17:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC] page lock ordering and OCFS2
Message-Id: <20051017161744.7df90a67.akpm@osdl.org>
In-Reply-To: <20051017222051.GA26414@tetsuo.zabbo.net>
References: <20051017222051.GA26414@tetsuo.zabbo.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
> 
> I sent an ealier version of this patch to linux-fsdevel and was met with
> deafening silence.

Maybe because nobody understood your description ;)

>  I'm resending the commentary from that first mail and am
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

The patch is of course pretty unwelcome: lots of weird stuff in the core
VFS which everyone has to maintain but probably will not test.

So I think we need a better understanding of what the locking inversion
problem is, so we can perhaps find a better solution.  Bear in mind that
ext3 has (rare, unsolved) lock inversion problems in this area as well, so
commonality will be sought for.

> OCFS2 maintains page cache coherence between nodes by requiring that a node
> hold a valid lock while there are active pages in the page cache.

"active pages in the page cache" means present pagecache pages in the node
which holds pages in its pagecache, yes?

>  The page
> cache is invalidated before a node releases a lock so that another node can
> acquire it.  While this invalidation is happening new locks can not be acquired
> on that node.  This is equivalent to a DLM processing thread acquiring
> PG_locked during truncation while holding a DLM lock.  Normal file system user
> tasks come to the a_ops with PG_locked acquired by their callers before they
> have a chance to get DLM locks.

So where is the lock inversion?

Perhaps if you were to cook up one of those little threadA/threadB ascii
diagrams we could see where the inversion occurs?

