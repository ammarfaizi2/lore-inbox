Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWHQPBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWHQPBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWHQPBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:01:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:19412 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965108AbWHQPBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:01:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dCu5K7ZQKPzqemar7RaVgCWTc99UCbqQzf4INAMh4NBvxOXEn+8Bf8JbZ4GX/gJ9TlOwqbVt7CdKDGw7XtAq3T7owCYovlgBkZE03r0jLIU81ZXAcTYf1rTEOHhz3rnIhTvgloFLca5a0z4aidP8/d57BpzS0yGrHsZ9WXvMbHs=
Message-ID: <b0943d9e0608170801v23592952scf12c2c0b4a7bf4@mail.gmail.com>
Date: Thu, 17 Aug 2006 16:01:37 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <6bffcb0e0608170745s8145df4ya4e946c76ab83c1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
	 <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
	 <6bffcb0e0608130726x8fc1c0v7717165a63391e80@mail.gmail.com>
	 <b0943d9e0608170602v13dea49bgf64dbf17b7a52273@mail.gmail.com>
	 <6bffcb0e0608170745s8145df4ya4e946c76ab83c1b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 17/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > On 13/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > It's kmemleak 0.9 issue. I have tested kmemleak 0.8 on 2.6.18-rc1and
> > > 2.6.18-rc2. I haven't seen this before.
> >
> > it looks like it was caused by commit
> > fc818301a8a39fedd7f0a71f878f29130c72193d where free_block() now calls
> > slab_destroy() with l3->list_lock held.
>
> I'll revert this commit.

I'm not sure it's a good idea, it might have other implications in
slab.c. I better fix kmemleak (I think currently you could get a
deadlock only on SMP).

> Please talk with Christoph Lameter, he is working on Modular Slab.
> http://www.ussg.iu.edu/hypermail/linux/kernel/0608.1/0951.html
> http://www.ussg.iu.edu/hypermail/linux/kernel/0608.2/0030.html
> Maybe he can help with this problem.

I haven't looked at these patches in detail but they look like making
the slab allocator cleaner.

Anyway, I still need to revisit the locking in kmemleak and not rely
on future changes to slab.c. At the moment I think I can avoid any
kmemleak locks when allocating memory (by using radix_tree_preload
with the radix trees). If this still fails, I'll think about writing
my own, very simple, memory allocator and avoid the re-entrance
problem.

Thanks.

-- 
Catalin
