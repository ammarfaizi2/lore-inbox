Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbVKXStG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVKXStG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbVKXStG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:49:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751385AbVKXStE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:49:04 -0500
Date: Thu, 24 Nov 2005 10:48:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux@horizon.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] SMP alternatives
In-Reply-To: <20051124174843.30544.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0511241045200.13959@g5.osdl.org>
References: <20051124174843.30544.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Nov 2005, linux@horizon.com wrote:
>
> > I suspect that with MAP_SHARED + PROT_WRITE being pretty uncommon anyway, 
> > we can probably find trivial patterns in the kernel. Like only one process 
> > holding that file open - which is what you get with things that use mmap() 
> > to write a new file (I think "ld" used to have a config option to write 
> > files that way, for example).
> 
> Just a bit of practical experience: I use mmap() to write data a LOT,
> because msync(MS_ASYNC) is the most portable way to do an async write.

Sure. But I suspect that nobody else has that file open when you do so?

In other words, even your usage is something where the OS could tell that 
you don't actually need atomic operations. It certainly gets slightly more 
complicated (we'd need to trigger some special stuff if another process 
does an mmap on it), but it's not conceptually very difficult to just 
notice automatically and do the right thing(tm).

Now, if two programs are using mmap() to write to the same file at the 
same time, then the kernel can't tell any more. But in that case, you 
probably _do_ want atomic ops to be guaranteed, so not disabling them is 
the right thing to do there.

			Linus
