Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUFFHUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUFFHUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 03:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUFFHUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 03:20:09 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:59809 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S262974AbUFFHUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 03:20:01 -0400
Message-ID: <40C2D5F4.4020803@codeweavers.com>
Date: Sun, 06 Jun 2004 17:29:40 +0900
From: Mike McCormack <mike@codeweavers.com>
Organization: Codeweavers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <40C2B51C.9030203@codeweavers.com> <20040606052615.GA14988@elte.hu>
In-Reply-To: <20040606052615.GA14988@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

Ingo Molnar wrote:

> there are multiple methods in FC1 to turn this off:
> 
> - FC1 has PT_GNU_STACK support and all binaries that have no
>   PT_GNU_STACK program header will have the stock Linux VM layout. 
>   (including executable stack/heap) So by stripping the PT_GNU_STACK 
>   header from the wine binary you get this effect.

As far as we can tell, this alone does not stop the kernel from loading 
stuff at the addresses we need.  Even without PT_GNU_STACK ld-linux.so.2 
and libc are loaded below 0x01000000, which is the region that Wine 
assumes is free.  I think this may be due to prelinking...

We (Codeweavers) build Wine on a Redhat 6.2 based machine, so 
PT_GNU_STACK is not added to the binaries.  They still don't work on 
Fedora Core 1.

> - you get the same effect by setting the personality to PER_LINUX32 via:
> 
> 	personality(PER_LINUX32);
> 
>   this is a NOP on stock x86 Linux, and turns off exec-shield on FC1.

 From the Wine project's POV, there are two problems with that solution:

1) it's not backwards compatible with older binaries

2) it's distribution specific, so other distributions could come up
    with a new method of doing the same thing.

> all these methods were present in FC1 from day 1 on. In fact we
> specifically targetted Wine (and similar applications) with these
> methods to make it easy for them to be built under FC1. (of course
> existing binaries of Wine worked and work fine because they dont have
> PT_GNU_STACK.)

The first thing we knew about exec-shield was when stuff started 
breaking. Perhaps we could work a little more closely when there's a 
possibility that Wine could break due to a new kernel feature?

Ideally the solution to the problem should be backward compatible, and 
not require any change to older binaries for them to work.

>>We developed a hack to work around this problem by creating a staticly
>>linked binary to reserve memory then load ld-linux.so.2 and a
>>dynamically executable into memory manually and run start them.
> 
> 
> while this should work too - why not one of the methods above?

It would be better to argue that with Alexandre Julliard, because he's 
the guy that chooses the solutions.  My guess is for the reasons I 
explained above.

Mike
