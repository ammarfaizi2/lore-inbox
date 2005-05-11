Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVEKWuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVEKWuB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEKWuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:50:00 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59743
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261291AbVEKWty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:49:54 -0400
Date: Thu, 12 May 2005 00:49:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Jordan <bjordan.ics@gmail.com>
Cc: Hugh Dickins <hugh@veritas.com>, Timur Tabi <timur.tabi@ammasso.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050511224947.GL6313@g5.random>
References: <20050411171347.7e05859f.akpm@osdl.org> <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com> <427BF8E1.2080006@ammasso.com> <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com> <427CD49E.6080300@ammasso.com> <Pine.LNX.4.61.0505071617470.5718@goblin.wat.veritas.com> <78d18e2050511131246075b37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d18e2050511131246075b37@mail.gmail.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 04:12:41PM -0400, William Jordan wrote:
> If I am reading you correctly, you are saying that mlock currently
> prevents pages from migrating around to unfragment memory, but
> get_user_pages does not prevent this? If this is the case, this could

This is not the case. Infact get_user_pages is a stronger pin than
mlock. But if you call it by hand and you plan to write to the page, you
have to use the "write=1" flag, this is fundamental if you want to write
to the physical page from userland while it's being tracked by IB dma.

In short you should not use mlock and you should use only
get_user_pages(write=1).

If the problem appears again even after the last fix for the COW I did
last year, than it means we've another yet another bug to fix.

Using mlock for this is unnecessary. mlock is a "virtual" pin and it
provides weaker guarantees than what you need. You need _physical_ pin
and get_user_pages(write=1) is the only one that will give it to you.

write=0 is ok too if you're never ever going to write to the page with
the cpu from userland.

In the old days there was the concept that get_user_pages wasn't a
"pte-pin", but that was infact broken in the way COW was working with threads,
but this is fixed now that is really a "pte-pin" again (like in 2.2
which never had the corruption cow bug!) even though the pte may
temporarily be set to swapcache or null. In current 2.6 you're
guaranteed that despite the pte may be temporarly be set to not-present,
the next minor fault will bring into memory the very same physical page
that was there before. At least unless you map the thing writeprotect
(i.e. write=0) and you write to it from userland.. ;).
