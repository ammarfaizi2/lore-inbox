Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWAWByR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWAWByR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWAWByR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:54:17 -0500
Received: from smtpout.mac.com ([17.250.248.46]:15316 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751382AbWAWByQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:54:16 -0500
In-Reply-To: <17364.12454.643875.626906@cse.unsw.edu.au>
References: <20060117174531.27739.patches@notabene> <43D42CA8.6060507@xs4all.nl> <17364.12454.643875.626906@cse.unsw.edu.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E47F8910-F8E6-4F64-90F0-3A13DF01F6AE@mac.com>
Cc: John Hendrikx <hjohn@xs4all.nl>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Date: Sun, 22 Jan 2006 20:54:04 -0500
To: Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2006, at 20:25, Neil Brown wrote:
> Changing the size of the devices is a separate operation that has  
> been supported for a while. For each device in turn, you fail it  
> and replace it with a larger device. (This means the array runs  
> degraded for a while, which isn't ideal and might be fixed one day).
>
> Once all the devices in the array are of the desired size, you run
>   mdadm --grow /dev/mdX --size=max
> and the array (raid1, raid5, raid6) will use up all available space  
> on the devices, and a resync will start to make sure that extra  
> space is in-sync.

One option I can think of that would make it much safer would be to  
originally set up your RAID like this:

                md3 (RAID-5)
        __________/   |   \__________
       /              |              \
md0 (RAID-1)   md1 (RAID-1)   md2 (RAID-1)

Each of md0-2 would only have a single drive, and therefore provide  
no redundancy.  When you wanted to grow the RAID-5, you would first  
add a new larger disk to each of md0-md2 and trigger each resync.   
Once that is complete, remove the old drives from md0-2 and run:
   mdadm --grow /dev/md0 --size=max
   mdadm --grow /dev/md1 --size=max
   mdadm --grow /dev/md2 --size=max

Then once all that has completed, run:
   mdadm --grow /dev/md3 --size=max

This will enlarge the top-level array.  If you have LVM on the top- 
level, you can allocate new LVs, resize existing ones, etc.

With the newly added code, you could also add new drives dynamically  
by creating a /dev/md4 out of the single drive, and adding that as a  
new member of /dev/md3.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


