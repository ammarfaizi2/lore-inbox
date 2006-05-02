Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWEBHP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWEBHP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWEBHP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:15:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54218 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932461AbWEBHP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:15:57 -0400
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: vgoyal@in.ibm.com, "Magnus Damm" <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kexec: Avoid overwriting the current pgd
 (i386)
References: <20060501095041.16897.49541.sendpatchset@cherry.local>
	<20060501143512.GA7129@in.ibm.com>
	<m1u089aegp.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30605011856v5023b8fdwf8542c746a8a09dd@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <aec7e5c30605011856v5023b8fdwf8542c746a8a09dd@mail.gmail.com> (Magnus
 Damm's message of "Tue, 2 May 2006 10:56:09 +0900")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Date: Tue, 02 May 2006 01:15:23 -0600
Message-ID: <m17j54aodw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> On 5/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Well global variables don't quite work in the normal case.
>>
>> However it probably makes most sense to maintain the needed variables
>> in a structure on the control page.  Which will keep them out of harms way,
>> and won't require patches to the generic code.
>
> I agree with both of you that the #ifdefs in struct kimage should be
> avoided, but I wonder if adding variables in a structure on the
> control page is the easiest and cleanest way.
>
> I think that defining a structure for each architecture in
> include/asm/kexec.h that is included in struct kimage is the best way
> to go. Then each architecture can have whatever data it wants there,
> and we both avoid #ifdefs in struct kimage _and_ we stay away from
> overly complicated code that just allocates, frees and parses
> architecture-dependent data.

Well I think it would be fairly simple to have a structure:
struct control_page {
       type	variabe;
       ...
       code[0];	
};

Or something like that we can work with.

The big reason for doing this is that I believe control pages
have additional protection that struct kimage does, being allocated
in areas where the kernel never sets up DMA transfers.  Possibly
that needs to be fixed, but this is something we need to be very
careful with.

For a page table all we need to store is the physical address of the
first page.  Storing and working with a struct page entry is the wrong
thing to do.  I would prefer to stomp the kernel data structures than
to add an extra dependencies on the original panic'd kernel.  At first
glance I am afraid that you current code introduces extra
dependencies.

You don't need two x86_64 page tables as you can easily map
all of the kernel virtual address, and the identity mapped physical
address until the x86_64 kernel stops using an 8TB/8TB split.

Eric
