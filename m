Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVIOUch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVIOUch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVIOUch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:32:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751200AbVIOUcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:32:36 -0400
Date: Thu, 15 Sep 2005 13:32:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Eric Dumazet <dada1@cosmosbay.com>, Sonny Rao <sonny@burdell.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <20050915201356.GA20966@kvack.org>
Message-ID: <Pine.LNX.4.58.0509151328260.26803@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
 <20050913063359.GA29715@kevlar.burdell.org> <43267A00.1010405@cosmosbay.com>
 <20050915201356.GA20966@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Sep 2005, Benjamin LaHaise wrote:
> 
> Alternatively, the kernel could track available file descriptors using a 
> tree to efficiently insert freed slots into an ordered list of free 
> regions (something similar to the avl tree used in vmas).  Is it worth 
> doing?

For file descriptors, even a few hundred is considered a _lot_ in almost 
all settings. Yes, you can certainly have more, but it's unusual.

And we keep track of the fd reservations with a bitmap _and_ a "lowest
possible" count. So we can check 32 fd's in one go (64 on modern setups),
starting from the last one we allocated.

In other words, no. It's not worth doing anything more than we already do. 

I bet all the expense in this area tends under heavy load to be the
cacheline bouncing of the updates. Keeping the lock close to the bitmap is 
probably advantageous, since the bitmap tends to be looked at only when we 
need to change them (and we hold the lock).

		Linus
