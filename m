Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310657AbSCHCz0>; Thu, 7 Mar 2002 21:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310661AbSCHCzQ>; Thu, 7 Mar 2002 21:55:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:16794 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310660AbSCHCzG>; Thu, 7 Mar 2002 21:55:06 -0500
Message-ID: <3C8827FE.8000509@us.ibm.com>
Date: Thu, 07 Mar 2002 18:54:54 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: truncate_list_pages()  BUG and confusion
In-Reply-To: <3C8809BA.4070003@us.ibm.com> <3C880EFF.A0789715@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>ksymoopsed output follows:
>>
>>kernel BUG at page_alloc.c:109!
>>
> 
> Now how did you manage that?  Looks like someone re-locked
> the page after truncate_list_pages unlocked it.

I stopped getting oopses from the dbench 64 on a small partition, and 
started getting these BUG()s instead.

The oopses I _was_ getting were because create_buffers() was returning a 
buffer chain with one of the bh->b_this_page entries set to 0x01010101. 
  The funny part was that it was always the same number, not a memory 
address, or NULL, it was always 0x01010101!  The next time through the 
loop, "bh->b_end_io = NULL;" was blowing up. (no surprise there :)

I put some code into create_buffers() to look for that magic number, but 
stopped getting the oopses after I added a couple of if( XX == 0x0101010 
) panic("foo").  I now can't recreate the original oopses.  The 
disassembly of create_empty_buffers() looked screwy the first time I 
looked, so I'm guessing that I just encountered a transient gcc bug or 
something.  But, I'm still getting those damn "__block_prepare_write: 
zeroing uptodate buffer!" messages, in addition to the new BUG(), which 
never happened before.  The hardware is extremely stable, and 2.4 
doesn't show any of these problems.

Have you had anyone else try the dbench torture test on other SMP machines?

-- 
Dave Hansen
haveblue@us.ibm.com

