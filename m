Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293043AbSB0XNq>; Wed, 27 Feb 2002 18:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293041AbSB0XNQ>; Wed, 27 Feb 2002 18:13:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63486 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292928AbSB0XMm>;
	Wed, 27 Feb 2002 18:12:42 -0500
Date: Wed, 27 Feb 2002 15:14:00 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Message-ID: <26750000.1014851639@w-hlinder.des>
In-Reply-To: <Pine.GSO.4.21.0202271645560.12074-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0202271645560.12074-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, February 27, 2002 16:48:07 -0500 Alexander Viro <viro@math.psu.edu> wrote:
> 
>> > looks a little distressing - the hold times on inode_lock by prune_icache
>> > look bad in terms of latency (contention is still low, but people are still
>> > waiting on it for a very long time). Is this a transient thing, or do people
>> > think this is going to be a problem?
>> 
>> inode_lock hold times are a problem for other reasons.
> 
> ed mm/vmscan.c <<EOF
> /shrink_icache_memory/s/priority/1/
> w
> q
> EOF
> 
> and repeat the tests.  Unreferenced inodes == useless inodes.  Aging is
> already taken care of in dcache and anything that had fallen through
> is fair game.
> 

I applied your patch and reran the tests. Looks like you solved the problem:

  SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

        7.1%  0.7us(  19ms)  7.7us(  17ms)( 2.6%) 779799309 92.9%  7.1% 0.00%  *TOTAL*

 0.16% 0.29%  0.6us(  91us)  2.2us(  46us)(0.00%)   5495642 99.7% 0.29%    0%  inode_lock

 0.90% 0.47%  1.4us(  19ms)  280us(  17ms)(0.10%)  12681192 99.5% 0.47%    0%  kernel_flag

The results are again stored at http://lse.sf.net/locking . 

Hanna



