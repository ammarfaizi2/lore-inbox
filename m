Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263249AbUCPAiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUCPAez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:34:55 -0500
Received: from alt.aurema.com ([203.217.18.57]:36264 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262885AbUCPA24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:28:56 -0500
Message-ID: <40564A22.5000504@aurema.com>
Date: Tue, 16 Mar 2004 11:28:18 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: John Reiser <jreiser@BitWagon.com>, Micha Feigin <michf@post.tau.ac.il>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com>	<1079198671.4446.3.camel@laptop.fenrus.com>	<4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com>
In-Reply-To: <20040313193852.GC12292@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, Mar 13, 2004 at 11:34:37AM -0800, John Reiser wrote:
> 
>>Arjan van de Ven wrote:
>>
>>>On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
>>>
>>>
>>>>Is it possible to find out what the kernel's notion of HZ is from user
>>>>space?
>>>>It seem to change from system to system and between 2.4 (100 on i386)
>>>>to 2.6 (1000 on i386).
>>>
>>>
>>>if you can see 1000 from userspace that is a bad kernel bug; can you say
>>>where you find something in units of 1000 ?
>>
>>create_elf_tables() in fs/binfmt_elf.c tells every ELF execve():
>>        NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
>>which can be found by crawling through the stack above the pointer
>>to the last environment variable.
> 
> 
> Ugh that should say 100 on x86....
> but..
> param.h:# define USER_HZ        100             /* .. some user interfaces are in "ticks" */
> param.h:# define CLOCKS_PER_SEC (USER_HZ)       /* like times() */
> .....
> that looks like 100 to me.
> 

This horrible hack of converting all tick values to 100 (from 1000) for 
export to user space because a large number of user space programs 
assume that HZ is 100 would NOT be necessary if there was a mechanism 
whereby user space programs could find out how many ticks there are in a 
second instead of having to make assumptions.

I think that providing such a mechanism should be a priority and when 
it's been available for a reasonable amount time (so that the user space 
programs can be converted to using it) USER_HZ should become equal to HZ.

Another alternative would be to stop exporting time as ticks and use 
some standard unit for all systems.  The chosen unit should be small 
enough (e.g. microseconds or mybe even nanoseconds) so that no 
information is lost (which it is in the current implementation) on 
conversion from ticks to these units.  Of course 64 bit integers would 
be needed.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


