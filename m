Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWGMHOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWGMHOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWGMHOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:14:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751207AbWGMHOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:14:36 -0400
Date: Thu, 13 Jul 2006 00:14:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix oom roll-back of __vmalloc_area_node
Message-Id: <20060713001433.801fa304.akpm@osdl.org>
In-Reply-To: <44B3FDE4.4040209@web.de>
References: <44B3FDE4.4040209@web.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 21:37:08 +0200
Jan Kiszka <jan.kiszka@web.de> wrote:

> __vunmap must not rely on area->nr_pages when picking the
> release methode for area->pages. It may be too small when
> __vmalloc_area_node failed early due to lacking memory.
> Instead, use a flag in vmstruct to differentiate.

So you mean that when this:

		if (unlikely(!area->pages[i])) {
			/* Successfully allocated i pages, free them in __vunmap() */
			area->nr_pages = i;
			goto fail;

happens, it could be that i <= PAGE_SIZE/sizeof(struct page *) and __vunmap
kfree()s something which it should have vfree()d, yes?

That sounds like a dead box, or worse.

I think the change would be a good one even if it didn't fix a bug, thanks.

