Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUCBWTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUCBWTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:19:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:29396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbUCBWTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:19:38 -0500
Date: Tue, 2 Mar 2004 14:21:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miquels@cistron.nl
Subject: Re: 2.6.4-rc1-mm1: queue-congestion-dm-implementation patch
Message-Id: <20040302142134.4074cd2f.akpm@osdl.org>
In-Reply-To: <200403020826.52448.kevcorry@us.ibm.com>
References: <cistron.200403011400.51008.kevcorry@us.ibm.com>
	<20040302130137.GA9941@cistron.nl>
	<200403020826.52448.kevcorry@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <kevcorry@us.ibm.com> wrote:
>
> > Changing down_read() in dm_any_congested to down_read_trylock() would
> > probably fix it for bdi_*_congested(). If you can tell me how to
> > reproduce it I can try a few things..
> 
> Switching to down_read_trylock() would certainly eliminate this problem, as 
> long as you don't *need* to check the congestion of the underlying devices 
> each time dm_any_congested() is called.

It's clear from the trace: we're doing down_read() inside
sync_sb_inodes()'s inode_lock.

Yes, a trylock would fix it up, but it's a bit sleazy.

And we might have another problem here: we're thnking about removing the
global plugging queue and switching disk plugging over to being a
per-address_space thing.  So blk_run_queues() goes away and is replaced with

	mapping->backing_dev_info.unplug(&mapping->backing_dev_info);

so we only unplug the queues which back the relevant address_space.

The top-level code will take the top-level queue's lock, and the
devicemapper's implementation of backing_dev_info.unplug() will be called
under the top-level queue lock and will need to perform the same
devicemapper table walk.  A trylock here will not be acceptable: if it
fails, a process hangs up for seconds or even minutes.

So for two reasons now, it's looking like that semaphore which protects the
devicemapper tables needs to become a spinlock.  One which has interesting
ranking properties.

