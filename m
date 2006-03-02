Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWCBXG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWCBXG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWCBXG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:06:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751082AbWCBXG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:06:56 -0500
Date: Thu, 2 Mar 2006 15:08:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, Reiserfs-List@namesys.com,
       green@linuxhacker.ru
Subject: Re: [Fwd: Re: [PATCH] reiserfs: use
 balance_dirty_pages_ratelimited_nr in reiserfs_file_write]
Message-Id: <20060302150859.51ffb93f.akpm@osdl.org>
In-Reply-To: <4407386D.4070008@namesys.com>
References: <4407386D.4070008@namesys.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> I suspect that when someone did the search and replace when creating
> balance_dirty_pages_ratelimited_nr they failed to read the code and
> realize this code path was already effectively ratelimited.  The result
> is they made it excessively infrequent (every 1MB if ratelimit is 8) in
> its calling balance_dirty_pages.

??  There's been no change to balance_dirty_pages_ratelimited().  I merely
widened the interface a bit: introduced the new
balance_dirty_pages_ratelimited_nr() and did

static inline void
balance_dirty_pages_ratelimited(struct address_space *mapping)
{
	balance_dirty_pages_ratelimited_nr(mapping, 1);
}

That being said, if reiserfs has `number of pages' in hand then yes, it
makes sense to migrate over to balance_dirty_pages_ratelimited_nr().

> If anyone has ever seen this as an actual problem on a real system, I
> would be curious to hear of it.

No, I wouldn't expect it to make much difference.

All that gunk is there just to avoid calling the expensive
get_writeback_state() once per set_page_dirty().

Inaccuracy here will introduce the possibility that we'll transiently dirty
more memory than dirty_ratio permits, but it'll only be a little bit (eight
times the amount of memory which is dirtied per balance_dirty_pages_ratelimited()
call).

That's a small amount of memory.  But if you have 1000 filesystems mounted
and they all do the same thing at the same time, things could get a bit
sticky.  Your patch will (greatly) reduce the possibility of even that
scenario.

