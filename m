Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbUAJQTa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAJQTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:19:30 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:36511 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265242AbUAJQTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:19:15 -0500
Message-ID: <400025FF.1030508@wmich.edu>
Date: Sat, 10 Jan 2004 11:19:11 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ornati <ornati@lycos.it>
CC: Ram Pai <linuxram@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
References: <200401021658.41384.ornati@lycos.it> <20040108171728.54a72cf7.akpm@osdl.org> <1073675705.14637.8.camel@dyn319250.beaverton.ibm.com> <200401101548.33458.ornati@lycos.it> <40002196.4030506@wmich.edu>
In-Reply-To: <40002196.4030506@wmich.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> Paolo Ornati wrote:
> 
>> On Friday 09 January 2004 20:15, Ram Pai wrote:
>>
>>> On Thu, 2004-01-08 at 17:17, Andrew Morton wrote:
>>>
>>>> Ram Pai <linuxram@us.ibm.com> wrote:
>>>>
>>>>> Well this is my theory, somebody should validate it,
>>>>
>>>>
>>>> One megabyte seems like far too litte memory to be triggering the
>>>> effect which you describe.  But yes, the risk is certainly there.
>>>>
>>>> You could verify this with:
>>>
>>>
>>> I cannot exactly reproduce what Pualo Ornati is seeing.
>>>
>>> Pualo: Request you to validate the following,
>>>
>>> 1) see whether you see a regression with files replacing the
>>>   cat command in your script with
>>>       dd if=big_file of=/dev/null bs=1M count=256
>>>
>>> 2) and if you do, check if you see a bunch of 'eek' with Andrew's
>>>        following patch. (NOTE: without reverting the changes
>>>        in filemap.c)
>>>
>>> ------------------------------------------------------------------------- 
>>>
>>> -
>>>
>>> --- 25/mm/filemap.c~a   Thu Jan  8 17:15:57 2004
>>> +++ 25-akpm/mm/filemap.c        Thu Jan  8 17:16:06 2004
>>> @@ -629,8 +629,10 @@ find_page:
>>>                        handle_ra_miss(mapping, ra, index);
>>>                        goto no_cached_page;
>>>                }
>>> -               if (!PageUptodate(page))
>>> +               if (!PageUptodate(page)) {
>>> +                       printk("eek!\n");
>>>                        goto page_not_up_to_date;
>>> +               }
>>> page_ok:
>>>                /* If users can be writing to this page using arbitrary
>>>                 * virtual addresses, take care about potential aliasing
>>>
>>> ------------------------------------------------------------------------- 
>>>
>>
>>
>>
>> Ok, this patch seems for -mm tree... I have applied it by hand (on a 
>> vanilla 2.6.1-rc1).
>>
>> For my tests I've used this script:
>>
>> #!/bin/sh
>>
>> RA_VALS="256 128 64"
>> FILE="/big_file"
>> SIZE=`stat -c '%s' $FILE`
>> NR_TESTS="3"
>> LINUX=`uname -r`
>>
>> echo "HD test for Penguin $LINUX"
>>
>> killall5
>> sync
>> sleep 3
>>
>> for ra in $RA_VALS; do
>>     hdparm -a $ra /dev/hda
>>     for i in `seq $NR_TESTS`; do
>>     echo "_ _ _ _ _ _ _ _ _"
>>     ./fadvise $FILE 0 $SIZE dontneed
>>     time dd if=$FILE of=/dev/null bs=1M count=256
>>     done
>>     echo "________________________________"
>> done
>>
>>
>> RESULTS (2.6.0 / 2.6.1-rc1)
>>
>> HD test for Penguin 2.6.0
>>
>> /dev/hda:
>>  setting fs readahead to 256
>>  readahead    = 256 (on)
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.427s
>> user    0m0.002s
>> sys    0m1.722s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.963s
>> user    0m0.000s
>> sys    0m1.760s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.291s
>> user    0m0.001s
>> sys    0m1.713s
>> ________________________________
>>
>> /dev/hda:
>>  setting fs readahead to 128
>>  readahead    = 128 (on)
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m9.910s
>> user    0m0.003s
>> sys    0m1.882s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m9.693s
>> user    0m0.003s
>> sys    0m1.860s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m9.733s
>> user    0m0.004s
>> sys    0m1.922s
>> ________________________________
>>
>> /dev/hda:
>>  setting fs readahead to 64
>>  readahead    = 64 (on)
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m9.107s
>> user    0m0.000s
>> sys    0m2.026s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m9.227s
>> user    0m0.004s
>> sys    0m1.984s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m9.152s
>> user    0m0.002s
>> sys    0m2.013s
>> ________________________________
>>
>>
>> HD test for Penguin 2.6.1-rc1
>>
>> /dev/hda:
>>  setting fs readahead to 256
>>  readahead    = 256 (on)
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.984s
>> user    0m0.002s
>> sys    0m1.751s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.704s
>> user    0m0.002s
>> sys    0m1.766s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.886s
>> user    0m0.002s
>> sys    0m1.731s
>> ________________________________
>>
>> /dev/hda:
>>  setting fs readahead to 128
>>  readahead    = 128 (on)
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.120s
>> user    0m0.001s
>> sys    0m1.830s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.596s
>> user    0m0.005s
>> sys    0m1.764s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.481s
>> user    0m0.002s
>> sys    0m1.727s
>> ________________________________
>>
>> /dev/hda:
>>  setting fs readahead to 64
>>  readahead    = 64 (on)
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.361s
>> user    0m0.006s
>> sys    0m1.782s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.655s
>> user    0m0.002s
>> sys    0m1.778s
>> _ _ _ _ _ _ _ _ _
>> 256+0 records in
>> 256+0 records out
>>
>> real    0m11.369s
>> user    0m0.004s
>> sys    0m1.798s
>> ________________________________
>>
>>
>> As you can see 2.6.0 performances increase setting readahead from 256 
>> to 64 (64 seems to be the best value) while 2.6.1-rc1 performances 
>> don't change too much.
>>
>> I noticed that on 2.6.0 with readahead setted at 256 the HD LED blinks 
>> during the data transfer while with lower values (128 / 64) it stays on.
>> Instead on 2.6.1-rc1 HD LED blinks with almost any values (I must set 
>> it at 8 to see it stable on).
>>
>> ANSWERS:
>>
>> 1) YES... I see a regression with files ;-(
>>
>> 2) YES, I see also a bunch of "eek!" (a mountain of "eek!")
>>
>> Bye
>>
> 
> 
> I'm using 2.6.0-mm1 and i see no difference from setting readahead to 
> anything on my extent enabled partitions. So it appears that filesystem 
> plays a big part in your numbers here, not just hdd attributes or settings.
> 
> The partition FILE is on is an ext3 + extents enabled partition. Despite 
> not having fadvise (what is this anyway?) the numbers are all real and 
> no error occured. Extents totally rocks for this type of data access, as 
> you can see below.
> 
> Stick to non-fs tests if you want to benchmark fs independent code. Not 
> everyone is going to be able to come up with the same results as you and 
> as such a possible fix could actually be detrimental, and we'd be stuck 
> in a loop of "ide regression" mails.
> 

debian unstable's dd may also be seeing that it's writing to /dev/null 
and just not doing anything. I know extents are fast and make certain 
manipulations on them extremely faster than plain ext3 but 256MB/sec is 
really really too fast. So in either case it looks like this test is not 
usable to me.


I dont know why you dont also try 8192 for readahead, measuring 
performance by the duration or intensity of the hdd is led is not very 
sound. i actually copy large files to and from parts of the same ext3 
partition at over 20MB/sec sustained hdparm shows it's highest numbers 
under it. For me it doesn't get any faster than that.  So what's this 
all say, maybe all these performance numbers are just as much based on 
your readahead value as they are on the position of the moon and the 
rest of the system and it's hardware. btw, what is the value of your HZ 
environment variable, debian still sets it to 100, i set it to 1024, not 
really sure if it made any difference.

i'm using the via ide driver, so are you, i'm not seeing the type of 
regression that you are, my dd doesn't do what your dd does. our hdds 
are different.  The regression in the kernels could just as easily be 
due to a regression in the schedular and nothing to do with the ide 
drivers.  Have you tried just using 2.6.0 (whatever version you see 
changes with your readahead values) then the same kernel with the new 
ide code from the kernel you dont see any changes so you're running 
everything else the same but only ide has been "upgraded" and see if you 
see the same regression.  I dont think you will. the readahead effects 
how often you have to ask the hdd to read from the platter and waiting 
on io can possibly effect how your kernel schedules it. Faster drives 
would thus not be effected the same way which could explain why none of 
the conclusions and results you've found are the same with my system.

or i could be completely wrong and something could be going bad with the 
ide drivers.  I just dont see how that could be the case and i not have 
the same performance regression you have when we both use the same ide 
drivers (just slightly different chipsets).



> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> HD test for Penguin 2.6.0-mm1-extents
> 
> /dev/hda:
>  setting fs readahead to 8192
>  readahead    = 8192 (on)
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.098793 seconds (244300323 bytes/sec)
> 
> real	0m1.100s
> user	0m0.005s
> sys	0m1.096s
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.102250 seconds (243534086 bytes/sec)
> 
> real	0m1.104s
> user	0m0.000s
> sys	0m1.104s
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.096914 seconds (244718759 bytes/sec)
> 
> real	0m1.098s
> user	0m0.001s
> sys	0m1.097s
> ________________________________
> 
> /dev/hda:
>  setting fs readahead to 256
>  readahead    = 256 (on)
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.104646 seconds (243005877 bytes/sec)
> 
> real	0m1.106s
> user	0m0.001s
> sys	0m1.105s
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.100904 seconds (243831834 bytes/sec)
> 
> real	0m1.102s
> user	0m0.000s
> sys	0m1.103s
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.102060 seconds (243576076 bytes/sec)
> 
> real	0m1.104s
> user	0m0.002s
> sys	0m1.101s
> ________________________________
> 
> /dev/hda:
>  setting fs readahead to 128
>  readahead    = 128 (on)
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.100799 seconds (243855121 bytes/sec)
> 
> real	0m1.102s
> user	0m0.000s
> sys	0m1.102s
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.101516 seconds (243696385 bytes/sec)
> 
> real	0m1.103s
> user	0m0.002s
> sys	0m1.101s
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.100963 seconds (243818758 bytes/sec)
> 
> real	0m1.102s
> user	0m0.000s
> sys	0m1.103s
> ________________________________
> 
> /dev/hda:
>  setting fs readahead to 64
>  readahead    = 64 (on)
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.104634 seconds (243008498 bytes/sec)
> 
> real	0m1.106s
> user	0m0.002s
> sys	0m1.105s
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.102107 seconds (243565703 bytes/sec)
> 
> real	0m1.104s
> user	0m0.003s
> sys	0m1.100s
> _ _ _ _ _ _ _ _ _
> /tester: line 18: ./fadvise: No such file or directory
> 256+0 records in
> 256+0 records out
> 268435456 bytes transferred in 1.104429 seconds (243053595 bytes/sec)
> 
> real	0m1.106s
> user	0m0.000s
> sys	0m1.106s
> ________________________________


