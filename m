Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbRGZGRy>; Thu, 26 Jul 2001 02:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbRGZGRp>; Thu, 26 Jul 2001 02:17:45 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:64014 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S267632AbRGZGR3>;
	Thu, 26 Jul 2001 02:17:29 -0400
Date: Thu, 26 Jul 2001 16:12:19 -0400
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: kmap() while holding spinlock
Message-ID: <20010726161219.D4963@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

I was debugging a lockup on sparc32 where we took a page_table_lock
in handle_mm_fault and then tried to take the same one again in
swap_out_mm. So it looks like we are scheduling somewhere inside
handle_mm_fault while holding the page_table_lock.

This machine might have highmem (Im awaiting more information). If
so copy_user_highpage and clear_user_highpage could sleep if we
run out of kmap entries. There are two problems:

do_anonymous_page calls clear_user_highpage with the page_table_lock held.

do_wp_page calls break_cow with the page_table_lock held.

Since I dont think we can drop the lock, do we need a kmap_atomic for
these?

Anton
