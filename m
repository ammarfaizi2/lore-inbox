Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbRGNMB3>; Sat, 14 Jul 2001 08:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbRGNMBT>; Sat, 14 Jul 2001 08:01:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58891 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267632AbRGNMBK>; Sat, 14 Jul 2001 08:01:10 -0400
Subject: Re: [CHECKER] 52 probable security holes in 2.4.6 and 2.4.6-ac2
To: kash@stanford.edu (Kenneth Michael Ashcraft)
Date: Sat, 14 Jul 2001 13:01:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
In-Reply-To: <Pine.GSO.4.31.0107131616290.8768-100000@myth9.Stanford.EDU> from "Kenneth Michael Ashcraft" at Jul 13, 2001 04:20:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LO7S-00017P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG] Need a lower-bound check-- lo_encrypt_key_size is an int
> /home/kash/linux/2.4.6/drivers/block/loop.c:782:loop_set_status: ERROR:RANGE:757:782: Using user length "lo_encrypt_key_size" as argument to "memcpy" [type=LOCAL] [state = need_lb] set by 'copy_from_user':759 [linkages -> 759:info->lo_encrypt_key_size -> 757:info:start] [distance=110]
> 	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid &&

This one looks like a tool error

        if ((unsigned int) info.lo_encrypt_key_size > LO_KEY_SIZE)

so the check is cast

In looking at the located ones I also found it missed a pile of related problems
it can check

There were a pile of

 	item *p=kmalloc(sizeof(item)*num_items);
	if(p==NULL)
		error

	for(i=0;i<num_items;i++)
	{
		..
	}

Where people rely on the kmalloc failing but forget that

	large value * sizeof(item) -> small value after overflow
	and the loop stomps all over kernel memory..


