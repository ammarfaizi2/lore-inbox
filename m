Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUHWXjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUHWXjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUHWXhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:37:50 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:7344 "EHLO
	server.home") by vger.kernel.org with ESMTP id S268520AbUHWXfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:35:53 -0400
Date: Mon, 23 Aug 2004 16:35:12 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.home
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>, "David S. Miller" <davem@redhat.com>,
       raybry@sgi.com, ak@muc.de, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for
 8,32     and    512 cpu SMP
In-Reply-To: <Pine.GSO.4.58.0408231916330.21483@sapphire.engin.umich.edu>
Message-ID: <Pine.LNX.4.58.0408231630490.20013@server.home>
References: <2uexw-1Nn-1@gated-at.bofh.it> <2uCTq-2wa-55@gated-at.bofh.it>
 <pan.2004.08.18.23.50.13.562750@umich.edu> <20040819000151.GU11200@holomorphy.com>
 <Pine.GSO.4.58.0408182005080.9340@sapphire.engin.umich.edu>
 <20040819002038.GW11200@holomorphy.com> <Pine.LNX.4.58.0408231456150.17943@server.home>
 <Pine.GSO.4.58.0408231916330.21483@sapphire.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Rajesh Venkatasubramanian wrote:

> So there are no other active thread (mm_user) other than the current
> exit_mmap() thread. This gives thread exclusion. So we don't need
> mm->mmap_sem.
>
> However, we have to lock out truncate()->zap_pmd_range(), rmap.c
> functions, and other places from walking the page tables while we
> are freeing the page tables in exit_mmap(). The page_table_lock in
> exit_mmap() provides that exclusion.
>
> That's my understanding. Correct me if I am wrong.

Correct. I just looked through the function and it unlinks the pgd before
unlocking page_table_lock. It frees the pgd tree content later.

Since no mm_user is active anymore no pte ops occur and therefore also
atomic pte operations do not need protection.


