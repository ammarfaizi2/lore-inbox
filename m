Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270271AbRH1Gvg>; Tue, 28 Aug 2001 02:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270273AbRH1Gv0>; Tue, 28 Aug 2001 02:51:26 -0400
Received: from ns.suse.de ([213.95.15.193]:21007 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270271AbRH1GvR>;
	Tue, 28 Aug 2001 02:51:17 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com.suse.lists.linux.kernel> <3B8AA7B9.8EB836FF@namesys.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2001 08:51:32 +0200
In-Reply-To: Hans Reiser's message of "27 Aug 2001 22:07:02 +0200"
Message-ID: <oupsneck77v.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> That said, it does not surprise me that our locking is coarser than other
> filesystems, and we will be fixing that in version 4.  Unfortunately we don't
> have the hardware to replicate your results.

It does not really look like a locking problem. If you look at the profiling
logs it is pretty clear that the problem is the algorithm used in 
bitmap.c:find_forward. find_forward and reiserfs_in_journal 
(called by find_forward)
are by most the biggest CPU users in file system space, and 
reiserfs_in_journal is called over 30 million times, far more often than
any other function. On looking at it it is pretty clear why it is slow;
the algorithm is just stupid. It also runs under the BKL, which explains 
the long locking times. Fix that function and it'll look much better.
i.e. one way would be to keep a shadow map of all bitmaps that has all
journaled blocks set also, to quickly skip them for the common case.

-Andi

 
