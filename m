Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268020AbUHEW22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268020AbUHEW22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268006AbUHEW2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:28:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:40123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268031AbUHEW2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:28:05 -0400
Date: Thu, 5 Aug 2004 15:31:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
Message-Id: <20040805153116.3e820106.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0408051302330.8229-100000@dhcp83-102.boston.redhat.com>
References: <Pine.LNX.4.44.0408051302330.8229-100000@dhcp83-102.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> The patch below implements RSS ulimit enforcement for 2.6.8-rc3-mm1.
> It works in a very simple way: if a process has more resident memory
> than its RSS limit allows, we pretend it didn't access any of its
> pages, making it easy for the pageout code to evict the pages.
> 
> In addition to this, we don't allow a process that exceeds its RSS
> limit to have the swapout protection token.

Thanks.

I'd kinda expected that the patch would try to limit a process to its
RLIMIT_RSS all the time.  So if a process is set to 16MB and tries to use
32MB it gets to do a lot of swapping.  But you're not doing that.  Instead,
the patch is preferentially penalising processes which are over their limit
when we enter page reclaim.  What are the pros and cons, and what is the
thinking behind this?

Also, I wonder if it would be useful if refill_inactive_zone() were to
unconditionally move pages from over-rss-limit mm's onto the inactive list,
ignoring swappiness.  Or if we should explicitly deactivate pages which are
newly added to the LRU on behalf of an over-rss-limit process.


