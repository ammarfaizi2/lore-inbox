Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280920AbRKLSim>; Mon, 12 Nov 2001 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280917AbRKLSie>; Mon, 12 Nov 2001 13:38:34 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:13540 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S280916AbRKLSiT>; Mon, 12 Nov 2001 13:38:19 -0500
Message-ID: <3BF01660.3040509@antefacto.com>
Date: Mon, 12 Nov 2001 18:35:12 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
CC: W Christopher Martin <wcm@catnap.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ramfs leak
In-Reply-To: <no.id>	<20011109204043.17315.qmail@gizmo.catnap.com> <3d3kbt82.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tachino Nobuhiro wrote:

> Hello,
> 
> At Fri, 9 Nov 2001 15:40:43 -0500 (EST),
> W Christopher Martin wrote:
> 
>>Padraig Brady writes:
>>
>>>When I remove files from a ramfs the space is not reclaimed?
>>>What am I doing wrong? Details below.
>>>
>>Nothing.  We've noticed the same thing.  It's a bug and was
>>first reported back in July, but no one has provided a fix yet.
>>I've had a brief look at the source code, but nothing obvious
>>pops out at me.
>>
> 
> I think you should use tmpfs instead of ramfs, but if you really want to use ramfs,
> the patch below may fix the problem.
> 
> diff -Nur linux-2.4.13-ac7.org/fs/ramfs/inode.c linux-2.4.13-ac7/fs/ramfs/inode.c
> --- linux-2.4.13-ac7.org/fs/ramfs/inode.c	Mon Nov 12 11:00:47 2001
> +++ linux-2.4.13-ac7/fs/ramfs/inode.c	Mon Nov 12 11:26:40 2001
> @@ -182,12 +182,9 @@
>  {
>  	struct ramfs_sb_info *rsb = RAMFS_SB(inode->i_sb);
>  
> -	if (! Page_Uptodate(page))
> -		return;
> -
>  	lock_rsb(rsb);
> -
> -	ClearPageDirty(page);
> +	if (Page_Uptodate(page))
> +		ClearPageDirty(page);
>  	
>  	rsb->free_pages++;
>  	inode->i_blocks -= IBLOCKS_PER_PAGE;
> 


Cool, this fixes it,
and I was just getting to the bottom of it myself :-)
None of this accounting stuff is in 2.4.15-pre3, so Alan
can you apply this?

cheers,
Padraig.

