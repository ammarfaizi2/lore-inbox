Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVIXExD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVIXExD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 00:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVIXExD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 00:53:03 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:28015 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751412AbVIXExB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 00:53:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xgWXSydnX5zs/w8DknUny54QWFNOTtm1LHdNhTPmZkJlUe9dlZXhGHvHMQZDPBdgX50t8vIyzzplz08gj2BasHLu6WPAA34xcqrk9cvVSJyjYGZyteqdzBNLVMrxoprFow0JKq/kxboYECy9ydBDgNzR2v+52fWSvQC32qAebKs=  ;
Message-ID: <4334DB96.3040904@yahoo.com.au>
Date: Sat, 24 Sep 2005 14:52:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] inline a few tiny functions in init/initramfs.c
References: <200509240126.26575.jesper.juhl@gmail.com> <200509241415.43773.kernel@kolivas.org>
In-Reply-To: <200509241415.43773.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Sat, 24 Sep 2005 09:26, Jesper Juhl wrote:
>
>>A few functions in init/initramfs.c are so simple that I don't see why
>>*any* point in them having to bear the cost of a function call.
>>Wouldn't something like the patch below make sense ?
>>
>
>>-static void __init *malloc(size_t size)
>>+static inline void __init *malloc(size_t size)
>> {
>> 	return kmalloc(size, GFP_KERNEL);
>>
>
>maybe it looks like it would, but kmalloc looks like this:
>
>85 static inline void *kmalloc(size_t size, int flags)
>86 {
>87         if (__builtin_constant_p(size)) {
>88                 int i = 0;
>89 #define CACHE(x) \
>90                 if (size <= x) \
>91                         goto found; \
>92                 else \
>93                         i++;
>94 #include "kmalloc_sizes.h"
>95 #undef CACHE
>96                 {
>97                         extern void __you_cannot_kmalloc_that_much(void);
>98                         __you_cannot_kmalloc_that_much();
>99                 }
>100 found:
>101                 return kmem_cache_alloc((flags & GFP_DMA) ?
>102                         malloc_sizes[i].cs_dmacachep :
>103                         malloc_sizes[i].cs_cachep, flags);
>104         }
>105         return __kmalloc(size, flags);
>106 }
>
>which is not a one liner to inline at all
>
>

Actually, this is even better, because the inline 'malloc' should be
able to propogate the builtin_constantness of 'size' while an out of
line version cannot.

IMO the best policy is not to second guess the API implementor's
choice of inline / noinline. That is - if kmalloc was too big to
inline then it should be fixed in kmalloc or another interface
introduced.

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
