Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWION1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWION1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWION1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:27:49 -0400
Received: from smtpout.mac.com ([17.250.248.184]:47829 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751411AbWION1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:27:48 -0400
In-Reply-To: <1158302578.4312.166.camel@pmac.infradead.org>
References: <200609150901.33644.ismail@pardus.org.tr> <1158302578.4312.166.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <96EE18FA-1682-4C73-B204-98DA3F525F90@mac.com>
Cc: Ismail Donmez <ismail@pardus.org.tr>, LKML <linux-kernel@vger.kernel.org>,
       mchehab@infradead.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: __STRICT_ANSI__ checks in headers
Date: Fri, 15 Sep 2006 09:27:32 -0400
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15, 2006, at 02:42:58, David Woodhouse wrote:
> On Fri, 2006-09-15 at 09:01 +0300, Ismail Donmez wrote:
>> Kernel headers currently uses __STRICT_ANSI__ check before  
>> defining a long
>> long variable because ANSI-C doesn't allow long long variables.  
>> But this
>> seems to harsh because any project including linux/videodev2.h  
>> ( and similar
>> ones ) and using -ansi flag will not compile because some types  
>> like __s64
>> will not be defined.
>
> One possible fix is to let videodev2.h use int64_t, and in userspace
> they can include <stdint.h>
>
> Another is just to declare videodev2.h incompatible with -ansi, or  
> maybe
> just omit 'value64' from the union if __STRICT_ANSI__ is defined, and
> replace it with an array of two __s32s.

A mildly better alternative is (on 32-bit architectures, 64-bit archs  
have no problem) change the typedef from this:

> #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
> typedef unsigned long long __u64;
> typedef   signed long long __s64;
> #endif

to this:

> #if defined(__GNUC__)
> __extension__ typedef unsigned long long __u64;
> __extension__ typedef   signed long long __s64;
> #endif

GCC always supports __extension__ to indicate not to warn or error on  
GCC-only extensions.  You only have to declare __extension__ on the  
typedef, any uses are considered OK.  I think this also works for  
code-expressions like this:

> int x = __extension__ ({ foo(); 1; })

but I don't remember exactly.  In certain really complex expressions  
GCC can get confused and give bogus errors, but as long as you don't  
start sprinkling it in macros you should be fine.

Cheers,
Kyle Moffett

