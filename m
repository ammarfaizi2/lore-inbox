Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264003AbSITX0i>; Fri, 20 Sep 2002 19:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264004AbSITX0i>; Fri, 20 Sep 2002 19:26:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:22217 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264003AbSITX0g>;
	Fri, 20 Sep 2002 19:26:36 -0400
Message-ID: <3D8BAFD3.6E4F495D@digeo.com>
Date: Fri, 20 Sep 2002 16:31:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [RFC][PATCH] 2.5.37 patch for making DIO async
References: <200209202219.g8KMJ2x26455@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 23:31:36.0118 (UTC) FILETIME=[DC70FD60:01C260FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> Hi,
> 
> Here is 2.5.37 patch for making DIO code async. Waiting for IO completion
> will be done at the higher level. This patch adds support for RAW Async IO.
> We already posted performance comparisions numbers earlier on 2.5.35.
> 
> ISSUE: This patch does set_page_dirty() on a page, from the interrupt
> handler (io completion handler). Which is NOT safe.  Any suggestions
> on (where and how to) moving this outside the interrupt handler ?
> Ben & Andrew, any ideas ?
> 

No particularly good ones, I'm afraid.  Options appear to be:

1: Lose data if the pages are swapcache or pagecache.

2: Make mapping->page_lock and mapping->private_lock irq-safe,
   and mandate that a_ops->set_page_dirty be callable from 
   interrupt context.

3: Hang onto the BIOs and find a process somewhere to mark the
   pages dirty and then release them after IO has completed.

None of these are particularly palatable.  But if this is a
showstopper for async IO against raw devices, and a showstopper
for async IO against O_DIRECT blockdevs and a showstopper for
async IO against O_DIRECT files (is it?) then I guess we clench
the teeth and go for option 2.

Holding onto gazillions of BIOs and punting it all up to keventd
some time in the future would be lame.  Making those locks and these
codepaths irq-safe is consistent with the general tougher, tighter
and more async direction in which the 2.5 IO paths are headed, so...

With the radix-tree gang lookup and truncate rework I expect that
the maximum hold time of those locks is miniscule, so interrupt
latency isn't a concern here.  (It would be 50 milliseconds or
more at present...)

ho-hum.  I'll do the patch.
