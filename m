Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVC3Www@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVC3Www (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVC3Www
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:52:52 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:47317 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262447AbVC3WwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:52:25 -0500
Subject: Re: Fw: ext2 corruption - regression between 2.6.9 and 2.6.10
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, bernard@blackham.com.au,
       ext2-devel@lists.sourceforge.net, matt@ucc.asn.au
In-Reply-To: <20050330140733.6f2edfdc.akpm@osdl.org>
References: <20050330140733.6f2edfdc.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 30 Mar 2005 14:52:20 -0800
Message-Id: <1112223141.3628.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think his patch for ext2 is correct. The corruption on ext3 is not the
same issue he saw on ext2. I believe that's the race between discard
reservation and reservation in-use that we already fixed it in 2.6.12-
rc1.

For the problem related to ext2, at the time when we design reservation
for ext3, we decide we only need to discard the reservation at the last
file close, so we have ext3_discard_reservation on iput_final-
>ext3_clear_inode.

The ext2 handle discard preallocation differently at that time, it
discard the preallocation at each iput(), not in input_final(), so we
think it's unnecessary to thrash it so frequently, and the right thing
to do, as we did for ext3 reservation, discard preallocation on last
iput(). So we moved the ext2_discard_preallocation from ext2_put_inode(0
to ext2_clear_inode.

Since ext2 preallocation is doing pre-allocation on disk, so it is
possible that at the unmount time, someone is still hold the reference
of the inode, so the preallocation for a file is not discard yet, so we
still mark those blocks allocated on disk, while they are not actually
in the inode's block map, so fsck will catch/fix that error later.

This is not a issue for ext3, as ext3 reservation(pre-allocation) is
done in memory.

> Begin forwarded message:
> 
> Date: Thu, 31 Mar 2005 01:09:15 +0800
> From: Bernard Blackham <bernard@blackham.com.au>
> To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
> Cc: matt@ucc.asn.au
> Subject: ext2 corruption - regression between 2.6.9 and 2.6.10
> 
> 
> Whilst trying to stress test a Promise SX8 card, we stumbled across
> some nasty filesystem corruption in ext2. Our tests involved
> creating an ext2 partition, mounting, running several concurrent
> fsx's over it, umounting, and fsck'ing, all scripted[1]. The fsck
> would always return with errors.
> 
> This regression was traced back to a change between 2.6.9 and
> 2.6.10, which moves the functionality of ext2_put_inode into
> ext2_clear_inode.  The attached patch reverses this change, and
> eliminated the source of corruption.
> 
> Whilst stress tesing the same Promise SX8 card on an ext3 partition
> (amd64 machine) also with fsx, we encountered a kernel panic who's
> backtrace looked like:
>   ext3_discard_reservation
>   ext3_truncate
>   .
>   .
>   .
>   do_truncate
>   sys_ftruncate
> Could this same change (which was in ext3 also) be responsible for
> this?
> 
> Bernard.
> 
> [1] http://matt.ucc.asn.au/ext2bad/
> 

