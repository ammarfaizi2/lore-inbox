Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSL0LFw>; Fri, 27 Dec 2002 06:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSL0LFw>; Fri, 27 Dec 2002 06:05:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:40641 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264877AbSL0LFv>;
	Fri, 27 Dec 2002 06:05:51 -0500
Message-ID: <3E0C35DF.2801AA43@digeo.com>
Date: Fri, 27 Dec 2002 03:13:35 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: missed inode->i_hash cleanup in prune_icache()
References: <15884.10772.44042.51586@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Dec 2002 11:13:35.0564 (UTC) FILETIME=[FFA828C0:01C2AD98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> 
> Hello,
> 
> fs/inode.c:prune_icache() does list_del(&inode->i_hash), and then calls
> destroy_inode(). Inode is returned to the slab with ->i_hash still
> containing dangling pointers. Probably this wasn't observed so far,
> because prune_icache() is called during memory pressure and slab page
> where inode is returned back into, is almost immediately released.
> 
> 2.4 explicitly calls INIT_LIST_HEAD(&inode->i_hash) in prune_icache().
> 
> Following patch re-initializes ->i_hash.
> 
> Nikita.
> ===== fs/inode.c 1.84 vs edited =====
> --- 1.84/fs/inode.c     Mon Dec 16 09:38:48 2002
> +++ edited/fs/inode.c   Wed Dec 25 16:19:10 2002
> @@ -248,7 +248,7 @@
>                 struct inode *inode;
> 
>                 inode = list_entry(head->next, struct inode, i_list);
> -               list_del(&inode->i_list);
> +               list_del_init(&inode->i_list);
> 
>                 if (inode->i_data.nrpages)
>                         truncate_inode_pages(&inode->i_data, 0);
> 

That's i_list, not i_hash.

Yes, it's a bit sloppy to leave the i_list pointers dangling but
fs/inode.c:new_inode() will just overwrite i_list and all is well.

Could you please double-check or clarify the need for this change?
