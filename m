Return-Path: <linux-kernel-owner+w=401wt.eu-S1755029AbWL2CAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbWL2CAh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 21:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbWL2CAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 21:00:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50706 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021AbWL2CAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 21:00:36 -0500
Date: Thu, 28 Dec 2006 17:59:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, guichaz@yahoo.fr, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, mh+linux-kernel@zugschlus.de,
       nickpiggin@yahoo.com.au, andrei.popa@i-neo.ro,
       linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, hugh@veritas.com,
       fw@deneb.enyo.de, tbm@cyrius.com, arjan@infradead.org,
       kenneth.w.chen@intel.com
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061228175954.fb744871.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612281730550.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612281325290.4473@woody.osdl.org>
	<20061228.145038.71089607.davem@davemloft.net>
	<Pine.LNX.4.64.0612281730550.4473@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 17:38:38 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> in 
> the hope that somebody else is working on this corruption issue and is 
> interested..

What corruption issue? ;)


I'm finding that the corruption happens trivially with your test app, but
apparently doesn't happen at all with ext2 or ext3, data=writeback.  Maybe
it will happen with increased rarity, but the difference is quite stark.

Removing the

                err = walk_page_buffers(handle, page_bufs, 0, PAGE_CACHE_SIZE,
                                        NULL, journal_dirty_data_fn);

from ext3_ordered_writepage() fixes things up.

The things which journal_submit_data_buffers() does after dropping all the
locks are ...  disturbing - I don't think we have sufficient tests in there
to ensure that the buffer is still where we think it is after we retake
locks (they're slippery little buggers).  But that wouldn't explain it
anyway.

It's inefficient that journal_dirty_data() will put these locked, clean
buffers onto BJ_SyncData instead of BJ_Locked, but
journal_submit_data_buffers() seems to dtrt with them.

So no theory yet.  Maybe ext3 is just altering timing.  But the difference
is really large..



Disabling all the WB_SYNC_NONE stuff and making everything go synchronous
everywhere has no effect.  Disabling bdi_write_congested() has no effect.



