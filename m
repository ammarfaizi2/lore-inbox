Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVDFMSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVDFMSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVDFMSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:18:24 -0400
Received: from [195.23.16.24] ([195.23.16.24]:62884 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262143AbVDFMPd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:15:33 -0400
Message-ID: <4253D2CD.2040600@grupopie.com>
Date: Wed, 06 Apr 2005 13:15:09 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Roland Dreier <roland@topspin.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
References: <4252BC37.8030306@grupopie.com> <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost> <521x9pc9o6.fsf@topspin.com> <Pine.LNX.4.62.0504052148480.2444@dragon.hyggekrogen.localhost> <20050406112837.GC7031@wohnheim.fh-wedel.de>
In-Reply-To: <20050406112837.GC7031@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Tue, 5 April 2005 22:01:49 +0200, Jesper Juhl wrote:
> 
>>On Tue, 5 Apr 2005, Roland Dreier wrote:
>>
>>
>>>    > or simply
>>>    > 	if (!(ptr = kcalloc(n, size, ...)))
>>>    > 		goto out;
>>>    > and save an additional line of screen realestate while you are at it...
>>>
>>>No, please don't do that.  The general kernel style is to avoid
>>>assignments within conditionals.

FWIW, I also agree that assignments within conditionals are evil and 
hurt readability a lot, for no actual benefit.

Since one of the advantages of this cleanup is improve readability, it 
would be counterproductive to do this.

To explain why this cleanup improves readability take the following 
sample from sound/usb/usx2y/usbusx2yaudio.c (a random sample):

> 		us = kmalloc(sizeof(*us) + sizeof(struct urb*) * NOOF_SETRATE_URBS, GFP_KERNEL);
> 		if (NULL == us) {
> 			err = -ENOMEM;
> 			goto cleanup;
> 		}
> 		memset(us, 0, sizeof(*us) + sizeof(struct urb*) * NOOF_SETRATE_URBS); 

In this case you have to read the size portion of the kmalloc and the 
memset carefully to make sure that they are exactly the same, whereas in 
code like this:

> 		us = kcalloc(1, sizeof(*us) + sizeof(struct urb*) * NOOF_SETRATE_URBS, GFP_KERNEL);
> 		if (NULL == us) {
> 			err = -ENOMEM;
> 			goto cleanup;
> 		}

it is self-evident that the whole area is being cleared. It also leaves 
a smaller room for mistakes.

I still don't like the kcalloc API with a "1" argument. Not only most of 
these allocations fall into that case, but also kmalloc_zero (or 
kmalloc_zeroed) is much more clear than kcalloc that changes just one 
letter from kmalloc. Someone reading fast through the code may kcalloc 
as if it were kmalloc.

More over, passing an extra parameter waste a few more bytes of code. I 
know is not much, but if the cleanup will address hundreds of these then 
it starts to be something to consider.

However "calloc" is the standard C interface for doing this, so it makes 
some sense to use it here as well... :(

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
