Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVINBc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVINBc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 21:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVINBcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 21:32:55 -0400
Received: from mail.servus.at ([193.170.194.20]:27908 "EHLO mail.servus.at")
	by vger.kernel.org with ESMTP id S932559AbVINBcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 21:32:55 -0400
Message-ID: <43277F54.1060508@oberhumer.com>
Date: Wed, 14 Sep 2005 03:39:32 +0200
From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       John Reiser <jreiser@bitwagon.com>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
References: <43273CB3.7090200@oberhumer.com> <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org> <4327611D.7@oberhumer.com> <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org>
X-no-Archive: yes
X-Oberhumer-Conspiracy: There is no conspiracy. Trust us.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 14 Sep 2005, Markus F.X.J. Oberhumer wrote:
> 
>>>You seem to be expecting that the address be aligned "before the return 
>>>address push", which is a totally different thing. Quite frankly, I don't 
>>>know which one gcc prefers or whether there's an ABI specifying any 
>>>preferences.
>>
>>I'm pretty sure that on both amd64 and i386 the alignment has to be 
>>_before_ the address push from the call, though I cannot find any exact ABI 
>>specs at the moment. Experts please advise.
>>
>>What do you get when running this slightly modified version of your test 
>>program? My patch would fix the alignment of Aligned16 here.
> 
> 
> Your test program does seems to imply that gcc wants the alignment before
> the return address (ie it prints out an address that is 4 bytes offset),
> but on the other hand I'm not even sure how careful gcc is about this
> alignment thing at all.
> 
> In the "main()" function, gcc will actually generate a "andl $-16,%esp" to 
> force the alignment, but ot in the handler function. Just a gcc special 
> case? Random luck?

I think that main() is a known name and therefore gets a special treatment 
- if you rename main() to foo() and then compare the disassembly you will 
see that the "andl $-16,%esp" has vanished.

OTOS the "andl" in main() exactly does show how gcc wants the stack to be 
aligned, i.e. _before_ the call-address push.

Another argument would be the 16-byte aligned stack-setup of glibc - please 
try runing this tiny program under gdb and look at "info reg":

     asm(".globl main\n main:\n int $3\n");

All of this would indicate that the kernel should get fixed.

~Markus

> 
> Andi - you know the gcc people, is there some documented rules somewhere? 
> How does gcc itself try to align the stack when it generates the calls?
> 
> 		Linus
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
