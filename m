Return-Path: <linux-kernel-owner+w=401wt.eu-S932381AbXAGIqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbXAGIqw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 03:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbXAGIqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 03:46:52 -0500
Received: from web55613.mail.re4.yahoo.com ([206.190.58.237]:20113 "HELO
	web55613.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932381AbXAGIqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 03:46:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=oBH8/TKE24cubIy0CbMNaowo8gSgPnxOcouv93WI1WfPzT3V+MitybtfgnlBRW1myA7O2P31Ti6M9DsI4lS9rddHPKZNPwdAYF5c6EOvcXfpKG8XQ86sG4x/YKyBJaDmjS5quhcyUiPx8zFccRcY4NoXFBnMyszHrs43oiRmc6k=;
X-YMail-OSG: Eh60dnYVM1mbE.4lz.zuvp65x5KzEckn3_14XEqrJtc.iTMJKwnNHfR5Vl_Z8WjKyA--
Date: Sun, 7 Jan 2007 00:46:50 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <585769.17683.qm@web55613.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>On 1/1/07, Amit Choudhary <amit2030@xxxxxxxxx> wrote:

>>    +#define KFREE(x) \
>>    + do { \
>>    + kfree(x); \
>>    + x = NULL; \
>>    + } while(0)


>>NAK until you have actual callers for it. CONFIG_SLAB_DEBUG already
>>catches use after free and double-free so I don't see the point of
>>this.

Well, I am not proposing this as a debugging aid. The idea is about correct programming, atleast
from my view. Ideally, if you kfree(x), then you should set x to NULL. So, either programmers do
it themselves or a ready made macro do it for them.

In my opinion, the programmers may welcome the macro that does it for them.

There is another good part about it that results in better programming and shorter code.

Consider an array x[10]. I allocate memory for all of them and then kfree them - kfree(x[0]),
kfree(x[1]), etc. But I do not set these elements to NULL. So,

x[0] = _location_0_already_freed
x[1] = _location_1_already_freed

... and so on...

Now, consider that when I try to allocate memory again, memory allocation fails at x[2]. So, we
have now,

x[0] = _valid_location_0
x[1] = _valid_location_1
x[2] = NULL
x[3] = _location_3_already_freed

So, now to avoid error path leak I have to free all the allocated memory. For this I have to
remember where the allocation failed because I cannot do kfree(x[3]) because it will crash.

You can easily visualize that how KFREE would have helped. Since, I have already KFREE'D them
earlier, x[3] is guaranteed to be NULL and I can free the entire array 'x' wihtout worrying.

So, the code becomes simpler.

Now, consider that there are two more arrays like 'x' being used in the same function. So, now we
have 'x', 'y', 'z' all allocating memory in the same function. Memory allocation can fail at
anytime. So, not only do I have to remember the element location where the allocation failed but
also the array that contains that element.

So, to avoid error path leak, we will have something like this (assume same number of elements in
all arrays):

case z_nomem:
              free_from_0_to_i
              free_all_'y'
              free_all_'x'
              return;

case y_nomem:
              free_from_0_to_i
              free_all_'x'
              return;

case x_nomem:
              free_from_0_to_i
              return;

However, if the programmer would have used KFREE, then the error path leak code have been shorter
and easier.

case nomem:
              free_all_'z'
              free_all_'y'
              free_all_'x'
              return;

I hope that I have made my point but please let me know if I have missed out something or made
some assumption that is not correct.

Regards,
Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
