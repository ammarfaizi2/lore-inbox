Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTKZOdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 09:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKZOdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 09:33:25 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:59529 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261863AbTKZOdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 09:33:23 -0500
Message-ID: <3FC4B9A2.7050204@softhome.net>
Date: Wed, 26 Nov 2003 15:33:06 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos> <3FC3E2F4.4080809@softhome.net> <Pine.LNX.4.53.0311260745190.9601@chaos> <3FC4A8BA.9070907@softhome.net> <20031126132719.GP8039@holomorphy.com>
In-Reply-To: <20031126132719.GP8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Nov 26, 2003 at 02:20:58PM +0100, Ihar 'Philips' Filipau wrote:
> 
>>  So what do you use then in user space to reliably allocate memory?
>>  As to me - memory is a resource. Is it virtual or is it physical - it 
>>is still resource. And I need to allocate part of this resource.
>>  malloc() uses brk() inside. But brk() is "implementation details". I 
>>honestly do not care about them - I just want to be sure that what ever 
>>resource I have allocated - I can use it afterwards until I shall free 
>>it. POSIX even doesn't mention brk() BTW.
>>  If you can hint me any other method to allocate memory without 
>>surprises - I will really appreciate.
> 
> 
> Non-overcommit is one such method at the kernel level.
> mlockall(MCL_CURRENT|MCL_FUTURE) is another (requiring support at both
> levels, in addition to administrative grants of privilege).
> 

   "requiring support at both levels" - what do you mean by this?


   In other words, right after I have allocated all memory I need for 
functioning properly, I can call mlockall(MCL_CURRENT) - and memory of 
my app will be guarantied to be present in memory?
   If I have understood from man - it will not be swapped out?
   Yeah... Nice. Cool. I have no swap in any way ;-)
   I do not need that heavy gun: as I have said looser term of memory 
being really allocated before malloc() returns - is enough for me. But 
as I have guessed overcommit_memory doesn't guarantie this either.

   But it looks like this is more appropriate solution for my situation. 
(more apropriate comparing to overcommit_memory)
   In critical pathes we use only pool based allocators - so we can lock 
them in RAM.

   How can I tell the limit of the RAM which can be locked?
   My test had shown that single application can lock 112MB of RAM, but 
fails to lock 128MB of RAM. (I have 256MB phy RAM - We just cannot find 
smaller memory modules on market in any way :-))
   Is it limited to less than half of physical RAM?
   This would be Ok for me in any way.

   ...

   Little bit more test results (2.4.18, 256MB RAM, Motorola's 
PowerQuiccIII 8280):
   overcommit_memory==0 (default): three memory eater apps run ok. 
fourth app which tryes to mlock() /successfully/ allocated 64MB of 
memory hang my box.
   overcommit_memory==-1: three memory eater apps run ok. fourth app 
fails to allocate its memory. All successful memory allocations do mlock 
Okay. As by my incomplete tests.

   That sounds like results ;-)
   Thanks everyone for help and this results!

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

