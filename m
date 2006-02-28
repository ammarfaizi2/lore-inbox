Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWB1SvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWB1SvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWB1SvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:51:16 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64984 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751890AbWB1SvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:51:16 -0500
Message-ID: <44049BA0.5080007@namesys.com>
Date: Tue, 28 Feb 2006 10:51:12 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>, drepper@redhat.com
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Marr <marr@flex.com>,
       reiserfs-dev@namesys.com
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org> <200602261407.33262.ioe-lkml@rameria.de> <4401B233.7050308@yahoo.com.au> <44036670.7060204@namesys.com> <44039A83.4050604@yahoo.com.au>
In-Reply-To: <44039A83.4050604@yahoo.com.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich, it seems that glibc is doing something that looks like some sort
of attempt at a filesystem optimization for fseek() which really ought
to be in the filesystems instead of glibc.  Could you comment, and
assuming you agree, fix it for us?

It particularly affects ReiserFS V3 performance in a highly negative
way, because we set stat.blksize to 128k.  stat.blksize is intended to
hint what the preferred IO size is for an FS.

Could you read this thread and contribute to it?

Hans

The most important part of the thread to read was:

Marr <marr@flex.com> wrote:
  

>>
>> ..
>>
>> When switching from kernel 2.4.31 to 2.6.13 (with everything else the same), 
>> there is a drastic increase in the time required to perform 'fseek()' on 
>> larger files (e.g. 4.3 MB, using ReiserFS [in case it matters], in my test 
>> case).
>> 
>> It seems that any seeks in a range larger than 128KB (regardless of the file 
>> size or the position within the file) cause the performace to drop 
>> precipitously.
>>
>    
>

Interesting.

What's happening is that glibc does a read from the file within each
fseek().  Which might seem a bit silly because the app could seek somewhere
else without doing any IO.  But then the app would be silly too.

Also, glibc is using the value returned in struct stat's blksize (a hint as
to this file's preferred read chunk size) as, umm, a hint as to this file's
preferred read size.

Most filesystems return 4k in stat.blksize.  But in 2.6, reiserfs bumped
that to 128k to get good I/O patterns.   Consequently this:

  

>>          for (j=0; j < max_calls; j++) {
>>             pos = (int)(((double)random() / (double)RAND_MAX) * 4000000.0);
>>             if (fseek(inp_fh, pos, SEEK_SET)) {
>>                printf("Error ('%s') seeking to position %d!\n", 
>>                       strerror(errno), pos);
>>             }
>>          }
>    
>

runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k read
on every fseek.



Nick Piggin wrote:

> Hans Reiser wrote:
>
>> Sounds like the real problem is that glibc is doing filesystem
>> optimizations without making them conditional on the filesystem type.
>
>
> I'm not sure that it should even be conditional on the filesystem type...
> To me it seems silly to even bother doing it, although I guess there
> is another level of buffering involved which might mean it makes more
> sense.
>
>
>> My entry for the ugliest thought of the day: I wonder if the kernel can
>> test the glibc version and.....
>>
>> Hans
>>
>> Nick Piggin wrote:
>>
>>
>>> Actually glibc tries to turn this pre-read off if the seek is to a page
>>> aligned offset, presumably to handle this case. However a big write
>>> would only have to RMW the first and last partial pages, so pre-reading
>>> 128KB in this case is wrong.
>>>
>>> And I would also say a 4K read is wrong as well, because a big read
>>> will
>>> be less efficient due to the extra syscall and small IO.
>>>

