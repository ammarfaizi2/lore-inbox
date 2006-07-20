Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWGTIJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWGTIJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 04:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWGTIJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 04:09:00 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:3266 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964836AbWGTII7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 04:08:59 -0400
Date: Thu, 20 Jul 2006 10:07:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Shorty Porty <getshorty_@hotmail.com>
cc: linux-kernel@vger.kernel.org, ricknu-0@student.ltu.se
Subject: RE: [RFC][PATCH] A generic boolean
In-Reply-To: <BAY104-DAV11BD5C0159C7CD7BA10CA3ED610@phx.gbl>
Message-ID: <Pine.LNX.4.61.0607200959020.19497@yvahk01.tjqt.qr>
References: <BAY104-DAV11BD5C0159C7CD7BA10CA3ED610@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
>from the compiler's standpoint. Function that return 'true' for an integer
>type (as opposed to a C++ standard-type bool) should be tested like
>
>  if(SomeFunction())
>
>or
>  if(!SomeFunction())
>
>instead of testing for equality
>
>  if(SomeFunction() == TRUE)
>of
>  if(SomeFunction() == FALSE)
>
>as the former (IMO) is as readable, if not more readable as the latter

Full ACK. What currently bugs me is that there are code places which 
"violate" your suggestion in a different way, i.e.

 void *foo = null_or_not_null_that_is_the_question();
 ...
 if(foo)
      do_bar();

vs

 if(foo == NULL)

>, and it's likely to get optimised better.

Unlikely that it will be better, as the compiler knows that bar() returns 
bool, testing it against TRUE or FALSE does not make a difference to
using "bar()" or "!bar()" respectively.

But I agree. The "!" operator was invented *for a reason*, so we do not 
need ==false.

>That and someone might give true AND return a status by returning neither 
>0 or 1, in which case 

In that case you cannot work with bools at all, because they are not 
guaranteed to be big enough for status codes. Here, 'int' comes into play.
And then func_return_int()==TRUE/FALSE seems strange anyhow. That's like

>> > If this is the case, then wouldn't "long" be preferable to "int"?
>
>Meh, it's all the same.

On x86, it is not. But x86_64 has int=4 bytes and long=8 bytes.
What's wasted is probably the cacheline due to a longer immediate 
integer in the instruction. SPARC64 for example is even more sensitive:
also has int=4 and long=8, but generates a lot more instructions for 'long' 
data shuffling than for 'int', because it has a small instruction size.
And also start to think of 'long long' (resp. int64_t) used somewhere [in 
code] on x86 -- also needs extra ops because the regs are not wide enough.


Jan Engelhardt
-- 
