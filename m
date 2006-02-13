Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWBMH7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWBMH7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWBMH7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:59:43 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36507
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751211AbWBMH7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:59:43 -0500
Date: Sun, 12 Feb 2006 23:59:06 -0800 (PST)
Message-Id: <20060212.235906.73211762.davem@davemloft.net>
To: akpm@osdl.org
Cc: hugh@veritas.com, wli@holomorphy.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] compound page: use page[1].lru
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060212231223.773d76ea.akpm@osdl.org>
References: <20060212181312.11392d12.akpm@osdl.org>
	<20060212.230516.86740481.davem@davemloft.net>
	<20060212231223.773d76ea.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 12 Feb 2006 23:12:23 -0800

> "David S. Miller" <davem@davemloft.net> wrote:
> >
> > The ->mapping check is there essentially to hit user mapped pages that
> > would be modified by the kernel using kernel space memory accesses
> > other than those done by copy_user_page() and clear_user_page() (and
> > their brothers copy_user_highpage() and clear_user_highpage() which
> > just call the former directly on a non-HIGHPAGE platform like
> > sparc64).
> 
> The direct-io.c code just does memset.  (That's very common - maybe
> clear_user_highpage_partial() is needed?)

Yes, something like clear_user_higpage_partial() is definitely needed
for cases like direct-io.c.

We have similar handling for when ptrace() uses get_user_pages() and
tries to write to those pages, via copy_to_user_page() and
copy_from_user_page().  But those interfaces don't clear memory and
they only work in the ptrace path, and they are optimized for that
usage.
