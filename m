Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265790AbUFDRKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265790AbUFDRKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFDRKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:10:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:51843 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265790AbUFDRIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:08:30 -0400
Message-ID: <40C0AC9D.1020805@tmr.com>
Date: Fri, 04 Jun 2004 13:08:45 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: "'Con Kolivas'" <kernel@kolivas.org>,
       "'FabF'" <fabian.frederick@skynet.be>,
       "'Bernd Eckenfels'" <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <40BF3250.9040901@tmr.com> <S265663AbUFDHTq/20040604071946Z+537@vger.kernel.org>
In-Reply-To: <S265663AbUFDHTq/20040604071946Z+537@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:
>>But swap behaviour kills performance even when memory is more than 
>>adequate. Consider building a DVD image in a 4GB system. The i/o forces 
>>all of the unused programs out, in spite of the fact that an extra 100MB 
>>doesn't make a measurable difference in performance. But when I click 
>>Mozilla paging most of it in from disk make a big difference in 
>>performance to the user.
> 
> 
> 
> We really need a server option. Something that ages out file backed pages
> naturally with less overhead than kswapd. One method would be to keep the
> pagecache on it's own list, and move pages to the head of the list any time
> they are modified or referenced, and reclaim from the tail. 
> 
> All pages on this list can be considered as "free memory", because any new
> memory requests would just cause pages to be evicted from the tail of the
> list.
> 
> Anonymous memory would *not* be on this list. This way any time anonymous
> memory is allocated, the pages can be readily stolen from the pagecache
> list.
> 
> Lastly one nifty configuration parameter that could exist as a knob for
> sys-admins is the ability to tell the VM not to add file backed pages with
> the execute bit set to the page cache list but rather, leave them to be
> reclaimed if kswapd wakes up in a true low memory situation (pagecache is
> exhausted and memory is still low). This would require a sys-admin to make
> sure only executables have the execute bit set and "data files", etc... do
> not have the execute bit set.

Or have the exec() call set a "part of a process" flag. That means that 
if I read an executable in as data it doesn't get locked, other than 
what part might be in my i/o buffers. And mmap can produce different 
effects than read/write which may be good, if they are GOOD different 
effects ;-) Before you ask, thing 'strings' as why avg user does this.

But I fail to make my point... I want to limit how much memory is used 
for i/o buffers, cache, or anything else which will produce memory 
pressure of my programs. The quick solution might be just a number from 
the admin, like the 2.2 patch, but some kernel logic to understand that 
while 20MB is much better than 10MB in a tiny system, 2GB is not a lot 
better than 1GB in a large memory system, and having a sync() bog the 
system for tens of seconds is undesirable. Well, maybe some folks don't 
agree, it could be that the admin set limit is really the way to go.

I regard this as a desktop issue, trading some i/o performance to keep 
window changes fast.
> 
> 
> A system that works like this is nice for the following reasons:
> 
> 1) The system administrator can size a system so that all programs
>     Safely run within physical RAM. Extra RAM
>     Could be added and sized based on the need
>     for caching files.
> 
> 2) Anonymous pages (and possibly executable if you read 
>      the last paragraph above) will only be evicted if kswapd is
>      awaken due to a true memory shortage (1/128th pagable memory?).
> 
> 
> I like to view the VM system as always being full, because if enough unique
> file system IO takes place, that is exactly what eventually happens. A
> system that counts page cache as free memory and uses a gentler mechanism to
> evict pages from the page cache would benefit IO bound servers significantly
> IMHO.

That's what would be nice with tuning, the admin can optimize what is 
important on that system. I am usually happy with what the system does 
on i/o, but I want my 500MB or so of programs to stay resident in a 2GB 
machine, and if that adds a ms or two to i/o I can live with it, so that 
when I change windows it happens now, not eventually. And I bet there 
are a lot of others who would like better response to focus changes aswell.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
