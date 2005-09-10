Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVIJOQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVIJOQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 10:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVIJOQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 10:16:22 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21426 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750938AbVIJOQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 10:16:21 -0400
Date: Sat, 10 Sep 2005 15:15:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2/2] Change p[gum]d_clear_* inlines to macros to fix p?d_ERROR
In-Reply-To: <4322CBD9.mailE1P118OD2@suse.de>
Message-ID: <Pine.LNX.4.61.0509101440420.14979@goblin.wat.veritas.com>
References: <4322CBD9.mailE1P118OD2@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Sep 2005 14:15:12.0858 (UTC) FILETIME=[0F1443A0:01C5B612]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Andi Kleen wrote:

> Change p[gum]d_clear_* inlines to macros to fix p?d_ERROR
> 
> When this code was refactored by Hugh it was moved out of the actual
> functions into these inlines. The problem is that pgd_ERROR
> uses __FUNCTION__ and __LINE__ to show where the error happened,
> and with the inline that is pretty meaningless now because
> it's the same for all callers.
> 
> Change them to be macros to avoid this problem

Please don't.  It adds much less than I misremember (only 550 bytes
to my i386 PAE config), but even so it's a waste of space.  If you
really believe information is going missing there, just put a WARN_ON(1)
into p[gum]d_clear_bad in mm/memory.c.

(And remove the __FUNCTION__ and __LINE__ from the p[gum]d_ERRORs in all
the architectures if you're very industrious - I was too lazy for that.)

But I'm afraid that 95% of the cases will just turn out to be from
unmap_page_range below exit_mmap, and even the other 5% will just tell
when the corruption was first observed, giving no hint of what caused
it sometime earlier on.

(Of course, I was emboldened to make those changes because the messages
had never been seen in living memory, beyond our own private development
screwups.  They started appearing just around the time I changed them.)

Hugh
