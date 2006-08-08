Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWHHHYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWHHHYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 03:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWHHHYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 03:24:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16832 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932507AbWHHHYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 03:24:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Horms <horms@verge.net.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, vgoyal@in.ibm.com, fastboot@osdl.org,
       linux-kernel@vger.kernel.org, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<20060804225611.GG19244@in.ibm.com>
	<m1k65onleq.fsf@ebiederm.dsl.xmission.com>
	<20060808033405.GA6767@verge.net.au> <44D813D7.3050004@zytor.com>
	<20060808060957.GC7681@verge.net.au>
Date: Tue, 08 Aug 2006 01:23:15 -0600
In-Reply-To: <20060808060957.GC7681@verge.net.au> (horms@verge.net.au's
	message of "Tue, 8 Aug 2006 15:09:58 +0900")
Message-ID: <m18xlz8zdo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms <horms@verge.net.au> writes:

> On Mon, Aug 07, 2006 at 09:32:23PM -0700, H. Peter Anvin wrote:
>> Horms wrote:
>> >
>> >I also agree that it is non-intitive. But I wonder if a cleaner
>> >fix would be to remove CONFIG_PHYSICAL_START all together. Isn't
>> >it just a work around for the kernel not being relocatable, or
>> >are there uses for it that relocation can't replace?
>> >
>> 
>> Yes, booting with the 2^n existing bootloaders.
>
> Ok, I must be confused then. I though CONFIG_PHYSICAL_START was
> introduced in order to allow an alternative address to be provided for
> kdump, and that previously it was hard-coded to some
> architecture-specific value.
>
> What I was really getting as is if it needs to be configurable at
> compile time or not. Obviously there needs to be some sane default
> regardless.

CONFIG_PHYSICAL_START has had 2 uses.
1) To allow a kernel to run a completely different address for use
   with kexec on panic.
2) To allow the kernel to be better aligned for better performance.

For maintenance reasons I propose we introduce CONFIG_PHYSICAL_ALIGN.
Which will round our load address up to the nearest aligned address
and run the kernel there.  That is roughly what I am doing on x86_64
at this point.

s/CONFIG_PHYSICAL_START/CONFIG_PHYSICAL_ALIGN/ gives me well defined
behavior and allows the alignment optimization without getting into 
weird semantics.

Before CONFIG_PHYSICAL_START we _always_ ran the arch/i386 kernel
where it was loaded and I assumed we always would.  Since people have
realized better aligned kernels can run better this assumption became
false.  Going to CONFIG_PHYSICAL_ALIGN allows us to return to the
simple assumption of always running the kernel where it is loaded
modulo a little extra alignment.

Eric
