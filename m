Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268261AbUHFTnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268261AbUHFTnk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268259AbUHFTm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:42:27 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:36360 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S268258AbUHFTkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:40:40 -0400
Message-ID: <4113DE5F.6040801@lougher.demon.co.uk>
Date: Fri, 06 Aug 2004 20:39:11 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-GB; rv:1.2.1) Gecko/20030228
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <Pine.LNX.4.44.0408052104420.2241-100000@dyn319181.beaverton.ibm.com> <411322E8.4000503@yahoo.com.au> <4113BA65.8050901@lougher.demon.co.uk> <4113D76E.9060906@yahoo.com.au>
In-Reply-To: <4113D76E.9060906@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Phillip Lougher wrote:
> 
>> It doesn't work.  It correctly handles the case where *ppos is equal
>> to i_size on entry to the function (and this does work for files 0, 4k
>> and n * 4k in length), but it doesn't handle readahead inside the for
>> loop.  The check needs to be in the for loop.
>>
>>
> 
> I don't quite follow. What is i_size, *ppos, and desc->count
> required for your problem to trigger?
> 

 From some output I prepared earlier :-)

Aug  6 16:15:29 pierrot kernel: Entered do_generic_mapping_read: *ppos 0x0, isize 0x3000
Aug  6 16:15:29 pierrot kernel: iteration 0x1
Aug  6 16:15:29 pierrot kernel: Entered squashfs_readpage, page index 0x0, inode->i_size 0x3000
Aug  6 16:15:29 pierrot kernel: at (ret == nr && desc->count) check: ret==nr ? yes, desc->count 0x3000
Aug  6 16:15:29 pierrot kernel: iteration 0x2
Aug  6 16:15:29 pierrot kernel: at (ret == nr && desc->count) check: ret==nr ? yes, desc->count 0x2000
Aug  6 16:15:29 pierrot kernel: iteration 0x3
Aug  6 16:15:29 pierrot kernel: at (ret == nr && desc->count) check: ret==nr ? yes, desc->count 0x1000
Aug  6 16:15:29 pierrot kernel: iteration 0x4
Aug  6 16:15:29 pierrot kernel: at "readpage: label", i_size 0x3000, *ppos 0x0, index 0x3
Aug  6 16:15:29 pierrot kernel: Entered squashfs_readpage, page index 0x3, inode->i_size 0x3000

iteration 0x1 etc are the separate passes through the loop.
The first squashfs_readpage is called via page_cache_readahead, which
reads pages 0, 1 and 2 (which is why no readpage is called in
iterations 2 and 3).  The second squashfs_readpage is called in the
fourth loop iteration by the 'goto no_cached_page' code path when no
page has been found by find_get_page, this is presumably because the
index is now out of bounds.

As I said in my previous email, I'm going to put an index
check into my code.  I don't want this argument to proceed
and myself to start (?) to look like an ass.

Phillip

