Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVIAHqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVIAHqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVIAHqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:46:04 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:6353 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S965078AbVIAHqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:46:02 -0400
Message-ID: <4316B1A2.5050306@sm.sony.co.jp>
Date: Thu, 01 Sep 2005 16:45:38 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: "Machida, Hiroyuki" <machida@sm.sony.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>	<874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp> <87irxm83eq.fsf@devron.myhome.or.jp> <431696BB.8050104@sm.sony.co.jp>
In-Reply-To: <431696BB.8050104@sm.sony.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machida, Hiroyuki wrote:
> OGAWA Hirofumi wrote:
> 
>> "Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:
>>
>>
>>> Right, it looks like TLB, which holds cache "Physical addres"
>>> correponding to "Logical address". In this case, PID and file name
>>> to be looked up, perform role of "Logical address".
>>
>>
>>
>> But, there is the big difference between hint table and TLB. TLB is
>> just the cache, and TLB hit is perfectly good, because kernel is
>> flushing the wrong values.
>>
>> But this hint table is just collecting the recent access, it's not
>> cache, and it's not tracking the process's access at all.  So, since
>> the hint value is really random, the hint value may be bad.
>>
>> I worry bad cases of this.
>>
>>
>> Umm... How about tracking the access pattern of process?  If that
>> seems randomly access, just give up tracking and return no hint.  And,
>> probably, I think it would be easy to improve the behavior later.
>>
>> What do you think?
> 
> 
> Sounds interesting...
> 
> Once concern about global URL in general, it tends to be occupied
                             ^^^
sorry, LRU not URL.

> by specific pattern, like accesses from one process or to on dir.
                                                             one dir.

> It prevents to realize locality.
> 
> I think it's better to have limitations like;
>     entries for same process would be limited to 2/3
>     entries for same dir would be limited to 1/3
> 
> 
>> e.g.
>>
>> #define FAT_LOOKUP_HINT_MAX    16
>>
>> /* this data per task */
>> struct fat_lookup_hint {
>>     struct list_head lru;
>>     pid_t pid;
>>     struct super_block *sb;
>>     struct inode *dir;
>>     loff_t last_pos;
>> /*    int state;*/
>> };
> 
> 
> Does this mean for each process recording last recent 16
> accesses to FAT file system ? If true, pid would be eliminated.
> 
> I guess it's better to record nr_slots for this entry.
> 
> As implementation issue, if number of entires is small enough,
> we can use an array, not a list.
> 
> 
>> static void fat_lkup_hint_inval(struct super_block *, struct inode *);
>> static loff_t fat_lkup_hint_get(struct super_block *, struct inode *);
>> static void fat_lkup_hint_add(struct super_block *, struct inode *, 
>> loff_t);
>> static int fat_lkup_hint_init(void);
> 
> 
> I think super_block can be retrieved from inode, any other intention do
> you have?
> 
> 
> In addtion, we can do follwoing to check the exact match case;
> 
>     0. Record hash value of file name in struct fat_lookup_hint
> 
>     1. Check hash value to find exact match case,
>     1-1. If matched entry is found, check if file name and
>          file name retieved from dirent corresponding
>     1-2. We found the entry
> 
>     2. Get hint value, if there seem to have locality
>     2-1. Check locality of access pattern for this PID and this
>          DIR.
>     2-2. If we relize access locality, return hit value so that
>          it covers a potential working set.
>     2-3. Use hint value as start position of dirscan.
> 


-- 
Hiroyuki Machida
