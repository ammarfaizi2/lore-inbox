Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWBBTZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWBBTZM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWBBTZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:25:11 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:2258 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751078AbWBBTZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:25:10 -0500
Message-ID: <43E25CDA.7020503@tmr.com>
Date: Thu, 02 Feb 2006 14:26:18 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
References: <200601281613.16199.vda@ilport.com.ua> <43DDAE2D.6080300@namesys.com> <200601300822.47821.mason@suse.com> <200602010932.50972.vda@ilport.com.ua>
In-Reply-To: <200602010932.50972.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Monday 30 January 2006 15:22, Chris Mason wrote:
> 
>>On Monday 30 January 2006 01:11, Hans Reiser wrote:
>>
>>>Chris, would Denis Vlasenko wrote:
>>>
>>>>[CCing namesys]
>>>>
>>>>Narrowed it down to 100% reproducible case:
>>>>
>>>>	chown -Rc 0:<n> .
>>>>
>>>>in a top directory of tree containing ~21938 files
>>>>on reiser3 partition:
>>>>
>>>>	/dev/sdc3 on /.3 type reiserfs (rw,noatime)
>>>>
>>>>causes oom kill storm. "ls -lR", "find ." etc work fine.
>>>>
>>>>I suspected that it is a leak in winbindd libnss module,
>>>>but chown does not seem to grow larger in top, and also
>>>>running it under softlimit -m 400000 still causes oom kills
>>>>while chown's RSS stays below 4MB.
>>
>>In order for the journaled filesystems to make sure the FS is consistent after 
>>a crash, we need to keep some blocks in memory until other blocks have been 
>>written.  These blocks are pinned, and can't be freed until a certain amount 
>>of io is done.
>>
>>In the case of reiserfs, it might pin as much as the size of the journal at 
>>any time.  The default journal is 32MB, which is much too large for a system 
>>with only 32MB of ram.
>>
>>You can shrink the log of an existing filesystem.  The minimum size is 513 
>>blocks, you might try 1024 as a good starting poing.
>>
>>reiserfstune -s 1024 /dev/xxxx
>>
>>The filesystem must be unmounted first.
> 
> 
> Will try this and report the result.
> 
> Please consider printing a big fat warning at mount time if total RAM
> on the system is close to sum of RAM space required for all currently
> mounted reiserfs partitions...

I would think that rather than warn about the problem that it would be 
better to teach the filesystem not to use all of memory, and to stop and 
wait for i/o to finish rather than pin so many pages that the system 
becomes unusable. For definitions of usable which include not killing 
random small processes because the filesystem code isn't playing nicely.

Would some global count of reiser_pinned_pages be possible as a way to 
track the problem?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
