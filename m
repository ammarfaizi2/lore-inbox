Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSLZVeq>; Thu, 26 Dec 2002 16:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSLZVep>; Thu, 26 Dec 2002 16:34:45 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:27556 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264617AbSLZVeh>;
	Thu, 26 Dec 2002 16:34:37 -0500
Message-ID: <3E0B77D5.2060002@colorfullife.com>
Date: Thu, 26 Dec 2002 22:42:45 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: anton@samba.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5 fast poll on ppc64
References: <200212262055.VAA28874@harpo.it.uu.se>
In-Reply-To: <200212262055.VAA28874@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

>>struct a1 { int a; char b; short c[];};
>>struct a2 { int a; char b; short c[1];};
>>
>>   sizeof(struct a{1,2}) is 8.
>>   offsetof(struct a{1,2}, c) is 6.
>>
>>--> sizeof(struct a1) != offsetof(struct a2, c)
>>    
>>
>
>Oh dear. I checked my C9x draft copy and you seem to be right.
>The standard states that sizeof(struct a1) == offsetof(struct a1, c),
>but both gcc (2.95.3 and 3.2) and Intel's icc (7.0) get it wrong on x86:
>they make sizeof(struct a1) == 8 but offsetof(struct a1, c) == 6.
>  
>
I've filed a gcc bug, no 9058: As the reply, I got a mail from Joseph 
Myers with links to TC to the C99 standard:
http://std.dkuug.dk/JTC1/SC22/WG14/www/docs/n983.htm
http://std.dkuug.dk/JTC1/SC22/WG14/www/docs/n987.htm

>  
>
>>I agree. Should we fix the kmalloc allocations, too?
>>
>>-	pp = kmalloc(sizeof(struct poll_list)+
>>+	pp = kmalloc(offsetof(struct poll_list,entries)+
>>			sizeof(struct pollfd)*
>>			(i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i),
>>				GFP_KERNEL);
>>    
>>
>
>Yes, this should be changed as you suggest. The old code only
>works in C99-compliant implementations, but we now know that both
>gcc and icc get this wrong, so it seems prudent to revert to
>the classical formulation, using the 'entries[0]' declaration
>syntax and offsetof() instead of sizeof().
>  
>
I found an even simpler formula:

    offsetof(struct poll_list,entries[i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i];

I'll ask the gcc guys if that formula is a portable solution.

--
    Manfred

