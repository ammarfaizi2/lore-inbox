Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbUCSTgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUCSTgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:36:21 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:17625 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263170AbUCSTgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:36:04 -0500
Message-ID: <405B4BA3.2030205@namesys.com>
Date: Fri, 19 Mar 2004 22:36:03 +0300
From: Hans Reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Peter Zaitsev <peter@mysql.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
References: <1079572101.2748.711.camel@abyss.local>	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>	 <1079641026.2447.327.camel@abyss.local>	 <1079642001.11057.7.camel@watt.suse.com>	 <1079642801.2447.369.camel@abyss.local>	 <1079643740.11057.16.camel@watt.suse.com>	 <1079644190.2450.405.camel@abyss.local>	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com> <1079704347.11057.130.camel@watt.suse.com>
In-Reply-To: <1079704347.11057.130.camel@watt.suse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Fri, 2004-03-19 at 03:05, Hans Reiser wrote:
>  
>
>>Chris Mason wrote:
>>
>>    
>>
>>>On Thu, 2004-03-18 at 16:09, Peter Zaitsev wrote:
>>> 
>>>
>>>      
>>>
>>>>On Thu, 2004-03-18 at 13:02, Chris Mason wrote:
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>>>>In the former case cache is surely not flushed. 
>>>>>>
>>>>>>       
>>>>>>
>>>>>>            
>>>>>>
>>>>>Hmmm, is it reiser?  For both 2.4 reiserfs and ext3, the flush happens
>>>>>when you commit.  ext3 always commits on fsync and reiser only commits
>>>>>when you've changed metadata.
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>Oh. Yes. This is Reiser, I did not think it is FS issue.
>>>>I'll know to stay away from ReiserFS now.
>>>>   
>>>>
>>>>        
>>>>
>>>For reiserfs data=ordered should be enough to trigger the needed
>>>commits.  If not, data=journal.  Note that neither fs does barriers for
>>>O_SYNC, so we're just not perfect in 2.4.
>>>
>>>-chris
>>>
>>>      
>>>
>>You are not listening to Peter.  As I understand it from what Peter says 
>>and your words, your implementation is wrong, and makes fsync 
>>meaningless.  If so, then you need to fix it.  fsync should not be 
>>meaningless even for metadata only journaling.  This is a serious bug 
>>that needs immediate correction, if Peter and I understand it correctly 
>>from your words.
>>    
>>
>
>I am listening to Peter, Jens and I have spent a significant amount of
>time on this code.  
>
but you need to get it right.

>We can go back and spend many more hours testing and
>debugging the 2.4 changes, or we can go forward with a very nice
>solution in 2.6.
>
>I'm planning on going forward with 2.6
>  
>
This is a very important patch that you have created, but you haven't 
articulated what happens in the following scenario (Peter I am making up 
something without knowing your internals, please feel encouraged to help 
me on this).

mysql fsync()'s a file, which it thinks guarantees that all of a mysql 
transaction has reached disk.  The disk write caches it.  You let fsync 
return.  It is not on disk.  mysql performs its mysql commit, and writes 
a mysql commit record which reaches disk, but not all of the transaction 
is on disk.  The system crashes.  mysql plays the log.  mysql has 
internal corruption.  User  calls Peter.  Peter asks, what do you expect 
when you use a piece of shit like reiserfs?  User doesn't care about our 
internal squabbling and goes back to using windows which does proper 
commits.

Or, random application fsyncs, expects that it means that data has 
reached disk, and tells user to perform real world actions dependent on 
the data being on disk, but it is not.

I hope I am totally off-base and not understanding you....  Please help 
me here.

>-chris
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans

