Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbWGKGn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWGKGn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWGKGn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:43:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22680 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965226AbWGKGn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:43:28 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] msi: Only keep one msi_desc in each slab entry.
References: <m1veq5m87s.fsf@ebiederm.dsl.xmission.com>
	<84144f020607102303o3e379e95qc58cec97cbfd7d0c@mail.gmail.com>
Date: Tue, 11 Jul 2006 00:42:43 -0600
In-Reply-To: <84144f020607102303o3e379e95qc58cec97cbfd7d0c@mail.gmail.com>
	(Pekka Enberg's message of "Tue, 11 Jul 2006 09:03:43 +0300")
Message-ID: <m1k66kiqvw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pekka Enberg" <penberg@cs.helsinki.fi> writes:

> On 7/11/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> It looks like someone confused kmem_cache_create with a different
>> allocator and was attempting to give it knowledge of how many cache
>> entries there were.
>>
>> With the unfortunate result that each slab entry was big enough to
>> hold every irq.
>>
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>>  drivers/pci/msi.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 0cd4a3e..082e942 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -40,13 +40,13 @@ msi_register(struct msi_ops *ops)
>>
>> static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
>>  {
>> -       memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
>> +       memset(p, 0, sizeof(struct msi_desc));
>
> You can use kmem_cache_zalloc() for this.

Please look at what the code changes.
Please recognize how very bad the current code is behaving.

As for the rest sure go ahead and create a patch to address it
but that really is a separate issue and thus a separate patch.

I'm just trying to keep the kernel from calling BUG_ON the first
time a msi irq is allocated on a kernel with a maximum NR_CPUS
configuration, and from wasting memory the rest of the time.

Or you know how bad the msi code is when every patch to fix a major
issue is followed up comments on how to improve the code even further.

Eric

>>  }
>>
>>  static int msi_cache_init(void)
>>  {
>>         msi_cachep = kmem_cache_create("msi_cache",
>> -                       NR_IRQS * sizeof(struct msi_desc),
>> +                       sizeof(struct msi_desc),
>>                         0, SLAB_HWCACHE_ALIGN, msi_cache_ctor, NULL);
>>         if (!msi_cachep)
>>                 return -ENOMEM;
>> --
>> 1.4.1.gac83a
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
