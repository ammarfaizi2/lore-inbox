Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVC3TU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVC3TU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVC3TSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:18:08 -0500
Received: from [195.23.16.24] ([195.23.16.24]:24506 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262411AbVC3TPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:15:12 -0500
Message-ID: <424AFA98.9080402@grupopie.com>
Date: Wed, 30 Mar 2005 20:14:32 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shankar Unni <shankarunni@netscape.net>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org, bunk@stusta.de,
       akpm@osdl.org
Subject: Re: Do not misuse Coverity please
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <OofSaT76.1112169183.7124470.khali@localhost> <d2er4p$qp$1@sea.gmane.org>
In-Reply-To: <d2er4p$qp$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shankar Unni wrote:
> Jean Delvare wrote:
> 
>>     v = p->field;
>>     if (!p) return;
>>
>> can be seen as equivalent to
>>
>>     if (!p) return;
>>     v = p->field;
> 
> 
> Heck, no.
> 
> You're missing the side-effect of a null pointer dereference crash (for 
> p->field) (even though v is unused before the return). The optimizer is 
> not allowed to make exceptions go away as a result of the hoisting.

I just had to try this out :)

Using gcc 3.3.2 this code sample:

> struct test {
>   int code;
> };
> 
> int test_func(struct test *a)
> {
>   int ret;
>   if (!a) return -1;
>   ret = a->code;
>   return ret;
> }

is compiled into:

>    0:   8b 54 24 04             mov    0x4(%esp,1),%edx
>    4:   83 c8 ff                or     $0xffffffff,%eax
>    7:   85 d2                   test   %edx,%edx
>    9:   74 02                   je     d <test_func+0xd>
>    b:   8b 02                   mov    (%edx),%eax
>    d:   c3                      ret

whereas this one:

> int test_func(struct test *a)
> {
>   int ret;
>   ret = a->code;
>   if (!a) return -1;
>   return ret;
> }

is simply compiled into:

>    0:   8b 44 24 04             mov    0x4(%esp,1),%eax
>    4:   8b 00                   mov    (%eax),%eax
>    6:   c3                      ret

It seems that gcc is smart enough to know that after we've dereferenced 
a pointer, if it was NULL, it doesn't matter any more. So it just 
assumes that if execution reaches that "if" statement then the pointer 
can not be NULL at all.

So the 2 versions aren't equivalent, and gcc doesn't treat them as such 
either.

Just a minor nitpick, though: wouldn't it be possible for an application 
to catch the SIGSEGV and let the code proceed, making invalid the 
assumption made by gcc?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
