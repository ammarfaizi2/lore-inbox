Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbUK3ViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbUK3ViV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUK3Vh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:37:58 -0500
Received: from [194.90.79.130] ([194.90.79.130]:53773 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262331AbUK3Vhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:37:32 -0500
Message-ID: <41ACE816.50104@argo.co.il>
Date: Tue, 30 Nov 2004 23:37:26 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2004 21:37:28.0985 (UTC) FILETIME=[CA86E890:01C4D724]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:

>>you're describing the deadlock here: all memory is full, no process 
>>which allocates memory can make any progress.
>>    
>>
>
>Yes they, can: the allocation will fail, function will return -ENOMEM,
>malloc will return NULL, pagefault will fail with OOM.  This is
>progress, though not the best sort.  It is most certainly _not_ a
>deadlock.
>
>  
>
Looks like we are in a deadlock here :)

However you choose to call it, it is unacceptable IMO.

>>This is not a true oom situation: there can be plenty of memory in
>>dirty pagecache which we could reclaim if we had that tiny bit of
>>reserve memory.
>>    
>>
>
>The amount of reserved memory that would be needed depends upon the
>filesystem.  Some filesystems would need only very little to be able
>to free some memory, some would need a lot (e.g. a bzip2 compressing
>filesystem).  There's no magic solution with reserving memory.
>  
>
So the userspace filesystem would pass that amount to the kernel. It's 
not pretty, but it is workable.

>And this is not unique to userspace filesystems, as Rik van Riel
>pointed out earlier, network filesystems are also prone to deadlock:
>
>http://lkml.org/lkml/2004/11/27/81
>
>  
>
This looks like a bug to me. Maybe jiggling the thresholds would help.

>>>I looked at ramfs, it isn't even limited.  You can easily crash your
>>>system just by filling it up with data, but no deadlock will happen.
>>> 
>>>
>>>      
>>>
>>Right. But ramfs doesn't call a userspace process which calls the kernel 
>>right back.
>>    
>>
>
>Doesn't matter one little whit.  The end result is the same: Out Of
>Memory, which is _not_ equivalent to deadlock.  Please think it over.
>  
>
The situation with userspace filesystems is:

  some process allocates memory, blocking on kswapd as memory is full
  kswapd calls userspace filesystem to free memory
  userspace filesystem calls kernel, which allocates memory and blocks 
on kswapd
  eventually all processes in the system block on kswapd

I have observed (and fixed) this on a real system.

with ramfs, once it accounts for memory, there would be no deadlock and 
no oom.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

