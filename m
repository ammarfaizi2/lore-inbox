Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVIMHEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVIMHEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 03:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVIMHEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 03:04:47 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:43841 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932413AbVIMHEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 03:04:46 -0400
Message-ID: <43267A00.1010405@cosmosbay.com>
Date: Tue, 13 Sep 2005 09:04:32 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <20050913063359.GA29715@kevlar.burdell.org>
In-Reply-To: <20050913063359.GA29715@kevlar.burdell.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao a écrit :
> On Mon, Sep 12, 2005 at 08:34:17PM -0700, Linus Torvalds wrote:
> <snip> 
> 
>>On the filesystem level, FUSE got merged, and ntfs and xfs got updated. In 
>>the core VFS layer, the "struct files" thing is now handled with RCU and 
>>has less expensive locking.
> 
> 
> I hope this means that people will be more accepting of multi-threaded
> benchmarks (who needs real apps... ;-)) which do open() and close().
> 
> 
> Yes, no?

If you look at RCU change, you discover they impact read()/write()/... (no 
more locking), but not open()/dup()/socket() and close() that still take a 
spinlock to modify the state.

And if your process has many files opened, the cost (read : latency) of open() 
can be very high, finding a zero bit in a large bit array.

So these RCU changes can help some benchmarks (or real apps... ;-) ), but not 
some others :)

I wish a process param could allow open() to take any free fd available, not 
the lowest one. One can always use fcntl(fd, F_DUPFD, slot) to move a fd on a 
specific high slot and always keep the 64 first fd slots free to speedup the 
kernel part at open()/dup()/socket() time.


