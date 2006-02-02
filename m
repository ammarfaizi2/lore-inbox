Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWBBTa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWBBTa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWBBTa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:30:57 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:59866 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751076AbWBBTa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:30:56 -0500
Message-ID: <43E25E39.4010908@tmr.com>
Date: Thu, 02 Feb 2006 14:32:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
References: <200601281613.16199.vda@ilport.com.ua> <43DDAE2D.6080300@namesys.com> <200601300822.47821.mason@suse.com> <200602020925.00863.vda@ilport.com.ua>
In-Reply-To: <200602020925.00863.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Monday 30 January 2006 15:22, Chris Mason wrote:
> 
>>>>	chown -Rc 0:<n> .
>>>>
>>>>in a top directory of tree containing ~21938 files
>>>>on reiser3 partition:
>>>>
>>>>	/dev/sdc3 on /.3 type reiserfs (rw,noatime)
>>>>
>>>>causes oom kill storm. "ls -lR", "find ." etc work fine.
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
> 
> 
> I had reiserfsprogs 3.6.11 and reiserfstune (above command) made my /dev/sdc3
> unmountable without -t reiserfs. I upgraded reiserfsprogs to 3.6.19 and now
> reiserfsck /dev/sdc3 reports no problems, but mount problem persists:
> 
> # mount -t reiserfs /dev/sdc3 /.3
> # umount /.3
> # mount /dev/sdc3 /.3
> mount: you must specify the filesystem type
> # dmesg | tail -3
> br: port 1(ifi) entering forwarding state
> FAT: bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev sdc3.
> 
> "chown -Rc <n>:<m> ." now does not OOM kill the box, so this issue
> is resolved, thanks!
> 
> Can I restore sdc3 somehow that I won't need -t reiserfs in mount command?
> You can find result of
> 
> dd if=/dev/sdc3 of=1m bs=1M count=1
> 
> at http://195.66.192.167/linux/1m

At the risk of stating the obvious:
1 - is reaser a module, and is it loaded?
2 - did this ever work? I think you said you removed the entry from 
fstab, was the filetype there which made it work?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
