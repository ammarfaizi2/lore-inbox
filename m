Return-Path: <linux-kernel-owner+w=401wt.eu-S1755229AbXAAQJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbXAAQJz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbXAAQJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:09:55 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:55224 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbXAAQJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:09:55 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
Date: Mon, 1 Jan 2007 17:09:46 +0100
User-Agent: KMail/1.9.5
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <88880.94256.qm@web55601.mail.re4.yahoo.com>
In-Reply-To: <88880.94256.qm@web55601.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011709.48349.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 1. January 2007 07:37, Amit Choudhary wrote:
> --- Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > #define kfree_nullify(x) do { \
> > 	if (__builtin_constant_p(x)) { \
> > 		kfree(x); \
> > 	} else { \
> > 		typeof(x) *__addr_x = &x; \

Ok, I should change that line to 
		typeof(x) *__addr_x = &(x); \

> > 		kfree(*__addr_x); \
> > 		*__addr_x = NULL; \
> > 	} \
> > } while (0)
> > 
> > Regards
> > 
> > Ingo Oeser
> > 
> 
> This is a nice approach but what if someone does kfree_nullify(x+20).

Then this works, because the side effect (+20) is evaluated only once. 
AFAIK __builtin_constant_p() and typeof() are both free of side effects.

 
> I decided to keep it simple. If someone is calling kfree_nullify() with anything other than a
> simple variable, then they should call kfree().

kfree_nullify() has to replace kfree() to be of any use one day. So this is not an option.

Anybody thinking of "Hey, this must be NULL afterwards!", will set it to NULL himself.
Anybody else doesn't know or care about it, which is the case we like to catch.

> But definitely an approach that takes care of all 
> situations is the best but I cannot think of a macro that can handle all situations. The simple
> macro that I sent earlier will catch all the other usage at compile time. 

The problems I see are:
1. parameter to kfree is a value not a pointer 
    -> solved by using a macro instead of function, 
         but generate new (the other) problems
    -> take the address of the value there.
2. possible side effects of macro parameter usage 
   -> solved by assigning once only and using typeof
3. Constants don't have an address 
   -> need to check for constant

So apart from missing braces before taking the address, I don't see
any problem with my solution :-)

Should I send a patch?

> Please let me know if I have missed something.

I reviewed it and you missed side effects (kfree(x); x = NULL).

Regards

Ingo Oeser
