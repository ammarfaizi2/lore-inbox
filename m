Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVFBAOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVFBAOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVFBAN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:13:58 -0400
Received: from mail.tmr.com ([64.65.253.246]:4486 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261544AbVFBANE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:13:04 -0400
Message-ID: <429E4F05.7060201@tmr.com>
Date: Wed, 01 Jun 2005 20:12:53 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
References: <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <429E062B.60909@tmr.com> <20050601220242.GC31585@merlin.emma.line.org>
In-Reply-To: <20050601220242.GC31585@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>On Wed, 01 Jun 2005, Bill Davidsen wrote:
>
>  
>
>>>It's a matter of enforcing write order. In how far such ordering
>>>constraints are propagated by file systems, VFS layer, down to the
>>>hardware, is the grand question.
>>>      
>>>
>>The problem is that in many options required to make that happen in the 
>>o/s, hardware, and application are going to kill performance. And even 
>>if you can control order of write, unless you can get write to final 
>>non-volatile media control you can get a sane database but still lose 
>>transactions.
>>
>>If there was a way for the o/s to know when a physical write was done 
>>other than using flushes to force completion, then overall performance 
>>could be higher, but individual transaction might have greater latency. 
>>And the app could use fsync to force order of write as needed. In many 
>>cases groups of writes can be done in any order as long as they are all 
>>done before the next logical step takes place.
>>    
>>
>
>I have a déjà-vu, and I do believe that this discussion has taken place
>in this list before, perhaps with a slightly different alignment, and
>likely in the context of mail transfer agents and perhaps synchronous
>directory (data) updates (file creation and such). Exposing a bit of the
>queueing to the user space through new syscalls may be an interesting
>experiment, although I do not have the resources to provide code.
>Something like fsync() that doesn't flush the whole file system (which
>appears to be the most common implementation) but tracks what is needed,
>and that returns when data for a given file is on disk.
>  
>

What I had in mind was not a "push" to flush anything anywhere, but 
rather a watch. As a hypothetical, I open a file and every time a 
write() is done a counter is incremented in the fd. That's the easy 
part. Then every time a physical write is completed the count is 
reduced. To allow for write combining the count could be in bytes rather 
than syscalls and physical operations. That's the hard part, I don't 
think the hardware is telling. In addition obviously writes may be 
combined between i/o related to several fds. But if that could be done, 
then fsync becomes "wait until my buffered byte count drops to zero," 
which could be an ioctl. Just having such a checkpoint would address 
some of the data coherency issues.

AFAIK this isn't possible with common ATA devices, and it clearly 
doesn't address every desirable feature. In spite of that, if someone 
better qualified to assess the problems and benefits cares to comment, 
fine. If not, at least I think I explained what I was thinking more clearly.

>  
>
>>This would change the meaning of fsync from "force out the data" to 
>>"wait for the data to be written" in some implementations.
>>    
>>
>
>Naming suggestion: flazysync()
>
>  
>


-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

