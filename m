Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUHAOB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUHAOB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHAOB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:01:26 -0400
Received: from justchat.medium.net ([83.120.2.52]:58546 "EHLO
	smtp.mail.service.medium.net") by vger.kernel.org with ESMTP
	id S265973AbUHAOBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:01:22 -0400
Message-ID: <410CF7AA.2020604@baldauf.org>
Date: Sun, 01 Aug 2004 16:01:14 +0200
From: =?ISO-8859-1?Q?Xu=E2n_Baldauf?= 
	<xuan--2004.08.01--linux-kernel--vger.kernel.org@baldauf.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a2) Gecko/20040714
X-Accept-Language: de-de
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software RAID 5 and crashes
References: <410CC397.6010509@baldauf.org> <16652.55805.900685.826943@cse.unsw.edu.au>
In-Reply-To: <16652.55805.900685.826943@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Sunday August 1, xuan--2004.08.01--linux-kernel--vger.kernel.org@baldauf.org wrote:
>  
>
>>Hello,
>>
>>I have been extensively searching for documentation and mailing lists, 
>>but was yet unable to answer this question:
>>
>>Does Linux software RAID 5 (or RAID 4) do ordered writes? (data stripes 
>>first, then parity stripes)
>>    
>>
>
>No, it doesn't impose any ordering between writes of parity and data
>in the same stripe, and it would not have any material effect on any
>outcomes if it did.
>  
>
I disagree. :-)

>  
>
>>Because if the writes are not ordered, parity stripes could be written 
>>before data stripes. If the system crashes at this time, reconstruction 
>>will  try to reconstruct the parity stripes by using the wrong (old) 
>>data stripes.
>>
>>If the writes are ordered, crashes after the write of the data stripe 
>>but before the write to the parity stripe do not harm.
>>    
>>
>
>When the system crashes, the RAID5 manager assume that all data blocks
>are correct and all parity blocks are suspect.  It checks all parity
>blocks against corresponding data and corrects  those that don't
>match.
>If a write is "in progress" - i.e. it has started but not all data and
>parity has been written, then either the "old" data or the "new" data
>are equally correct.  The only thing that needs to be guaranteed after
>a crash, and the only thing that can be guaranteed, is that any data
>that has been reported as "safe-in-storage" really is safe.  That is
>all journalling filesystems, or anything else, assume.
>
>Hope that helps.
>  
>
Yes, thank you, the clear statement, that writes are not ordered, helps. 
:-) It is also relieving to read that data blocks are always preferred 
to parity blocks, so that data blocks never can become scrambled by 
unmatching other data blocks and parity blocks (at least in non-degraded 
mode).

Unfortunately, it still does not make me satisfied, because: The 
asymmetry of "all data blocks are correct, all parity blocks are 
suspect" should be exploited.
Consider 4 disks joined as RAID 5. There are 4 stripes (s0, s1, s2, s3), 
where s3 is the parity stripe.

    * <>Example 0: s3,s2,s1 are written to disk, while s0 is not written
      to disk for some reason. The system crashes. What happens at
      reconstruction? s3 gets replaced by s0 XOR s1 XOR s2. s0 contains
      old (read: wrong) data.
    * Example 1: s0,s1,s2 are written to disk, while s3 is not written
      to disk for some reason. The system crashes. What happens at
      reconstruction? s3 gets replaced by s0 XOR s1 XOR s2. s0 does not
      contain old data. The stripe which contains the old data (s3) is
      replaced anyway during reconstruction.

If we now consider, that for each disk (as member of a RAID 5), there 
are parity stripes and there are data stripes. Doesn't it make sense to 
prefer data blocks over partiy blocks when writing, just to get more 
cases of "example 1" against "example 0" than without this preference?

One could even imagine to intensionally postpone the parity block 
writing for some time in favour of peak throughput. The RAID 5 device 
looses its rendundancy for some bounded time at a bounded region of its 
space, but this may be acceptable for certain applications, I think.

>NeilBrown
>
>  
>
Xuân Baldauf.


