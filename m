Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263198AbTDRS2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTDRS2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:28:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6821 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263198AbTDRS2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:28:47 -0400
Message-ID: <3EA0469D.7090602@pobox.com>
Date: Fri, 18 Apr 2003 14:40:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Trivial Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup
References: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com> <3EA02E55.80103@pobox.com> <Pine.LNX.4.53.0304181323400.22493@chaos>
In-Reply-To: <Pine.LNX.4.53.0304181323400.22493@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Fri, 18 Apr 2003, Jeff Garzik wrote:
> 
> 
>>Linus Torvalds wrote:
>>
>>>On Fri, 18 Apr 2003, Jeff Garzik wrote:
>>>
>>>
>>>>You should save the strlen result to a temp var, and then s/strcpy/memcpy/
>>>
>>>
>>>No, you should just not do this. I don't see the point.
>>
>>
>>strcpy has a test for each byte of its contents, and memcpy doesn't.
>>Why search 's' for NULL twice?
>>
>>	Jeff
> 
> 
> Because it doesn't. strcpy() is usually implimented by getting
> the string-length, using the same code sequence as strlen(), then
> using the same code sequence as memcpy(), but copying the null-byte
> as well. The check for the null-byte is done in the length routine.
> 
> If you do a memcpy(a, b, strlen(b));, then you are making two
> procedure calls and dirtying the cache twice..

Wrong, because we have to call strlen _anyway_, to provide the size to 
kmalloc.


> A typical Intel procedure, stripped of the push/pops to save
> registers is here....

That's kinda cute.  Why not submit a patch to the strcpy implementation 
in include/asm-i386/string.h?  :)  Ours is shorter, but does have a jump:
         "1:\tlodsb\n\t"
         "stosb\n\t"
         "testb %%al,%%al\n\t"
         "jne 1b"

Which is better?  I don't know; I'm still learning the performance 
eccentricities of x86 insns on various processors.


Related x86 question:  if the memory buffer is not dword-aligned, is 
'rep movsl' the best idea?  On RISC it's usually smarter to unroll the 
head of the loop to avoid unaligned accesses; but from reading x86 asm 
code in the kernel, nobody seems to care about that.  Is the 
unaligned-access penalty so small that the increased code size of the 
head-unroll is never worth it?


> A lot of persons who are unfamiliar with tools other than 'C' think
> that strcpy() is made like this:
> 
> 	while(*dsp++ = *src++)
>                    ;

In fact, that's basically the kernel's non-arch-specific implementation :)

	Jeff



