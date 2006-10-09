Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932923AbWJISU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbWJISU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932994AbWJISU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:20:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932923AbWJISUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:20:23 -0400
Date: Mon, 9 Oct 2006 11:20:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix IO error reporting on fsync()
Message-Id: <20061009112011.b8c84e54.akpm@osdl.org>
In-Reply-To: <20061009114040.GI17620@atrey.karlin.mff.cuni.cz>
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
	<20061006230609.c04e78bc.akpm@osdl.org>
	<20061009114040.GI17620@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 13:40:41 +0200
Jan Kara <jack@suse.cz> wrote:

> > What about putting an address_space* into the buffer_head?  Transfer the
> > EIO state into the address_space within, say, __remove_assoc_queue()?
>   Yes, that's of course possible. But it enlarges each buffer head by 4
> bytes (or 8 on 64-bit arch).

I suspect we could get that back by removing buffer_head.b_bdev.  That's
not a trivial thing to do, but should be feasible.

We can't just do bh->b_page->mapping->host->i_sb->s_bdev because of races
with trunate, plus the general horror of it all.  But I expect that all
callers of submit_bh() have the blockdev* easily available by other means,
so adding a `struct block_device*' argument to submit_bh() would get us
there.

