Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266052AbUGJIMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUGJIMS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUGJIMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:12:18 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:494 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S266052AbUGJIL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:11:56 -0400
Message-ID: <40EFA4C8.1050409@metaparadigm.com>
Date: Sat, 10 Jul 2004 16:11:52 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040704 Debian/1.7-4
X-Accept-Language: en
MIME-Version: 1.0
To: Lutz Vieweg <lkv@isg.de>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to find out which pages were copied-on-write?
References: <40EACC0C.6060606@isg.de> <20040709113125.GA8897@lnx-holt.americas.sgi.com> <40EF0346.4040407@isg.de>
In-Reply-To: <40EF0346.4040407@isg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HPAs library LPSM sounds like what you're looking for.

http://freshmeat.net/projects/lpsm/

Or you can do what you want the hard way using mprotect and a SEGV handler.

~mc

On 07/10/04 04:42, Lutz Vieweg wrote:
> Robin Holt wrote:
> 
>> OK, now that I am considering this problem,  I am trying to figure out
>> what problem we are trying to solve.
>>
>> By reading your email, I gather that you have a single threaded
>> application which is doing an mmap on a file as a MAP_PRIVATE mapping.
>> The memory area is then handed to a library which may modify some pages.
>> You want to decide after the return if you had success and thereby
>> control the writing of the updated data back to the file.  Because of
>> the size of the file, doing a second mapping and comparing/copying pages
>> is unreasonable and you would like to only modify the pages that have
>> actually changed.
> 
> 
> That's about it, the most important issue is that I want to avoid
> having an inconsistent file on the disk for long periods, because a)
> the application could crash and b) another process might want to map
> the same file (read-only). And since the application is reaching points
> where the data is consistent, while it is not in between, it would be nice
> to have a private mapping while it is inconsistent and commit the changes
> only at the points where the application knows the data is consistent.
> 
> Turning a private into a shared mapping would be a perfect solution
> since that would mean another process could map the file at any time
> and find consistent data. The second best solution would be the
> one where the application just manually writes out the changed pages
> at the time of consistence, this would at least reduce the times when the
> data on disk is inconsistent to a minimum.
> 
> 
> 
>>> Yet another feature that I could use if it were available:
>>> A "copy-on-read"-mapping. There, a page would become a private
>>> copy of a process once _another_ process wrote data to the
>>> corresponding file location. But I suspect that feature
>>> could be very hard to implement...
>>
>>
>> This is a different way of thinking of copy-on-write.  I believe you
>> are thinking of the time when there are two processes sharing the page.
>> When one process takes the write fault, the page is copied and the by 
>> that
>> process and the other process becomes the exclusive owner of the page.
> 
> 
> A little different: Think of N processes (N may be 8 or so) that mmap()
> a file using a new mode "MAP_SNAPSHOT" (which could be read-only if a mix
> with private copy-on-write pages was too hard to realize), and 1 process
> mmap()ing the same file using MAP_SHARED. Once the N processes mmap()ed
> the file using MAP_SNAPSHOT, their "view" of the file content would never
> change, that is, if the one process that mmap()ed the file with MAP_SHARED
> writes to a page, that page _is_ written to disk the usual way, but the
> other N processes get a copy of the page before it has been changed, so
> they will always see the same data.
> Once the processes that mmap()ed using MAP_SNAPSHOT unmap the file, the
> copies of the pages that were changed on disk are simply discarded.
> 
> That would - similar to the features mentioned above - allow one process
> to efficiently work on portions of a huge file over a longer period of 
> time,
> and only at times when the file in total contains consistent data, other
> processes could be instructed to mmap() them again to obtain a newer 
> version.
> 
> 
> Regards,
> 
> Lutz Vieweg
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Michael Clark,  . . . . . . . . . . . .  michael@metaparadigm.com
Metaparadigm Pte. Ltd . . . . . . . . http://www.metaparadigm.com

                    "Explore Operations Research:
          The Science of Better at www.scienceofbetter.org "
