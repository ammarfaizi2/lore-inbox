Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWHCUKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWHCUKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWHCUKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:10:55 -0400
Received: from relay1.beelinegprs.ru ([217.118.71.5]:32339 "EHLO
	relay1.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S932358AbWHCUKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:10:54 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: reiserfs-dev@namesys.com
Subject: Re: partial reiser4 review comments
Date: Fri, 4 Aug 2006 00:11:16 +0400
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060803001741.4ee9ff72.akpm@osdl.org>
In-Reply-To: <20060803001741.4ee9ff72.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608040011.16363.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (480/060802)
X-SpamTest-Info: Profile: Detect Standard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm only partway through this, but let me unload my observations thus
> far. I still need to find a chunk of time for a file-by-file
> walkthrough and it's unobvious where that chunk will come from at
> present :(
>
>
> reiser4 as found in 2.6.18-rc2-mm1.
>
> - set_page_dirty_internal() pokes around in VFS internals.  Use
>   __set_page_dirty_no_buffers() or create a new library function in
>   mm/page-writeback.c.
>
>   In particular, it gets the radix-tree dirty tagging out of sync.
>
> - running igrab() in the writepage() path is really going to hammer
>   inode_lock.  Something else will need to be done here.
>
> - The preferred way of solving the above would be to mark the page as
>   PageWriteback() with set_page_writeback() prior to unlocking it. 
> That'll pin the page and the inode.  It does require that the page
> actually get written later on.  If we cannot do that then more
> thought is needed.
>
> - wbq.sem should be using a completion for the "wait until entd
> finishes", not a semaphore.  Because there's a teeny theoretical race
> when using semaphores this way which completions were designed to
> avoid.  (The waker can still be playing with the semaphore when it
> has gone out of scope on the wakee's stack).
>
> - write_page_by_ent(): the "spin until entd thread" thing is gross.

that spinlock is especially against the "teeny theoretical race...".  
good if completion will allow us to remove it.

>
>   This function is really lock-intensive.


Thanks,
Alex.

