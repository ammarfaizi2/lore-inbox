Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbUBYBuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUBYBmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:42:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:19651 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262596AbUBYBmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:42:02 -0500
Date: Tue, 24 Feb 2004 17:43:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH 2.6.3-mm3] serialize_writeback_fdatawait patch
Message-Id: <20040224174354.517b1d23.akpm@osdl.org>
In-Reply-To: <1077671733.1956.247.camel@ibm-c.pdx.osdl.net>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<1077671733.1956.247.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> This patch moves the serializing of writebacks up one level to before
> where the dirty_pages are moved to the io_pages list.  This prevents
> writebacks from missing any pages that are moved back to the
> dirty list by an SYNC_NONE writeback.  I have not seen this race in
> testing -- just by looking at the code.  It also skips the serialization
> for blockdevs.
> 
> Also this patch changes filemap_fdatawrite() to leave the page on the
> locked_pages list until the i/o has finished.  This prevents
> parallel filemap_fdatawait()s from missing a page that should be
> waited on.  I have not seen this in testing, either.

hm, OK.  I've converted all the down_read_trylock() things into a sinple
down_read(), to address the pdflush-busywait problem which Hugh identified.

This does mean that pdflush can get blocked by ongoing sync activity but
that's probably insignificant and we have per-spindle pdflush collision
avoidance which will help a bit.

Call me lazy, but could you please work out the ranking of wb_rwsem with
respect to the other VFS locks, update the locking documentation in
mm/filemap.c and make sure that we're actually adhering to it?  Thanks.

