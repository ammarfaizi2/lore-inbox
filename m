Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVBUW22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVBUW22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVBUW21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:28:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:25757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262158AbVBUW2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:28:20 -0500
Date: Mon, 21 Feb 2005 14:28:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: mort@wildopensource.com, linux-kernel@vger.kernel.org, raybry@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050221142804.2b7de5ed.akpm@osdl.org>
In-Reply-To: <20050221141252.6b44f0ea.pj@sgi.com>
References: <20050214154431.GS26705@localhost>
	<20050214193704.00d47c9f.pj@sgi.com>
	<20050221192721.GB26705@localhost>
	<20050221134220.2f5911c9.akpm@osdl.org>
	<20050221141252.6b44f0ea.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
> > sys_free_node_memory(long node_id, long pages_to_make_free, long what_to_free)
> > ...
> > - To make the syscall more general, we should be able to reclaim mapped
> >   pagecache and anonymous memory as well.
> 
> sys_free_node_memory() - nice.
> 
> Does it make sense to also have it be able to free up slab cache,
> calling shrink_slab()?

Yes, I suggested that slab be one of the `what_to_free' flags.  (Some of
this may be tricky to implement.  But a good interface with an
initially-crappy implementation is OK ;)

> Did you mean to pass a nodemask, or a single node id?  Passing a single
> node id is easier - we've shown that it is difficult to pass bitmaps
> across the user/kernel boundary without confusions.  But if only a
> single node id is passed, then you get the thread per node that you just
> argued was sometimes overkill.

I meant a single node ID.  With a bitmap, the kernel needs to futz around
scanning the bitmap, launching kernel threads, etc.

I'm proposing that there be no kernel threads at all.   If you have four nodes:

for i in 0 1 2 3
do
	call-sys_free_node_memory $i -1 -1 &
done

> I'd prefer the single node id, because it's easier to get right.

yup.
