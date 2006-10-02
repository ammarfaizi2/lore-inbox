Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWJBRag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWJBRag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWJBRag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:30:36 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:39353 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S965160AbWJBRaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:30:35 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: [PATCH 4/4] fdtable: Implement new pagesize-based fdtable allocation scheme.
Date: Mon, 2 Oct 2006 19:30:31 +0200
User-Agent: KMail/1.9.4
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200610011414.30443.vlobanov@speakeasy.net> <p73y7rzghos.fsf@verdi.suse.de> <200610021004.13634.vlobanov@speakeasy.net>
In-Reply-To: <200610021004.13634.vlobanov@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021930.32017.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 19:04, Vadim Lobanov wrote:
> On Monday 02 October 2006 03:01, Andi Kleen wrote:
> > Vadim Lobanov <vlobanov@speakeasy.net> writes:
> > > The allocation algorithm sizes the fdarray in such a way that its
> > > memory usage increases in easy page-sized chunks. Additionally, it
> > > tries to account for the optimal usage of the allocators involved:
> > > kmalloc() for sizes less than a page, and vmalloc() with page
> > > granularity for sizes greater than a page.
> >
> > Best would be to avoid vmalloc() completely because it can be quite
> > costly
>
> It's possible. This switch between kmalloc() and vmalloc() was there in the
> original code, and I didn't feel safe ripping it out right now. We can
> always explore this approach too, however.
>
> What is the origin and history of this particular code? (It's been there
> since at least 2.4.x.) Who put in the switch between the two allocators,
> and for what reason? Is that reason still valid?

I think Andi was suggesting using a indirection, with a table of pointers to 
PAGES, each PAGE containing PAGE_SIZE/sizeof(struct file *) pointers. Kind of 
what is doing vmalloc(), but without the need of contiguous virtual memory 
space.

You cannot just zap vmalloc() and use one kmalloc(), because some programs 
open one million files. That's 8 MByte of memory on x86_64. kmalloc() cannot 
cope with that. It cannot even cope with 32KB allocations but just after 
reboot...


Eric
