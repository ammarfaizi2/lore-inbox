Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271517AbTGRKLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271824AbTGRKJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:09:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:14031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271821AbTGRKI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:08:59 -0400
Date: Fri, 18 Jul 2003 03:24:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-Id: <20030718032433.4b6b9281.akpm@osdl.org>
In-Reply-To: <m2d6g8cg06.fsf@telia.com>
References: <m2wueh2axz.fsf@telia.com>
	<20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org>
	<m2d6g8cg06.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> If this patch is an acceptable approach to fix the problem,

Seems reasonable.

> the balance_pgdat function should probably be cleaned up.

Well it was rather bolted on the side of the kswapd code.  But from an API
perspective, being able to tell it how many page to free is a bit more
flexible.  Minor point.

However I'm trying to remember why the code exists at all.  Why doesn't
swsusp just allocate lots of pages then free them again?

Something like:

	LIST_HEAD(list);
	int sleep_count = 0;

	while (sleep_count < 10) {
		page = __alloc_pages(0, GFP_ATOMIC);
		if (page) {
			list_add(&page->list, &list);
		} else {
			blk_congestion_wait(WRITE, HZ/20);
			sleep_count++;
		}
	}
	<free all the pages on `list'>

