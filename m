Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269648AbUICMil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269648AbUICMil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUICMik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:38:40 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11649
	"EHLO x30.random") by vger.kernel.org with ESMTP id S269668AbUICMhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:37:19 -0400
Date: Fri, 3 Sep 2004 14:35:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>
Subject: Re: EXT3: problem with copy_from_user inside a transaction
Message-ID: <20040903123541.GB8557@x30.random>
References: <20040903150521.B1834@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903150521.B1834@castle.nmd.msu.ru>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 03:05:21PM +0400, Andrey Savochkin wrote:
> Hi Andrew,
> 
> filemap_copy_from_user() between prepare_write() and commit_write()
> appears to be a problem for ext3.
> 
> prepare_write() starts a transaction, and if filemap_copy_from_user() causes
> a page fault, we'll have
>  - order violation with mmap_sem taken inside a transaction (possible
>    deadlocks),
>  - __GFP_FS memory allocation with all re-entrancy problems (e.g.,
>    current->journal_info corruption).
> 
> Am I missing something?
> 
> If this observation is correct, the possible solution is to call
> get_user_pages() or somehow pin the user pages before prepare_write(),
> although it will hurt performance...

yes, Chris is working on it for a few months.

just for the mmap_sem the easiest fix I proposed him, was to take the
mmap_sem in read mode before starting the transaction in prepare_write,
then the mmap_sem has to become recursive but that's trivial (my 2.4
rw semaphores are much simpler, they don't crash with million of
waiters, and they can support recursion).

however it seems the mmap_sem is not the only issue, he found another
issue with the page lock, maybe Chris you want to elaborate (the above
deadlock is absolutely clear, the one with the page lock less, btw, I
don't care much with reading the same page from disk that we're writing
to in the write syscall, that's a case we may just want to forbidden
since it makes no sense and currently it's racey even in 2.4, no pin
happens, but the prefaulting hides it).

We also hidden the above deadlock with prefaulting (but it's far from
fixed), prefaulting is a good idea anyways.
