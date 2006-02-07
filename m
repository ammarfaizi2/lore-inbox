Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWBGWtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWBGWtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBGWtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:49:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34970 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932448AbWBGWtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:49:31 -0500
Date: Tue, 7 Feb 2006 14:51:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-Id: <20060207145134.2fcba768.akpm@osdl.org>
In-Reply-To: <20060207074213.GX58731470@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com>
	<20060205202733.48a02dbe.akpm@osdl.org>
	<20060206054815.GJ43335175@melbourne.sgi.com>
	<20060205222215.313f30a9.akpm@osdl.org>
	<20060206115500.GK43335175@melbourne.sgi.com>
	<20060206151435.731b786c.akpm@osdl.org>
	<20060207003410.GS43335175@melbourne.sgi.com>
	<20060206170411.360f3a97.akpm@osdl.org>
	<20060207013157.GU43335175@melbourne.sgi.com>
	<20060206212750.2126ca8c.akpm@osdl.org>
	<20060207074213.GX58731470@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
> So, if we leave the inode on the "more to do" list, we need to prevent
> overwrite from monopolising writeout because the only thing stopping it
> now is the fact the inode gets shoved to the dirty list by chance.....
> 
> I'm going to have a bit more of a think about this. Current
> patch attached below.

One concern I have about all this is sys_sync() and
umount->sync_inodes_sb().  Those functions _must_ write all inodes and wait
upon the result.  If pdflush is concurrently moving inodes between the
various lists, we'll miss inodes.

I suspect we're wrong already.  Adding more lists won't help.  Possibly
adding some tests for sb->s_syncing in the right place will plug the
problem, but it'll be hard to test and won't do much to clarify things.

An alternative fix is to add locking, which might be acceptable.
