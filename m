Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVJWVLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVJWVLn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVJWVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:11:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750760AbVJWVLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:11:43 -0400
Date: Sun, 23 Oct 2005 14:10:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH] Fix and add EXPORT_SYMBOL(filemap_write_and_wait)
Message-Id: <20051023141057.59e458f3.akpm@osdl.org>
In-Reply-To: <87ek6dtvxz.fsf@devron.myhome.or.jp>
References: <87ek6dtvxz.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> This patch add EXPORT_SYMBOL(filemap_write_and_wait) and use it.
> 
>  See mm/filemap.c:
> 
>  And changes the filemap_write_and_wait() and filemap_write_and_wait_range().
> 
>  Current filemap_write_and_wait() doesn't wait if filemap_fdatawrite()
>  returns error. However, even if filemap_fdatawrite() returns error, it
>  may be submiting data pages . (e.g. in the case of -ENOSPC)
> 
>  However, even if filemap_fdatawrite() returned an error, it may have
>  submitted the partially data pages to the device.
> 
>  I think we should wait those submitted data pages.

This behaviour is deliberate, although I wouldn't claim that a lot of
thought went into it.

If filemap_fdatawrite() returns an error, this might be due to some I/O
problem: dead disk, unplugged cable, etc.  Given the generally crappy
quality of the kernel's handling of such exceptions, there's a good chance
that the filemap_fdatawait() will get stuck in D state forever.

I don't know how useful that really is - probably not very.  Plus, yes, we
should wait on writeout after a -ENOSPC.

So hum, not sure.  My gut feeling is that anything which we can do to help
the kernel limp along after an I/O error is a good thing, hence the
don't-wait-after-EIO feature should remain.

