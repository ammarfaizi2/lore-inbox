Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUHYX5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUHYX5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUHYX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:57:31 -0400
Received: from mail.shareable.org ([81.29.64.88]:33477 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266467AbUHYXyQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:54:16 -0400
Date: Thu, 26 Aug 2004 00:54:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@lst.de>, Alex Zarochentsev <zam@namesys.com>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825235409.GA23423@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com> <20040825205149.GA17654@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825205149.GA17654@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> > Reiser4 may have a mount option for whoose who like or have to use
> > traditional O_DIRECTORY semantics.  There would be no /metas under
> > non-directories, if user wants that.
> 
> Again, O_DIRECTORY was added to solve a real-world race, not just for
> the sake of it.  If you really want to add that option I'll research the
> CAN number for you so you can named it after that - or just call it -o
> insecure directly.

man open(2) explains that O_DIRECTORY is used by opendir() to prevent
blocking when opening pipes and certain devices*, and should only by
used by opendir (of course it isn't only used by opendir, as it's a
handy optimisation).

In fact O_DIRECTORY is also used by Glibc to optimise away stat()
before and fstat() after calls.

An O_NODEVICE flag would be equally secure, and more generally useful.

It's important that device nodes cannot be opened when O_DIRECTORY is
set.  This is compatible with reiser4 file-as-directory semantics, but
I don't know if reiser4 actually implements this.  If it does (and it
should) then there is no device blocking problem.

That leaves only the optimisation of fstat() in opendir().

But that begs the question: do we want opendir() to succeed on a reiser4 file?

It's up to us to decide if we like that semantic, or prefer a
different one such as the one I described before (path search enters
file-as-directory, but opendir() directly on it fails), or the Sun
syscalls someone mentioned.

-- Jamie


* Aside: O_NONBLOCK|O_NOCTTY is an effective way to prevent blocking on
many systems.  It's best if you can avoid opening devices at all though.
