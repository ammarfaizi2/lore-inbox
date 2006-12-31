Return-Path: <linux-kernel-owner+w=401wt.eu-S933112AbWLaJpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112AbWLaJpp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 04:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933110AbWLaJpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 04:45:45 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42364
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933106AbWLaJpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 04:45:43 -0500
Date: Sun, 31 Dec 2006 01:45:33 -0800 (PST)
Message-Id: <20061231.014533.71091424.davem@davemloft.net>
To: miklos@szeredi.hu
Cc: rmk+lkml@arm.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1H0wiB-0003iu-00@dorka.pomaz.szeredi.hu>
References: <20061230224604.GA3350@flint.arm.linux.org.uk>
	<20061230.212338.92583434.davem@davemloft.net>
	<E1H0wiB-0003iu-00@dorka.pomaz.szeredi.hu>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 31 Dec 2006 10:10:35 +0100

> > Therefore, FUSE probably could have been fixed by judicious use
> > of copy_{to,from}_user_page() calls instead of adding this new
> > ad-hoc flush_anon_page() thing.
> 
> Probably, but I don't think either interface is perfect.
> copy_*_user_page() will double flush the user mapping
> (get_user_pages() already does a flush_dcache_page()).  Actually
> nothing except ptrace uses the copy_*_user_page() interface even
> though there are many uses of get_user_pages().
> 
> What I think get_user_pages() really needs is a single operation that
> 
>   - flushes the virtual address view
>   - flushes the kernel view
> 
> regardles whether the page is anonymous or file backed.

I guess part of the problem is that flush_dcache_page() could have
better defined semantics.

Sparc64 never notices this precisely because it can flush by physical
page and thus it can just do the flush on anonymous pages
synchronously very cheaply.

ARM probably avoids it because it would be very expensive since it
needs to flush by virtual address, so in the best case it would need
to walk the RMAP mapping list and hit every user mapping, then flush
again for the kernel side virtual address of the direct mapping to
that physical page too.

It is certainly the case that all of this stuff could be done in
a much cleaner manner.  Although it's really hard for me to get
excited by this and do the work since sparc64 already works :-)
