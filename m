Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269400AbTCDMMO>; Tue, 4 Mar 2003 07:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269401AbTCDMMO>; Tue, 4 Mar 2003 07:12:14 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:28070 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S269400AbTCDMMN>; Tue, 4 Mar 2003 07:12:13 -0500
Date: Tue, 4 Mar 2003 12:24:23 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dawson Engler <engler@csl.stanford.edu>
cc: linux-kernel@vger.kernel.org, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] potential races in kernel/*.c mm/*.c net/*ipv4*.c
In-Reply-To: <200303041112.h24BCRW22235@csl.stanford.edu>
Message-ID: <Pine.LNX.4.44.0303041151090.10154-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Dawson Engler wrote:
> 
> BUG? pair: lock=<struct shmem_inode_info.lock>, var=<struct shmem_inode_info.next_index>
>   z score=0.20
>   first = 2
>   1 error out of 6 uses:
>      /u2/engler/mc/oses/linux/linux-2.5.62/mm/shmem.c:385:shmem_truncate: ERROR: var <struct shmem_inode_info.next_index> not protected by <struct shmem_inode_info.lock>(pop=6, s=5) [locked=0] [seen_lock=1]
> 
>    seems like a potential race, since info_next_index seems like it could
>    get decreased in the meantime violating the if-stmt:
> 
>         if (idx >= info->next_index)
>                 return;
> 
>         spin_lock(&info->lock);
>         limit = info->next_index;

Thanks for the report, but this one is okay as is.

info->next_index is only ever _decreased_ here in this shmem_truncate
function, which is always entered under the protection of inode->i_sem
(which is guarding corresponding changes to inode->i_size).  As you've
noticed, it's okay if next_index increases before spin lock is taken.

Hugh

