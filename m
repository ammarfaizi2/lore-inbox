Return-Path: <linux-kernel-owner+w=401wt.eu-S1030330AbXAEE5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbXAEE5B (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 23:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbXAEE5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 23:57:00 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:31556 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030330AbXAEE47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 23:56:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IC1/tYUrMeoOoj3s8FgRJGyxX7tgamtqSF8EnvkZaZpBDU17jhTJ4t8TKJmuhDGZp/OA46PmR8AktFc6Sq5HSrXlZOvDt9B24fm0ZRn14HYoPf100k0j+TgySNRxpgzj5uZTNM/o4PQ+FfG6VfxOM7NOjjHCxmfmtehuiVaJqss=  ;
X-YMail-OSG: 2M4gSuMVM1kagAi4uHtTfMrDM3QUB563p16qXISwDBWZtgAoXzuJ2PsIan846X6QJwcQMA37Tv_ZG.OAaIl1DUNqJZ1A.jPhSdvsEoxqW_KCzR8qQISKaF2BA6SWfESYDU1.coxg8ZcsO2k-
Message-ID: <459DDA73.9080706@yahoo.com.au>
Date: Fri, 05 Jan 2007 15:56:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-aio@kvack.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com> <459C95FE.1090802@yahoo.com.au> <20070104062622.GB24532@in.ibm.com> <459CA3A3.5090106@yahoo.com.au> <20070104112455.GA15934@in.ibm.com>
In-Reply-To: <20070104112455.GA15934@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> On Thu, Jan 04, 2007 at 05:50:11PM +1100, Nick Piggin wrote:

>>OK, but I think that after IO submission, you do not run sync_page to
>>unplug the block device, like the normal IO path would (via lock_page,
>>before the explicit plug patches).
> 
> 
> In the buffered AIO case, we do run sync page like normal IO ... just
> that we don't block in io_schedule(), everything else is pretty much 
> similar.

You do? OK I must have misread it. Ignore that, then ;)

>>I'm sure more merging or batching could be done, but also consider that
>>most programs will not ever make use of any added complexity.
> 
> 
> I guess I didn't express myself well - by batching I meant being able to
> surround submission of a batch of iocbs with explicit plug/unplug instead
> of explicit plug/unplug for each iocb separately. Of course there is no
> easy way to do that, since at the io_submit() level we do not know about
> the block device (each iocb could be directed to a different fd and not
> just block devices). So it may not be worth thinking about.

Well we currently _could_ do that, because the block device plugging code
will detect if the request queue changes, and flush built up requests...

However, I think we may want to make the plug operations a callback rather
than hardcoded block device plugging, so that will make it harder... but
you have a good point about increasing the scope of the plugging, it would
be a win if we can do it.

>>Regarding your patches, I've just had a quick look and have a question --
>>what do you do about blocking in page reclaim and dirty balancing? Aren't
>>those major points of blocking with buffered IO? Did your test cases
>>dirty enough to start writeout or cause a lot of reclaim? (admittedly,
>>blocking in reclaim will now be much less common since the dirty mapping
>>accounting).
> 
> 
> In my earlier versions of patches I actually had converted these waits to
> be async retriable, but then I came to the conclusion that the additional
> complexity wasn't worth it. For one it didn't seem to make a difference 
> compared to the other bigger cases, and I was looking primarily at handling
> the gross blocking points (say to enable an application to keep device queues
> busy) and not making everything asynchronous; for another we had a long
> discussion thread waay back about not making AIO submitters exempt from
> throttling or memory availability waits.

OK, I was just curious. For keeping queues busy, your patchset should work
well (sleeping for more memory should be pretty uncommon). But for
overlapping computation with IO, it may not work so well if it encounters
throttling.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
