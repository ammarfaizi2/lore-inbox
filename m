Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265930AbSKBKv4>; Sat, 2 Nov 2002 05:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265931AbSKBKv4>; Sat, 2 Nov 2002 05:51:56 -0500
Received: from ns.suse.de ([213.95.15.193]:17683 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265930AbSKBKvy>;
	Sat, 2 Nov 2002 05:51:54 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
References: <20021102025838.220E.AT541@columbia.edu.suse.lists.linux.kernel> <3DC3A9C0.7979C276@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Nov 2002 11:58:24 +0100
In-Reply-To: Andrew Morton's message of "2 Nov 2002 11:36:51 +0100"
Message-ID: <p73y98cqlv3.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> (That is, using the movnta instructions for well-aligned copies
> and clears so that we don't read the destination memory while overwriting
> it).

I did some experiments with movnta and it was near always a loss for
memcpy/copy_*_user type stuff. The reason is that it flushes the destination
out of cache and when you try to read it afterwards for some reason
(which happens often - e.g. most copy_*_user uses actually do access it
afterwards) then you eat a full cache miss for them and that is costly
and kills all other advantages.

It may be a win for direct copy-to-page cache and then page cache DMA
outside and page cache not mapped anywhere, but even then it's not completely
clear it's that helpful to have it not in cache. For example an Athlon
can serve an DMA directly out of its CPU caches and that may be 
faster than serving it out of RAM (Intel CPUs cannot however) 

-Andi
