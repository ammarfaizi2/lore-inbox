Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVAWKgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVAWKgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVAWKfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:35:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:46809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261288AbVAWKd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:33:28 -0500
Date: Sun, 23 Jan 2005 02:32:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050123023248.263daca9.akpm@osdl.org>
In-Reply-To: <20050123095608.GD16648@suse.de>
References: <20050121161959.GO3922@fi.muni.cz>
	<1106360639.15804.1.camel@boxen>
	<20050123091154.GC16648@suse.de>
	<20050123011918.295db8e8.akpm@osdl.org>
	<20050123095608.GD16648@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> But I'm still stuck with all of my ram gone after a
>  600MB fillmem, half of it is just in swap.

Well.  Half of it has gone so far ;)

> 
>  Attaching meminfo and sysrq-m after fillmem.

(I meant a really big fillmem: a couple of 2GB ones.  Not to worry.)

It's not in slab and the pagecache and anonymous memory stuff seems to be
working OK.  So it has to be something else, which does a bare
__alloc_pages().  Low-level block stuff, networking, arch code, perhaps.

I don't think I've ever really seen code to diagnose this.

A simplistic approach would be to add eight or so ulongs into struct page,
populate them with builtin_return_address(0...7) at allocation time, then
modify sysrq-m to walk mem_map[] printing it all out for pages which have
page_count() > 0.  That'd find the culprit.
