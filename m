Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270779AbRH1Lrr>; Tue, 28 Aug 2001 07:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270784AbRH1Lrh>; Tue, 28 Aug 2001 07:47:37 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:36791 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S270779AbRH1Lrd>; Tue, 28 Aug 2001 07:47:33 -0400
Date: Tue, 28 Aug 2001 12:27:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: find_get_swapcache_page() question
In-Reply-To: <Pine.LNX.4.21.0108272123380.7385-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0108281154030.1015-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Marcelo Tosatti wrote:
> 
> Looking at find_get_swapcache_page(), I can't see _how_ we can find a
> page on the swapper pagecache table that is not a swapcache page.

I had a look at this a couple of weeks back.  If I remember rightly,
the page found by __find_page_nolock() cannot be other than a swapcache
page, and will always have PageSwapCache bit set... until pagecache_lock
is dropped on return to its only caller lookup_swap_cache().  In which the 
		if (!PageSwapCache(found))
			BUG();
		if (found->mapping != &swapper_space)
			BUG();
are not safe, since there may a concurrent remove_from_swap_cache(),
either from try_to_unuse() or from Rik's new vm_swap_full() deletion.
Those tests would be safe if the page were locked, but it's not.

I say find_get_swapcache_page() serves no purpose, should be deleted,
and find_get_page() used instead.  That was one of various things in
the swapoff patch I posted to linux-mm on 16 Aug, which I need to
finish off, cut into pieces and submit to Linus.

Hugh

