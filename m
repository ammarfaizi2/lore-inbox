Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269007AbUJQCTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269007AbUJQCTk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269001AbUJQCTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 22:19:39 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:58724 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269007AbUJQCTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 22:19:16 -0400
Message-ID: <4171D6A0.4030200@yahoo.com.au>
Date: Sun, 17 Oct 2004 12:19:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org> <4171C20D.1000105@pobox.com> <4171C9CD.4000303@yahoo.com.au> <4171D5F8.8050504@pobox.com>
In-Reply-To: <4171D5F8.8050504@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Nick Piggin wrote:
> 
>> diff -puN mm/vmscan.c~vm-fix mm/vmscan.c
>> --- linux-2.6/mm/vmscan.c~vm-fix    2004-10-17 11:14:02.000000000 +1000
>> +++ linux-2.6-npiggin/mm/vmscan.c    2004-10-17 11:20:55.000000000 +1000
>> @@ -181,7 +181,7 @@ static int shrink_slab(unsigned long sca
>>      struct shrinker *shrinker;
>>  
>>      if (scanned == 0)
>> -        return 0;
>> +        scanned = 1;
>>  
>>      if (!down_read_trylock(&shrinker_rwsem))
>>          return 0;
>> @@ -1065,7 +1065,8 @@ scan:
>>              total_reclaimed += sc.nr_reclaimed;
>>              if (zone->all_unreclaimable)
>>                  continue;
>> -            if (zone->pages_scanned > zone->present_pages * 2)
>> +            if (zone->pages_scanned > (zone->nr_active +
>> +                            zone->nr_inactive) * 4)
>>                  zone->all_unreclaimable = 1;
>>              /*
>>               * If we've done a decent amount of scanning and
> 
> 
> 
> Nope, this patch does not fix the hang.
> 

Arrgh, sorry that should be
	if (zone->pages_scanned *>=* blah)

If you've got zero LRU pages, both sides of this should be zero, and
we *want* all_unreclaimable to be set.
