Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269295AbUIHSiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269295AbUIHSiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUIHSiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:38:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22446 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269289AbUIHSfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:35:06 -0400
Message-ID: <413F5032.1070008@engr.sgi.com>
Date: Wed, 08 Sep 2004 11:32:18 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Arthur Corliss <corliss@digitalmages.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net, ? <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>, csa@oss.sgi.com
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de> <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org> <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de> <412E4C27.1010805@engr.sgi.com> <Pine.LNX.4.58.0408271727020.1075@bifrost.nevaeh-linux.org> <20040830122614.GA2518@frec.bull.fr> <Pine.LNX.4.53.0408311611080.9018@gockel.physik3.uni-rostock.de> <4135032E.7060605@engr.sgi.com>
In-Reply-To: <4135032E.7060605@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The block IO data was not used in billing for CSA customers.

Nobody has ever charged for this data. It is more for accountability
and resource consumption tracking. Accuracy changes as the program
runs for hours or days in our market. Repeatable billing is critical
and block IO is one that is not repeatable.

The write blocks was useful and with the type of programs running for
hours and days (which are the ones of interest in block IO data). The
delayed write after the process terminates is ignored because that is
insignificant for a process doing io for hours or days. We use the
bytes transferred vs blocks transferred to see programs dominating
and polluting the cache. Processes big in one and not the other are of
interest to profile more closely.

However, if nobody else wants to have this feature, we can pull it out
until we can find a way of doing this that makes people happy.

I will submit a new set of patch based on 2.6.8.1 later.

Thanks!
  - jay


Jay Lan wrote:
> Adding csa@oss.sgi.com, the CSA user group mailing list, to Cc.
> 
> Tim Schmielau wrote:
> 
>> On Mon, 30 Aug 2004, Guillaume Thouvenin wrote:
>>
>>
>>>  Thus, to be clear, the enhanced accounting can be divided into
>>> three parts:
>>>
>>>    1) A common data collection method in the kernel.
>>>       We could start from BSD-accounting and add CSA information. Could
>>>       it be something like BSD version4?
>>
>>
>>
>> I've had a quick look at the CSA data collection patches. To get the 
>> discussion started, here are my comments:
>>
>>
>>> --- linux.orig/drivers/block/ll_rw_blk.c        2004-08-13 
>>> 22:36:16.000000000 -0700
>>> +++ linux/drivers/block/ll_rw_blk.c     2004-08-18 12:07:10.000000000 
>>> -0700
>>> @@ -1948,10 +1950,12 @@
>>>
>>>        if (rw == READ) {
>>>                disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
>>> +               current->rblk += nr_sectors;
>>>                if (!new_io)
>>>                        disk_stat_inc(rq->rq_disk, read_merges);
>>>        } else if (rw == WRITE) {
>>>                disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
>>> +               current->wblk += nr_sectors;
>>>                if (!new_io)
>>>                        disk_stat_inc(rq->rq_disk, write_merges);
>>>        }
>>
>>
>>
>> Andi Kleen's comment on the ELSA patch also applies here - most writes
>> will get accounted to pdflushd. See
>>
>> http://www.lib.uaa.alaska.edu/linux-kernel/archive/2004-Week-31/0047.html
>>
>> for his comment.
> 
> 
> I need more time on this. :)
> 
>>
>>
>>> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
>>> +++ linux/include/linux/csa_internal.h  2004-08-19 15:19:05.000000000 
>>> -0700
>>
>>
>> [...]
>>
>>> +#else  /* CONFIG_CSA || CONFIG_CSA_MODULE */
>>> +
>>> +#define csa_update_integrals()         do { } while (0);
>>> +#define csa_clear_integrals(task)      do { } while (0);
>>> +#endif /* CONFIG_CSA || CONFIG_CSA_MODULE */
>>
>>
>>
>> I suppose the semicolons are unintentional.
> 
> 
> Good catch! I fixed this in our internal tree.
> 
>>
>>
>>> --- linux.orig/include/linux/sched.h    2004-08-19 15:17:52.000000000 
>>> -0700
>>> +++ linux/include/linux/sched.h 2004-08-19 15:19:05.000000000 -0700
>>
>>
>> [...]
>>
>>> @@ -525,6 +527,10 @@
>>>
>>> /* i/o counters(bytes read/written, blocks read/written, #syscalls, 
>>> waittime */
>>>         unsigned long rchar, wchar, rblk, wblk, syscr, syscw, bwtime;
>>> +#if defined(CONFIG_CSA) || defined(CONFIG_CSA_MODULE)
>>> +       unsigned long csa_rss_mem1, csa_vm_mem1;
>>> +       clock_t csa_stimexpd;
>>> +#endif
>>
>>
>>
>> These probably need to be u64, otherwise they might easily overflow 
>> within
>> a view seconds on 32 bit platforms.
> 
> 
> Will fix it.
> 
>>
>>
>>> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
>>> +++ linux/include/linux/acct_eop.h      2004-08-19 18:48:44.000000000 
>>> -0700
>>
>>
>>
>> This should probably be unified with BSD accounting to a general 
>> accounting
>> hook.
> 
> 
> Do you suggest to merge acct_eop.h into acct.h? It sounds good to me!
> 
> Thanks!
>  - jay
> 
>>
>>
>> Tim
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by BEA Weblogic Workshop
>> FREE Java Enterprise J2EE developer tools!
>> Get your free copy of BEA WebLogic Workshop 8.1 today.
>> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
>> _______________________________________________
>> Lse-tech mailing list
>> Lse-tech@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

