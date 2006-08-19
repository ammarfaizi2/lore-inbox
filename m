Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWHSNZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWHSNZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 09:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWHSNZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 09:25:51 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:46408 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751331AbWHSNZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 09:25:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AXbae7MhjaZ46byPkTzTBlFlXCkpmh6WBOACPuxsoPWcDx70NOGUZrzqcKykJNJmXv4tIOnjQgfWft8R5g6mwlLIC4GfAzFNtTzrWgCWj2VfOwyfHEJ6gQnIuO+h2lTgMuPqETxqis/lcsa8MOeieBdKPDT4SdXqlIcVMC5uUEY=
Message-ID: <b0943d9e0608190625k1f25eb63t25ccfc84f7222f2@mail.gmail.com>
Date: Sat, 19 Aug 2006 14:25:50 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1155986453.14337.9.camel@daplas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608180715v27015481vb7c603c4be356a21@mail.gmail.com>
	 <b0943d9e0608180846s4ed560b7ld4e3081bdc754454@mail.gmail.com>
	 <6bffcb0e0608180942l12e342epd60dffbb5c5d4b3e@mail.gmail.com>
	 <b0943d9e0608180957w60d22261k61b272c9b76505bd@mail.gmail.com>
	 <6bffcb0e0608181438m3406de08q9a168d486127aef@mail.gmail.com>
	 <b0943d9e0608181447t5503b24eyfea6f3903c2ba27d@mail.gmail.com>
	 <6bffcb0e0608181549o3034398fob3763d3ce0869cfe@mail.gmail.com>
	 <b0943d9e0608190307v5853f38dja21ad65e2c67840c@mail.gmail.com>
	 <1155986453.14337.9.camel@daplas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/06, Antonino A. Daplas <adaplas@pol.net> wrote:
> On Sat, 2006-08-19 at 11:07 +0100, Catalin Marinas wrote:
> > On 18/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > orphan pointer 0xc6110000 (size 12288):
> > >   c017480e: <__kmalloc>
> > >   c024dda4: <vc_resize>
> > >   c020ed9c: <fbcon_startup>
> > >   c0251028: <register_con_driver>
> > >   c02511e0: <take_over_console>
> > >   c020e21e: <fbcon_takeover>
> > >   c0212b08: <fbcon_fb_registered>
> > >   c0212ce1: <fbcon_event_notify>
>
> On boot, vc->vc_screenbuf is allocated by alloc_bootmem() (vc->kmalloced
> == 0), so yes, there's a leak in there . But I don't think we have a way
> to deallocate this type of memory, so we just let it go.

It's not the leak caused by alloc_bootmem as kmemleak doesn't track
this kind of allocations. The block allocated via kmalloc in
vc_resize() is reported as unreferenced. However, I think that's a
false positive because it looks like the vc_screenbuf pointer is
stored in vc_cons[].d->vc_screenbuf which is allocated by
alloc_bootmem in con_init() and kmemleak doesn't track the
alloc_bootmem blocks. I'll fix kmemleak.

Thanks.

-- 
Catalin
