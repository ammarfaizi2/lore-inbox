Return-Path: <linux-kernel-owner+w=401wt.eu-S1753861AbWLRLjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbWLRLjd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 06:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbWLRLjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 06:39:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52831 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbWLRLjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 06:39:33 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Jones <davej@redhat.com>
Cc: Daniel Drake <dsd@gentoo.org>, linux list <linux-kernel@vger.kernel.org>
Subject: Re: amd64 agpgart aperture base value
References: <4580C954.103@gentoo.org> <20061214132224.GD17565@redhat.com>
	<4581DFC2.1000304@gentoo.org> <20061215000250.GB18456@redhat.com>
Date: Mon, 18 Dec 2006 04:38:58 -0700
In-Reply-To: <20061215000250.GB18456@redhat.com> (Dave Jones's message of
	"Thu, 14 Dec 2006 19:02:50 -0500")
Message-ID: <m1psahsab1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Thu, Dec 14, 2006 at 06:35:30PM -0500, Daniel Drake wrote:
>
>  > So, you think that the aperture moving to a different location on every 
>  > boot is what the BIOS desires? Is it normal for it to move so much?
>
> Beats me. I gave up trying to understand BIOS authors motivations years ago.
>
>  > The current patch drops the upper bits and results in the aperture 
>  > always being in the same place, and this appears to work. If the BIOS 
>  > did really put the aperture beyond 4GB but my patch is making Linux put 
>  > it somewhere else, does it surprise you that things are still working 
>  > smoothly?
>
> Does it survive a run of testgart when masking out the high bits?
> It could be that you're right, and the upper bits being reported really
> are garbage.
>
>  > Is it even possible for the aperture to start beyond 4GB when the system 
>  > has less than 4GB of RAM?
>
> The amount of RAM is irrelevant, it can appear anywhere in the address space,
> which on 64bit, is pretty darned huge.  The aperture isn't backed by RAM,
> it's a 'virtual window' of sorts. When you write to an address in that range, it
> gets transparently remapped to somewhere else in the address space.
> The window is the 'aperture', where it remaps to is controlled by a translation
> table called the GATT (which does live in real memory).
>
> That's pretty much all there is to AGP. It's just a really dumb MMU of sorts.

Well I just took a quick look, and it looks like there is a bug in amd64-agp.c
It isn't masking off the reserved high bits of the register at 0x94, and it
isn't being very careful with the promotion to 64bits.

However that does not appear to be the problem, as the base addresses you are
seeing are only seeing 40 bits long, and you are fixing it in the register
before the code in amd64-agp.c runs.

So I do agree that it appears that the BIOS is letting the upper address bits
float, and giving you a 32bit value.

Fixing this with a board specific pci quirk is questionable but it may
be ok.  A reliable fix is probably if the address is sufficiently questionable
to allocate a new aperture ourselves, and scream that the BIOS messed up.
arch/x86_64/kernel/aperture.c appears to do that when we use the agp aperture
for an iommu.

I don't think a agp aperture above 64bits is actually very interesting,
in practice as most agp cards are only 32bits so won't be able to use it.
And we are talking bus addresses here.

Eric
