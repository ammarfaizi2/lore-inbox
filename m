Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWFVKhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWFVKhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWFVKhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:37:09 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:28455 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161039AbWFVKhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:37:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hrfe0K0/Y+ywJX925tTonU0/HBwUIzrm+UJ9tw3X3q43IL/yI27zuWY5rF6TtdzIqjM+X1/tuWmbeqmz8S10I4XqWHG8f7MA+RxrabVMPAaoi9cWVtSFErLAwi8dWMDIfbGSogud2FeZKgnwumD1s2KTQEANOCXQxOvxaYT7RJ0=
Message-ID: <449A72CC.9030704@gmail.com>
Date: Thu, 22 Jun 2006 18:37:00 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
CC: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
References: <200606211715.58773.a1426z@gawab.com> <44996332.5090408@gmail.com>	 <200606220005.32446.a1426z@gawab.com> <4499E89F.6030509@gmail.com> <69304d110606212332t3781bbf6g28ce33cca79a8bb0@mail.gmail.com>
In-Reply-To: <69304d110606212332t3781bbf6g28ce33cca79a8bb0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:
> On 6/22/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Al Boldi wrote:
>> > Antonino A. Daplas wrote:
>> >> Al Boldi wrote:
>> >>> Enabling CONFIG_VGACON_SOFT_SCROLLBACK causes random fatal system
>> >>> freezes.
>> >>>
>> >>> Especially, ping 10.1 -A easily causes a complete system hang during
>> >>> scroll.
>> >>>
>> >>> Is there an easy way to fix this, other than disabling the option?
>> >> I can't duplicate your problem. Did it ever work before?
>> >
>> > This option did not exist before 2.6.17.
>>
>> I meant if you tried any of the -rc kernels.
>>
>> Anyway, can you try the patch below.  It's a debugging patch and
>> it will slow down the console.
>>
>> If the system hang disappears, remove the line
>>
>>     while (i--);
>>
>> in include/linux/vt_buffer.h.  This line is introduced by
>> the patch below.
>>
>> Let me know at what point it worked, or whether it worked at all.
>>
>> >
>> >> Can you send me you kernel config?
>> >
>> > Attached below.
>> >
>> > BTW, is there any chance to patch your savagefb to support VIA/S3
>> UniChrome?
>> >
>>
>> If someone posts a patch to lkml or fbdev-devel, why not?  But a separate
>> driver is probably better as the 2 are very different.
>>
>> Tony
>>
>> diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
>> index 057db7d..e9b6064 100644
>> --- a/include/linux/vt_buffer.h
>> +++ b/include/linux/vt_buffer.h
>> @@ -20,11 +20,21 @@ #endif
>>
>>  #ifndef VT_BUF_HAVE_RW
>>  #define scr_writew(val, addr) (*(addr) = (val))
>> -#define scr_readw(addr) (*(addr))
>> -#define scr_memcpyw(d, s, c) memcpy(d, s, c)
>> -#define scr_memmovew(d, s, c) memmove(d, s, c)
>> -#define VT_BUF_HAVE_MEMCPYW
>> -#define VT_BUF_HAVE_MEMMOVEW
>> +//#define scr_readw(addr) (*(addr))
>> +
>> +static inline u16 scr_readw(volatile const u16 *addr)
>> +{
>> +    int i = 10000;
>> +    u16 val = *addr;
>> +
>> +    while (i--);
>> +    return val;
>> +}
>> +
>> +//#define scr_memcpyw(d, s, c) memcpy(d, s, c)
>> +//#define scr_memmovew(d, s, c) memmove(d, s, c)
>> +#undef VT_BUF_HAVE_MEMCPYW
>> +#undef VT_BUF_HAVE_MEMMOVEW
>>  #endif
>>
>>  #ifndef VT_BUF_HAVE_MEMSETW
> 
> Antonino, is this while(i--) a cpu busy-wait loop???

Yes.

> This would have
> different timings on different cpu kinds...

Yes. This is just a debugging patch to help me pinpoint where
the problem is.

> maybe a short usleep()?

It can be called in any context, so sleep() will be illegal
in certain circumstances.

Tony
