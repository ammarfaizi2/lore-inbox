Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131967AbRADStc>; Thu, 4 Jan 2001 13:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132141AbRADStW>; Thu, 4 Jan 2001 13:49:22 -0500
Received: from zeus.kernel.org ([209.10.41.242]:9735 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131967AbRADStN>;
	Thu, 4 Jan 2001 13:49:13 -0500
Date: Thu, 4 Jan 2001 18:46:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Mason <mason@suse.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] filemap_fdatasync & related changes
Message-ID: <20010104184604.A2034@redhat.com>
In-Reply-To: <428710000.978539866@tiny> <Pine.LNX.4.10.10101031027090.1896-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101031027090.1896-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 03, 2001 at 10:28:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Wed, Jan 03, 2001 at 10:28:05AM -0800, Linus Torvalds wrote:
> 
> On Wed, 3 Jan 2001, Chris Mason wrote:
> > 
> > Just noticed the filemap_fdatasync code doesn't check the return value from
> > writepage.  Linus, would you take a patch that redirtied the page, puts it
> > back onto the dirty list (at the tail), and unlocks the page when writepage
> > returns 1?
> 
> I don't see how that would help. It's just asking for endless loops.

Ultimately our whole IO-error handling for writes is fundamentally
broken right now, at least at the buffer_head level.  We just don't
have any mechanism in the buffer_head for distinguishing between write
errors and read errors.  If you get a write error, the next reader who
happens upon that buffer will see an invalid buffer and will try to
reread from disk, discarding the newer data from cache that we had
problems writing.

It's less of a problem with the page cache in 2.4 because such a write
error doesn't set the page to being not-uptodate, but the problem is
still there.  If we're going to start trying to be rigorous about
propagating driver write failure notification back up to user space
(eg. for O_SYNC), then ideally we need to do it in conjunction with a
rethink of the end_request() code.

The only reason I've come up against this particular problem recently
is that it impacts journaling filesystems.  It can lead to buffers in
memory suddenly appearing non-uptodate after a write, causing
subsequent reads to submit disk IOs on a buffer which the journaling
code expects to be unlocked.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
