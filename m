Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932740AbVINSO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbVINSO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbVINSO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:14:59 -0400
Received: from smtpout.mac.com ([17.250.248.47]:53185 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932423AbVINSO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:14:58 -0400
In-Reply-To: <4328299C.9020904@tmr.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <4328299C.9020904@tmr.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BB99A175-9BC7-4004-896D-7A5A22349861@mac.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Wed, 14 Sep 2005 14:14:37 -0400
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2005, at 09:46:04, Bill Davidsen wrote:
> H. Peter Anvin wrote:
>> Followup to:  <20050902235833.GA28238@codepoet.org>
>> By author:    Erik Andersen <andersen@codepoet.org>
>> In newsgroup: linux.dev.kernel
>>> <uClibc maintainer hat on>
>>> That would be wonderful.
>>> </off>
>>>
>>> It would be especially nice if everything targeting user space  
>>> were to use only all the nice standard ISO C99 types as defined  
>>> in include/stdint.h such as uint32_t and friends...
>> Absolutely not.  This would be a POSIX namespace violation; they  
>> *must* use double-underscore types.
>
> Could you explain why you think it would be a violation to use  
> POSIX types instead of defining our own? That's what the types are  
> for, to avoid having everyone define some slightly conflicting types.
>
> The kernel predates C99, sort of, and it would be a massive but  
> valuable  task to figure out where a type is really, for instance,  
> 32 bits rather than "size of default int" in length, etc, and use  
> POSIX types where they are correct. Fewer things to maintain, and  
> would make it clear when something is 32 bits by default and when  
> it really must be 32 bits.

Argh, it seems I'm going to be giving this example forever!  Here's  
why this won't work.  We want to have sys/stat.h do something like  
the following:

# define __kabi_stat64 stat
# include <kabi/stat.h>
/* Now we expect struct stat to be defined with correct types */

Since struct stat in that case uses fixed-bit-size types, the header  
fine <kabi/stat.h> needs to include a file providing those types.  If  
it used stdint.h types, such as uint32_t, then it would need to  
#include <stdint.h> or provide the stdint.h types itself.  In order  
to remain POSIX compliant, sys/stat.h must not include stdint.h or  
assume that stdint.h is included or that those types were defined by  
the user program.  Therefore, kabi/*.h cannot use the stdint.h types  
at all!  The solution is a separate file, kabi/types.h, which  
properly defines __kabi_[su]{8,16,32,64} which are safe to include  
and reuse anywhere.  Then sys/types.h would look like this:

# include <kabi/types.h>
typedef __kabi_u8 u_int8;
typedef __kabi_s8 int8;
typedef __kabi_u16 u_int16;
typedef __kabi_s16 int16;
[...]

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



