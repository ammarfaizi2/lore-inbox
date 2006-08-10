Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWHJXS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWHJXS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWHJXS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:18:58 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:2255 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932310AbWHJXSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:18:55 -0400
Message-ID: <44DBBF2B.2050605@free.fr>
Date: Fri, 11 Aug 2006 01:20:11 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2 - OOM storm
References: <20060806030809.2cfb0b1e.akpm@osdl.org>	<44DAF6A4.9000004@free.fr> <20060810021957.38c82311.akpm@osdl.org>
In-Reply-To: <20060810021957.38c82311.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10.08.2006 11:19, Andrew Morton a écrit :
> On Thu, 10 Aug 2006 11:04:36 +0200
> Laurent Riffard <laurent.riffard@free.fr> wrote:
> 
>> Le 06.08.2006 12:08, Andrew Morton a écrit :
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/26.18-rc3-mm2/
>> Hello,
>>
>> On my system, a cron runs every day to check the integrity of
>> installed RPMS, it runs "rpm -v" on each package, which computes
>> MD5 hash for each installed file and compares this result, the file 
>> size and modification time with values stored in RPM database.
>>
>> This is the workload. Since 2.6.18-rc3-mm2, this processus eats 
>> all the memory and triggers OOM.
>>
>> On my system, "free -t" output normally looks like this ("cached" value 
>> is about half of RAM):
>> # free -t 
>>              total       used       free     shared    buffers     cached
>> Mem:        515032     508512       6520          0      22992     256032
>> -/+ buffers/cache:     229488     285544
>> Swap:      1116428        324    1116104
>> Total:     1631460     508836    1122624
>>
>> After the rpm database check, "free -t" says:
>>              total       used       free     shared    buffers     cached
>> Mem:        515032     507124       7908          0       8132     398296
>> -/+ buffers/cache:     100696     414336
>> Swap:      1116428      34896    1081532
>> Total:     1631460     542020    1089440
>>
>> And the value of "cached" won't decrease.
>>
> 
> Yes, I was just trying to reproduce this.  No luck so far.  Will try your
> .config tomorrow.
> 
> It would be interesting to try disabling CONFIG_ADAPTIVE_READAHEAD -
> perhaps that got broken.

I just try it: when CONFIG_ADAPTIVE_READAHEAD is disabled, 
/proc/meminfo:Cached is stable and never exceeded 230.000, the system 
didn't even try to swap.

$ cat /proc/meminfo   # taken a few minutes after the end of rpm -V
MemTotal:       515032 kB
MemFree:          6612 kB
Buffers:         42212 kB
Cached:         182236 kB
SwapCached:          0 kB
Active:         376256 kB
Inactive:        75468 kB
SwapTotal:     1116428 kB
SwapFree:      1116428 kB
Dirty:             272 kB
Writeback:           0 kB
AnonPages:      227260 kB
Mapped:          62812 kB
Slab:            44968 kB
PageTables:       2152 kB
NFS Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   1373944 kB
Committed_AS:   637400 kB
VmallocTotal:   515796 kB
VmallocUsed:      6916 kB
VmallocChunk:   508760 kB

> Also, are you able to determine whether the problem is specific to `rpm
> -V'?  Are you able to make the leak trigger using other filesystem
> workloads?

Will try...
 
> If it's specific to `rpm -V' then perhaps direct-io is somehow causing
> pagecache leakage.  That would be a bit odd.
> 
> 
> 
> btw, it's not necessary to go all the way to oom to work out if the
> pagecache leak is happening.  After booting, do
> 
> 	echo 3 > /proc/sys/vm/drop_pagecache
> 
> and record the `Cached' figure in /proc/meminfo.  After running some test,
> run `echo 3 > /proc/sys/vm/drop_pagecache' again and check
> /proc/meminfo:Cached.  If it dodn't do gown to a similarly low figure,
> we're leaking pagecache.

I played with these values and as far I can remember, I get some poor  
improvement. Will try to gather some data.
 
> btw2: please use /proc/meminfo output rather than free(1).  Because free(1)
> shows less info, and it does mysterious mangling of the info which it does
> read in ways which confuse me.

Ok
 
-- 
laurent
