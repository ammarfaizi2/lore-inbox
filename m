Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292579AbSB0Trr>; Wed, 27 Feb 2002 14:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292832AbSB0TrM>; Wed, 27 Feb 2002 14:47:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22795 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292914AbSB0Tql>;
	Wed, 27 Feb 2002 14:46:41 -0500
Message-ID: <3C7D374B.4621F9BA@zip.com.au>
Date: Wed, 27 Feb 2002 11:45:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, viro@math.psu.edu
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
In-Reply-To: <10460000.1014833979@w-hlinder.des>,
		<10460000.1014833979@w-hlinder.des> <67850000.1014834875@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> ...
> looks a little distressing - the hold times on inode_lock by prune_icache
> look bad in terms of latency (contention is still low, but people are still
> waiting on it for a very long time). Is this a transient thing, or do people
> think this is going to be a problem?

inode_lock hold times are a problem for other reasons.  Leaving this
unfixed makes the preepmtible kernel rather pointless....  An ideal
fix would be to release inodes based on VM pressure against their backing
page.  But I don't think anyone's started looking at inode_lock yet.

The big one is lru_list_lock, of course.  I'll be releasing code in
the next couple of days which should take that off the map.  Testing
would be appreciated.

I have a concern about the lockmeter results.  Lockmeter appears
to be measuring lock frequency and hold times and contention.  But
is it measuring the cost of the cacheline transfers?   For example,
I expect that with delayed allocation and radix-tree pagecache, one
of the major remaining bottlenecks will be ownership of the superblock
semaphore's cacheline.   Is this measurable?  (Actually, we may
then be at the point where copy_from_user costs dominate).

-
