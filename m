Return-Path: <linux-kernel-owner+w=401wt.eu-S965140AbXASNvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbXASNvs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 08:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbXASNvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 08:51:48 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:1736 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965140AbXASNvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 08:51:47 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NOdjMaN0fwuPtTfQFR9Tgyb90SkovkWUKNF2YzJo2/UwAee3IsnePS7ZtIDjAcodYAi8rT1FiKNNBWcjixvwM3zQHjopkcgdGJWC/7WhWVk1Q+rC4gjeBlPCZ8EAK5iVY5A1LCkdq0xpUXPrI3A7z/0NGjv1wz3DSkEjOdf2vpA=
Message-ID: <61ec3ea90701190331y459ad373n21a610157df03282@mail.gmail.com>
Date: Fri, 19 Jan 2007 12:31:18 +0100
From: "Franck Bui-Huu" <fbuihuu@gmail.com>
To: "Hugh Dickins" <hugh@veritas.com>
Subject: Re: unable to mmap /dev/kmem
Cc: "Nadia Derbey" <Nadia.Derbey@bull.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45AFA490.5000508@bull.net>
	 <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hugh Dickins wrote:
> On Thu, 18 Jan 2007, Nadia Derbey wrote:
>> Trying to mmap /dev/kmem with an offset I take from /boot/System.map,
>> I get an EIO error on a 2.6.20-rc4.
>> This is something that used to work on older kernels.
>>
>> Had a look at mmap_kmem() in drivers/char/mem.c, and I'm wondering whether
>> pfn is correctly computed there: shouldn't we have something like
>>
>> pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) +
>>       __pa(vma->vm_pgoff << PAGE_SHIFT);
>>
>> instead of
>>
>> pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) + vma->vm_pgoff;
>>
>> Or may be should I substract PAGE_OFFSET from the value I get from System.map
>> before mmapping /dev/kmem?
>
> Sigh, you're right, 2.6.19 messed that up completely.
> No, you never had to subtract PAGE_OFFSET from that address
> in the past, and you shouldn't have to do so now.
>
> Please revert the offending patch below, and then maybe Franck
> can come up with a patch which preserves the original behaviour
> on architectures which used to work (e.g. i386), while fixing
> it for those architectures (which are they?) that did not.
>

I've been confused by 'vma->vm_pgoff' meaning. I assumed that it was
an offset relatif to the start of the kernel address space
(PAGE_OFFSET) as the commit message I submitted explains. So doing:

	fd = open("/dev/kmem", O_RDONLY);
	kmem = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 4 * 4096);

actually asks for a kernel space mapping which start 4 pages after the
begining of the kernel memory space.

So yes, if the 'offset' expected by 'mmap(/dev/kmem, ..., offset)'
usage is actually a kernel virtual address the patch I submitted is
wrong. The offending line should have been something like:

	pfn = PFN_DOWN(virt_to_phys((void *)(vma->vm_pgoff << PAGE_SHIFT)));

and in this case 'vma->vm_pgoff' has no sense to me. My apologizes for
this mess.

> I guess it's reassuring to know that not many are actually
> using mmap of /dev/kmem, so you're the first to notice: thanks.
>

yes it doesn't seems to be used. In my case, I was just playing with
it when I submitted the patch but have no real usages.

		Franck
