Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319763AbSIMTxI>; Fri, 13 Sep 2002 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319765AbSIMTxH>; Fri, 13 Sep 2002 15:53:07 -0400
Received: from packet.digeo.com ([12.110.80.53]:30437 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319763AbSIMTxG>;
	Fri, 13 Sep 2002 15:53:06 -0400
Message-ID: <3D824330.6BC374E7@digeo.com>
Date: Fri, 13 Sep 2002 12:57:36 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davenport <dragonpt@rcn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can prune_icache safely discard inodes which have only clean pages? 
 (2.4.18)
References: <005a01c25b1b$ac7fb390$3083accf@tabasco>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 19:57:41.0013 (UTC) FILETIME=[D13B2450:01C25B5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davenport wrote:
> 
> I've got a system which has a fairly large amount of physical memory (2GB)
> that experiences
> performance problems after a large number of files have been accessed.
> 
> ...

Your analysis is 100% correct.  It's a problem.

There's a fix for this in Andrea's kernel.
 
> ...
> 
> and I'd like to change it to:
> 
>  void prune_icache(int goal)
>  {
>   ...
>   while (entry != &inode_unused)
>   {
>    ...
>    if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
>     continue;
>    if ((inode->i_state != 0) || inode_has_buffers(inode))
>     continue;
>    if (inode->i_data.nrpages != 0) {
>     if ((!list_empty(&inode->i_data.dirty_pages)) ||
>         (!list_empty(&inode->i_data.locked_pages))) {
>      /* skip if any dirty or locked pages */
>      continue;
>     }
>    }

locked_pages tends to hold clean, unlocked pages, alas.  Testing
->dirty_pages makes sense.

If there are no dirty pages then you can run invalidate_inode_pages();
chances are, that will bring ->nrpages to zero, and all is well.
