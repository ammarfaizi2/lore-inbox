Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRACRkh>; Wed, 3 Jan 2001 12:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbRACRk1>; Wed, 3 Jan 2001 12:40:27 -0500
Received: from hermes.mixx.net ([212.84.196.2]:37393 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129183AbRACRkX>;
	Wed, 3 Jan 2001 12:40:23 -0500
Message-ID: <3A535C3F.EE5B3331@innominate.de>
Date: Wed, 03 Jan 2001 18:07:11 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <Pine.LNX.4.21.0012291446560.13194-100000@freak.distro.conectiva> <428710000.978539866@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> Hi guys,
> 
> Just noticed the filemap_fdatasync code doesn't check the return value from
> writepage.  Linus, would you take a patch that redirtied the page, puts it
> back onto the dirty list (at the tail), and unlocks the page when writepage
> returns 1?

It would be a lot more consistent if ->writepage always unlocks the page
(or starts the chain of events that eventually unlocks the page) even
when it fails.

> That would loop forever if the writepage func kept returning 1 though...I
> think that's what we want, unless someone like ramfs made a writepage func
> that always returned 1.

Even then it's ok.  Without major surgery, those pages are going to loop
forever somewhere, it might as well be the inactive_dirty list.  This is
going to mess up the mm balancing calculations, but of course only when
somebody is actually using ramfs.  Maybe somebody will come up with a
tidy way of getting those pages entirely off the mm lists so they doing
just keep eating cpu cycles.

By the way, the whole concept of ramfs is really elegant - ramdisks are
just wrong, because all the ramdisk data in cache is in memory twice. 
Solution: throw away the disk, keep the cache.  Nice.

> For the reiserfs code, I'd like to be able to tell page_launder and
> filemap_fdatasync to try the page again later.  reiserfs would clean and
> unlock the page if no io needs to be done at all.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
