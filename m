Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUCJNPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 08:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUCJNPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 08:15:25 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:23301 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP id S262597AbUCJNPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 08:15:20 -0500
Date: Wed, 10 Mar 2004 14:15:11 +0100 (CET)
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
Subject: Re: stack allocation and gcc
To: jkroon@cs.up.ac.za
Cc: filia@softhome.net, linux-kernel@vger.kernel.org
In-Reply-To: <404F104C.2030206@cs.up.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20040310131514.B448A2BFE@etpmod.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


0x68 (hex) == 104 (dec)

Regards,
Bart


On 10 Mar, Jaco Kroon wrote:
> Hi Ihar,
> 
> In your code you have 3 buffers, one in the mani branch of 32 bytes
> and one of 32 bytes in each of the sub branches.  This adds up to a
> total of 64 bytes since as you say, the two buffers named buf2[32]
> can be shared.  Thus it is 32 bytes for buf and 32 bytes for the
> shared buffer.  Now if you look at the function startup code:
> 
>    0:   55                      push   %ebp
>    1:   89 e5                   mov    %esp,%ebp
>    3:   83 ec 68                sub    $0x68,%esp
> 
> THe push saves the frame pointer (ebp).  The mov sets up the new stack 
> frame and the sub allocates space of 68 bytes on the stack, 4 bytes
> more than the expected 64, this is probably for temporary storage
> required somewhere in the function.  As such, gcc does not allocate
> 32 bytes too many (at least not on i386, but probably not on other
> architectures either).
> 
> Jaco
> 
> Ihar 'Philips' Filipau wrote:
> 
>> Hello All!
>>
>>    [ please cc: me ]
>>
>>    I have observed funny behaviour of both gcc 2.95/322 on ppc32 and 
>> i686 platforms.
>>
>>    Have written this routine and compiled it with 'gcc -O2':
>>
>> int a(int v)
>> {
>>         char buf[32];
>>
>>         if (v > 5) {
>>                 char buf2[32];
>>                 printf( buf, buf2 );
>>         } else {
>>                 char buf2[32];
>>                 printf( buf, buf2 );
>>         }
>>         return 1;
>> }
>>
>>    I expected that stack on every branch of 'if(v>5)' will be 
>> allocated later - but seems that gcc allocate stack space once and in 
>> this case it will 'overallocate' 32 bytes - 'char buf2' will be 
>> allocated twice for every branch. On i686 gcc allocates 108 bytes, on 
>> ppc32 it allocates 116 bytes. (additional space seems to be induced
>> by printf() call)
>>    Adding to this routine something like 'do { char a[32]; } 
>> while(0);' several times shows that stack buffers are not reused -
>> and allocated for every this kind of context separately.
>>
>>    As to my understanding - since this buffers do live in different 
>> mutually exclusive contextes - they can be reused. But this seems to 
>> be not case. Waste of precious kernel stack space - and waste of
>> d-cache.
>>
>>    I have read 'info gcc' - but found nothing relevant to this.
>>    I've checked ppc abi - but found no limitations to reuse of stack 
>> space.
>>
>>    Is it expected behaviour of compiler? gcc feature?
>>
>>    [ I have created macro which opens into inline function call which 
>> utilizes va_list - on ppc32 va_list adds at least 32 bytes to stack 
>> use. Seems to be bad idea for kernel-space, since every use if macro 
>> adds to stack use (10 macro calls == 320 bytes). Easy to rewrite to 
>> not to use va_list - but have I *NO* stack allocation check script in 
>> place - this stuff could easily get into production release. Not nice. ]
>>
>>    disassembling outputs:
>>
> ===========================================
> This message and attachments are subject to a disclaimer. Please refer
> to www.it.up.ac.za/documentation/governance/disclaimer/ for full
> details. Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule
> onderhewig. Volledige besonderhede is by
> www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
> ===========================================
> 

-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
