Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUH1V2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUH1V2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUH1V06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:26:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:16331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267974AbUH1VZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:25:25 -0400
Date: Sat, 28 Aug 2004 14:23:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
Message-Id: <20040828142332.4bbce4fc.akpm@osdl.org>
In-Reply-To: <m3vff3f0a3.fsf@telia.com>
References: <m33c2py1m1.fsf@telia.com>
	<20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com>
	<20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com>
	<20040825065055.GA2321@suse.de>
	<m3u0unwplj.fsf@telia.com>
	<20040828130757.GA2397@suse.de>
	<m3zn4ff6jy.fsf@telia.com>
	<20040828124519.0caf23bf.akpm@osdl.org>
	<m3vff3f0a3.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> > So it basically spins around all the queues keeping them full in a
>  > non-blocking manner.
>  > 
>  > There _are_ times when pdflush will accidentally block.  Say, doing a
>  > metadata read.  In that case other pdflush instances will keep other queues
>  > busy.
>  > 
>  > I tested it up to 12 disks.  Works OK.
> 
>  OK, this should make sure that dirty data is flushed as fast as the
>  disks can handle, but is there anything that makes sure there will be
>  enough dirty data to flush for each disk?
> 
>  Assume there are two processes writing one file each to two different
>  block devices. To be able to dirty more data a process will have to
>  allocate a page, and a page becomes available whenever one of the
>  disks finishes an I/O operation. If both processes have a 50/50 chance
>  to get the freed page, they will dirty data equally fast once steady
>  state has been reached, even if the block devices have very different
>  write bandwidths.

hm.

Page allocation is fairly decoupled from the dirty memory thresholds.  The
process which wants to write to the fast disk will skirt around the pages
which are dirty against the slow disk and will reclaim clean pagecache
instead.  So the writer to the fast disk _should_ be able to allocate pages
sufficiently quickly.

The balance_dirty_pages() logic doesn't care (or know) about whether the
pages are dirty against a slow device of a fast one - it just keeps the
queues full while clamping the amount of dirty memory.  I do think that
it's possible for the writer to the fast device to get blocked in
balance_dirty_pages() due to there being lots of dirty pages against a slow
device.

Or not - the fact that the fast device retires writes more quickly will
cause waiters in balance_dirty_pages() to unblock promptly.

Or not not - we'll probably get into the situation where almost all of the
dirty pages are dirty against the slower device.

hm.  It needs some verification testing.
