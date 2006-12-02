Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162388AbWLBAh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162388AbWLBAh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 19:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162415AbWLBAh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 19:37:28 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:51290 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1162028AbWLBAh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 19:37:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zXK7ntbQ0DTk+64kbydZkFLzcqDPhP6VpcyZ8osiFe1GNv0AUXhEsAKSz/28p/ash2YkRTWf4N2kjw+FG9yo60nCJwS+CmZTcXaT/j7doG7J6H3XXr19dHA0xB7kCLgkZIGmVqUITHtfd26uS7JO8m80BpiZUpvGPUa40Rkgie8=  ;
X-YMail-OSG: agxOhYcVM1lqdoFnNmaG759fUZGDB1xogN4AqnOx0gPbeoa2DVj8Kh8htZpdlJSbdVRmCxXluPPjI0F6do1jAN_xwIyL8K5RlekRTAcnri6IrEgPA8.v96qxaW.hFXtEAPjpRX2Phh.ZBH4-
Message-ID: <4570CA90.8050203@yahoo.com.au>
Date: Sat, 02 Dec 2006 11:36:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
References: <20061130072058.GA18004@wotan.suse.de>	<20061130072202.GB18004@wotan.suse.de>	<20061130072247.GC18004@wotan.suse.de>	<20061130113241.GC12579@wotan.suse.de>	<87r6vkzinv.fsf@duaron.myhome.or.jp>	<20061201020910.GC455@wotan.suse.de>	<87mz68xoyi.fsf@duaron.myhome.or.jp>	<20061201050852.GA31347@wotan.suse.de>	<20061130232102.0cc7fc0b.akpm@osdl.org>	<20061201075341.GB31347@wotan.suse.de> <87slfzu0ty.fsf@duaron.myhome.or.jp>
In-Reply-To: <87slfzu0ty.fsf@duaron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> Nick Piggin <npiggin@suse.de> writes:
> 
> 
>>>> 		status = __block_prepare_write(inode, new_page, zerofrom,
>>>> 						PAGE_CACHE_SIZE, get_block);
>>>> 		if (status)
>>>>@@ -2110,7 +2111,7 @@
>>>> 		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
>>>> 		flush_dcache_page(new_page);
>>>> 		kunmap_atomic(kaddr, KM_USER0);
>>>>-		generic_commit_write(NULL, new_page, zerofrom, PAGE_CACHE_SIZE);
>>>>+		__block_commit_write(inode, new_page, zerofrom, PAGE_CACHE_SIZE);
>>>
>>>Whatever function this is doesn't need to update i_size?
>>
>>Yes, it is the code in cont_prepare_write that is expanding a hole
>>at the end of file.
>>
>>We can do this now because fat_commit_write is now changed to call
>>generic_commit_write in the case of a non-zero length.
>>
>>I think it is an improvement because now the file will not get
>>arbitrarily extended in the case of a write failure somewhere down
>>the track.
> 
> 
> Ah, unfortunately we can't this. If we don't update ->i_size before
> page_cache_release, pdflush will think these pages is outside ->i_size
> and just clean the page without writing it.

I see. I guess you need to synchronise your writepage versus this
extention in order to handle it properly then. I won't bother with
that though: it won't be worse than it was before.

Thanks for review, do you agree with the other hunks?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
