Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbTCMXRy>; Thu, 13 Mar 2003 18:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbTCMXRp>; Thu, 13 Mar 2003 18:17:45 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30375 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262885AbTCMXRE>; Thu, 13 Mar 2003 18:17:04 -0500
Message-ID: <3E7113E5.2090200@redhat.com>
Date: Thu, 13 Mar 2003 18:27:33 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Haverkamp <markh@osdl.org>,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
References: <20030228133037.GB7473@jiffies.dk>	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>	 <3E6FC8D6.7090005@torque.net> <1047517604.23902.39.camel@irongate.swansea.linux.org.uk> <3E6FDF61.8060708@torque.net>
In-Reply-To: <3E6FDF61.8060708@torque.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> Alan Cox wrote:
> 
>> On Wed, 2003-03-12 at 23:55, Douglas Gilbert wrote:
>>
>>>         /*
>>>          * Limit max queue depth on a single lun to 256 for now.  
>>> Remember,
>>>          * we allocate a struct scsi_command for each of these and 
>>> keep it
>>>          * around forever.  Too deep of a depth just wastes memory.
>>>          */
>>>         if(tags > 256)
>>>                 return;
>>> ....
>>
>>
>>
>> I can see the memory consideration. However the thing can really 
>> handle big
>> queues well. Possibly we should be setting the queue to 512 / 
>> somefunction(volumes)
>> though to avoid the worst case overcommit here
> 
> 
> The situation is different between 2.4 and 2.5 ...
> 
> In 2.4 the per device queue_depth is an unsigned char
> and that number of scsi_cmnd instances are pre-allocated
> in the scsi_build_commandblocks() function. So the worst
> case number of scsi_cmnd instances for all scsi devices
> is always available (at the expense of [wasted] ram).

Correct.

> In 2.5 queue_depth is an unsigned short and a slab
> allocator called "scsi_cmd_cache" is used as required.
> There is some throttle logic (or at least it has been
> talked about) to make sure one scsi_cmnd instance per
> scsi device will always be available.

Not throttle logic, we simply have a struct list_head that we stick one 
command (per host) onto and should it ever need to be used, then in 
scsi_done() when we would normally free a command we are done with we 
instead stick it back on that list head.  That way, memory pressure 
can't kill us, just slow us down.

> I think that comment (probably by Doug Ledford) refers
> to the 2.5 series before the slab allocator was
> introduced.

Yep.


-- 
   Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
          Red Hat, Inc.
          1801 Varsity Dr.
          Raleigh, NC 27606


